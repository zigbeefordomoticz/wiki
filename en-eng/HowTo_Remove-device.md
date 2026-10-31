# Remove a device

## Principle

A paired device is known in three places:

1. the coordinator (the Zigbee network);
1. the plugin (one entry per device);
1. Domoticz (one or more widgets per device).

To remove a device completely, it must be removed from all three.

**Removing a device deletes its widgets, and with them their history.** If you are replacing a device by a new one and want to keep the history, use [Replace a device](HowTo_Replace_Device.md) instead.

## What the plugin does when you delete the widgets

When you delete **the last** Domoticz widget of a device, the plugin:

* removes the device from its groups;
* sends the device a *Leave* request, asking it to leave the network;
* asks the coordinator to remove the device;
* marks the device as removed. It is dropped from the plugin database at the next plugin restart.

The Domoticz log shows `Device <name> with IEEE: <ieee> fully removed from the system.` and `Request device <name> -> <ieee> to be removed from coordinator`.

When the device actually leaves, the log shows:

`<name> (d009/00158d0002722c67) sent a Leave indication and will be outside of the network. LQI: 0`

Deleting only some of the widgets doesn't remove the device. See [Managing the widgets of a device](HowTo_Pairing-device.md#managing-the-widgets-of-a-device).

## Remove a router (mains powered)

1. Delete all the widgets of the device in Domoticz.
1. Check the Domoticz log for the *Leave indication* message above.

A router listens to the network all the time, so it normally receives the *Leave* request and leaves. If you don't see the *Leave indication*, follow the procedure for end devices.

## Remove an end device (battery)

An end device sleeps most of the time and only wakes up to send its data. It usually never receives the *Leave* request the plugin sends, so it doesn't leave the network by itself: you have to reset it by hand.

1. Make sure the network is not open for pairing: the *Accept new hardware* switch of the WebUI menu bar is off, and the coordinator LED doesn't show the pairing mode. Otherwise the device joins again right after the reset.
1. Reset the device (as for pairing it, see the device documentation).
1. Check the Domoticz log for the *Leave indication* message above.
1. Delete all the widgets of the device in Domoticz.

If the device is not reset, it stays in the network and keeps sending its data to the coordinator, and it can come back in the plugin later.

## A device the plugin still lists

If the device still appears in *Management > Device Management* (for example a device whose widgets were deleted while the plugin was stopped, or whose pairing never completed), click its row to open the device details, click *Remove device* and confirm. *Remove device* is only available for a device whose pairing failed, that is not in Domoticz, or that has no widget. See [WebUI Management](WebUI_Management.md#device-details). Before plugin 9.1.009, click the trash icon in the *Del.* column instead.
