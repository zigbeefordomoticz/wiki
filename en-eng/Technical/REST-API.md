# REST API

The plugin WebUI talks to the plugin through a REST API, served on the *Plugin WebUI port* of the plugin hardware (9440 by default). You can call it yourself, for scripts or troubleshooting.

## Security

**The REST API has no authentication of its own**: anyone who can reach the port can read the plugin data (including, with `domoticz-env`, the Domoticz user name and password set in the plugin) and send commands to the coordinator and the devices.

* By default the plugin listens on all the network interfaces. Set the *Plugin WebUI port* hardware parameter to `127.0.0.1:9440` to accept local connections only.
* Never expose the port to the Internet. To reach the WebUI from outside, put it behind a reverse proxy with authentication: see [Reverse proxy with Caddy](../HowTo_Reverse-Proxy-with-Caddy.md), [Reverse proxy with Apache 2](../HowTo_Reverse-Proxy-with-Apache2.md) and [Dashboard access with basic authentication](../HowTo_Dashboard-Access-Basic-Auth.md).

## Format

`http://<host>:<port>/rest-z4d/<version>/<command>[/<parameter>…]`

For example:

```bash
curl http://127.0.0.1:9440/rest-z4d/1/plugin-health
```

* The version is `1`.
* The older prefix `/rest-zigate/` is still accepted.
* Parameters are added to the path: `/rest-z4d/1/zdevice-raw/<NwkId>`.
* `PUT` requests take a JSON body: `curl -X PUT -d '{"PermitToJoin": 240}' http://127.0.0.1:9440/rest-z4d/1/permit-to-join`.
* `/rest-z4d/1/help` lists all the commands and the verbs each one accepts.

`<NwkId>` is the short network address of a device (4 hexadecimal digits) and `<IEEE>` its IEEE address (16 hexadecimal digits). Most commands that take one accept the other.

The commands below are those of plugin 9.1.007 (`stable9`).

## Plugin

| Command | Verbs | Description |
| ------- | ----- | ----------- |
| `plugin` | GET | The Domoticz hardware parameters of the plugin. |
| `plugin-health` | GET | Plugin health: `HealthFlag` (0 off, 1 operational, 2 operational but under load, 3 problem) and `HealthTxt`. |
| `plugin-ping` | GET | Returns `{"status": "Ok"}` when the plugin answers. |
| `plugin-stat` | GET | Transport statistics: messages sent and received, load, errors… |
| `plugin-log` | GET | The current plugin log file, when the plugin writes its own log (`enablePluginLogging`). |
| `plugin-restart` | GET | Restart the plugin (through the Domoticz API). |
| `plugin-upgrade` | GET | Upgrade the plugin from its git repository (as *Admin > Plugin* does). |
| `upgrade-certified-devices` | GET | Upgrade the `z4d-certified-devices` package. |
| `restart-needed` | GET | Whether a settings change requires a plugin restart. |
| `setting` | GET, PUT | The plugin settings and their values; PUT changes them. |
| `setting-debug` | GET, PUT | Same, including the debug settings. |
| `domoticz-env` | GET | The Domoticz environment, **including the Domoticz user name and password** set in the plugin. |
| `log-error-history` | GET | The errors recorded by the plugin (*Tools > Error(s)*). |
| `clear-error-history` | GET | Empty the error history. |
| `help` | GET | The list of the commands and their verbs. |

## Coordinator

| Command | Verbs | Description |
| ------- | ----- | ----------- |
| `coordinator` | GET | Coordinator information: IEEE, short address, PAN ID, extended PAN ID, channel, firmware. |
| `change-channel` | PUT | Move the network to another channel: `{"Channel": 15}` (11 to 26). See [Change the Zigbee channel](../HowTo_Change-ZigBee-channel.md). |
| `sw-reset-coordinator` | GET | Restart (software reset) the coordinator. |
| `coordinator-erase-PDM` | GET | ZiGate only: erase the ZiGate memory, when the `eraseZigatePDM` setting is on. |
| `coordinator-mode` | GET | ZiGate only, no longer active. |
| `permit-to-join` | GET, PUT | The time left in pairing mode (`PermitToJoin`: 0 closed, 255 permanent). PUT opens or closes it: `{"PermitToJoin": 240}` for 4 minutes, `0` to close; add `"Router": "<NwkId>"` to open it on one router only. |

`zigate`, `zigate-erase-PDM`, `zigate-mode` and `sw-reset-zigate` are the old names of the coordinator commands, still accepted.

## Pairing

| Command | Verbs | Description |
| ------- | ----- | ----------- |
| `new-hrdwr/<action>` | GET | Pairing assistant: `enable` starts it (and opens the network for 4 minutes), `disable` or `cancel` stops it. |
| `rcv-nw-hrdwr` | GET | The devices that joined since the assistant started, with their pairing progress. |
| `full-reprovisionning` | PUT | *Reset mode* of a device: `{"NWKID": "<NwkId>"}` or `{"IEEE": "<IEEE>"}`. The plugin forgets the bindings, reporting and attributes, and redoes a full discovery at the next pairing. |
| `recreate-widgets` | PUT | Create the Domoticz widgets of a device again: `{"NWKID": "<NwkId>"}` or `{"IEEE": "<IEEE>"}`. |
| `change-model` | PUT | Change the model of a device and recreate its widgets: `{"NWKID": "<NwkId>", "Model": "<model>"}`. |

## Devices

