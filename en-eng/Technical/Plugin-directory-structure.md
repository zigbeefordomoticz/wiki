# Plugin directory structure

The plugin is installed in `domoticz/plugins/Domoticz-Zigbee`. Its main folders:

| Folder | Content | Access rights |
| ------ | ------- | ------------- |
| `Classes` | Python classes (transport, WebServer, group management, OTA…) | read only for the user running Domoticz, except when updating |
| `Modules` | Python modules | read only, except when updating |
| `DevicesModules` | Manufacturer-specific device modules | read only, except when updating |
| `Z4D_decoders` | Decoders of the messages received from the coordinator | read only, except when updating |
| `Zigbee` | Zigbee helpers (ZCL, ZDP commands) | read only, except when updating |
| `www` | The WebUI | read only, except when updating |
| `Conf` | Configuration: `Local-Devices` (your own device configuration files), `ZclDefinitions` (Zigbee cluster definitions) | read/write for the user running Domoticz |
| `Data` | The plugin databases (`DeviceList-<hardware id>.txt`, groups, settings, coordinator backups…) | read/write for the user running Domoticz |
| `OTAFirmware` | Firmware files for over-the-air device updates | read/write for the user running Domoticz |
| `Logs` | The plugin log files, when the plugin writes its own logs | read/write for the user running Domoticz |
| `Reports` | Topology and interference scan reports | read/write for the user running Domoticz |
| `Tools` | Command-line tools and scripts | read only |

The certified device configuration files are not in this folder: they come with the `z4d-certified-devices` Python package (see [Device configuration files](Device_Configuration_file.md)).
