Purpose is to document the list of Hardware devices **tested** with the Zigate USB/WiFi and the Zigate plugin.

Either the information is coming from one of the plugin user (through direct communication, Domoticz forum), or from the plugin developers whom have make it working.

## BITRON HOME 
https://www.conrad.com/o/bitron-home-2805047

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| Smartplug (902010/28) | Plug   | Switch On/Off | Full Op. | 4.6 |
| Door/Windows contact (902010/121A) | Door | Door sensor Open/Closed | Fully Op. | 4.6 |
| Motion Sensor (902010/22A) | Motion | Motion | Full Op. | 4.6 |


## Centralite Micro 
https://centralite.com/

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| Door/Windows |  Door         | Open/Closed |        |                |

### ELKO

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| Thermostat  | Setpoint+ Temp | Setpoint/ Temp | Operational. Currently investigating the Thermostat Mode capability | 4.1    |
| Dimmer      | Switch / LvlControl | Dimmer | Full Op. | 4.1.0 |

### EUROTRONIC

https://eurotronic.org/produkte/zigbee-heizkoerperthermostat/

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| Thermostat | Setpoint + Temp | Setpoint to configure the target temperature, and you can get the local temperature | Operational | 4.1.0 & Firm 3.0f|

## GLEDOPTO

Please do not that it seems that GLEDOPTO do not provide LQI information, and due to that would probably behave as a very bad router. Controller and other routers won't have any clue on the LQI quality they have with such devices.

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| LED 12W     | ColorControl/Switch/LvlControl | Led controled with RGB+WW, On/Off, Lvl Control | Fully Op.| 4.3 |
| LED 4 W (GL-B-001Z) | ColorControl/Switch/LvlControl | Led controled with Level Control, On/Off and RGB + WW. Can be reset with Philips Remote Hue | Fully Op. | 4.1 |
| Spot(GL-S-004Z) | Whitecolor/Switch/LvlControl | Sport controled with Level Control, On/Off and WW. Can be reset with Philips Remote Hue | Fully Op. | 4.1 |

## HEIMAN

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| HS2WD-E     | Switch Selector Off/Alarm/Siren/Strobe | Siren and Strobe | Fully Op. | 4.4 with Firm 3.1a |


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

## KONKE

### Attention:
1. those devices works only on channel 15, 20 and 25
1. for now there is no reporting of Battery level ( under investigation )

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| Entry Sensor| Door contact   | Door contact| Op. with 4.5, Fully Op. with 4.6 | 4.5 |
| Button      | Switch Selector | 1 Click and 2 Click and long Click | Fully Op. 4.6 | 4.6 |
| Temp Humi   | Temp & Humi    | Temp et Humi| Op. with 4.5, Fully Op. with 4.6 | 4.6 |
| Motion      | Motion         | Motion      | Fully Op.| 4.6 |


### Legrand

