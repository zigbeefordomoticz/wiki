
## Standard Cluster Domoticz Widget association

 | Cluster | Widget |
 | 0001    | Voltage |
 | 0006    | Switch |
 | 0008    | LvlControl |
 | 0009    | Alarm |
 | 000c    | Analog |
 | 0101    | DoorLock |
 | 0102    | WindowCovering |
 | 0201    | Temp/ThermoSetpoint/ThermoMode/Valve *|
 | 0202    | FanControl |
 | 0300    | ColorControl |
 | 0400    | Lux |
 | 0402    | Temp |
 | 0403    | Baro |
 | 0405    | Humi |
 | 0406    | Motion |
 | 0702    | Power/Meter **|
 | 0500    | Door |
 | 0502    | AlarmWD |
| 0b04    | Power/Meter/Ampere/Voltage***|

\* 0201 is the Thermostat cluster. This cluster can provide several informations such as:
    Local temperature
    SetPoint
    Thermostat Mode
    Valve status

    depending on the device not all of the sensor could be enabled.

\*\* 0702 is the Metering (Smart Energy) cluster. It can report instant power (Power) and summation (Meter)

\*\*\* 0b04 is the Electrical Measurement. It can report instant power, summation, current, voltage