| Command | Verbs | Description |
| ------- | ----- | ----------- |
| `zdevice` | GET | The devices with their main information. |
| `zdevice-name` | GET, PUT, DELETE | The *Device Management* data (name, model, health, widgets…). PUT updates the device names and device parameters; `DELETE zdevice-name/<NwkId>` removes a device from the plugin. |
| `zdevice-raw` | GET, PUT | The full plugin database (`ListOfDevices`), or one device with `zdevice-raw/<NwkId>`. |
| `ieee2nwk-raw` | GET | The IEEE → NwkId table. |
| `device` | GET | The Domoticz widgets of the plugin, or one with `device/<IEEE>`. |
| `dev-cap/<NwkId>` | GET | The actions a device supports (used by *Tools > Command*). |
| `dev-command` | PUT | Send an action to a device: `{"Command": "On", "NwkId": "<NwkId>", "Value": "", "Color": ""}` (*Tools > Command*). |
| `device-param` | GET, PUT | The device parameters: `device-param/<NwkId>`; PUT `{"NWKID": "<NwkId>", "Param": {…}}`. See [Device parameters](../HowTo_Device-parameters.md). |
| `device-settings-help` | GET | The list of the device parameters known to the plugin, with their description. |
| `battery-state` | GET | Battery devices by level and by date of the last battery update. |
| `non-optmize-device-configuration/<NwkId>` | GET | The discovery data of a device, as a draft configuration file (see [Dealing with a non-optimized device](../Problem_Dealing-with-none-optimized-device.md)). |
| `raw-zigbee` | PUT | Send a raw Zigbee frame (*Tools > Command*, zigpy): `TargetAddr`, `TargetEp`, `SourceEp`, `ProfileId`, `ClusterId`, `Payload`, `GroupAddressFlag`, `AckMode`… |
| `raw-command` | PUT | ZiGate only: send a raw ZiGate command `{"Command": "<msg type>", "payload": "<hex>"}`. |

## Reporting

| Command | Verbs | Description |
| ------- | ----- | ----------- |
| `cfgrpt-ondemand/<NwkId>` | GET | Send the reporting configuration to the device now (*Tools > Reporting*, *Trigger*). |
| `cfgrpt-ondemand-config/<NwkId>` | GET, PUT, DELETE | Your reporting configuration of a device: read it, save it (PUT), or drop it to go back to the plugin defaults (DELETE). |

## Groups

| Command | Verbs | Description |
| ------- | ----- | ----------- |
| `zgroup` | GET, PUT | The groups and their members; PUT saves the groups (*Management > Group Management*). |
| `zgroup-list-available-device` | GET | The device endpoints that can be put in a group. |
| `rescan-groups` | GET | Ask every router for its group memberships (*Admin > Group*, *Full scan*). |
| `scan-device-for-grp` | PUT | Scan some devices only: a JSON list of NwkIds. |

## Binding

| Command | Verbs | Description |
| ------- | ----- | ----------- |
| `bind-lst-cluster` | GET | The clusters that can be bound. |
| `bind-lst-device/<cluster>` | GET | The devices (and endpoints) that have this cluster. |
| `binding`, `unbinding` | PUT | Bind or unbind two devices: `{"sourceIeee", "sourceEp", "destIeee", "destEp", "cluster"}`. |
| `binding-group`, `unbinding-group` | PUT | Bind or unbind a device to a group: `{"sourceIeee", "sourceEp", "groupId", "cluster"}`. |
| `binding-table-req/<NwkId>` | GET | Ask the device for its binding table. |
| `binding-table-disp/<NwkId>` | GET | The binding table received from the device. |

See [Bind two devices](../HowTo_Binding.md).

## Network

| Command | Verbs | Description |
| ------- | ----- | ----------- |
| `req-topologie` | GET | Start a topology scan. |
| `topologie` | GET, DELETE | The list of topology reports (timestamps), or one report with `topologie/<timestamp>`. DELETE removes a report. |
| `req-nwk-inter` | GET | Start an interference (energy) scan. |
| `req-nwk-full` | GET | ZiGate only: interference scan on every router. |
| `nwk-stat` | GET, DELETE | The list of interference reports, or one with `nwk-stat/<timestamp>`. DELETE removes a report. |

## Firmware update (OTA)

| Command | Verbs | Description |
| ------- | ----- | ----------- |
| `ota-firmware-list` | GET | The firmware files available to the plugin. |
| `ota-firmware-device-list/<manufacturer code>` | GET | The devices of a manufacturer that a firmware could update. |
| `ota-firmware-update` | PUT | Start the update of a device with a firmware. |
| `ota-firmware-available` | GET | The firmware images loaded by the plugin. |

See [Upgrading device firmware](../HowTo_Update-device-firmware.md).

## Manufacturer pages

| Command | Verbs | Description |
| ------- | ----- | ----------- |
| `casaia-list-devices` | GET | The CASA.iA AC201 controllers and their infrared code. |
| `casaia-update-ircode` | PUT | Set the infrared code of CASA.iA controllers. |
| `zlinky` | GET | The data of the ZLinky devices. |
| `zlinky-stge/<NwkId>` | GET | The decoded STGE status register of a ZLinky. |
| `gamma-troniques-ticmeter` | GET | The data of the Gamma-Troniques TICmeter devices. |
| `chameleon-ticmeter` | GET | The data of the Chameleon TIC readers. |

See [WebUI Manufacturer](../WebUI_Manufacturer.md).