* The pairing process seems to be special. You might have 2 cases happening along the pairing.
  .1 It works straight. Most likely this is a new device - never paired with the Legrand Hub - In such nothing much.
  .1 It works, but after 10s the device is un-paired, because it is sending a leave message. In that case there 2 tricks found in order to make the pairing resilient.
     * When the first pairing is done (before it sends the leav message, you do an electrical power off and then On
     * Click on Reset once (or several time) more after the pairing .

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| Celiane with Netatmo Plug | Switch and Power Meter | Plug with Switchn Power and Meter widget | Op. | 2.4.0 |
| Celiane with Netatmo switch/Dimmer W/O neutre | Switch, Dimmmer | Dimmer not working, need update firmware ? | Op. | 2.4.0 | | Switch for rolling shutter with neutral| Switch/LvlControl | On/Off/Stop | Op. | 4.1 & Firm 3.0f |

### OSRAM
| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| Smart Plug  | Plug (On/off)  |             |  Fully Op. |            |


### Philips

* Philips bulbs don't have Configure Reporting working. Due to that and in order to get their states (if you can comman dthe Bulb outside of Domoticz , like with a remote), you must set a regular polling. So you MUST enable 'enableReadAttributes' parameter.
So there is a risk of latency when using Remote or Group command between the command and geting the status reflected on Domoticz (as it is based on the polling frequency)

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

### TUYATEC

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| ----------- | -------------- | ----------- | ------ | -------------- |
| TYZDS-02    | Door Contact   | Door contact | Op with 4.5 , Fully Op. with 4.6| 4.5        |



### Xiaomi

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| -----------| -------------- | ----------- | ------ | -------------- |
| Aqara Human Motion Sensor | Human Motion Sensor | Switch turns on when a movement is detected | Lux sensor included doesn't work on master - report false values - To be tested in developement branch | 2.4.0 |
|Aqara Temperature Humidity Pressure Sensor | Temp + Humidity + Barometer | | Fully operationnal | 2.4.0 |
| Aqara Vibration sensor | Selector Switch Take, Tilt, Move, Drop; Vibration Curve widget, Orientation widget | Fully. OP |  | 4.6 |
| Aqara Water sensor | Water sensor | Sensor turns on when it is under water | Fully operationnal | 2.4.0 |
| Aqara Aqara Smart Light Wall Switch ( QBKG12LM) | 2 switches , Power, Meter | 2 independents switches with a cummulative Power and Meter consumption widget | Fully Op. | 4.2 |
| Aqara Window Door switch | Window Door switch | Switch turns on when the door is open | Fully operationnal | 2.4.0 |
| Aqara WXKG01LM (86sw1) | Switch Selector | The following events are reported to the Domoticz Switch selectors : 1 Click, 2 Clicks, 3 Clicks, 4 Clicks (more than 4 clicks got to 4 clicks)| Fully operationnal | 3.1.0 |
| Aqara WXKG02LM (86sw2) | Switch Selector | The following events are reported to the Domoticz Switch selectors : Right Click, Left Click, Both Click | Fully operationnal | 3.1.0 |
| Aqara WXKG11LM Square Device with round Button | Switch Selector | The following events are reported to the Domoticz Switch selectors : 1 Click, 2 Clicks, 3 Clicks, 4 Clicks (more than 4 clicks got to 4 clicks)| Fully operationnal | 3.1.0 |
| Aqara WXKG03LM Aqara wireles switch single button | Button | The following events are reported to the Domoticz Switch : ON | Fully operationnal | 3.3 |
| Aqara WXKG12LM | Button with giroscop | Simple and double click, Long Click and Long Release, Shake | Fully Op. | 4.3 |
| Aqara Cube | Switch Selector | The following events are reported to the Domoticz Switch selectors : Shake, Wakepup, Drop, 90° and 180° rotation, Push, Tab and horizontal Rotation . | Fully operationnal | 2.4.0 |
| Human Motion Sensor | Human Motion Sensor | Switch turns on when a movement is detected | Fully operationnal | 2.4.0 |
| Plug | Plug, Power meter | Can switch on/off the plug and you get Watts consuption | Fully operationnal | 3.1.0 |
| Smoke Sensor | Smoke Sensor | Need 3 push on button to run synch| can't be reset from Domoticz | 2.3.5 |
| Temperature Humidity Sensor | Temp + Humidity | | Fully operationnal | 2.3.5 |
| Vibration Sensor | Switch Selector | | Fully operationnal | 4.1.0 |
| Wall Double Switch QBKG12LM | Switch, Power meter | 2 switches with Power meter n each line | Fully operationnal | 3.1.0  |
| Window Door switch | Window Door switch | Switch turns on when the door is open | Fully operationnal | 2.4.0 |
| Smart Wireless Switch Key Built In Gyro Multi-Functional | Switch Selector | Selector Switch: Click, Double Click, Long Click, Release Click, Shake | Fully Op. | 4.2.1 |

### Zemismart

| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| -----------| -------------- | ----------- | ------ | -------------- |
| Zemismart FNB56-ZSW01LX2.0 Zigbee On/Off 1 Gang | 1 Switch | 1 Switch | Fully Op. | 4.1.0 |
| Zemismart FNB56-ZSW01LX2.0 Zigbee On/Off 2 Gang| 2 Switch | 2 Switch | Fully Op. | 4.1.0 |
| Zemismart NUET56-DL27LX1.1 Zigbee RGBW Downlight | Color Switch RGBWW | Color Switch RGBWW | Fully Op. | 4.1.0 |

### Other
| Device/Type | Domoticz usage | Description | Status | Plugin Version |
| -----------| -------------- | ----------- | ------ | -------------- |
| KSEntry KS-SM001 Zigbee On/Off | Switch | Switch | Fully Op. | 4.1.0 |
| FB56-ZCW08KU1.1 | Strip Light WRGB | Switch/LvlControl/ColorControl | Fully Op. | 4.2.0 |
| Müller-Licht 44062|  Color Switch RGBWW | "tint white + color" (LED E27 9,5W 806lm 1.800-6.500K RGB) | Fully Op. | 4.4 |
| DIY CC2531 based router | Switch | Zigbee CC2531 based router with a test button to test connection | Fully Op. | 4.1  |
