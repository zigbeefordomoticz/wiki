# Debugging mode for ZigBeeForDomoticZ Plugin

## Introduction

The aim of this document is to give you some hints on how to debug and also provide more information to the developer when reporting an issue.

## Where are the plugin logs?

By default (`enablePluginLogging` enabled), the plugin writes its logs in its own file, in the `Logs` folder of the plugin:

`Domoticz-Zigbee/Logs/PluginZigbee_<hardware id>.log` (for example `PluginZigbee_05.log` for the hardware with idx 5 in DomoticZ)

At startup, the DomoticZ log tells you which file is used: `Z4D Please watch plugin logs into .../Logs/PluginZigbee_05.log`.

* **Debug messages only go to this file.** Errors, warnings and status messages are also sent to the DomoticZ log.
* The file is rotated every night at midnight, and the last 7 files are kept (`loggingBackupCount`). If you set `loggingMaxMegaBytes` to a value above 0, the file is rotated when it reaches that size instead.
* If you disable `enablePluginLogging` (restart needed), there is no file: all messages, including debug, go to the DomoticZ log (`Z4D Plugin logs are redirected to Domoticz log`).

The errors are also kept in `Logs/PluginZigbee_log_error_history_<hardware id>.json`, with their context. You can download it from **WebUI > Tools > Error(s) > Log Error History (json)**, and attach it when you report an issue.

## The Debugging options

The debugging options are in the WebUI, menu **Tools > Debug**. Enable the **Advanced settings** switch to see the debug modules, check the ones you need and click **Validate**. They take effect immediately, no restart needed (except `enablePluginLogging`, `loggingBackupCount` and `loggingMaxMegaBytes`). **Settings (default)** turns everything back to the defaults.

Don't forget to disable the debug modules once you are done: some of them are very verbose.

### Logging options

| Option | Purpose |
| ------- | -------- |
| `MatchingNwkId` | Limits the debug messages linked to a device to the devices you list here: one short address (Nwkid, for example `a1b2`) or several separated by commas (`a1b2,3c4d`). `ffff` (default) means all devices. Messages that are not linked to a device are always logged. |
| `enablePluginLogging` | Enabled by default: the plugin logs go to the plugin log file (see above). Disabled: they go to the DomoticZ log. Requires a plugin restart. |
| `loggingBackupCount` | Number of old log files kept (default 7). Requires a plugin restart. |
| `loggingMaxMegaBytes` | 0 (default): new log file every day. Above 0: new log file when the file reaches this size in MB. Requires a plugin restart. |
| `logDeviceUpdate` | Enabled by default: logs each update of a DomoticZ widget by the plugin. |
| `logThreadName` | Adds the thread, the module and the device short address to each message. Useful when you send logs to the developers. |

### The main debug modules

Each module enables the debug messages of one part of the plugin. The ones you will need most often:

| Module | Description |
| ------ | ----------- |
| `Input` | Incoming messages from the coordinator |
| `Cluster` | Decoding of the incoming messages: this is where the plugin extracts the values from the message payload |
| `Widget`, `WidgetUpdate` | Update of the DomoticZ widgets, usually called from Input or Cluster |
| `WidgetCreation` | Creation of the DomoticZ widgets at pairing |
| `Command` | Actions coming from DomoticZ (switch on, set level...) |
| `BasicOutput` | Commands sent to the devices |
| `Pairing` | Pairing of a new device |
| `DeviceAnnoucement` | Device announcements (a device joins or comes back on the network) |
| `ConfigureReporting`, `Binding`, `ReadAttributes`, `WriteAttributes` | Configuration of the devices by the plugin |
| `DeviceParameter` | [Device parameters](HowTo_Device-parameters.md) |
| `Heartbeat` | Recurring actions, executed every 5s |
| `Database` | Plugin database and device configuration files |
| `Groups` | Group management |
| `OTA` | Over-the-air firmware updates |
| `Plugin` | The plugin program itself |
| `WebServer` | The WebUI and REST API |

There are also modules per brand or device family (`Tuya`, `Tuya0601`, `TuyaTS011F`, `Lumi`, `Ikea`, `Legrand`, `Philips`, `Schneider`, `Sonoff`, `Danfoss`, `Profalux`, `ZLinky`, `Thermostats`...), and for the coordinator and the zigpy library:

| Module | Description |
| ------ | ----------- |
| `ZigpyZNP`, `ZigpyEZSP`, `ZigpydeCONZ`, `ZigpyBLZ` | The radio library of your coordinator (Texas Instruments, Silicon Labs, ConBee/RaspBee, Bouffalo Lab) |
| `Zigpy`, `TransportZigpy` | The link between the plugin and zigpy |
| `Python/zigpy`, `Python/zigpy-application`, `Python/zigpy-device`, `Python/zigpy-zcl`, `Python/zigpy-zdo`... | The zigpy library itself (very verbose) |
| `ZigpyDefaultLoggingInfo` | Logs the zigpy library messages at INFO level |

## Use Cases

### Case 1: A sensor doesn't update its widgets in DomoticZ

In that case you need to check if we have incoming messages, if they are correctly processed, and if they are pushed to DomoticZ for update.

1. Find the short address of the sensor (see [below](#short-address-and-ieee)).
1. In **Tools > Debug**, enable `Input`, `Cluster`, `Widget` and `WidgetUpdate`.
1. Set `MatchingNwkId` to the short address of this particular sensor, so you limit the logs to it.
1. Do whatever is needed to make the sensor send messages, and collect the logs in the plugin log file for analysis.

### Case 2: A new device is paired, but it looks like it is not well recognized

1. In **Tools > Debug**, enable `Pairing`, `Input`, `Cluster`, `Widget`, `WidgetCreation`, `Command` and `BasicOutput`.
1. Set `MatchingNwkId` to the short address of this device, so you limit the logs to it. If you enable the modules before pairing, the short address is not known yet: keep `ffff`.
1. Perform actions from DomoticZ and check the logs (`Command` and `BasicOutput`).
1. Perform actions on the device to stimulate activities and check the logs (`Input`, `Cluster`, `Widget`).

See also [Dealing with not-optimized devices](Problem_Dealing-with-none-optimized-device.md).

### Case 3: The coordinator doesn't start or loses the connection

1. Enable the module of your coordinator (`ZigpyZNP`, `ZigpyEZSP`, `ZigpydeCONZ` or `ZigpyBLZ`) and `TransportZigpy`.
1. Restart the plugin and collect the logs from the start.

## Short Address and IEEE

* You can get the Short Address and/or the IEEE of the Device:
  * via the Plugin Web Interface in the **Management > Device Management** menu (short address and IEEE columns)
  * via DomoticZ, in **Setup > Devices**: the IEEE can be found in the ID column

The short address can change when a device leaves and joins the network again: check it again if a device is re-paired.
