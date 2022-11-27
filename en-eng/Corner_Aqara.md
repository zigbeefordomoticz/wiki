# Aqara corner


## Summary

* [Opple Switchs](#opple-switchs)
* [Lumi motion](#lumi-motion)


## Opple Switchs

### Introduction

Those switchs have 2 modes of operating.

1. Binded to a dedicated Group of device, you will be able to command the end device directly.
   On/Off, Dimmer, and Color Control should be working

1. Binded directly with the coordinator, you can get up to 6 events per button


### Domoticz Zigate Plugin behaviours

On the ZigBeeForDomoticZ plugin, we have 3 operating modes:

   1. By default the switch is configured in 6 events per button mode. During the provisioning phase, 1 widget will be created in Domoticz per button
   1. You can enable a mode, where the switch will be bound to Zigte and in that case you will let events. For the 6 butons switch, you will
   get 3 widgets: 1 On/Off for the 1 row of button, 2 Switch Selector for row two and three.
   1. you can do a bind between the switch and any devices in the Zigate network.
   To enable this mode you have a parameter to enable (AqaraOppleBulbMode ) which can be found in the Miscaleneous section


### Technical Findings

* After reset the Switch seems to be broadcasting all actions made on the switch.
* There is a registration step to be performed if you want to activate Mode 1 ,
and in that case all events will reaching the Zigate and the host via Cluster 0x0012
* In Mode 2, there is a need of Firmware update in order to receive the 0x0300 Color Control cluster.
if you have a firmware below or equal to 3.1c, the row 3 of the 6 buttons switch will not operate


## Lumi motion
