# Model name resolution and `Conf/Local-Devices` precedence

> This page describes plugin **9.1.008** with **z4d-certified-devices 10.xxx** or later.
> Two behaviours differ in earlier versions; both are called out in place below.

## Why this page exists

A Zigbee device reports a model name in the Basic cluster (`0x0000`, attribute `0x0005`) — for
example `TS011F`. That raw string is rarely enough: dozens of unrelated Tuya products report
`TS011F`, and hundreds report `TS0601`. The plugin therefore **rewrites** the reported model name
into a plugin-internal model name (`TS011F-plug`, `TS0601-eTRV3`, …) and then looks that name up in
the device configuration database.

This page documents how that rewrite happens, in which order the different sources are consulted,
and — the question that keeps coming back — **what you have to name your `Conf/Local-Devices` file
so that it actually wins** over the hardcoded tables and over the certified database.

## The three sources

| Source | Where | Loaded by |
| ------ | ----- | --------- |
| **Local devices** | `Conf/Local-Devices/<name>.json` in your plugin directory | `import_local_device_conf()` in `Modules/database.py` |
| **Certified devices** | `Certified/<Brand>/<name>.json` inside the `z4d-certified-devices` PyPI package | `z4d_import_device_configuration()` in that package |
| **Hardcoded matrix** | `PLUGIN_MODELS_MATRIX` in `Modules/pluginModels.py` | n/a — a Python constant in the plugin code |

The first two both populate the same two in-memory dictionaries:

* `self.DeviceConf` — `{"<model name>": {<the JSON content>}}`. The key is always the **file name
  without its `.json` extension** (the "stem"). The brand folder is *not* part of the key, so model
  names must be unique across the whole certified database.
* `self.ModelManufMapping` — `{("<reported model>", "<manufacturer name>"): "<model name>"}`, built
  from the optional top-level `Identifier` list inside a config file.

### Load order: Local-Devices wins

In `plugin.py`:

```python
import_local_device_conf(self)                                   # 1. Conf/Local-Devices
z4d_certified_devices.z4d_import_device_configuration(self, ...)  # 2. certified package
```

Local devices are loaded **first**, and the certified loader skips any model name that is already
present:

```python
if model_name in self.DeviceConf:
    # "Config for <Brand>/<model> already defined, skipped."
    continue
```

So dropping `Conf/Local-Devices/SML001.json` in place completely replaces the certified
`Certified/Philips/SML001.json`. **Same file name = full override.** This is the supported way to
patch a certified device without waiting for a new `z4d-certified-devices` release.

> Only `*.json` files are read from `Conf/Local-Devices`. `README.md`, `.PRECIOUS`, dot-files and
> editor backups (`SML001.json.bak`) are skipped — which also means a backup copy will *not*
> accidentally shadow anything.

## The resolution order at pairing time

When the Basic cluster model-name attribute arrives, `handle_model_name()` calls
`_build_model_name()` (`Modules/zclClusterHelpers.py`). Given the reported model `M` and the
device's `Manufacturer Name` `N`, it returns the **first** match in this order:

| # | Lookup | Key it tries |
| - | ------ | ------------ |
| 1 | `M + "-" + N` in `DeviceConf` | `TS011F-_TZ3000_cehuw1lw` |
| 2 | `M + N` in `DeviceConf` | `TS011F_TZ3000_cehuw1lw` |
| 3 | `(M, N)` in `ModelManufMapping` (the `Identifier` lists) | `("TS011F", "_TZ3000_cehuw1lw")` |
| 4 | `PLUGIN_MODELS_MATRIX` in `Modules/pluginModels.py` | → `TS011F-plug` |
| 5 | fall back to `M` unchanged | `TS011F` |

Steps 1 to 3 all need `N`. When the `Manufacturer Name` has not been received yet — the two
Basic cluster attributes arrive independently — none of them can be looked up, and the order
becomes: the matrix for the few models that can only be resolved there
(`MODELS_RESOLVED_BY_MATRIX_ONLY`, see below), then `M` alone in `DeviceConf`, then the matrix.

