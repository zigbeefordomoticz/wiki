# The Web Interface — General Presentation

The plugin includes a built-in web interface accessible from your browser. It provides a graphical way to manage devices, monitor the Zigbee network, and configure the plugin without editing configuration files directly.

## Accessing the Web Interface

Please refer to [Step 3 — Plugin Configuration](Plugin_Configuration.md) for instructions on how to enable and access the web interface.

Once configured, the interface is available at:

```
http://<domoticz-ip>:<port>/z4d/
```

The port is the one set in the plugin's hardware parameters (9440 by default).

## Menu

The menu bar at the top of every page gives access to the following sections:

| Menu | Entries | Purpose |
|------|---------|---------|
| *(plugin name)* | — | [Dashboard](WebUI_Dashboard.md): overview of the plugin, the coordinator and the network. The menu shows the name you gave the plugin hardware in Domoticz. |
| [Management](WebUI_Management.md) | Device Management, Group Management | List, rename and configure the paired devices and the Zigbee groups |
| [Network](WebUI_Network.md) | Topology, [Mesh graph](WebUI_Network-Mesh.md) (from plugin 9.1.008), Interference level | Neighbour tables of the mesh, the mesh drawn as a graph, and an energy scan of the Zigbee channels |
| [Admin](WebUI_Admin.md) | Plugin, Provisionning, Group, Coordinator, Firmware | One page with a status bar and five tabs (from plugin 9.1.009; a drop-down menu before). *Plugin*: upgrade and restart the plugin. *Provisionning*: open the network for pairing, full-reset pairing, recreate widgets. *Group*: ask the routers for their groups. *Coordinator*: coordinator details, change the Zigbee channel, soft reset (ZiGate). *Firmware*: device firmware updates (OTA). |
| [Settings](WebUI_Settings.md) | — | The plugin settings |
| [Tools](WebUI_Tools.md) | Data, Command, Binding / Reporting, Debug, Errors | One page with five tabs (from plugin 9.1.009; before, a drop-down menu with *Tools*, *Command*, *Reporting*, *Binding*, *Debug* and *Error(s)*). *Data*: view and download the plugin data, and a support bundle for an issue. *Command*: send commands, or a raw Zigbee frame, to a device. *Binding / Reporting*: the bindings of a device, and its attribute reporting (zigpy coordinators). *Debug*: the debug logging settings. *Errors*: the errors recorded by the plugin. |
| [Manufacturer](WebUI_Manufacturer.md) | CASA.iA, ZLinky, TICmeter, Chameleon | Pages dedicated to some devices. The menu only appears when at least one of these devices is paired, and only lists the ones you have. |
| [About](WebUI_About.md) | — | Plugin version, where to find help (wiki, Domoticz forum, Keybase) and acknowledgements |

## Header elements

On the right of the menu bar:

* **Accept new hardware**: a switch that opens the network for pairing for 4 minutes, then closes it again. See [Add a new device](HowTo_Pairing-device.md).
* **Language**: a flag selects the interface language (English, French, Dutch, Spanish, German, Italian).
* **Restart needed** (blinking exclamation mark): a change is waiting for a plugin restart. Click it to go to *Admin > Plugin*, where the plugin can be restarted. From plugin 9.1.009, a *Restart needed* card also shows at the top of the *Admin* page.
* **Error(s) detected** (blinking red triangle): the plugin has recorded errors. Click it to go to *Tools > Errors* (*Tools > Error(s)* before plugin 9.1.009). See [Deal with errors](HowTo_Dealing-plugin-errors.md).

On a narrow screen the menu collapses behind a ☰ button, and the *Accept new hardware* switch and the language flag move to the bottom of that menu.

The plugin also sends anonymous usage statistics; what is sent and how to opt out is described on the [Statistics](WebUI_Statistics.md) page.

*The interface appearance may have changed since this documentation was written.*
