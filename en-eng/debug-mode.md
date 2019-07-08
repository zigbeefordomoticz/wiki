# How to Debug and see what is happening


## 1. Assumptions / Prerequisites

* We assume that you have a full access to the domoticz logs, as the plugin rely also on that.
Usally on linux system, domoticz has an option '-log' where you can specify the filename where to store all logs.

* You have access to the Zigate Plugin Admin Web Interface, usally accessible via the same URL as domoticz but on port 9440 (if you didn't update it)


## 2. Debug parameters

* Here is the default Debug menu under the Setting Tab.
![default debug menu](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/default-debug.png)

* You need to enable 'Advanced' in order to get the full list of debuging options and get this menu
![advance debug menu](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/advanced-debug.png)

* Options
  * debugMatchId: By default is set to ffff and means that all messages are logged. You can specify either an IEEE (mac address of the Zigbee device), or NwkId (Short address) of the Zigbee equipment. Be aware that the Short Address can changed during the time and so won't be tracked anymore in such case.
  * debugInput: This is mainly all inbound messages - from Air to Zigate to Plugin.
  * debugCluster: This is a subset of the inbound messages, which contain data information from the device, like sensor temperature, Battery, ...)
  * debugOutput: This are all outbount messages ( from Plugin to Zigate )
  * debugHeartbeat: This are all recurring activities managed by the plugin ( every 5s )
  * debugWidget: This are all operations (from the plugin, and from the Widgets) in regards to Domoticz widget
  * debugNetworkMap: This are all operation in regards to the creation of the Topology report
  * debugNetworkEnergy: This are all operation in regards to the creation of the Energy report
  * debugGroups: This are all operations in regards to Group management
  * debugWebServer: This are all operations in regards to the Web Admin server
