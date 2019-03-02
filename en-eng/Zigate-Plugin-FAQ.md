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

If I power Off an Ikea Bulb (with a physical switch), when switching it on I don't have a status updated in Domoticz. I have the same issue if using a remote controller .

Most likely the issue is that the automatic reporting is not correctly configured at the device end. 

1. Make sure that you have Allow reBinding Cluster in the PluginConf.txt ( that is the default ). check the parameters allowReBindingClusters it must be set to 1.
1. Switch off the Ikea bulb with the physical switch, and then switch it on. It will re-do the rebinding and the configuration reporting.

