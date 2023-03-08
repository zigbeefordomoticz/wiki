# How To : Device Parameter

A number of parameters are available inside the plugin to customize the behaviour of the plugin or the behaviour of the device.

By default, a Certified device get default parameters allready initiatialized. If you want to customize, you have to go to the plugin Web Admin page,
then go to Management -> Device Management and you will find for each device a Parameters icon ( right column ) > a popup will open :

![EN_WebUI-Device-management-parametres.png](../Images/EN_WebUI-Device-management-parametres.png)

You can edit this field, by adding, removing or updating attributes. Please make sure to follow the syntax:

{ 'parameter1': value, 'parameter2': value .... }

| Parameter Name | Description | Working Device |
| -------------- | ----------- | -------------- |
| Calibration    | Allow to define a calibration value in °C | Tuya eTRV, Eurotronics SPZB0001, Schneider VACT, Danfoss eTRV |
| Alarm1         | Configuration of Alarm1. you have to specify Duration Volume, Melody | Tuya Siren TS0601 |
| Alarm2         | Configuration of Alarm2. you have to specify Duration Volume, Melody | Tuya Siren TS0601 |
| Alarm3         | Configuration of Alarm3. you have to specify Duration Volume, Melody | Tuya Siren TS0601 |
| Alarm4         | Configuration of Alarm4. you have to specify Duration Volume, Melody | Tuya Siren TS0601 |
| Alarm5         | Configuration of Alarm5. you have to specify Duration Volume, Melody | Tuya Siren TS0601 |
| alarmSirenCode | Allow to bypass the default code for Siren command | All Sirens/Alarms using IAS Warning |
| alarmStrobeCode | Allow to bypass the default code for Strobe command | All Sirens/Alarms using IAS Warning |
| Duration       | Applicable only inside the Alarm definition, it will configure the duration of alarm in Sec | Tuya Siren TS0601 |
| Volume         | Applicable only inside the Alarm definition, it will configure the Volume of alarm 0,1,2 (High, Medium, Low) | Tuya Siren TS0601 |
| Melody         | Applicable only inside the Alarm definition, it will configure the Melody ( from 1 to 15 ) 0 - doorbell, 1 - fur elise, 2 - big ben, 3 - ring ring, 4 - lone ranger, 5 - turkish march, 6 - high pitch siren, 7 - red alert, 8 - cricket, 9 - beep beep, 10 - dogs, 11 - police, 12 - grandfather clock, 13 - phone ring, 14 - firetruck| Tuya Siren TS0601 |
| HumidityMinAlarm    | Minimum humidity threshold for Alarm | Tuya Siren TS0601 |
| HumidityMaxAlarm    | Maximum humidity threshold for Alarm | Tuya Siren TS0601 |
| TemperatureMinAlarm | Minimum temperature threshold for Alarm | Tuya Siren TS0601 |
| TemperatureMaxAlarm | Maximum temperature threshold for Alarm | Tuya Siren TS0601 |
| PowerOnAfterOffOn   | If managed by the device, the device will go to a desired state after an electric Off/On. 0 stands for  stay Off, 1 stands for switch On, 255 stands for previous state | Ikea, ENki, BlitzWolf plug, Legrand, Philips (could required a firmware update of the end device )|
| fadingOff     | Transition time for power device power off. [0] default , fade to off in 0.8 seconds, [1] 50% dim down in 0.8 seconds then fade to off in 12 seconds, [2] 20% dim up in 0.5s then fade to off in 1 second, [255] No fade | all dimming Led |
| moveToHueSatu    | Transition time in tenth of seconds ( 10 means 1s ) to change Saturation Temp from current level to target level | all dimming Led |
| moveToColourTemp | Transition time in tenth of seconds ( 10 means 1s ) to change White color from current level to target level | all dimming Led |
| moveToColourRGB  | Transition time in tenth of seconds ( 10 means 1s ) to change Led color from current level to target level | all dimming Led |
| moveToLevel      | Transition time in tenth of seconds ( 10 means 1s ) to dim the Led from current level to target level | all dimming Led |
| occupancySensibility | Sensitivity level of the Philips Hue Motion Sensor 0 default, 1, High, 2 Max | Philips Hue SML001, SML002 |
| PIROccupiedToUnoccupiedDelay | The PIROccupiedToUnoccupiedDelay attribute specifies the time delay, in seconds,before the PIR sensor changes to its unoccupied state after the last detection of movement in the sensed area. | Tested with Philips SML001 |
| profaluxOrientBSO | default Tilt for Profalux BSO Orientation | Profalux BSO |
| alarmDuration | Define the number of second the alarm will last | Heiman IAS Siren |
| OnOffPollingFreq | Polling frequency for On/Off and Level status | Gledopto LED, Philips Led |
| PowerPollingFreq | Polling frequency for instant power | BlitzWolf and Lumi plug maeu01 Plug |
| AC201Polling | Polling of AC201 and CAC201 status | Only for OWON AC201 and Casia CAC201 |
| netatmoLedIfOn | Enable the Led if On | Legrand-Netatmo Plug, Switch |
| netatmoLedInDark | Enable Led if Off (allow to be visible in dark | Legrand-Netatmo Plug, Switch |
| netatmoLedShutter | Enable Led on Shutter switch | Legrand-Netatmo Shutter |
| netatmoEnableDimmer | Enable Dimming mode | Legrand-Netatmo Switch w/o neutral |
| netatmoInvertShutter | Invert the Shutter switch | Legrand-Netatmo Shutter|
| netatmoReleaseButton | special for François | Remote Legrand-Netatmo |
| SensorMode | Develop for Tuya Thermostat for now, specify which sensor to be use 0: IN, 1, ALL, 2: OUT | Tuya Thermostat TS0601 |
| LightIndicator | Available for Tuya TS0601 switches 0: Off, 1: On when On, 2: On when Off | Tuya Switches 1,2,3 Gangs TS0601 |
| pingBlackListed | if enable ( 1 ) , never ping the device | all routers |
| TuyaPing | if enable (1), it will simulate the Tuya Ping done every 5s by the Tuya GW| Tuya routers |
| TuyaEnergyChildLock | For Tuya DIN Energy Switch, allow to enable Child Lock ( not tested )| Tuya DIN Energy switch |
| Countdown | when switching On or Off, it will use the countdown. If set to __n__, it will wait __n__ secondes before switching | Walkaround for Tuya DIN Energy |
| WiserRoomNumber | Allow to define a room number per Wiser Thermostat, which monitor the heating demand of Actionners belongings to the same room. So you need to define the WiserRoomNumber parameter with the same room number for each actionners and the thermostat per room (Room Number association between eTRV thermostat and external temperature sensor)| Wiser Thermostat and any Actionners |
| BatteryPollingFreq | Polling frequency for getting Battery level | Needed for SChneider Wiser Thermostat RTS |
| DanfossRoom | Room Number association between eTRV thermostat and external temperature sensor | Danfoss eTRV thermostat and any type of Temperature Sensor both associated in same plugin instance  |
| DanfossRoomFreq | Polling Frequency in second, 0 disable. Indicates the frequency when refreshing the external temperature. | Danfoss eTRV thermostat  recommendation depends on which mode is set in thermostat: 1800- 10800 in "offset mode", 300-1800 in "room sensor mode" |
| DanfossTRVOrientation | 'H' or 'V': Orientation of thermostat, Horizontal or Vertical | Danfoss eTRV thermostat  |
| DanfossViewDirection | 1 or 2: The viewing direction of thermostat LCD| Danfoss eTRV thermostat  |
| eTRVExerciseDay | 0-6: (Sun-Sat) The day to do weekly exercising of radiator valve | Danfoss eTRV thermostat  |
| eTRVExerciseTime | Minutes after midnight to do weekly exercising of radiator valve | Danfoss eTRV thermostat  |
| vibrationAqarasensitivity | set the Aqara vibration sensibility level low, medium are high are the correct values |
| resetMotiondelay | when it is not possible to configure the OnOffdelay for device like Aqara motion, you can overwrite the 30 seconds delay with that | Aqara, and other motion devices |
| resetSwitchSelectorPushButton | When you have a switch Selector, you might want to have it coming back to the Off position after a while. This is tru when your Switch selector works as a push buttons. Value is in seconds (30 for 30 seconds before the device come back to Off position) | Scene controler |
| RTCZCGQ11LMMotionSensibility | Motion sensibility for Presence Detector FP1 RTCZCGQ11LM, 1=low 2=mid 3=high | Presence Detector FP1 RTCZCGQ11LM  |
| RTCZCGQ11LMApproachDistance |	Approach Distance for Presence Detector FP1 RTCZCGQ11LM,  0=far 1=mid 2=close |	Presence Detector FP1 RTCZCGQ11LM |
| RTCZCGQ11LMMonitoringMode |	Monitoring mode for Presence Detector FP1 RTCZCGQ11LM, 0=undirected 1=left/right ability to check left/right enter/leaving  | Presence Detector FP1 RTCZCGQ11LM  |
| TuyaMotoReversal | Manage the motor direction. Used with Curtain Smart Switch, 0=Standard sens (UP for opening / DOWN for closing), 1=Reversed sens | Tuya TS130F __TZ3000_ltiqubue |
| TuyaBackLight | Allow to backlight the active button on Curtain Smart Switch, 0=Active button lightning, 1=No backlight | Tuya TS130F __TZ3000_ltiqubue |
| moesCalibrationTime | Define the duration of motor activation, <value>=[nb 1/10 second], Value 10 = 1 second | Tuya TS130F __TZ3000_ltiqubue |
| ZG204Z_MotionSensivity | Motion sensitivity 0:low, 1:medium, 2:high | TUYA PIR ZG-204Z |
| ZG204Z_MotionOccupancyTime | Occupancy keep time 0:10s, 1:30:s, 2:60s, 3:120s | TUYA PIR ZG-204Z |
