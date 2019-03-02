Purpose is to document the list of Hardware devices **tested** with the Zigate USB/WiFi and the Zigate plugin.

Either the information is coming from one of the plugin user (through direct communication, Domoticz forum), or from the plugin developers whom have make it working.

### ELKO

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| Thermostat  | Setpoint+ Temp | Setpoint/ Temp | Operational. Currently investigating the Thermostat Mode capability | 4.1    |
| Dimmer      | Switch / LvlControl | Dimmer | Full Op. | 4.1.0 |

### EUROTRONIC

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| Thermostat | Setpoint + Temp | Setpoint to configure the target temperature, and you can get the local temperature | Operational | 4.1.0 |

### IKEA Tradfri

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| LED1623G12 | Combied Switch+Level Control |  |   Fully Operationnal | 2.3.5 |
| LED1649C5 | Switch Light, Level Control | You can switch on/off the lead, managed the LUX via the level control. | Fully operationnal | 3.3.2 |
| LED1536G5 | Combined Switch+Level Control |  | Fully Operationnal | 2.4.0 |
| LED1624G9 | Combined Switch+Level+Color control | |  Fully Operationnal | 2.4.0 |
| LED1545G12 | Combined  Switch+Level+Color control | | Fully Operationnal | 2.4.0 |
| LED1546G12 | Combined  Switch+Level+Color control | |  Fully Operationnal | 2.4.0 |
| LED 1622G12 | Switch Light, Level Control | You can switch on/off the lead, managed the LUX via the level control. | Fully operationnal | 2.3.5 |
| remote control E1524 | Remote Control | Pair the device, then associate with Ikea devices using touchlink, finaly add Zigate to the group created | Fully Operationnal | 4.10 @ Firm 3.0f |
| TRADFRI motion sensor |  | | Not supported | required Group/Scene |

### Innr

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| BY 265      | Light White    |             | Fully Op. | 4.1.0       |

### Jiawen

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| JW-A04-RGBW Led Strip Controler | Switch Light, Level Control, Color Control |  You can switch on/off the lead, managed the LUX via the level control and the LED color, through the Color Seting. | Fully operationnal | 3.1.0 |

### Legrand

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| Celiane with Netatmo Plug | Switch and Power Meter | It might happend the Power Meter doesn't work. In that case it is because the device requirers firmware update. To do so you need to have at your disposal the Legrand gateway | Tested | 2.4.0 |
| Celiane with Netatmo switch/Dimmer W/O neutre | Switch, Dimmmer | Dimmer not working, need update firmware ? | Tested | 2.4.0 |
| Micro Module | Switch On/Off | Switch On/Off | Fully Op. | 4.1 and Fw 3.0f |
| Shutter/Window Covering | Level Control | Level Control | in progress | 4.1 and Fw 3.0f |

### OSRAM
| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| Smart Plug  | Plug (On/off)  |             |  Fully Op. |            |


### Philipps

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| LCT001 |  Color Switch RGBWW | Hue bulb A19 | Full Op. |   4.1.0        |
| LST002 |  Color Switch RGBWW | Hue LightStrips Plus | Full Op. |   4.1.0        |
| LCT007 |  Color Switch RGBWW | Hue bulb A19 | Full Op. |   4.1.0        |
| RWL021 | Remote Control | Remote Control with On/Off/DIM+/DIM- |  | 4.1.0 & Firm 3.0f |
| SML001 | Motion Sensor | Temperature, Lux and Motion detection | Fully Op. | 4.1.0 |

### Philio Technology Corporation

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| Slim Multisensor PST03-A/B/C | | | Operationnal | 2.4.0 |

### Profalux

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| shutter | Blind percentage inverted switch | can command the shutter from the domoticz switch, but also you can pull shutter status and update the Domoticz device. | Fully operationnal | 2.3.5 | 

### Salus

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| SP600 | Plug, Power Meter Voltage | Can switch on/off the plug | Power and Meter required a firmware upgrade of Zigate > 3.0e | 3.1.0 |

### Xiaomi

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| -----------| -------------- | ----------- | ------ | -------------- |
| Aqara Human Motion Sensor | Human Motion Sensor | Switch turns on when a movement is detected | Lux sensor included doesn't work on master - report false values - To be tested in developement branch | 2.4.0 |
|Aqara Temperature Humidity Pressure Sensor | Temp + Humidity + Barometer | | Fully operationnal | 2.4.0 |
| Aqara Vibration sensor | Selector Switch Take, Tilt, Move, Drop | | Under developement | dev |
| Aqara Water sensor | Water sensor | Sensor turns on when it is under water | Fully operationnal | 2.4.0 |
| Aqara Window Door switch | Window Door switch | Switch turns on when the door is open | Fully operationnal | 2.4.0 |
| Aqara WXKG01LM (86sw1) | Push On | The following events are reported to the Domoticz Switch : ON | Fully operationnal | 3.1.0 |
| Aqara WXKG02LM (86sw2) | Switch Selector | The following events are reported to the Domoticz Switch selectors : Right Click, Left Click, Both Click | Fully operationnal | 3.1.0 |
| Aqara WXKG11LM Square Device with round Button | Switch Selector | The following events are reported to the Domoticz Switch selectors : 1 Click, 2 Click, 3 Click, 4 CliCk | Fully operationnal | 3.1.0 |
| Aqara WXKG03LM Aqara wireles switch single button | Push On | The following events are reported to the Domoticz Switch : ON | Fully operationnal | beta 3.3 |
| Aqara Cube | Switch Selector | The following events are reported to the Domoticz Switch selectors : Shake, Wakepup, Drop, 90° and 180° rotation, Push, Tab and horizontal Rotation . | Fully operationnal | 2.4.0 |
| Human Motion Sensor | Human Motion Sensor | Switch turns on when a movement is detected | Fully operationnal | 2.4.0 |
| Plug | Plug, Power meter | Can switch on/off the plug and you get Watts consuption | Fully operationnal | 3.1.0 |
| Smoke Sensor | Smoke Sensor | Need 3 push on button to run synch| can't be reset from Domoticz | 2.3.5 |
| Temperature Humidity Sensor | Temp + Humidity | | Fully operationnal | 2.3.5 |
| Vibration Sensor | Switch Selector | | Fully operationnal | 4.1.0 |
| Wall Double Switch QBKG12LM | Switch, Power meter | 2 switches with Power meter n each line | Fully operationnal | 3.1.0  |
| Window Door switch | Window Door switch | Switch turns on when the door is open | Fully operationnal | 2.4.0 |

###

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| -----------| -------------- | ----------- | ------ | -------------- |
| KSEntry KS-SM001 Zigbee On/Off | Switch | Switch | Fully Op. | 4.1.0 |
