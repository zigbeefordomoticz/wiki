# HowTo : Real time topology



1. make sure that the plugin is stopped
2. Installed missing python modules if requires `sudo pip3 install jsonschema coloredlogs`
3. from the plugin home folder `domoticz/plugins/Domoticz-Zigbee`, run `python3 -m zigpy_znp.tools.energy_scan /dev/ttyUSB0`where /dev/ttyUSB0 is the serial port to the USB dongle

This should provide you a scan of all Zigbee channels and reports the level of noise

![Network Toplogy](../Images/real-time-topology.png)

If you do not succeed here, this mean that something is wrong between the system and the USB dongle
