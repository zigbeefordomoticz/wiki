# Tuya 0xEF00

## Objective

Document all findings around the Tuya cluster 0xef00 which seems to be a kind of tunnel inside the tuya firmware.

Model name ( Basic attribute 0x0005 ) seems to act as a set of functionality, while Manufacturer Name ( Basic Attribute 0x0004 ) seems to identify the real device.

The manufacture name is always composed by `_<hardware cart>_<a letter><model id>`.

I'm providing this information to the community. it is based on what I have collected on the web but also my findings while sniffing the Tuya gateway with some devices. I you feel this information usefull, please feel free to add/enhance via PR.

## Cluster 0xEF00

Seems to be the foundation of a number of Tuya devices.
The tuya Cluster 0xEF00 is more or less one tunnel for tuyas MQTT commands from there MCUs to there cloud MQTT servers.

[Status of tuya TRVs implanted on ZHA](https://github.com/zigpy/zigpy/discussions/653)

## Devices using this clusters

![Tuya devices List](https://github.com/dresden-elektronik/deconz-rest-plugin/wiki/Tuya-devices-List)
![Compatibility list of Zigbee Thermostats and HVACs units compatible with ZHA](https://github.com/zigpy/zha-device-handlers/issues/357)


### Payload for 0x01 - Query and report product information, 0x02 - Device Status Query / Report

| status | transaction Id | Data Point | Data Type | Function | Len   | Data |
| ------ | -------------- | ---------- | --------- | -------- | ----- | ---- |
| uint8  | uint8          | uint8      | uint8     | uint8    | uint8 | len * uint8 |

### Identified Data Type

| Data Point | Data Type |  Description |
| ---------- | --------- |  ----------- |
| 0x00 	| RAW 	| |
| 0x01 	| BOOL 	| 1 byte |
| 0x02 	| VALUE 	| 4 byte unsigned integer |
| 0x03 	| STRING 	| variable length string |
| 0x04 	| ENUM 	| 1 byte enu m|
| 0x05 	| FAULT	| 1 byte bitmap |


### Identified Data Points: Curtain Motor

* Manufacturer Name: \_TZE200_rddyvrci, \_TZE200_5zbp6j0u, \_TZE200_nkoabg8w, \_TZE200_xuzcvlku, \_TZE200_4vobcgd3, \_TZE200_nogaemzt, \_TZE200_pk0sfzvr, \_TZE200_fdtjuw7u, \_TZE200_zpzndjez
* Model Name: TS0601

| Data Point | Data Type |  Description |
| ---------- | --------- |  ----------- |
| 0x01       |  0x01     |  Command: Open 0x00/Closed 0x01/Stopped 0x02|
| 0x02       |  0x02     |  Command: Curtain Percentage |
| 0x03       |           |   |
| 0x07       |           |  Curtain Percentage |
| 0x05       |           |  Direction - allow to change the direction |
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
* Pairing: (<https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/en-eng/Technical/Tuya-TS061-eTRV.md>)

| Data Point | Data Type | Description |
| ---------- | --------- | ----------- |
| 0x08       |  0x01     | Window Detection status |
| 0x0a       |  0x01     | Antifreeze status |
| 0x1b       |  0x02     | Calibration |
| 0x28       |  0x01     | Child Lock status |
| 0x65       |  0x01     | Mode 0x00 Off, 0x01 On |
| 0x66       |           | Temperature |
| 0x67       |  0x02     | SetPoint |
| 0x6a       |  0x01     | LH ???? |
| 0x6c       |           | Program Mode |
| 0x6d       |           | Valve Position ??? |
| 0x6e       | 0x00      | ????? |
| 0x73       | 0x00      | ????? |
| 0x77       | 0x00      | ????? |
| 0x82       | 0x01      | Water scale proof |

## List of tuya command (not verified)

| Cmd ID  | Description |
| ------- | ----------- |
| 0x01 |       Product Information Inquiry / Reporting |
| 0x02 |       Device Status Query / Report |
| 0x03 |       Zigbee Device Reset |
| 0x04 |       Order Issuance |
| 0x05 |       Status Report |
| 0x06 |       Status Search |
| 0x07 |       reserved |
| 0x08 |       Zigbee Device Functional Test |
| 0x09 |       Query key information (only scene switch devices are valid) |
| 0x0A |       Scene wakeup command (only scene switch device is valid) |
| 0x0A-0x23 |  reserved |
| 0x24 |       Time synchronization |

## Payload for 0x24 - Time Synchronisation

* Device -> Host 0xef00 Command 0x24  Payload 0x0008
* Host -> Device 0xef00 Command 0x24  Payload 0x0008 600d8029 600d8e39

The synopsis is like :

1. Device send a Time synchronisation request with a uint16 as payload
1. Host will respond with a payload equal to the same unint16 followed by the UTC time and the local time, for exemple

| payload       | UTC Time    | Local Time |
| ------        | -----       | --------- |
| uint16        |  uint32     | uint32     |
| 0008          |  600d8029   | 600d8e39  |
| 0000          |  6009cdd0   | 6009dbe0  |
| 000b          |  6009cdd3   | 6009dbe3  |
| 000d          |  600d8e5e   | 600d9c6e  |
| 000e          |  600d9c92   | 600daaa2  |
| 0018          |  600daac6   | 600db8d6  |


Timestamp is the total number of seconds from 00: 00: 00 on January 01, 1970, GMT

* <https://developer.tuya.com/en/docs/iot/device-development/embedded-software-development/mcu-development-access/zigbee-general-solution/tuya-zigbee-module-uart-communication-protocol?id=K9ear5khsqoty>

* <https://medium.com/@dzegarra/zigbee2mqtt-how-to-add-support-for-a-new-tuya-based-device-part-2-5492707e882d>
