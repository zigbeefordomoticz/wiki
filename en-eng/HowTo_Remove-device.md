# How to remove Zigbee Devices

## Principle

When a device is paired this imply that the device is known in several locations:

1. known by the coordinator
1. known by the plugin ( one entry by device )
1. known by DomoticZ ( one or multiple widgets are related to the same device)

In order to get a device fully removed, you need to make sure that device is removed on all 3 locations.


## Removing End devices ( battery )

There is no automatic way to get most of the end devices removed from the locations. To make sure you get the device removed
from every where, here is a step approach to follow :

1. Make sure coordinator is not in "Permit to Join mode", so "Accept new Hardware " is disabled in the WebAdmin UI and the coordinator doesn't blink or have the pairing specific color (depends on the coordinator used).
1. Reset the end device
1. you should receive a leave message like that one `Status: (DIN-ZiGate)  (d009/00158d0002722c67) send a Leave indication and will be outside of the network. LQI: 0`
1. Remove all Widgets from Domoticz
1. Go to the Managment -> Device managment menu
2. Find your device in the list and click on the left trash icon.

That's it.


## Removing Router devices ( main powered )

Usually with Main Powered device, you can remove all associated Widgets from DomoticZ, and while removing the last one, (if the "Removal on plugin" parameter is enabled), the plugin will request the device to leave.


A message like that should be received by the plugin and visible in the log as a "Status"

```
Status: (DIN-ZiGate)  (d009/00158d0002722c67) send a Leave indication and will be outside of the network. LQI: 0
```

If you don't get such message, you just need to apply the same procedure as the one presented for the End Devices
