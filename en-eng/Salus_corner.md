# Salus Corner

## Overview


## Devices

* Salus Thermostat VS20WRF



## Salus Thermostat 

### Decoding sequence

| Hub                       | direction |      Devices             | Value     |
| ------------------------- | --------- | ------------------------ | --------- |
|                           | <-        | Match Descriptor Request |           |
|                           | <-        | Read Attributes          |           |
|                           | <-        | Device Announcement      |           |
| Match Descriptor response | ->        |                          | 0x01      |
| Read Attribute response   | ->        |                          | SAU2AG1   |
| Active Endpoint Request   | ->        |                          |           |
|                           | <-        | Active Ep response       | 0x09      |
| Identify                  | ->        |                          | 0x00      |
| Read Attribute            | ->        |                          | 0x0000 / 0x0005 |
|                           | <-        | Read Attr Response       | SAL6ET1   |
|                           | <-        | Command 0x10             | Cluster 0xfc00, FCF: 0x1d, ManufCode: 0x1078, Data: ff0202a4509a00 |



