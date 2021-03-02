The plugin is providing 2 widgets for administration purposes. Those Widgets are created by the plugin itself at startup phase

## 1.1 Status Widget

![Administration Widgets](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Widgets_Admin.png)

In domoticz you will find a Widget name 'Zigate Status xx' (in the Measurement dashboard) where 'xx is the HardwareID of the plugin
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
The plugin switch to this mode, when the number of commands to Zigate is exceeding a certain threshold. In that state, you can experiment delays.

## 1.2 Text Widget


Here is a non-exhaustive list of notifications:
* Enrolment Success
* Enrolment not successful
* Leave notification from an object
* Network Topology (LQI) report available
* Network Scan (Interferences) report available
* Network down
* Zigate Channel

Here is an example of the Notifications Widget Logs

![Notification Widgets](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Widget_Notifications.png)
