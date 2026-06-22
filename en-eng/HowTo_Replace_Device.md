# Replacing a Zigbee device while keeping its Domoticz history

`Tools/replace_device.py` lets you swap a physical Zigbee device for a new one
**without losing the historical data** (Temperature, Meter, Counter, …) that
Domoticz has accumulated for the old device.

---

## When do I need this?

A device dies (a thermometer, an energy meter, a motion sensor…) and you replace
it with a brand-new unit. Once the new device is paired, the plugin creates a
**fresh set of widgets** for it, with a new IEEE address and an **empty history**.

Your years of recorded data are still attached to the **old** widgets. This tool
moves the old widgets onto the new device so the new hardware keeps driving them,
and removes the duplicate widgets that were just created.

> **In short:** old hardware gone, new hardware paired, but you want to keep using
> the *old* widgets and their graphs.

> **In principle:** You would like to do it via DOmoticz, but unfortunatly the Ùpdate`function from Domoticz doesn't tell the plugin that he has done such action, and we loose the synchronisation between plugin and domoticz.

---

## How it works (the short version)

In Domoticz, all the history tables (`Temperature`, `Meter`, `MultiMeter`,
`Percentage`, …) reference a widget by its **Idx** (`DeviceStatus.ID`), *not* by
the Zigbee IEEE address. The history therefore follows the **old Idx**.

To make the new device drive the old widgets, two things must be updated:

1. **Domoticz database** – the old widgets are re-pointed from the *old* IEEE to
   the *new* IEEE (and the IEEE embedded in each widget name is rewritten). The
   freshly-created new widgets that duplicate an old one are deleted, together
   with their empty history rows.

2. **Plugin DeviceList** (`Data/DeviceList-<hwid>.txt`) – the new device's
   per-endpoint `ClusterType` is rewritten so each widget type now references the
   matching **old Idx**, and the old device entry is removed (its network address
   no longer exists).

Widgets are matched **by type**: first endpoint-by-endpoint, then across
endpoints as a fallback. This is designed to replace a device with one of the
**same (or very similar) kind**. Anything that cannot be matched 1:1 is reported
and left untouched, so nothing is ever silently lost.

---

## Before you start

You will need:

| What | Where to find it |
|------|------------------|
| **Old IEEE** – the device being replaced | Plugin Web UI device list |
| **New IEEE** – the new device (already paired) | Same place; pair the new device first |
| **Hardware ID (`hwid`)** of the Zigbee plugin | Domoticz → Setup → Hardware |
| **Path to `domoticz.db`** | Your Domoticz install directory |
| **Path to `DeviceList-<hwid>.txt`** | Plugin `Data/` directory |

> ⚠️ **Pair the new device first.** It must already exist in the plugin
> (have its own IEEE and freshly-created widgets) before you run this tool.

---

## Usage

### Step 1 — Dry-run (safe, writes nothing)

Always start with a dry-run. It loads both devices, computes the full plan and
prints it **without changing anything**.

```bash
python3 Tools/replace_device.py \
    --db /path/to/domoticz.db \
    --hwid 3 \
    --devicelist /path/to/Data/DeviceList-3.txt \
    --old-ieee 00124b00aaaaaaaa \
    --new-ieee 00124b00bbbbbbbb
```

Read the plan carefully. It shows:

- which **old widgets** will be re-pointed to the new device (history preserved),
- which **new widgets** will be deleted (the superseded duplicates),
- the `ClusterType` Idx remapping (`new Idx -> old Idx`),
- any widget that **could not be matched** (flagged with `!!`), and
- consistency warnings (`??`) when a `ClusterType` references an Idx that is not
  in the database.

### Step 2 — Apply (Domoticz **must be stopped**)

When the plan looks correct, **stop Domoticz** and re-run with `--apply`:

```bash
# Stop Domoticz (or its Docker container) first!
service domoticz stop
````

```bash
python3 Tools/replace_device.py \
    --db /path/to/domoticz.db \
    --hwid 3 \
    --devicelist /path/to/Data/DeviceList-3.txt \
    --old-ieee 00124b00aaaaaaaa \
    --new-ieee 00124b00bbbbbbbb \
    --apply
```

The tool will:

1. Verify that **nothing still has the database open** (see *Safety* below).
2. Ask for an interactive `yes` confirmation (skip with `--yes`).
3. Make **timestamped backups** of both the database and the DeviceList.
4. Apply the database changes in a single transaction (rolled back on any error).
5. Rewrite the DeviceList.

