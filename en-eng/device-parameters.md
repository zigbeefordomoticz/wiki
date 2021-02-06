# Device Parameters

## Overview

A number of parameters are available inside the plugin to customize the behaaviour of the plugin or the behaviour of the device.

By default a Certified device get default parameters already initiatialized. If you want to customize you have to go to the plugin Web Admin page,
then go to Management -> Device Management and you will find for each device a Parameters field ( right column )
You can edit this field, by adding, removing or updating attributes. Please make sure to follow the syntax:

{ 'parameter1': value, 'parameter2': value .... }

| Parameter Name | Description | Working Device |
| -------------- | ----------- | -------------- |
| Calibration    | Allow to define a calibration value in °C | Tuya eTRV, Eurotronics SPZB0001 |
| Alarm1         | Configuration of Alarm1. you have to specify Duration Volume, Melody | Tuya Siren TS0601 |
| Alarm2         | Configuration of Alarm2. you have to specify Duration Volume, Melody | Tuya Siren TS0601 |
| Alarm3         | Configuration of Alarm3. you have to specify Duration Volume, Melody | Tuya Siren TS0601 |
| Alarm4         | Configuration of Alarm4. you have to specify Duration Volume, Melody | Tuya Siren TS0601 |
| Alarm5         | Configuration of Alarm5. you have to specify Duration Volume, Melody | Tuya Siren TS0601 |
| Duration       | Applicable only inside the Alarm definition, it will configure the duration of alarm in Sec | Tuya Siren TS0601 |
| Volume         | Applicable only inside the Alarm definition, it will configure the Volume of alarm 0,1,2 (High, Medium, Low) | Tuya Siren TS0601 |
| Melody         | Applicable only inside the Alarm definition, it will configure the Melody ( from 1 to 15 ) | Tuya Siren TS0601 |
| HumidityMinAlarm    | Minimum humidity threshold for Alarm | Tuya Siren TS0601 |
| HumidityMaxAlarm    | Maximum humidity threshold for Alarm | Tuya Siren TS0601 |
| TemperatureMinAlarm | Minimum temperature threshold for Alarm | Tuya Siren TS0601 |
| TemperatureMaxAlarm | Maximum temperature threshold for Alarm | Tuya Siren TS0601 |
