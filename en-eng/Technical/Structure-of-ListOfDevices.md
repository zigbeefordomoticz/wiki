## Overview
ListOfDevices is an internal plugin structure which is managing the all plugin database. This object is store in the DeviceList-xx.txt at different period of time:

1. When a new Domoticz Device is created
1. When stoping the plugin
1. Every 15'

## Data Structure

| Field Name | Description |
| ---------- | ----------- |
| Ep | list of End Points, and for each of them list of clusters |
| NbEp | Number of End points |
| Type |
| Model | Model name |
| MacCapa | Device capabilities as per ZigBee definition |
| IEEE | IEEE address |
| ProfileID | profileID as per ZigBee definition |
| ZDeviceID | DeviceID as per ZigBee definition |
| Manufacturer | Manufacturer code |
| DeviceType | FFD ( Full Functional Device ) , RFD ( Reduced Functional Device) |
| LogicalType | Router, Controller, End Device |
| PowerSource | Main, Battery |
| ReceiveOnIdle | On (able to receive command when Idle), Off ( cannot receive command on Idle) |
| App Version | Application version |
| Stack Version | Zigbee stack version |
| HW Version | Hardware version |
| Status | inDB (in Domoticz DB), UNKNOWN (unidentified device) |
| Battery | battery % |
| RSSI | Link quality |
| SQN | Sequence Number |
| ClusterType | Domoticz device Id and Cluster Type |
| RIA | Used during the pairing process |
| Version | plugin data structure version |
| Stamp | timestamp of the last message received |
| ColorInfos | Color info reported by the device (if applicable) |
| ConfigureReporting | report per Ep/Cluster if the ConfigureReporting was a success or not |
| ReadAttributes | report per Ep/Cluster/Attribute if the ReadAttribute was a success or not |


`b837 : {
'Version': '3',
Status': 'inDB',
'SQN': {},
'Ep': {'01': {'0000': {}, '0003': {}, '0004': {}, '0005': {}, '0006': '00', '0008': {}, '0300': {}, '0b05': {}, '1000': {}, 'Type': 'ColorControl', 'ClusterType': {'641': 'ColorControl'}}},
'Heartbeat': '201',
'RIA': '3',
'RSSI': 63,
'Battery': {},
'Model': 'TRADFRI bulb E27 WS clear 950lm',
'MacCapa': '8e',
'IEEE': '90fd9ffffe86c7a1',
'Type': '', 
'ProfileID': 'c05e',
'ZDeviceID': '0220', 
'NbEp': '1', 
'Manufacturer': '117c', 
'DeviceType': 'FFD', 
'LogicalType': 'Router', 
'PowerSource': 'Main', 
'ReceiveOnIdle': 'On', 
'App Version': '17', 
'Stack Version': '87', 
'HW Version': '1', 
'Stamp': {'Time': '2018-11-27 11:18:06', 'MsgType': '8102'}, 
'ColorInfos': {'X': '30138', 'Y': '26909', 'ColorTemperatureMireds': '370', 'ColorMode': 2}, 
'NO cfg rprtng': ['0300', '0300', '0300']}`

