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
| [Admin](WebUI_Admin.md) | Plugin, Provisionning, Group, Coordinator, Firmware | *Plugin*: upgrade and restart the plugin. *Provisionning*: open the network for pairing, full-reset pairing, recreate widgets. *Group*: rescan the groups. *Coordinator*: software reset, change the Zigbee channel. *Firmware*: device firmware updates (OTA). |
| [Settings](WebUI_Settings.md) | — | The plugin settings |
| [Tools](WebUI_Tools.md) | Tools, Command, Reporting, Binding, Debug, Error(s) | *Tools*: buttons that display (and export) plugin data — plugin and coordinator info, devices, groups, battery state, traffic, plugin health, plugin logs… *Command*: send raw Zigbee commands. *Reporting*: attribute reporting configuration (only shown with a zigpy coordinator). *Binding*: bind clusters between devices. *Debug*: the debug logging settings. *Error(s)*: the errors recorded by the plugin. |
| Manufacturer | CASA.iA, ZLinky, TICmeter, Chameleon | Pages dedicated to some devices. The menu only appears when at least one of these devices is paired, and only lists the ones you have. |
| [About](WebUI_About.md) | — | Plugin version, where to find help (wiki, Domoticz forum, Keybase) and acknowledgements |

## Header elements

On the right of the menu bar:

* **Accept new hardware**: a switch that opens the network for pairing for 4 minutes, then closes it again. See [Add a new device](HowTo_Pairing-device.md).
* **Language**: a flag selects the interface language (English, French, Dutch, Spanish, German, Italian).
* **Restart needed** (blinking exclamation mark): a change is waiting for a plugin restart. Click it to go to *Admin > Plugin*, where the plugin can be restarted.
* **Error(s) detected** (blinking red triangle): the plugin has recorded errors. Click it to go to *Tools > Error(s)*. See [Deal with errors](HowTo_Dealing-pluging-error.md).

On a narrow screen the menu collapses behind a ☰ button, and the *Accept new hardware* switch and the language flag move to the bottom of that menu.

The plugin also sends anonymous usage statistics; what is sent and how to opt out is described on the [Statistics](WebUI_Statistics.md) page.

*The interface appearance may have changed since this documentation was written.*