Two consequences that surprise people:

* **The hardcoded matrix is the *last* resort, not the first.** If any of steps 1–3 matches, the
  matrix is never consulted. So yes — a correctly named `Conf/Local-Devices` file does override
  `pluginModels.py`.
* **The bare reported model name `M` is never looked up in `DeviceConf` by this function.** Dropping
  `Conf/Local-Devices/TS011F.json` does **nothing** for a device whose manufacturer is listed in the
  matrix: the name is rewritten to `TS011F-plug` at step 4 before `TS011F` is ever considered.
  (`TS011F.json` is still used — but only for devices whose manufacturer matches *nothing* in
  steps 1–4, which reach step 5 with the bare name.)

### Worked example: `TS011F` / `_TZ3000_cehuw1lw`

This manufacturer appears **twice** in the plugin: once in the `PLUGIN_MODELS_MATRIX` entry that
maps it to `TS011F-plug`, and once in the `Identifier` list of certified
`Certified/Tuya/TS011F-plug.json`. Because step 3 comes before step 4, the certified `Identifier`
already resolves it — the matrix entry is effectively dead code for this particular manufacturer.
Either way the result is `TS011F-plug`.

To change that outcome from `Conf/Local-Devices`:

| Your file in `Conf/Local-Devices/` | Result |
| ---------------------------------- | ------ |
| `TS011F-_TZ3000_cehuw1lw.json` | ✅ **Wins at step 1.** Model becomes `TS011F-_TZ3000_cehuw1lw`, your config is used, the matrix is never reached. |
| `TS011F_TZ3000_cehuw1lw.json` | ✅ Wins at step 2. Same effect, less readable — prefer the dashed form. |
| `TS011F-plug.json` | ✅ The name is still rewritten to `TS011F-plug`, but **your file supplies the configuration** (the certified one is skipped at load time). Use this to patch the shared `TS011F-plug` profile for *all* 45 manufacturers listed in it. |
| `MyPlug.json` with `"Identifier": [["TS011F", "_TZ3000_cehuw1lw"]]` | ✅ Wins at step 3. Before z4d-certified-devices 10.607 this was silently overridden — see the caveat below. |
| `TS011F.json` | ❌ No effect for this device. The bare model name is not part of the lookup chain. |

**Recommendation:** to give one manufacturer its own behaviour, name the file
`<ReportedModel>-<ManufacturerName>.json`. To change a whole shared profile, name the file exactly
like the certified one.

### Before z4d-certified-devices 10.607: a local `Identifier` list could be overwritten

`import_local_device_conf()` registers your `Identifier` tuples into `ModelManufMapping`, and the
certified loader used to write its own identifiers **unconditionally**:

```python
self.ModelManufMapping[tuple(identifier)] = model_name   # no guard
```

The skip-if-already-defined check in the certified loader is on the *model name*, not on the
identifier key. So if your local file was called `MyPlug.json` and a certified file under a
*different* name (`TS011F-plug.json`) claimed the same `(model, manufacturer)` tuple, the certified
file was loaded and your mapping was replaced. Identifier-based overrides only survived when the
local file carried the **same name** as the certified file that would otherwise claim the tuple.

Since 10.607 the loader snapshots the mappings that exist before the certified import starts — which
can only come from `Conf/Local-Devices` — and leaves them alone. Note that identifiers claimed twice
*inside* the certified database still follow last-one-wins; a dozen pairs are in that situation, and
that is a data question for the JSON files, not for the loader.

If you are on an older certified database, name your file
`<ReportedModel>-<ManufacturerName>.json` (steps 1–2) instead: no loader can undo that.

### Caveat: `DeviceID`-based disambiguation only exists in the matrix

`Identifier` can only express a `(model, manufacturer name)` pair. Some devices report the *same*
model **and** the same manufacturer, and differ only by their ZDP device id — the Sonoff `66666`
family is the canonical case (`0x0302` = temperature/humidity, `0x0402` = motion). That distinction
can only be made in `PLUGIN_MODELS_MATRIX`, which also matches on `ManufId` (the manufacturer code)
and `DeviceID`.

