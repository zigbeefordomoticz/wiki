# Dealing with pairing issues

The plugin is developped in a way that it is capable to handle devices which respects ZigBee specifications.
For instance if the plugin see an unknown device type, it will try to create widgets based on the Device capabilities.

## Introduction

The pairing is done at 2 levels.

1. At the coordinator level, where we have the fact that the device is joining the Zigbee network controled by the coordinator.
1. At the Plugin level, where the plugin will do a discovery of the devices capabilities like:
   1. Is that main powered device
   1. Is there a Switch ON/OFF
   1. Is there a Dimmer
   1. Is there a Color RGB, WW possibility
   1. Is that Window convering device
   ...


## What type of issues could you encounter after the pairing

* At the end of the pairing process, I do not see any widget in Domoticz
* The Widget created in Domoticz is not correct like:
  * I got a Switch and Level control, but I don't get anything to change the color


## What to do

Starting Plugin 4.7, there are some tools which allow to share all information collected during the pairing/discovery process.


![Export Device List raw (json)](../Images/ExportDevicesRaw.png)

1. Got to the Tools Menu
1. Select Plugin Raw Devices (json)
1. Export

This will create an export.json file that you can save.

* Product Name
* Brand
* URL on a web site
* What do you expect
* The logs from the pairing process

Please create an issue here on GitHub: https://github.com/pipiche38/Domoticz-Zigate/issues/new?assignees=&labels=&template=Add_New_Hardware.md&title= with the here above informations
