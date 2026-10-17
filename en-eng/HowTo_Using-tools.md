# Web Admin: Tools page

The *Tools > Tools* page of the WebUI gives access to a set of REST APIs that query the plugin's memory directly. It is mainly for developers and for troubleshooting: click a button to display the data as JSON, then *Export* to download it as `export.json`.

For troubleshooting you might be asked to export the __Plugin Raw Devices__ data.

## The buttons

| Button | REST API | Returns |
| ------ | -------- | ------- |
| Plugin Raw Devices | `/zdevice-raw` | The plugin's device database in memory: everything the plugin knows about each device. |
| Non-optimized devices | `/non-optmize-device-configuration/<NwkId>` | The discovery data of each device the plugin has no certified configuration for (see [Dealing with a non-optimized device](Problem_Dealing-with-none-optimized-device.md)). |
| Plugin Groups | `/zgroup` | The plugin's group database. |
| Traffic | `/plugin-stat` | The plugin statistics: messages sent and received, load… |
| Coordinator info | `/coordinator` | Coordinator information: firmware version, channel… |
| Plugin Logs | `/plugin-log` | Downloads the current plugin log file. Only shown when the plugin writes its own log file (`enablePluginLogging`). |
| Plugin info | `/plugin` | The Domoticz plugin parameters. |
| Plugin health | `/plugin-health` | The plugin health status. |
| Settings | `/setting` | The plugin settings and their values. |
| domoticz-env | `/domoticz-env` | **The Domoticz user name and password configured in the plugin settings.** Don't paste this output into a public issue or forum post. |
| Battery State | `/battery-state` | Battery information of the devices, by level and update time. |
| zDevice-name | `/zdevice-name` | The data of the *Device Management* page (names, model, health…). |
| zGroup-lst-devices | `/zgroup-list-available-device` | The devices and widgets that can be put in a group. |
| OTA Firmware Available | `/ota-firmware-available` | The firmware images loaded by the plugin for over-the-air updates. |
| IEEE to NWK Raw | `/ieee2nwk-raw` | The table matching each device's IEEE address to its short address (NwkId). |
| Help | `/help` | The list of all REST API commands and the HTTP verbs each accepts. |
| Zlinky | `/zlinky` | The data of the ZLinky TIC devices. |
| Gamma-Troniques TICmeter | `/gamma-troniques-ticmeter` | The data of the Gamma-Troniques TICmeter devices. |
| Chameleon TICmeter | `/chameleon-ticmeter` | The data of the Chameleon Technology TICmeter devices. |

## How to use the REST API

The WebUI calls the plugin's REST API under the `/rest-z4d/1/` prefix (the older `/rest-zigate/1/` prefix is still accepted). You can call it yourself, for example to check the plugin health:

`curl http://127.0.0.1:9440/rest-z4d/1/plugin-health`

Replace `9440` with the port set in the plugin hardware parameters if you changed it.

See [REST API](Technical/REST-API.md) for the full list of endpoints.
