# Plugin settings

This is the second step of the ZigBeeForDomoticZ Plugin installation process.

You should have finished the [Step 1 Plugin installation](Plugin_Installation.md)

## Seetings

* Open __DomoticZ__ in your navigator.

* Go to then __Configuration__ menu then __Hardware__

* To add the ZigBeeForDomoticZ Plugin, fill the following informations  :

| Parameter    | Description | Information |
| ------------ | ------------------ | ----------- |
| __Name__                  | Fill a Coordinator's Name  | This is the name you want to set for the instance of the plugin. In case you run several coordinators, you'll have several instance of this Plugin Hardware and so the name will help you to distinguish each of them.<br/><br/>It is advisable not to put any space or special character in the name of the Plugin. This name can be used in a URL and a space or special characters can generate problems. |
| __Type__                 | Select `ZigBeeForDomoticZ plugin` | If ZigBeeForDomoticZ plugin does not appear at the bottom of the list, it is because the plugin is not properly installed.
| __Coordinator Model__         | Select the Coordinator's model | - ZiGate (V1)<br/> - ZiGate+ (V2)<br/> - Texas Instruments ZNP<br/> - Silicon Labs EZSP<br/> - ConBee/RasBee|
| __Coordinator  Type__         | Select the Coordinator's type | -  USB<br/>-  DIN<br/>- PI<br/>- TCPIP (wifi or Ethernet)<br/>- Aucun|
| __Port série__           | Select the USB port to which the coordinator is plugged | Remember to fix the port of your usb equipment [Persistent USB](https://www.domoticz.com/wiki/PersistentUSBDevices)|
| __IP__                   | Fill in the coordinator's IP address | For TCPIP mode only<br/>Leave 0.0.0.0 for other modes |
| __Port__                 | Fill the Coordinator's Port (9999 by default)| For TCPIP mode only<br/>Leave 9999 for other modes |
| __API base url__ | Fill the address of the DomoticZ server | Address form <http://username:password@127.0.0.1:port> <br/>By default : <http://127.0.0.1:8080> |
| __WebUI Port__| Fill in the port to access the web administration of the Plugin (9440 by default). | To be modified when using several instances of the Plugin.. |
| __Initialize Coordinator__ | Select True to initialize the coordinator with the plugin settings (False by default). <br/>__Must be activated__ during initial configuration (ou after an Erase EEPROM of a ZiGate). | __ATTENTION :__ Activation will erase all pairing information from the coordinator.<br/> Restart the Plugin to start initialization. Verify that the setting is in a False state after reboot. |
| __Debugging__ | Leave empty |

* If it is for a first installation of the Plugin with a new coordinator, set Initialize Coordinator to __True__, otherwise always leave to __False__ (this parameter erases the coordinator's information).

* Click on __Add__.

The line corresponding to your ZigBeeForDomoticZ plugin (with the name defined) normally appeared in the hardware list.

* Click on the line of your ZigBeeForDomoticZ plugin.

__ATTENTION :__ From now on, you should not click on the __Add__ button at the bottom: this would have the effect of duplicating the plugin. Always go up to the top of the settings to use the __Modify__.

* Set __Initialize ZCoordinator (Erase Memory)__ to __False__.

* Unchecked __Activate__ to disable the plugin.

* Click on __Modify__ (do not click Add as this will duplicate the plugin).

* Reclick on the plugin ZigBeeForDomoticZ line.

* Recheck __Activate__ to reactivate the Plugin.

* Click on __Modifier__ to relaunch the Plugin.

Check the logs that the ZigBeeForDomoticZ plugin initializes correctly.

![Domoticz Hardware Menu for Plugin](Images/FR_Plugin-Parametrage.png)

*This page may have have changed since this documentation was written.*

## The Plugin's Widgets

### Status Widget

The plugin is providing 2 widgets for administration purposes. Those Widgets are created by the plugin itself at startup phase

![Administration Widgets](../Images/Widgets_Admin.png)

In domoticz you will find a Widget name 'Zigbee Status xx' (in the Measurement dashboard) where 'xx is the HardwareID of the plugin
This status widget will give you information on the current state of the plugin. You can even see in the Log of the widget what have been the different states in the past

1. Off (Red)
The plugin set the status to Off when it is going Off, or there is a communication problem identified

1. Startup (grey)
The plugin set the status to Startup, when starting up

1. Ready (green)
This is a normal state, where the plug-in is ready to handle messages and commands

1. Enrolment (amber)
The plugin switch to this mode, when an object is currently in pairing/enrolment process.

1. Busy (amber)
The plugin switch to this mode, when the number of commands to Coordinator is exceeding a certain threshold. In that state, you can experiment delays.

### Text Widget

Here is a non-exhaustive list of notifications:

* Enrolment Success
* Enrolment not successful
* Leave notification from an object
* Network Topology (LQI) report available
* Network Scan (Interferences) report available
* Network down
* Zigbee Channel

Here is an example of the Notifications Widget Logs

![Notification Widgets](../Images/Widget_Notifications.png)
