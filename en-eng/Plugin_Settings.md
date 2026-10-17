# Plugin settings

This is step 2 of the installation: declare the plugin hardware in Domoticz. You should have finished [Step 1: Plugin installation](Plugin_Installation.md).

## Add the plugin hardware

1. Open Domoticz in your browser.
1. Go to *Setup > Hardware*.
1. Fill in the parameters below, then click **Add**.

![Domoticz hardware page for the plugin](Images/EN_Domoticz-Hardware.png)
*This picture may have changed since this documentation was written.*

| Parameter | What to set | Notes |
| --------- | ----------- | ----- |
| **Name** | A name for this plugin instance, for example `Zigbee`. | It prefixes the name of every widget the plugin creates. With several coordinators, there is one plugin hardware per coordinator: the name tells them apart. Avoid spaces and special characters: the name can end up in URLs. |
| **Type** | *Zigbee for domoticz plugin (zigpy enabled)* | If it isn't in the list, the plugin is not installed correctly (see [Plugin installation](Plugin_Installation.md)). |
| **Coordinator Model** | The coordinator family: *Texas Instruments ZNP (via zigpy)*, *Silicon Labs EZSP (via zigpy)*, *Conbee/Rasbee I, II, III (via zigpy)*, *Bouffalo Lab Zigbee (via zigpy)*, or *ZiGate* / *ZiGate+* (no longer supported). | See [Compatible coordinators](Coordinators.md). |
| **Coordinator connection type** | How the coordinator is connected: **USB** for a USB dongle (or a module on a serial port); **Socket** for a network coordinator (Ethernet or Wi-Fi) with a zigpy coordinator model; *DIN*, *PI* and *TCPIP* are for ZiGate; *None* is a test mode without coordinator. | *USB* uses 115200 baud and no flow control. If your coordinator needs other values, pick the matching *USB, \<baudrate\>, \<flow control\>* entry (for example *USB, 115200, hardware*). |
| **Serial Port** | The serial port of the coordinator (USB connection). | Prefer the persistent name under `/dev/serial/by-id/…`: `/dev/ttyUSB0` can change after a reboot (see [Persistent USB devices](https://wiki.domoticz.com/PersistentUSBDevices)). |
| **Socket or TCPIP IP** | The IP address of a network coordinator (*Socket* or *TCPIP*). | Leave `0.0.0.0` otherwise. |
| **Socket or TCPIP Port** | The port of a network coordinator. | For example `6638` for SMLIGHT SLZB coordinators; check your coordinator's documentation. Leave `9999` otherwise. |
| **API base url** | The Domoticz address, as seen from the plugin: `http://127.0.0.1:8080` by default. | Change the port if Domoticz doesn't listen on 8080. If Domoticz asks for a login for local connections, use `http://username:password@127.0.0.1:8080`. |
| **Plugin WebUI port** | The port of the plugin WebUI, `9440` by default. | Use another port for each plugin instance. `127.0.0.1:9440` restricts the WebUI to the local machine (for use behind a reverse proxy); `None` disables it. |
| **Initialize Coordinator** | *False*, except to start a new network on a coordinator. | With a zigpy coordinator, if `autoRestore` is on (default) and a coordinator backup exists, the plugin **restores that backup** instead of forming a new network. Otherwise **the coordinator is erased and a new network is formed: all paired devices must be paired again.** It doesn't remove anything from Domoticz or from the plugin database. See below. |
| **Debugging** | *None* | The debug options are now in the WebUI, *Tools > Debug* (see [Debug mode](Problem_Debuging-mode.md)). |

## First start and new networks

A **blank** zigpy coordinator (a new one, or one reset to factory settings) gets a network at the first start, with *Initialize Coordinator* left to *False*: the plugin restores the most recent coordinator backup if `autoRestore` is on (default) and a backup exists, and forms a new network otherwise. See [Replace or migrate the coordinator](HowTo_Replace-coordinator.md).

**Initialize Coordinator** is only needed to start a new network on a coordinator that already has one:

1. If a coordinator backup exists (`Data/Coordinator-<hardware id>.backup`), turn the `autoRestore` setting off in the WebUI *Settings* (*Zigpy CIE specific configuration*, advanced): otherwise the plugin restores that backup instead of forming a new network.
1. Set **Initialize Coordinator** to *True* and click **Update**.
1. The plugin forms the new network, then sets **Initialize Coordinator** back to *False* and restarts by itself. Check it in the hardware list, and set it back to *False* yourself if it isn't (otherwise the network is formed again at each start).
1. Pair the devices again, then turn `autoRestore` back on.

With a ZiGate, *Initialize Coordinator* erases the ZiGate and forms a new network.

If the network isn't formed, see [Form a network with a zigpy coordinator](HowTo_Form-network-zigpy.md).

## Changing a parameter later

Click the plugin line in the hardware list, change the parameter and click **Update**: the plugin restarts with the new value. **Don't click Add**, which would create a second plugin instance.

Most of the plugin behaviour is not set here but in the WebUI *Settings* page: see [Step 3: Plugin configuration](Plugin_Configuration.md).

## The plugin's administration widgets

At start-up, the plugin creates two widgets of its own, in the Domoticz *Utility* tab (`xx` is the Domoticz hardware ID of the plugin):

![Administration widgets](../Images/Widgets_Admin.png)

Like all the plugin widgets, they can only be created while the Domoticz setting *Accept new Hardware Devices* is on (*Setup > Settings > System*, see [Add a new device](HowTo_Pairing-device.md#before-you-start-let-domoticz-accept-new-devices)).

### Z4D Status xx

An alert widget showing the state of the plugin. Its log keeps the history of the states.

| State | Color | Meaning |
| ----- | ----- | ------- |
| *Startup* | grey | The plugin is starting. |
| *Ready* | green | Normal state: the plugin handles messages and commands. |
| *Enrollment* | orange | A device is being paired. |
| *Busy* | orange | Many commands are waiting to be sent to the coordinator: you may notice delays. |
| *No Communication* | red | The plugin can't talk to the coordinator. |

### Z4D Notifications xx

A text widget showing the last plugin notification. Its log keeps the history. For example:

* a device paired, or a pairing that failed;
* a device that left the network, or was removed;
* a topology or interference report available;
* the coordinator channel, or a network problem.

![Notifications widget log](../Images/Widget_Notifications.png)
