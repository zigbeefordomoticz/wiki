# Web Admin: Tools page

This page give access to a set of REST API to query directly the plugin memory. This page is mainly for developers and for debugging purposes.
The REST API are mainly developped to be used by the plugin Web Admin interface.

For troubleshooting purposes you might be asked to do an export.json of the __Plugin Raw devices (json)__

| Tools                       | REST API        | Usage | Description |
| -----                       | --------------- | ----- | ----------- |
| Infos plugin (json)         |  /plugin        | dev   | Domoticz plugin parameters |
| Plugin Raw devices (json)   |  /zdevice-raw   | debug | Plugin database in memory |
| zDevice-name (json)         |  /zdevice-name  | dev   |
| Infos zigate (json)         |  /zigate        | debug | Provide ZiGate related information as Channel, Firmware version ... |
| Plugin health (json)        |  /plugin-health | debug | Provide health status |
| domoticz-env (json)         |  /domoticz-env  | dev   | provide Domoticz UserName/Password and port defined in the plugin Web Ui Settings |
| Domoticz Widgets (json)     |  /device        | dev   | Provide DomoticZ widgets information |
| zGroup-lst-devices (json)   |  /zgroup-list-available-device | dev | List the potential devices with their Dz Widget whcih can be managed in a group |
| Plugin Devices (json)       |  /zdevice       | dev   | Provide information for all plugin devices |
| Settings (json)             |  /settings      | dev   | Provide the list of plugin settings |
| Plugin Groups (json)        |  /zgroup        | debug | Provide the group plugin database |
| Traffic (json)              |  /plugin-stat   | debug | dump all plugin statistics |

## How to use the REST API

If you want to call /plugin-health in order to check the plugin health

`wget <http://127.0.0.1:9440/rest-zigate/1/plugin-stat>`
