# Aqara corner


## Summary

* [Opple Switchs](#opple-switchs)
* [Lumi Presence Detector FP1 RTCZCGQ11LM](#Lumi-Presence-Detector-FP1-RTCZCGQ11LM)


## Opple Switchs

### Introduction

Those switchs have 2 modes of operating.

1. Binded to a dedicated Group of device, you will be able to command the end device directly.
   On/Off, Dimmer, and Color Control should be working

1. Binded directly with the coordinator, you can get up to 6 events per button


### Domoticz Zigate Plugin behaviours

On the ZigBeeForDomoticZ plugin, we have 3 operating modes:

   1. By default the switch is configured in 6 events per button mode. During the provisioning phase, 1 widget will be created in Domoticz per button
   1. You can enable a mode, where the switch will be bound to Zigate and in that case you will let events. For the 6 butons switch, you will get 3 widgets: 1 On/Off for the 1 row of button, 2 Switch Selector for row two and three.
   1. you can do a bind between the switch and any devices in the Zigate network.
   To enable this mode you have a parameter to enable (AqaraOppleBulbMode ) which can be found in the Miscaleneous section


### Technical Findings

* After reset the Switch seems to be broadcasting all actions made on the switch.
* There is a registration step to be performed if you want to activate Mode 1 , and in that case all events will reaching the Zigate and the host via Cluster 0x0012
* In Mode 2, there is a need of Firmware update in order to receive the 0x0300 Color Control cluster.
if you have a firmware below or equal to 3.1c, the row 3 of the 6 buttons switch will not operate


## Lumi Presence Detector FP1 RTCZCGQ11LM

This sensor isn't a Motion Sensor, this is a presence sensor with ability to check if there is some one in or not even if there micro mouvement.

4 parameters for this device

1. You have to set resetMotiondelay': 0, parameter otherwise no motion is detected until a real physical leave
2. Other Parameter
| RTCZCGQ11LMMotionSensibility =  Motion sensibility for Presence Detector FP1 RTCZCGQ11LM : 1=low 2=mid 3=high
| RTCZCGQ11LMApproachDistance =	Approach Distance for Presence Detector FP1 RTCZCGQ11LM :  0=far 1=mid 2=close |
| RTCZCGQ11LMMonitoringMode =	Monitoring mode for Presence Detector FP1 RTCZCGQ11LM 1 : 0=undirected 1=left/right ability to check left/right enter/leaving  |
