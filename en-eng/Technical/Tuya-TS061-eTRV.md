# Tuya TS0601 eTRV

## Pairing

| Host                           |                          Device   | Comment |
| ----                           |                          ------   | ------- |
|                                | Device Annoucement                |         |
| Read Attribute Basic           |                                   | 0x0004, 0x0000, 0x0001, 0x0005, 0x0007, 0xffe |
| Active EP request              |                                   |         |
| Simple Descriptor request      |                                   | Ep 0x01 |
| Write Attribute                |                                   | Cluster 0x0000, attribut 0xffde, value 0x13 |
| Command 0xf0 on cluster 0x0000 |                                   |         |
| Command 0x03 on Cluster 0xef00 |                                   |         |
|                                | Report Attributes 0x0000 / 0xfffe | Value 0x00 |
|                                | Report Attributes 0x0000 / 0x0001 | Value 0x55 |
|                                | Report Attributes 0x0000 / 0xffe2 | Value 0x1f |
|                                | Report Attributes 0x0000 / 0xffe4 | Value 0x01 |
|                                | Read Attributes 0x000a / 0x0007   | Request Local Time |
| Command 0x10 on cluster 0xef00 |                                   | Value 0x0022 |
|                                | Command 0x0b                      | Value 0x000140 |
|                                | Command 0x01                      | 00 17 0a 01 0001 01 |
|                                | Command 0x01                      | Data: 00 18 08 01 0001 01 |
|                                | Command 0x24                      | Data: 0008 |
|                                | Command 0x01                      | Data: 00 19 82 01 0001 01 |
| Response Command 0x24          |                                   | Data: 0008 60 0d 80 29 600d8e39 |

## Findings

It is a __must__ to have _Default Response Sent_ for any message received from the device.
Otherwise, the device is looping sending the command 0x65 !
