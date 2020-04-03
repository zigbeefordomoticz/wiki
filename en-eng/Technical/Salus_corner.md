# Salus Corner

## Overview


## Devices

* Salus Thermostat VS20WRF



## Salus Thermostat 

### Decoding sequence

| Hub                       | direction |      Devices             | Value     |
| ------------------------- | --------- | ------------------------ | --------- |
|                           | <- | Match Descriptor Request |           |
|                           | <- | Read Attributes          |           |
|                           | <- | Device Announcement      |           |
| Match Descriptor response | -> |                          | 0x01      |
| Read Attribute response   | -> |                          | SAU2AG1   |
| Active Endpoint Request   | -> |                          |           |
|                           | <- | Active Ep response       | 0x09      |
| Identify                  | -> |                          | 0x00      |
| Read Attribute            | -> |                          | 0x0000 / 0x0005 |
|                           | <- | Read Attr Response       | SAL6ET1   |
|                           | <- | Command 0x10             | Cluster: 0xfc00, FCF: 0x1d, ManufCode: 0x1078, Data: ff0202a4509a00 |
| Command 0x81              | -> |                          | Data: 2000c244c325030e00ffffffff3100 |
|                           | <- | Command 0x31             | Data: 21204a20303030302a4a46422a664b573f6320203d502c4b573f6320203d502c4b573f6320203d502c4b573f6320203d502c4b573f6320203d502c51573f63202039502c51573f63202039502c |
|                           | <- | Command 0x31             | Data: 212e4a4a30303030202020213030303035273030342a312a312e31662a56342c202020202020202020202020202020202020202020202020314a4a30ffcd000001004a21202020450900656520 |
| Read Attribute            | -> |                          | 0x0000 / 0x0003, 0x0005 |
|                           | <- | Read Attr Response       | 0x0003: 0xff, 0x0005: SAL6ET1 |

Loop of communication between Thermostat and Hub

| Hub                       | direction |      Devices             | Value     |
| ------------------------- | --------- | ------------------------ | --------- |
|                           | <- | Command 0x17             | Data: 34083408f40101 |
|                           | <- | Command 0x8e             | Data: 0146d2ffffffffffffffffffffffff |
|                           | <- | Command 0x31             | Data: 212e4a4a30303030202020213030303035273030342a312a312e31662a56342c202020202020202020202020202020202020202020202020314a4a30ff00000002004a21202020451300656520 |



