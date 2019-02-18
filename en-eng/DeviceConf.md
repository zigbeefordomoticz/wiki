This file is crucial at Device creation, when a new device is paired.

| Field | Value | Description |
| ----- | ----- | ----------- |
| Model | Device model | Device model. The device model is provided by the device at pairing time through various commands like Read Attribute Request on Basic cluster |
| Ep    | Dictionary | The list of Ep with their corresponding clusters |
| '01': { }   |       | List of clusters available on this Ep, and optionnaly a list of possible Type associated to this Ep , in case of ColorControl Type, you can also associate a ColorMode |

## Type 

| Name          | Domoticz  | Description |
| ------------- | --------- | ----------- |
| Switch        | Switches  | On/Off     |
| LvlControl    | Switches  | 0-100%     |
| ColorControl  | Switches  | 0-100% / Hue   |
| ColorControlRGB| RGB Color | 0-100% + RGB |
| ColorControlRGBWW| RGB + WW | 0-100% + RGB + WW |
| ColorControlFull| RGB + WW +Z | 0-100% + RGB + WW + Z (default) |
| ColorControlWW| WW | 0-100+ + WW |
| Plug          | Switches  | On/Off     |
| Door          |        |        |
| Motion        |        |        |
| MSwitch       | Switches  | Switch multi level 86sw2        |
| DSwitch       | Switches  | Double switch on different EPs  |       
| DButton       | Switches  | Double switch on different EPs  |
| Smoke         | Switches  |        |
| Water         |        |        |
| Button        | Switches|        |
| Lux           |        |        |
| Power         | Utility   |        |
| Meter         | Utility   |        |
| Voltage       | Utility | |
| Temp          |        |        |
| Aqara         | Selector  | Passive switch, just provide object state |
| Vibration     | Selector  | Passive switch, just provide object state |

## ColorMode

| Color Mode | Explaination | Domoticz Widget |
| --------- | ------------ | --------------- |
| 0x00 | CurrentHue and CurrentSaturation | SubType sTypeColor_RGB_CW_WW_Z 0x07 Like RGBWW |
| 0x01 | CurrentX and CurrentY | SubType sTypeColor_RGB 0x02 // RGB |
| 0x02 | ColorTemperatureMireds | SubType sTypeColor_CW_WW | 

## Exemples

* `'PST03A-v2.2.5':{'Ep':{'01':{'0406':'','0500':'','0400':'','0402':'','Type':'Door/Switch/Lux/Temp'},'02':{'0500':'','Type':''Motion''}},'Type':''},`
  * Model : PST03A-v2.2.5
  * EP:01 - Clusters are '0406','0500','0400','0402' and 4 devices created on Domoticz Door, Switch, Lux, Temp
  * EP:02 - CLusters are '0500' and 1 device created on Domoticz Motion

* '`lumi.plug':{'Ep':{'01'{'0006':'','000c':'','0000':'','Type':'Plug'},'02'{'000c':'','Type':'Power/Meter'}},'Type':''},`
  * Model : lumi.plug
  * EP:01 - Clusters are 0006','000c','0000 and 1 device created on Domoticz Plug
  * EP:02 - Clusters is '000c' and 2 devices created on Domoticz Power and Meter