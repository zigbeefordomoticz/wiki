# Zigbee for Domoticz Troubleshooting guide.



## I'm using a SONOFF Zigbee USB Dongle Plus, but it is not working

I can see in the log file ( domoticz/plugins/Domoticz-Zigbee/Logs/PluginZigbee-xx.log ) some messages like that


```
2022-02-25 00:19:41,006 INFO    : [       MainThread] Zigate plugin beta6-6.0.114 started
2022-02-25 00:19:41,384 INFO    : [       MainThread] Plugin Database: DeviceList-2.txt
2022-02-25 00:19:41,466 INFO    : [       MainThread] DeviceConf loaded - 23 confs loaded
2022-02-25 00:19:43,858 INFO    : [       MainThread] DeviceConf loaded - 329 confs loaded
2022-02-25 00:19:43,875 INFO    : [       MainThread] load ListOfDevice
2022-02-25 00:19:43,955 INFO    : [       MainThread] Transport mode: ZigpyZNP
2022-02-25 00:20:45,074 ERROR   : [       MainThread] [ 61] I have hard time to get Coordinator Version. Mostlikly there is a communication issue
2022-02-25 00:20:45,084 ERROR   : [       MainThread] [   ] Stop the plugin and check the Coordinator connectivity.

```

This indicate a miss communication between the plugin and the dongle. you need to cross-check the following pieces in the Domoticz Hardware menu:

* ensure that the serial port is the right one.
* ensure that the Coordinator Model matchs your dongle (in that case it must be Texas Instrument ZNP (via zigpy)
* ensure that there is not an other process running on the port


## I cannot get my TI CCxxx dongle working with the plugin

In that case, we suggest that you try to test the TI CCxxx dongle without Domoticz and the plugin. 

1. make sure that the plugin is stopped
2. Installed missing python modules if requires `sudo pip3 install jsonschema coloredlogs`
3. from the plugin home folder `domoticz/plugins/Domoticz-Zigbee`, run `python3 -m zigpy_znp.tools.energy_scan /dev/ttyUSB0`where /dev/ttyUSB0 is the serial port to the USB dongle

This should provide you a scan of all Zigbee channels and reports the level of noise

![Network Toplogy](../Images/real-time-topology.png)

If you do not succeed here, this mean that something is wrong between the system and the USB dongle

## Pairing issues - Not able to pair a device, the pairing works, but the device doesn't work or doesn't behave as expected

Please check [here](https://zigbeefordomoticz.github.io/wiki/en-eng/Problem_Dealing-with-none-certified-device.html)

## I want to debug myself and get more logs

Please check [here](https://zigbeefordomoticz.github.io/wiki/en-eng/Problem_Debuging-mode.html)

## While running , I see some `Decode8000`errors in the log file.

if you see error logs like here after, this is most-likely an issue with the ZiGate hardware. 

```
2022-02-22 18:03:11.851 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 22 Status: [ZigBee Error Code Unknown code : 80]
2022-02-22 18:06:23.656 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 4d Status: [ZigBee Error Code Unknown code : 80]
2022-02-22 18:06:30.282 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 51 Status: [ZigBee Error Code Unknown code : 80]
2022-02-22 18:06:30.499 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 52 Status: [ZigBee Error Code Unknown code : 80]

```

* make sure that you don't have the old __blue__ USB-TTL module (it must be a red one )
* try to power off the ZiGate by stopping the plugin, removing ZiGate, wait for 1 minute, plug-in back and restart the plugin

cc: [Issue reported on ZiGate](https://github.com/fairecasoimeme/ZiGate/issues/394)



