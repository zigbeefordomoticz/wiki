# FAQ for Zigate plugin

## How to manage several USB key and make sure that the Zigate is awlays using the same port
This is more an OS issue, but here are few hints
* https://www.domoticz.com/wiki/Assign_fixed_device_name_to_USB_port
* https://www.domoticz.com/wiki/PersistentUSBDevices

## How to commission/pair a new device
1. Make sure you authorized new hardware in Domoticz
1. Set the Permit Join to 120 ( 120 seconds )
1. Start the Plugin
1. Trigger the pairing process from the device

## I don't get the device updated in Domoticz when interacting via a remote control or manualy

For example : If you power off an Ikea bulb (with the physical switch) and then switch it on again the status of the bulb is not updated in Domoticz. and are having the same issue with a remote controller which also doesn't update it's current state to Domoticz.

If you encounter problems like the above example, it is most likely the automatic reporting is not configured correctly from the device end. Please follow below steps to fix this issue:

1. Open the PluginConf.txt file (more information about this here https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/en-eng/PluginConf.txt.md)
1. Please check if the parameter "AllowRebindingClusters" is set to 1.
    If it is not, set it to "1"
1. Switch off the Ikea bulb with the physical switch, wait for 10 seconds, then turn it on again.
The rebinding process will start itself, the status problems should now be fixed.
