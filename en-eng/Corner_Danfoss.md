
# Danfoss Corner

## Overview

Purpose is to describe some plugin specific implementation for Danfoss Ally

## External Temperature Sensor

Thanks to @shger whom pointed this feature, but the eTRV can get its local temperature from an external sensor.

### Principle

You need to define a room ( number ) where your eTRV are, and the Temp Sensor device you want to use.
We will use the Room number to determine which Temp Sensor has to feed the temperature to the eTRV device.

### How to

Two device parameters have been introduced:

* DanfossRoom: By default set to 0, which will indicate the room number the device (eTRV or Temp sensor) belongs
* DanfossRoomFreq": By default set to 0 (which stand for disable), indicate the frequency (in seconds) when checking the temperature sensor and pushing teh result to the eTRV of the corresponding room. Danfoss recommend to set the ferquency above 30 minutes ( 1800 seconds)

#### Exemple 1:: 1 room  with the following zigbee devices

* 1 x Lumi Weather ( Temp, Humi, Baro )
* 3 x eTRV

You will set the device parameter of Lumi Weather to :  `{ "DanfosseRoom": 1 }` which will tell the plugin that the Lumi Weather is in Room #1
You will set the device parameter of the 3 eTRV to :  `{ "DanfosseRoom": 1 , "DanfossRoomFreq": 1800 }` which will tel the plugin that each of the 3 eTRVs will receive the temperature from the Lumi Weater (and not from the eTRV local temp sensor). This will be refreshed every 30 minutes.

#### Exemple 2: 3 room  with the following zigbee devices

| Devices                                              | Device Parameter to be use                        |
| -------                                              | --------------------------                        |
| 1 x Lumi Weather ( Temp, Humi, Baro ) for Room 1     |  `{ "DanfosseRoom": 1 }`                          |
| 3 x eTRV for Room 1                                  | `{ "DanfosseRoom": 1 , "DanfossRoomFreq": 1800 }` |
| 1 Philips Motion for Room 2                          | `{ "DanfosseRoom": 2 }`                           |
| 1 eTRV for Room 2                                    | `{ "DanfosseRoom": 1 , "DanfossRoomFreq": 1800 }` |
| 1 Frient Motion for Room 3                           | `{ "DanfosseRoom": 3 }`                           |
| 2 eTRV for Room 3                                    | `{ "DanfosseRoom": 1 , "DanfossRoomFreq": 1800 }` |

You can refer to [How To Device Parameters](../HowTo_Device-parameters.md)
