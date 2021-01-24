# Tuya 0xEF00

## Objective

Document all findings around the Tuya cluster 0xef00 which seems to be a kind of tunnel inside the tuya firmware.

Model name ( Basic attribute 0x0005 ) seems to act as a set of functionality, while Manufacturer Name ( Basic Attribute 0x0004 ) seems to identify the real device.

I'm providing this information to the community. it is based on what I have collected on the web but also my findings while sniffing the Tuya gateway with some devices. I you feel this information usefull, please feel free to add/enhance via PR.

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

* Manufacturer Name: \_TZE200_rddyvrci', \_TZE200_5zbp6j0u, \_TZE200_nkoabg8w, \_TZE200_xuzcvlku, \_TZE200_4vobcgd3, \_TZE200_nogaemzt, \_TZE200_pk0sfzvr, \_TZE200_fdtjuw7u,* \_TZE200_zpzndjez
* Model Name: TS0601

| Data Point | Data Type |  Description |
| ---------- | --------- |  ----------- |
| 0x01       |  0x01     |  Command: Open 0x00/Closed 0x01/Stopped 0x02|
| 0x02       |  0x02     |  Command: Curtain Percentage |
| 0x03       |           |   |
| 0x07       |           |  Curtain Percentage |
| 0x05       |           |  Direction ???? |
| 0x67       |           |  Curtain Percentage |
| 0x69       |           |  Curtain Percentage |

### Identified Data Points: Smart Dimmer

* Manufacturer Name: \_TZE200_dfxkcots
* Model Name: TS0601

| Data Point | Data Type |  Description |
| ---------- | --------- |  ----------- |
| 0x01       |  0x01     |  Switch On 0x01, Off 0x00 |
| 0x02       |  0x02     |  Level % |

### Identified Data Points: Siren

* Manufacturer Name: \_TZE200_d0yu2xgi
* Model Name: TS0601

| Data Point | Data Type |  Description |
| ---------- | --------- |  ----------- |
|  0x65      |   0x04    |  Power Mode 0x00 Battery, 0x04 Battery |
|  0x66      |   0x04    |  Alarm Melody            |
|  0x67      |   0x02    |  Alarm Duration
|  0x68      |   0x01    |  Alarm On 0x01 Off 0x00            |
|  0x69      |           |  Temperature            |
|  0x6a      |           |  Humidity Level            |
|  0x6b      |   0x02    |  Min Alarm Temperature            |
|  0x6c      |   0x02    |  Max Alarm Temperature            |
|  0x6d      |   0x02    |  Min Alarm Humidity            |
|  0x6e      |   0x02    |  Max Alarm Humidity            |
|  0x70      |   0x01    |  Temperature Unit ( F 0x00, C 0x01 |
|  0x71      |   0x01    |  Alarm by Temperature status |
|  0x72      |   0x01    |  Alarm by Humidity status |
|  0x73      |           |  ??? |
|  0x74      |   0x04    |  Siren Volume |

### Identified Data Points: Smart TRV ( eTRV )

* Manufacturer Name: \_TYST11_zivfvd7h
* Model Name: fvq6avy, ivfvd7h

| Data Point | Data Type |  Description |
| ---------- | --------- |  ----------- |
| 0x02       |  0x03     | SetPoint |
| 0x03       |           | Local Temperature |
| 0x04       |  0x04     | Thermostat Mode 0x00 Off, 0x01 Auto, 0x02 Manual|
| 0x07       |           | Child Lock ? |
| 0x15       |           | Battery ? |

* Manufacturer Name:
* Model Name: TS0601

| Data Point | Data Type | Description |
| ---------- | --------- | ----------- |
| 0x08       |  0x01     | Window Detection status |
| 0x0a       |  0x01     | Antifreeze status |
| 0x1b       |  0x02     | Calibration |
| 0x28       |  0x01     | Child Lock status |
| 0x65       |  0x01     | Mode 0x00 Off, 0x01 On |
| 0x66       |           | Temperature ???? |
| 0x67       |  0x02     | SetPoint |
| 0x6c       |           | Program Mode |
| 0x6d       |           | Valve Position ??? |

## References

* <https://developer.tuya.com/en/docs/iot/device-development/embedded-software-development/mcu-development-access/zigbee-general-solution/tuya-zigbee-module-uart-communication-protocol?id=K9ear5khsqoty>

* <https://medium.com/@dzegarra/zigbee2mqtt-how-to-add-support-for-a-new-tuya-based-device-part-2-5492707e882d>
