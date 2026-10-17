# Scripts

Community dzVents scripts that can help with your Domoticz integration.

These scripts are provided by their authors, as examples. They are not maintained by the plugin team and were written for older Domoticz versions: check them on your own Domoticz before relying on them, and report problems to their authors.

All of them are dzVents scripts, including the `.lua` files: in Domoticz, create them under *Setup > More Options > Events* as **dzVents** scripts, then adapt the device names to yours.

## Device health and batteries

* [Device health](Devices-Health.md): monitor that devices are still alive, with a short dzVents example.
* [CheckBatteryLevel.dzVents](CheckBatteryLevel.dzVents): weekly check of the battery level of a list of devices.
* [CheckLastSeen.dzVents](CheckLastSeen.dzVents): daily check of when a list of devices was last seen.
* [CheckDeadDevices.lua](CheckDeadDevices.lua): every 10 minutes, check that a list of devices was seen within a threshold, with notifications.
* [GetDevicesStatus.lua](GetDevicesStatus.lua): every 15 minutes, count the live, lost and unknown devices from the plugin REST API, and show it on an Alert widget.

## Automation examples

* [SwitchWithAqaraDoubleSwitch.lua](SwitchWithAqaraDoubleSwitch.lua): toggle lights with the clicks of an Aqara double switch.
* [SwitchZigbeeGroupByMotionSensor.lua](SwitchZigbeeGroupByMotionSensor.lua): switch a Zigbee group on with a motion sensor, and off after a few minutes without motion.
* [SwitchZigbeeGroupsOnScheduleAndAqaraSwitch.lua](SwitchZigbeeGroupsOnScheduleAndAqaraSwitch.lua): switch Zigbee groups on a schedule or with an Aqara switch.
* [SwitchZigbeeSwitchOnScheduleAndTemperature.lua](SwitchZigbeeSwitchOnScheduleAndTemperature.lua): run a floor-heating pump on a schedule and on a water temperature.
* [DefineDomoVariableIsPublicHolidayOnWebservice.lua](DefineDomoVariableIsPublicHolidayOnWebservice.lua): set a Domoticz variable when today is a public holiday (web service).
