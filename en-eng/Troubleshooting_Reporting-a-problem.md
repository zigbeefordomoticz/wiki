# Troubleshooting - Getting help and reporting a problem

Something doesn't work as expected. This page tells you where to ask, what the plugin logs look like when everything is fine, how to collect useful logs with the debug parameters, and what to attach when you open an issue.

## 1. Where to go

| Your situation | Where |
| -------------- | ----- |
| A question, a setup problem, or you are not sure whether it is a bug | The forums: [English](https://www.domoticz.com/forum/viewforum.php?f=68) or [French](https://easydomoticz.com/forum/viewforum.php?f=28) |
| A device is **not optimized** yet (new model), or an optimized device needs an **update** (missing widget, wrong value, new firmware or model variant) | An issue on [z4d-certified-devices](https://github.com/zigbeefordomoticz/z4d-certified-devices/issues/new?assignees=&labels=Device+Integration&projects=&template=certified-device-model.md&title=%5BModel+Certification%5D+-+) |
| An **identified bug** of the plugin | An issue on [Domoticz-Zigbee](https://github.com/zigbeefordomoticz/Domoticz-Zigbee/issues/new?template=bug_report.md) |
| A mistake or a missing page in this wiki | The [wiki issues](https://github.com/zigbeefordomoticz/wiki/issues) |

### Domoticz-Zigbee issues are for identified bugs only

Open an issue on [Domoticz-Zigbee](https://github.com/zigbeefordomoticz/Domoticz-Zigbee/issues) only when you have identified a bug: the plugin itself does something wrong. For example:

* an error in the logs, with a stack trace, that comes back;
* the plugin stops, hangs or loses the coordinator;
* a feature of the plugin or the WebUI doesn't work as documented;
* something that worked stops working after a plugin update (a regression).

Before opening it:

1. Check that you run the latest version of the plugin: the Dashboard shows the version in red when an update is available, and the log says `Z4D found a recent plugin version (...) on gitHub. You are on (...)` (see [Plugin update](Plugin_Update.md)).
1. Check the [plugin FAQ](Problem_FAQ.md) and the errors recorded by the plugin (see [Deal with plugin errors](HowTo_Dealing-plugin-errors.md)).
1. Make sure you can reproduce the problem, and collect the logs with the debug mode (see [below](#4-use-the-debug-parameters)).

A device request opened on Domoticz-Zigbee is not a bug: it will be redirected to z4d-certified-devices. Questions and setup problems go to the forums.

### z4d-certified-devices issues are for devices

Open an issue on [z4d-certified-devices](https://github.com/zigbeefordomoticz/z4d-certified-devices/issues) when:

* you paired a device that is **not optimized** yet: the orange icon in the *Optimized* column of *Management > Device Management*, or the log message `We have detected a working device ... not optimized with the plugin`;
* an optimized device needs an update: a widget is missing, a value is wrong, or a new firmware or model variant doesn't behave like the one already known.

See [Dealing with a non-optimized device](Problem_Dealing-with-none-optimized-device.md) for the complete procedure.

## 2. Where are the logs

The plugin writes to two places (details in [Debug mode](Problem_Debuging-mode.md#where-are-the-plugin-logs)):

* **The Domoticz log** (*Setup > Log* in Domoticz): status, warning and error messages only. They are prefixed with the name you gave the plugin hardware in Domoticz.
* **The plugin log file** `Domoticz-Zigbee/Logs/PluginZigbee_<hardware id>.log`: everything, including the informational and the **debug** messages. Each line starts with the date, the time and the level (`INFO`, `WARNING`, `ERROR`). This is the file to look at, and to attach to an issue.

If you disabled `enablePluginLogging`, there is no plugin log file: everything, including debug, goes to the Domoticz log.

## 3. Expected logs

The messages below are the normal ones. Their exact text may change from one version to the next, but you should find them in this order. If the log stops before the end of the list, look at the last message and the errors after it.

### At startup

| Message | Meaning |
| ------- | ------- |
| `Z4D Please watch plugin logs into .../Logs/PluginZigbee_<hardware id>.log` | The plugin log file is open (or `Z4D Plugin logs are redirected to Domoticz log` if `enablePluginLogging` is disabled). |
| `Z4D starts with stable9-<version> and using DomoticzEx !` | The plugin branch and version. Copy this line in a bug report. |
| `Z4D initializes a connection to Domoticz API/JSON` | The plugin connects to the Domoticz API. |
| `Z4D loads plugin database` | The plugin loads its list of devices (`Z4D loads <n> entries from Domoticz (version ...)` when it loads it from the Domoticz database). |
| `Z4D starts transport Mode: 'ZigpyZNP' Serial: '/dev/ttyUSB0' ...` | The coordinator type and port, as set in the Domoticz hardware page. |
| `Z4D starts ZNP` (or `EZSP`, `deConz`, `Bouffalo Lab Zigbee`) | The zigpy radio library starts. It is followed by lines starting with `++` that describe the coordinator (`++   Radio version : ...` for example). |
| `Z4D starts WebUI on port 9440` | The WebUI is available, on the port set in the Domoticz hardware page. |
| `Z4D starts with Domoticz 'Extended Framework'` | The start sequence is done. The plugin now waits for the coordinator. |
| `Z4D starts Group Management`, `Z4D starts Over-The-Air Management` | Only if these features are enabled in the settings. |
| `Z4D with Zigpy, coordinator <model>, firmware <version> communication confirmed.` | **The plugin is fully running.** Copy this line in a bug report: it gives the coordinator model and firmware. |
| `Z4D sends analytics information. ...` | Only if the anonymous statistics are enabled (see [Usage statistics](WebUI_Statistics.md)). |

Until the `communication confirmed` line, the plugin is not fully started: a command sent from Domoticz at that time is dropped (`onCommand - Not yet ready, plugin not fully started, we drop the command`). This is normal right after a restart.

### When you pair a device

| Message | Meaning |
| ------- | ------- |
| `Z4D opens the Zigbee network for <n> seconds` | The network accepts new devices (see [Add a new device](HowTo_Pairing-device.md)). |
| `[...] NEW OBJECT: Nwkid: 0x<short address> IEEE: 0x<ieee> Status: ...` | A device joined. Note the short address: you need it for `MatchingNwkId`. |
| `[...] NEW OBJECT: <short address> Model Name: ...`, `... Manufacturer Name: ...` | The device identity, used to look up its configuration in the certified database. |
| `NEW OBJECT: ... Request Node Descriptor`, `Request Simple Descriptor for Ep: ...` | The plugin discovers what the device offers. |

If the device is not optimized, the plugin log file also shows, at most once a day per device:

```
We have detected a working device <name> (<short address>) Model: <model> not optimized with the plugin.
 --- Please follow the link https://zigbeefordomoticz.github.io/wiki/en-eng/Problem_Dealing-with-none-optimized-device.html
```

This is not an error: it is an invitation to open an issue on z4d-certified-devices.

### During normal operation

* `UpdateDevice - (<widget name>) <nValue>:<sValue>` each time the plugin updates a Domoticz widget (when `logDeviceUpdate` is enabled, which is the default). If a sensor never shows this line, its messages don't reach the widget: see Case 1 of [Debug mode](Problem_Debuging-mode.md#case-1-a-sensor-doesnt-update-its-widgets-in-domoticz).
* `Z4D found a recent plugin version (...) on gitHub. You are on (...) ***` when an update is available.

### What is not normal

* Any message at the `ERROR` level (in red in the Domoticz log), and the red **Error(s) detected** triangle in the WebUI: see [Deal with plugin errors](HowTo_Dealing-plugin-errors.md).
* `Z4D reconnects after failure`: the plugin lost the coordinator and reconnects. Once in a while after a USB problem, it can happen; often, it is worth a look at the coordinator and its cable (see Case 3 of [Debug mode](Problem_Debuging-mode.md#case-3-the-coordinator-doesnt-start-or-loses-the-connection)).
* The start sequence stops before `communication confirmed`.

## 4. Use the debug parameters

By default, the plugin doesn't write debug messages. To understand a problem, or to send useful logs, you enable the debug modules of the part of the plugin concerned, in **WebUI > Tools > Debug** (enable **Advanced settings** to see all of them, then **Validate**). They take effect immediately, without restart. The full list is in [Debug mode](Problem_Debuging-mode.md#the-debugging-options).

1. **Limit to one device**: set `MatchingNwkId` to the short address of the device (for example `a1b2`), or several separated by commas. Keep `ffff` (all devices) when you pair a new device, as its short address is not known yet.
1. **Enable the modules** that match the problem:

   | Problem | Modules |
   | ------- | ------- |
   | A sensor doesn't update its widgets | `Input`, `Cluster`, `Widget`, `WidgetUpdate` |
   | A device doesn't react to commands from Domoticz | `Command`, `BasicOutput`, plus `Input` to see its answer |
   | Pairing a device (also for a z4d-certified-devices request) | `Pairing`, `Input`, `Cluster`, `WidgetCreation`, `DeviceAnnoucement` |
   | Reporting or binding doesn't work | `ConfigureReporting`, `Binding`, `ReadAttributes` |
   | A device of a given brand (Tuya, Lumi, Ikea, Legrand...) | The brand module (`Tuya`, `Tuya0601`, `Lumi`...) in addition to the above |
   | The coordinator doesn't start or loses the connection | The module of your coordinator (`ZigpyZNP`, `ZigpyEZSP`, `ZigpydeCONZ`, `ZigpyBLZ`) and `TransportZigpy`, then restart the plugin |
   | OTA, groups, WebUI | `OTA`, `Groups`, `WebServer` |

1. **Enable `logThreadName`** when you will send the logs: each line then shows the thread, the module and the device short address, which makes the analysis much easier.
1. **Reproduce the problem**, and note the time when it happens.
1. **Collect** the part of the plugin log file around that time.
1. **Disable the debug modules** when you are done (**Settings (default)** turns everything back to the defaults): some modules are very verbose and make the log file grow fast.

The `Python/zigpy...` modules show the messages of the zigpy library itself. They are very verbose: enable them only when asked.

## 5. What to put in the issue

### A bug on Domoticz-Zigbee

* The plugin version and branch: the `Z4D starts with ...` line, or the *Plugin* version on the WebUI Dashboard.
* The coordinator model and firmware: the `communication confirmed` line, or the *Firmware* version on the Dashboard.
* The Domoticz version, the Python version and the operating system.
* What you did, what you expected, and what happened instead, step by step so that it can be reproduced.
* The plugin log file excerpt around the problem, with the relevant debug modules enabled (see [above](#4-use-the-debug-parameters)). As a text file attachment, not a screenshot.
* The exported error history: *Tools > Error(s) > Log Error History (json)*, then *Export* (see [Deal with plugin errors](HowTo_Dealing-plugin-errors.md)).
* For a problem linked to a device: the device data, from *Tools > Tools*, **Plugin Raw Devices**, then *Export* (see [Use the plugin tools](HowTo_Using-tools.md)).

### A device on z4d-certified-devices

* The product name and brand, and a link to the product page or where you bought it.
* The discovery data: in *Management > Device Management*, click the orange icon of the device in the *Optimized* column, it is copied to the clipboard.
* What works, what doesn't, and what you expect.
* The pairing log, with the `Pairing` debug modules enabled (see [above](#4-use-the-debug-parameters)).
* If asked: the device data, from *Tools > Tools*, **Plugin Raw Devices**, then *Export* (`export.json`).

### Before posting

The logs and the exports contain details of your network (IEEE addresses, device names, network identifiers). Look at them before posting them publicly, and remove what you don't want to share.
