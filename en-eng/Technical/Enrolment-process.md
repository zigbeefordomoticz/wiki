## Enrolment : Discovery process
1. End Device send a Device Announcement by sending 0x004d
1. When the plugin receive Device Announcement, it will send a 0x0045 Active Endpoint request, this will give information on the number of EndPoints available on the End Device
1. End Device at reception of 0x0045 will send 0x8045 Active Endpoint request with the list of Endpoints
1. The Plugin will then 
   1. send 0x0043 for each EndPoint
   1. If at that stage the Model Name is unknown it will send a Read Attribute Request on cluster 0x0000
   1. If at that stage the Manufacturer is unknown it will send a 0x0042 to get a Node Descriptor
1. When the Plugin will receive 0x8043 in response to 0x0043 with the list of Clusters per EndPoint, all necessary informations are available to create the corresponding widgets in Domoticz. In addition we could also get the response to Read Attribute Request to get the Model Name.

## Enrolment : Domoticz Widget creation

The Domoticz widgets creation is based on two type of information

1. If the Model name is known, the plugin will search for the Model name in the DeviceConf.txt database where are listed the certified objects and their definition. The widgets will be created based on that.
1. If the Model name is not found in deviceConf.txt or if the Model Name is not defined, the widgets will be created based on the Clusters found during the discovery phase.

| Cluster | Widget |
| ------- | ------ |
[ 0x0006 | switch On/Of |
| 0x0008 | Switch Level Control |
| 0x0101 | Vibration |
| 0x0300 | Switch Color Control |
| 0x0400 | Lux |
| 0x0402 | Temp |
| 0x0403 | Baro |
| 0x0405 | Humi |
| 0x0406 | Motion |
| 0x0702 | Power and Meter |
| 0x0500 | Door switch |
| 0x0001 | Voltage |

## Enrolment : dealing with Issues

### Nothing happen or it failed

There are quiet a number of reason why the Enrolment would not go through a positive end, but here are few elements:

* The main reason is that the plugin has not ben able to collect enough information to be in a situation to create the corresponding widget. Either because:
  * The object is not compatible with Zigate
  * They were some communication issues during the enrolment and the plugin has not been able to collect the required information.
  * The object is a Zigate compatible object , but the plugin doesn't manage it for now.

### What to do:
 * Check if the object is Zigbee compatible and Zigate compatible ( you can cross-check http://zigate.fr/le-materiel-compatible-zigate/ )
 * Try once more time the enrolment process
 * Check the Log file, you might get some useful information
 * Use the forum 



