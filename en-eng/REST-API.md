# REST API 


## Format

host:port/rest-zigate/version/API

eg.

localhost:9440/rest-zigate/1/device


## APIs

| API            | Verbs |  Description |
| -------------- | ----- |  ----------- |
| /device        | GET   |  list the all Domoticz widgets related to this plugin |
| /plugin-health | GET   | Provides health/status information. HealthFlag reports a value of 0 to 3 and HealthTxt reports a text statement. The HealthFlag are 0 - Plugin is off, 1 - Green/Operational, 2 - Yellow/Operational but under tension, 3 - Red/Problem |
| /nwk-stat      | GET, DELETE   | list the timestamp of Network Interference reports. If you add TimeStamp as a parameter you'll get the report for this TimeStamp |
| /permit-to-join | GET, PUT | give the current PermitToJoin state, and update it (PUT) |
| /plugin        | GET   |  list all Domoticz plugin parameters | 
| /plugin-stat   | GET   |  list the main Transport statistics  |
| /restart-needed| GET   | Will respond if the Plugin needs to be restarted -due to a channge- or not |
| /req-nwk-inter | GET   | Start a Network interferences discovery |
| /req-topologie | GET   | Start a Network Topology discovery |
| /setting       | GET, PUT | list the all plugin configurable parameters and update them (PUT) |
| /sw-reset-zigate  | GET   |  Software Reset of Zigate | 
| /topologie     | GET,DELETE   |  with no parameters, list the timestamp for which we have a Topology, with a TimeStamp as a parameter will send a full Topology report taken at that time |
| /zdevice       | GET   | list the all Devices paired with the plugin |
| /zdevice-name  | GET, PUT | list the all Devices paired with the plugin with limited information and with the list of Domoticz Widget associated , PUT allows the update of ZDeviceName |
| /zdevice-raw   | GET   | Send the raw ListOfDevices data |
| /zgroup        | GET   | list the current groups |
| /zgroup-list-available-device | GET | List all eligeable devices for been part of a Group |
| /zigate        | GET   | Provide the Zigate informations as IEEE, NwkID, PANid, ExtendedPANID and Channel |
| /zigate-erase-PDM | GET | Erase Permanent Data Memory of Zigate |


