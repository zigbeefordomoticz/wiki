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
		"Alarm1": { "Duration": 5, "Volume": 2, "Melody": 1},
		"Alarm2": { "Duration": 5, "Volume": 2, "Melody": 2},
		"Alarm3": { "Duration": 5, "Volume": 2, "Melody": 3},
		"Alarm4": { "Duration": 5, "Volume": 2, "Melody": 4},
		"Alarm5": { "Duration": 5, "Volume": 2, "Melody": 5},
		"HumidityMinAlarm": 25,
		"HumidityMaxAlarm": 75,
		"TemperatureMinAlarm": 3,
		"TemperatureMaxAlarm": 27
