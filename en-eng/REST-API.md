# REST API 


## Format

host:port/rest-zigate/version/API

eg.

localhost:9440/rest-zigate/1/device


## APIs

| API            | Verbs |  Description |
| -------------- | ----- |  ----------- |
| /plugin        | GET   |  list all Domoticz plugin parameters | 
| /plugin-stat   | GET   |  list the main Transport statistics  |
| /topologie     | GET,DELETE   |  with no parameters, list the timestamp for which we have a Topology, with a TimeStamp as a parameter will send a full Topology report taken at that time |
| /device        | GET   |  list the all Domoticz widgets related to this plugin |
| /zdevice       | GET   | list the all Devices paired with the plugin |
| /zdevice-name  | GET, PUT | list the all Devices paired with the plugin with limited information and with the list of Domoticz Widget associated , POST allows the update of ZDeviceName |
| /setting       | GET, PUT | list the all plugin configurable parameters and update them (POST) |
| /permit-to-join | GET, PUT | give the current PermitToJoin state, and update it (POST) |
| /zgroup        | GET   | list the current groups |
| /nwk-stat      | GET, DELETE   | list the timestamp of Network Interference reports. If you add TimeStamp as a parameter you'll get the report for this TimeStamp |
| /zgroup-list-available-device | GET | List all eligeable devices for been part of a Group |
| /zigate        | GET   | Provide the Zigate informations as IEEE, NwkID, PANid, ExtendedPANID and Channel |
| /req-topologie | GET   | Start a Network Topology discovery |
| /req-nwk-inter | GET   | Start a Network interferences discovery |
