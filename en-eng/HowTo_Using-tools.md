# Web Admin: Tools page

The *Tools > Data* tab of the WebUI gives access to a set of REST APIs that query the plugin's memory directly. It is mainly for developers and for troubleshooting: *View* displays an item as JSON, *Download* saves it as `z4d-<item>.json`, and the **Support bundle** puts several items in one file to attach to an issue (see [WebUI Tools](WebUI_Tools.md#data)).

Before plugin 9.1.009, the page is *Tools > Tools*: one button per item, and *Export* downloads the item shown as `export.json`. The button names are in the last column below.

For troubleshooting you might be asked for the **Devices (raw)** data, or for the support bundle.

## The items

| Item | REST API | Returns | Before 9.1.009 |
| ---- | -------- | ------- | -------------- |
| **Plugin** | | | |
| Plugin information | `/plugin` | The Domoticz plugin parameters: version, branch, coordinator, Domoticz. | Plugin info |
| Plugin health | `/plugin-health` | The plugin health status, and what it is doing (pairing, group scan, OTA…). | Plugin health |
| Plugin statistics | `/plugin-stat` | The plugin statistics: messages sent and received, load… | Traffic |
| Settings | `/setting` | The plugin settings and their values. | Settings |
| Domoticz environment | `/domoticz-env` | The Domoticz access used by the plugin, **including the Domoticz user name and password**. They are removed from the download and the copy, but shown by *View*. | domoticz-env |
| Plugin log | `/plugin-log` | Downloads the current plugin log file. Only there when the plugin writes its own log file (`enablePluginLogging`). | Plugin Logs |
| **Devices** | | | |
| Devices (raw) | `/zdevice-raw` | The plugin's device database in memory: everything the plugin knows about each device. | Plugin Raw Devices |
| Device names | `/zdevice-name` | The data of the *Device Management* page (names, model, health, parameters…). | zDevice-name |
| IEEE to NwkId | `/ieee2nwk-raw` | The table matching each device's IEEE address to its short address (NwkId). | IEEE to NWK Raw |
| Battery state | `/battery-state` | Battery information of the devices, by level and update time. | Battery State |
| Non-optimised devices | `/non-optmize-device-configuration/<NwkId>` | The discovery data of each device the plugin has no certified configuration for (see [Dealing with a non-optimized device](Problem_Dealing-with-none-optimized-device.md)). | Non-optimized devices |
| **Groups** | | | |
| Groups | `/zgroup` | The plugin's group database. | Plugin Groups |
| Devices available for groups | `/zgroup-list-available-device` | The devices and widgets that can be put in a group. | zGroup-lst-devices |
| **Coordinator and firmware** | | | |
| Coordinator information | `/coordinator` | Coordinator information: firmware version, channel… The network key is removed from the download and the copy. | Coordinator info |
| Firmware available | `/ota-firmware-available` | The firmware images loaded by the plugin for over-the-air updates. | OTA Firmware Available |
| **Manufacturer** | | | |
| ZLinky | `/zlinky` | The data of the ZLinky TIC devices. | Zlinky |
| Gamma Troniques TICmeter | `/gamma-troniques-ticmeter` | The data of the Gamma-Troniques TICmeter devices. | Gamma-Troniques TICmeter |
| Chameleon TICmeter | `/chameleon-ticmeter` | The data of the Chameleon Technology TICmeter devices. | Chameleon TICmeter |
| **Reference** | | | |
| REST API help | `/help` | The list of all REST API commands and the HTTP verbs each accepts. | Help |

The support bundle can also hold the **Error history** (`/log-error-history`, see [Deal with plugin errors](HowTo_Dealing-plugin-errors.md)). The downloads, the copies and the bundle have the passwords, the Domoticz credentials and the network key removed. Look at a file before posting it publicly all the same: it still holds the details of your network and devices.

## How to use the REST API

The WebUI calls the plugin's REST API under the `/rest-z4d/1/` prefix (the older `/rest-zigate/1/` prefix is still accepted). You can call it yourself, for example to check the plugin health:

`curl http://127.0.0.1:9440/rest-z4d/1/plugin-health`

Replace `9440` with the port set in the plugin hardware parameters if you changed it.

See [REST API](Technical/REST-API.md) for the full list of endpoints.