Those models are listed in `MODELS_RESOLVED_BY_MATRIX_ONLY` (`Modules/zclClusterHelpers.py`). For
them, and only while the `Manufacturer Name` is still unknown, the matrix is consulted *before* a
generic `<Model>.json` config is accepted — otherwise every Sonoff `66666` would take the generic
`66666` profile instead of `66666-temphumi` or `66666-motion`. Once the manufacturer name is known,
steps 1 to 3 run first as for any other model, so these devices **can** be overridden from
`Conf/Local-Devices` like the rest.

**Before 9.1.008**, model `66666` short-circuited to the matrix unconditionally, so it was the one
model no `Conf/Local-Devices` file could ever influence. In 9.1.007 and earlier the matrix also
returned `66666-temphumi.json` / `66666-motion.json` — with the `.json` suffix, which matches no
`DeviceConf` key — so a Sonoff `66666` was stored under a bogus model name and received no
configuration at all.

## After the name is resolved

`handle_model_name()` then decides what to do with the resolved name:

1. If the device is **already provisioned** — at least one endpoint carries a non-empty
   `ClusterType`, i.e. Domoticz widgets exist — the model name is refreshed but the endpoint
   structure is left untouched. **Changing a `Conf/Local-Devices` file does not retro-fit an
   already-paired device.** To benefit from a new configuration you must remove the widgets and
   re-pair from scratch.
2. If the stored `Model` is already a known `DeviceConf` entry and differs from the newly resolved
   one, the incoming name is logged as a warning and dropped — the stored one wins.
3. Otherwise `_update_data_structutre_based_on_model_name()` applies the configuration: it sets
   `ConfigSource = "DeviceConf"`, copies `Param` and `Type`, resets `Ep` and rebuilds the endpoint
   / cluster / attribute structure from the config file.

If the resolved name is **not** a key in `DeviceConf`, step 3 is a no-op: the device keeps the
resolved model name but gets no configuration, and widgets are created from the raw cluster list
discovered during pairing instead (see [Enrolment process](Enrolment-process.md)).

## Resolution outside pairing

`check_found_plugin_model()` is also called directly, bypassing `DeviceConf` and
`Conf/Local-Devices` entirely:

* `hack_ts0601()` (`Modules/database.py`) runs on every device at each device-database load. It
  re-applies the matrix, but **only** to devices whose stored `Model` is still exactly `TS0601` —
  i.e. devices that were never resolved. A device already resolved to `TS0601-eTRV3` (or to your own
  local name) is left alone.

## How to verify what the plugin decided

Enable the **Pairing** and **Database** verbose logging categories
(see [Debug mode](../Problem_Debuging-mode.md)), then look for:

```
Z4D loads N configuration from the local certified Db.
++ Overwrite standard configuration model <name> with <path>     <- your Local-Devices file was taken
++   Manufacturer mapping [ <model>, <manufacturer>              <- an Identifier tuple was registered
Config for <Brand>/<model> already defined, skipped.             <- certified file skipped in favour of yours
_build_model_name  <reported model>
check_found_plugin_model - model=..., manufacturer_name=...       <- the matrix was reached (steps 1-3 missed)
handle_model_name - incoming_model_name after build model name <resolved name>
```

The `Model` field finally stored for the device is visible in `Data/DeviceList.txt`, and in the
WebUI under **Management → Device list**.

## Reference

* Resolution chain — `_build_model_name()`, `Modules/zclClusterHelpers.py`
* Hardcoded matrix — `PLUGIN_MODELS_MATRIX` and `check_found_plugin_model()`, `Modules/pluginModels.py`
* Local-Devices loader — `import_local_device_conf()`, `Modules/database.py`
* Certified loader — `z4d_import_device_configuration()`, `z4d_certified_devices/__init__.py`
* Config file format — [Device configuration file](Device_Configuration_file.md) and
  [Device customization](../HowTo_Device-Customization.md)
