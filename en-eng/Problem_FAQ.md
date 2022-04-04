# Frequently Asked Questions

* [Q1. Where can I get support ?](#q1-where-can-i-get-support)
* [Q2. Where are the logs ?](#q2-where-are-the-logs-)
* [Q3. Can I debug myself ?](#q3-can-i-debug-myself-)
* [Q4. Where can I find the list of supported Coordinators and Devices ?](#q4-where-can-i-find-the-list-of-supported-coordinators-and-devices-)
* [Q5. Where can I find the coordinator firmwares ?](#q5-where-can-i-find-the-coordinator-firmwares-)
* [Q6. Can I use several coodinators in the same DomoticZ ?](#q6-can-i-use-several-coodinators-in-the-same-domoticz-)
* [Q7. Can I fixe the USB Port number ?](#q7-can-i-fixe-the-usb-port-number-)
* [Q8. My device is not updated in DomoticZ when interacting via a remote control or manualy](#q8-my-device-is-not-updated-in-domoticz-when-interacting-via-a-remote-control-or-manualy)
* [Q9. Can I run Plugin Version 6 on a Windows system ?](#q9can-i-run-plugin-version-6-on-a-windows-system)

## Troubleshooting

* [T1. My coordinator is not working](#t1-my-coordinator-is-not-working)
* [T2. My object can not be paired](#t2-my-object-can-not-be-paired)
* [T3. My object doen't work as expected](#t3-my-object-doent-work-as-expected)

## Errors

* [E1. Log error : `No transport, write directive to XXX.XXX.XXX.XXX:8080' ignored`](#e1-log-error--no-transport-write-directive-to-xxxxxxxxxxxx8080-ignored)
* [E2. Log error : `Decode8000`](#e2-log-error--decode8000)
* [E3. Log error : `Error: (Zigate) Communication error when transmiting a previous command to XXXX ieee XXXXXXXXXXXXXXXX`](#e3-log-error--error-zigate-communication-error-when-transmiting-a-previous-command-to-xxxx-ieee-xxxxxxxxxxxxxxxx)

------------
------------

## Q1. Where can I get support ?

The first source of support is the Wiki :

* [English Wiki](https://zigbeefordomoticz.github.io/wiki/en-eng)
* [French Wiki](https://zigbeefordomoticz.github.io/wiki/fr-fr)
* [Dutch Wiki](https://zigbeefordomoticz.github.io/wiki/nl-dut) ( _Unfortunately outdated. Please contact us if you are willing to contribute in the udpate of this wiki_)

You can also get support and ask questions :

* The [English Forum](https://www.domoticz.com/forum/viewforum.php?f=68)
* The [French Forum](https://easydomoticz.com/forum/viewforum.php?f=28)
* The [Keybase English channel](https://keybase.io/team/zigateforum)
* The [Keybase French channel](https://keybase.io/team/zigate)

------------

## Q2. Where are the logs ?

Since Stable6, the logs are saved in a file : `domoticz/plugins/Domoticz-Zigbee/Logs/PluginZigbee-XX.log`

The folder __Domoticz-Zigbee__ can also be __Domoticz-Zigate__ if you used the plugin ZiGate before april 2022.

------------

## Q3. Can I debug myself ?

Please refer to [Troubleshooting pairing or connection](Troubleshooting_Pairing.md)

------------

## Q4. Where can I find the list of supported Coordinators and Devices ?

Please refer to [Zigbee Device Compatibility Repository](https://zigbee.blakadder.com/z4d.html)

------------

## Q5. Where can I find the coordinator firmwares ?

* For __Texas Instrument__, we recommend to use the Z-Stack firmware from @Koenkk available [here](https://github.com/Koenkk/Z-Stack-firmware/tree/master/coordinator). We do not recommend to use _develop_ branch and rely on the _master_.
* For __ZiGate__, the firmwares are available [here for Zigate V1](https://github.com/fairecasoimeme/ZiGate/releases) or [here for ZiGate+ V2](https://github.com/fairecasoimeme/ZiGateV2/releases)
* For __EZNP (Silicon Labs)__, we recommend to follow the [zigpy recommendations](https://github.com/zigpy/zigpy/wiki/Coordinator-Firmware-Updates)

------------

## Q6. Can I use several coodinators in the same DomoticZ ?

We have currently a limitation of the number of instances using Zigpy layer, which prevent having several instances of zigpy based communication.

If you use ZiGate hardware, you can run as many plugin instances ( one instance per ZiGate ) as you wish.
If you use non-ZiGate hardware, like TI CCxxxx or Silicon Labs, you can run only one instance of those 2, but still can mix with as many ZiGate as you want.

------------

## Q7. Can I fixe the USB Port number ?

Some times, when you reboot your system, the USB Port (like _dev/ttyUSB0_) can change its number which cases a communication error with the coordinator. This is more an OS issue, but there are few hints :

* [Assign fixed device name to USB port](https://www.domoticz.com/wiki/Assign_fixed_device_name_to_USB_port)
* [Persistent USB Devices](https://www.domoticz.com/wiki/PersistentUSBDevices)

------------

## Q8. My device is not updated in DomoticZ when interacting via a remote control or manualy

For example : If you power off an Ikea bulb (with the physical switch) and then switch it on again, the status of the bulb is not updated in DomoticZ. And having the same issue with a remote controller which also doesn't update it's current state to DomoticZ.

If you encounter problems like the above example, it is most likely the automatic reporting is not configured correctly from the device end. Please follow below steps to fix this issue:

1. Go to the settings page on the WebUI
1. Activate the advanced settings
1. Please check if the parameter __AllowRebindingClusters__.
1. Switch off the Ikea bulb with the physical switch, wait for 10 seconds, then turn it on again.
The rebinding process will start itself, the status problems should now be fixed.

------------

## Q9. Can I run Plugin Version 6 on a Windows system ?

------------

## T1. My coordinator is not working

I can see in the [log file](#q2.-where-are-the-logs) some messages like that

```log
2022-02-25 00:19:41,006 INFO    : [       MainThread] Zigate plugin beta6-6.0.114 started
2022-02-25 00:19:41,384 INFO    : [       MainThread] Plugin Database: DeviceList-2.txt
2022-02-25 00:19:41,466 INFO    : [       MainThread] DeviceConf loaded - 23 confs loaded
2022-02-25 00:19:43,858 INFO    : [       MainThread] DeviceConf loaded - 329 confs loaded
2022-02-25 00:19:43,875 INFO    : [       MainThread] load ListOfDevice
2022-02-25 00:19:43,955 INFO    : [       MainThread] Transport mode: ZigpyZNP
2022-02-25 00:20:45,074 ERROR   : [       MainThread] [ 61] I have hard time to get Coordinator Version. Mostlikly there is a communication issue
2022-02-25 00:20:45,084 ERROR   : [       MainThread] [   ] Stop the plugin and check the Coordinator connectivity.
```

This indicate a miss communication between the plugin and the coordinator. You need to cross-check the following pieces in the DomoticZ Hardware menu :

* If this is the first time you are using the Coordinator (no device paired yet), you have to initialize it, set the __Initialize Coordinator: True__ in the Domoticz Hardware menu when starting the plugin. Once the first startup is ok, then disable this parameter to prevent erasing all paired devices at the next restart.
* Ensure that the serial port is the right one.
* Ensure that the Coordinator Model matchs your dongle (in that case it must be Texas Instrument ZNP (via zigpy)
* Ensure that there is not an other process running on the port
* If the coordinator is connected on a PI, make sure that you use USB2 (and not the USB3 from the PI4)
* If you have connected the coordinator on an USB HUB, try to plug it directly to the server

If it still don't work, you can try to test the coordinator with [making Real time topology](HowTo_Have-a-real-time-topology.md). This test will be done without Domoticz and the plugin. It is only working with TI CCxxx.

------------

## T2. My object can not be paired

* If the coordinator is plugged directly into a USB port on the server, try deporting it using a USB extension cord (don't use an USB HUB). This will keep it away from interference, especially from SSD disks, wifi chips, etc...

Please refer to [Dealing with none certified device](https://zigbeefordomoticz.github.io/wiki/en-eng/Problem_Dealing-with-none-certified-device.html)

------------

## T3. My object doen't work as expected

Please refer to [Dealing with none certified device](https://zigbeefordomoticz.github.io/wiki/en-eng/Problem_Dealing-with-none-certified-device.html)

------------

## E1. Log error : `No transport, write directive to XXX.XXX.XXX.XXX:8080' ignored`

Time to time I see the following error message. Is that a big issue ? How can I get rid of it ?

```log
Apr 02 13:30:23 pi domoticz[1328]: 2022-04-02 13:30:23.327  Error: ZigBee: No transport, write directive to 'XXX.XXX.XXX.XXX:8080' ignored.
```

This error is coming from DomoticZ and is related to the fact that you had the WebUI page opened and which timeout, at the time you tried to refresh this page, Domoticz detected that they were no transport/communication anymore.
You shouldn't worry much of this message.

------------

## E2. Log error : `Decode8000`

if you see error logs like here after, this is most-likely an issue with the ZiGate hardware.

```log
2022-02-22 18:03:11.851 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 22 Status: [ZigBee Error Code Unknown code : 80]
2022-02-22 18:06:23.656 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 4d Status: [ZigBee Error Code Unknown code : 80]
2022-02-22 18:06:30.282 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 51 Status: [ZigBee Error Code Unknown code : 80]
2022-02-22 18:06:30.499 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 52 Status: [ZigBee Error Code Unknown code : 80]
```

* Make sure that you don't have the old __blue__ USB-TTL module (it must be a red one )
* Try to power off the ZiGate by stopping the plugin, removing ZiGate, wait for 1 minute, plug-in back and restart the plugin

cc: [Issue reported on ZiGate](https://github.com/fairecasoimeme/ZiGate/issues/394)

------------

## E3. Log error : `Error: (Zigate) Communication error when transmiting a previous command to XXXX ieee XXXXXXXXXXXXXXXX`

Here after is an exemple of errors found in the log file.

```log
Apr 24 11:47:47 pi3 domoticz[23926]: 2019-04-24 11:47:47.697  Error: (Zigate) Communication error when transmiting a previous command to 9d58 ieee 90fd9ffffe31f150
Apr 24 11:47:47 pi3 domoticz[23926]: 2019-04-24 11:47:47.697  Error: (Zigate) Decode8702 - SQN: bc AddrMode: 02 DestAddr: 9d58 SrcEP: 01 DestEP: 01 Status: d4 - Unicast frame does not have a route available but it is buffered for automatic resend
```

This indicates that device ```90fd9ffffe31f150```is not reachable or - Zigate get a communication problem with it -
