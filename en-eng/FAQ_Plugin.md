<a href="Home.md"><img align="left" width="80" height="80" src="../Images/logo_Z4D.png" alt="Logo"></a>

# FAQ for ZigBeeForDomoticZ plugin

</br>

## How to manage several USB key and make sure that the coordinator is awlays using the same port

This is more an OS issue, but here are few hints
* https://www.domoticz.com/wiki/Assign_fixed_device_name_to_USB_port
* https://www.domoticz.com/wiki/PersistentUSBDevices

## How to commission/pair a new device

1. Make sure you authorized new hardware in DomoticZ
1. Set the Permit Join to 120 ( 120 seconds )
1. Start the Plugin
1. Trigger the pairing process from the device

## I don't get the device updated in DomoticZ when interacting via a remote control or manualy

For example : If you power off an Ikea bulb (with the physical switch) and then switch it on again, the status of the bulb is not updated in DomoticZ. And having the same issue with a remote controller which also doesn't update it's current state to DomoticZ.

If you encounter problems like the above example, it is most likely the automatic reporting is not configured correctly from the device end. Please follow below steps to fix this issue:

1. Open the PluginConf.txt file
1. Please check if the parameter "AllowRebindingClusters" is set to 1.
    If it is not, set it to "1"
1. Switch off the Ikea bulb with the physical switch, wait for 10 seconds, then turn it on again.
The rebinding process will start itself, the status problems should now be fixed.

## I'm getting 'Error: (Zigate) Communication error when transmiting a previous command to 9d58 ieee 90fd9ffffe31f150'

Here after is an exemple of errors found in the log file.
```
Apr 24 11:47:47 pi3 domoticz[23926]: 2019-04-24 11:47:47.697  Error: (Zigate) Communication error when transmiting a previous command to 9d58 ieee 90fd9ffffe31f150
Apr 24 11:47:47 pi3 domoticz[23926]: 2019-04-24 11:47:47.697  Error: (Zigate) Decode8702 - SQN: bc AddrMode: 02 DestAddr: 9d58 SrcEP: 01 DestEP: 01 Status: d4 - Unicast frame does not have a route available but it is buffered for automatic resend

```

This indicates that device ```90fd9ffffe31f150```is not reachable or - Zigate get a communication problem wit it -