When it finishes, **restart Domoticz** (and the plugin) to load the updated
database and DeviceList.

---

## Command-line options

| Option | Required | Description |
|--------|:--------:|-------------|
| `--db` | yes | Path to the Domoticz database (`domoticz.db`). |
| `--hwid` | yes | Domoticz Hardware ID of the Zigbee plugin. |
| `--devicelist` | yes | Path to the plugin `DeviceList-<hwid>.txt`. |
| `--old-ieee` | yes | IEEE of the device being replaced (the history source). |
| `--new-ieee` | yes | IEEE of the new, already-paired device. |
| `--apply` | no | Actually perform the changes. Without it, the tool is a dry-run. |
| `--yes` | no | Do not ask for interactive confirmation when applying. |
| `--force` | no | Apply even if the database looks like it is still open by another process. **Not recommended.** |

---

## Safety

This tool modifies the Domoticz SQLite database **directly**. Modifying the
database while Domoticz has it open corrupts both the file and the running
instance. To protect you:

- **Dry-run by default.** Nothing is written unless you pass `--apply`.
- **"Is the database in use?" guard.** Before writing, the tool checks for any
  process holding the database open (matched by inode, so it works even for
  **Docker** containers that see the file under a different path) and for any
  running `domoticz` process. If it finds one, it refuses to proceed.
  - On non-Linux systems (no `/proc`) it cannot check — it warns you to make sure
    Domoticz is stopped.
  - If some processes can't be inspected (e.g. a root-owned container), it warns
    that a holder might exist; run the tool as **root** for a fully reliable check.
  - `--force` overrides the guard. Only use it if you are certain Domoticz is
    stopped.
- **Automatic backups.** Timestamped copies of both files are made before any
  write:
  - `domoticz.db.bak-<timestamp>`
  - `DeviceList-<hwid>.txt.bak-<timestamp>`
- **Atomic database update.** All database changes happen in one transaction; any
  error rolls it back and leaves the DeviceList untouched.

> 💡 **Keep the backups** until you have confirmed the replacement worked. To
> restore, stop Domoticz and copy the `.bak-<timestamp>` files back over the
> originals.

---

## Reading the plan output

```
Old device : NwkId 1a2b  IEEE 00124b00aaaaaaaa  Model lumi.weather
New device : NwkId 3c4d  IEEE 00124b00bbbbbbbb  Model lumi.weather

=== Plan ===
Domoticz database (/path/to/domoticz.db):
  Re-point old widgets to the new IEEE (history preserved):
    Idx 245    Temp+Hum+Baro 00124b00aaaaaaaa
    ...
  Delete superseded new widgets (and their empty history):
    Idx 512    Temp+Hum+Baro 00124b00bbbbbbbb

Plugin DeviceList (/path/to/Data/DeviceList-3.txt):
  Rewrite new device (NwkId 3c4d) ClusterType -> old Idx:
    512 -> 245
  Remove old device entry NwkId 1a2b (no longer on the network).
```

Markers you may see:

- `~~` — a type was matched across **different endpoints** (fallback matching).
- `!!` — a widget had **no counterpart** and was left as-is (new kept as new, old
  re-pointed but "frozen", i.e. no new data will flow into it).
- `??` — a `ClusterType` references an **Idx not present in the database**
  (a consistency warning worth investigating before applying).

If **no widget type can be matched** between the two devices, the tool aborts
without changing anything — the devices are probably too different for an
automatic replacement.

---

## Limitations

- Intended for replacing a device with one of the **same or very similar type**.
  Mismatched widgets are reported and not merged.
- Only handles the widgets of a single Hardware ID (the one you pass via `--hwid`).
- Works with the text-based `DeviceList-<hwid>.txt`. If you store the device list
  in the Domoticz database (`useDomoticzDb`), export/locate the DeviceList file
  the plugin uses.

---

## Troubleshooting

| Message | Meaning / fix |
|---------|---------------|
| `Old IEEE … not found in …` | Check the IEEE and that you pointed `--devicelist` at the right file. |
| `New IEEE … not found … is the new device paired?` | Pair the new device first so the plugin creates its entry. |
| `No Domoticz widget found for the old IEEE …` | Wrong `--hwid`, or the old device has no widgets to preserve. |
| `Domoticz appears to be running / the database is in use` | Stop Domoticz (or its Docker container) and re-run. |
| `No widget type could be matched … aborting` | The two devices are too different to remap automatically. |