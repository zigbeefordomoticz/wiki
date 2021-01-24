# Tuya 0xEF00


## Cluster 0xEF00

Seems to be the foundation of a number of Tuya devices.


## Devices using this clusters


| Manufacturer Name | Model Name | Description |
| ----------------- | ---------- | ----------- |
|                   | fvq6avy    | eTRV        |
| _TYST11_zivfvd7h  | ivfvd7h    | eTRV        |



## Cluster protocol

The interaction with the cluster 0xef00 are following the folling structutre commands ( 1 bytes ) + payload

### Payload 

| status | transaction Id | Data Point | Data Type | Function | Len   | Data |
| ------ | -------------- | ---------- | --------- | -------- | ----- | ---- |
| uint8  | uint8          | uint8      | uint8     | uint8    | uint8 | len * uint8 |


### Identified Data Points: Curtain Motor

| Data Point | Data Type | Manufacturer Name | Model Name | Object | Description |
| ---------- | --------- | ----------------- | ---------- | ------ | ----------- |
| 0x01       |  0x01     |                   | TS0601     | Curtain Motor | Command: Open 0x00/Closed 0x01/Stopped 0x02|
| 0x02       |  0x02     |                   | TS0601     | Curtain Motor | Command: Curtain Percentage |
| 0x03       |           |                   | TS0601     | Curtain Motor |  |
| 0x07       |           |                   | TS0601     | Curtain Motor | Curtain Percentage |
| 0x05       |           |                   | TS0601     | Curtain Motor | Direction ???? |
| 0x67       |           |                   | TS0601     | Curtain Motor | Curtain Percentage |
| 0x69       |           |                   | TS0601     | Curtain Motor | Curtain Percentage |

### Identified Data Points: Smart Dimmer

Manufacturer Name: \_TZE200_dfxkcots
Model Name: TS0601

| Data Point | Data Type | Manufacturer Name | Model Name | Object | Description |
| ---------- | --------- | ----------------- | ---------- | ------ | ----------- |
| 0x01       |  0x01     |                   | TS0601     | Smart Dimmer | Switch On 0x01, Off 0x00 |
| 0x02       |  0x02     |                   | TS0601     | Smart Dimmer | Level % |



### Identified Data Points: Smart TRV ( eTRV )

Manufacturer Name: \_TYST11_zivfvd7h
Model Name: fvq6avy, ivfvd7h

| Data Point | Data Type | Manufacturer Name | Model Name | Object | Description |
| ---------- | --------- | ----------------- | ---------- | ------ | ----------- |
| 0x02       |  0x03     |                   | fvq6avy, ivfvd7h | eTRV | SetPoint |
| 0x03       |           |                   | fvq6avy, ivfvd7h | eTRV | Local Temperature |
| 0x04       |  0x04     |                   | fvq6avy, ivfvd7h | eTRV | Thermostat Mode 0x00 Off, 0x01 Auto, 0x02 Manual|
| 0x07       |           |                   | fvq6avy, ivfvd7h | eTRV | Child Lock ? |
| 0x15       |           |                   | fvq6avy, ivfvd7h | eTRV | Battery ? |


Manufacturer Name: 
Model Name: TS0601

| Data Point | Data Type | Manufacturer Name | Model Name | Object | Description |
| ---------- | --------- | ----------------- | ---------- | ------ | ----------- |
| 0x08       |  0x01     |                   | TS0601     | eTRV   | Window Detection status |
| 0x0a       |  0x01     |                   | TS0601     | eTRV   | Antifreeze status |
| 0x1b       |  0x02     |                   | TS0601     | eTRV   | Calibration |
| 0x28       |  0x01     |                   | TS0601     | eTRV   | Child Lock status |
| 0x65       |  0x01     |                   | TS0601     | eTRV   | Mode 0x00 Off, 0x01 On |
| 0x66       |           |                   | TS0601     | eTRV   | Temperature ???? |
| 0x67       |  0x02     |                   | TS0601     | eTRV   | SetPoint |
| 0x6c       |           |                   | TS0601     | eTRV   | Program Mode |
| 0x6d       |           |                   | TS0601     | eTRV   | Valve Position ??? |








## References

* https://developer.tuya.com/en/docs/iot/device-development/embedded-software-development/mcu-development-access/zigbee-general-solution/tuya-zigbee-module-uart-communication-protocol?id=K9ear5khsqoty

* https://medium.com/@dzegarra/zigbee2mqtt-how-to-add-support-for-a-new-tuya-based-device-part-2-5492707e882d
