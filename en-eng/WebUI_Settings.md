# The Web interface - Settings page

Please refer to STEP 3 [Plugin Configuration](Plugin_Configuration.md) to get access to the Web interface administration.

Here is the __Seetings__ page of the plugin Web interface :

![Seetings](../Images/EN_WebUI-Settings.png)

*This page may have have changed since this documentation was written.*

## Contents

This file is used to customized some behaviour of the plugin at run time.

If you are updating values in PluginConf, we strongly recommend you to make a copy of it in order to avoid any lost when doing an update of the plugin.

The file is edited directly from the Web Admin page.

ATTENTION: Starting Version 4.5 the Configuration File Name is : PluginConf-xx.json and not '.txt', and respect the json syntax.

The .txt' one is not more used and can be removed


## Services

Those parameters allow the activation or not of services at plugin start.

| parameter | default | description |
| --------- | ------- | ----------- |
| enablegroupmanagement | disable | manage the Groups |
| enableReadAttributes | disable | manage the polling service |
| enableWebServer |  |  manage the Web Admin page |
| internetAccess | enable | Allow plugin to access Internet and check for latest version of Firmware and Plugin |
| allowOTA | disable |  manage the Over-the-Air firmware upgrade |
| pingDevices | enable |  ping every hour each main powered device (see pingDevicesFeq parameter) |

## DomoticZEnvironment

Some of the DomoticZ parameters like on which port DomoticZ listen for getting access to the domoticZ API need to be provided.

| parameter | default | description |
| --------- | ------- | ----------- |
| port      | 8080    | on which port DomoticZ listen to accept API requests |


## Group Management

| parameter | default | description |
| --------- | ------- | ----------- |
| Group is On if one device is On (otherwise needs all devices On) | enable | If you disable it, you will have the same behaviour as on the Philips Hue hub. The group will be on only when ALL devices are On. |
| reComputeGroupState | enable | The group state will be regularly computed based on the state of the devices attached to that group. |
| forceGroupDeviceRefresh | enable | When doing a group action, like On/Off, a request will be made to each device part of the group for their current status |

## Command transitions for Lights

Those parameters enable smooth transitions from their current status to the desire one. This is applicable to all Bulbs and Groups.

| parameter | default | description |
| --------- | ------- | ----------- |
| Transition for Hue           | instantaneous | |
| Transition for Color Temp    | instantaneous | Transition time in 10th of seconds when changing White color |
| Transition for RGB color     | instantaneous | Transition time in 10th of seconds when changing the Color |
| Transition for Move to Level | instantaneous | Transition time in 10th of seconds when diming |

## Web Interface

Those are parameters which will influence the behaviour of the plugin internal web server. We do recommend to not touch it.

| parameter | default | description |
| --------- | ------- | ----------- |
| enableGzip | enable | gzip compression |
| enableDeflate |enable | deflate compression |
| enableChunk | enable | allow file to be chunk |
| enableKeepalive | enable | Keep a live session |
| enableCache | enable | caching |

## Polling

Those parameter manage the Polling activities (if enabled).
We do not recommend to enable it as it will increase the load on the Zigate and on the network. Please do note that reducing the timing will increase the frequency of polling information from the device and can generate bottleneck and even impact async commands.

| parameter | default | description |
| --------- | ------- | ----------- |
| pingDevicesFeq | 3600 | Ping device frequency every hour |
| pollingPhilips | disable | For Philips you need to enable polling in order to get thei status. We recommend a value of 300 or above which correspond of number of seconds of polling |
| pollingGledopto | disabled |For Gledopto you need to enable polling in order to get thei status. We recommend a value of 300 or above which correspond of number of seconds of polling |
| polling0000 | 8600 | retreiving device basic info every day |
| polling0001 | 86400 | retreving device power info every day |
| pollingONOFF | 900 | retreving device On/off status every 15' |
| pollingLvlControl | 900 | retreiving device Level Control every 15' |
| polling000C | 3600 |   |
| polling0100 | 3600 | retreiving Shade Configuration |
| polling0102 | 900 | retreiving Window Covering info |
| polling0201 | 900 | Thermostat |
| polling0204 | 86400 | Fan Control |
| polling0300 | 900  | Color Control |
| polling0400 | 900 | Illuminance measurement |
| polling0402 | 900 | Temperature measurement |
| polling0403 | 900 | Pressure measurement |
| polling0405 | 900 | Relative Humidity |
| polling0406 | 900 | Occupancy sensing |
| polling0500 | 86400 | |
| polling0502 | 86400 | |
| polling0702 | 900 | Power measure |
| polling000f | 900 | |
| pollingfc01 | 900 | |


## Device Management

| parameter | default | description |
| --------- | ------- | ----------- |
| forcePollingAfterAction | enable | will request a status update of the device state after an action |
| forcePassiveWidget | disable | will allow a DomoticZ acion on the widget dispite the fact that the end device cannot receive the command. For exemple you have a Xiaomi battery device. |
| allowForceCreationDomoDevice| disable | Will create a Domotciz Widget even if there is already an existing one. |
| resetPluginDS | disable | will reset the plugin database data structure |
| resetConfigureReporting| disable | will reset the Configure Reporting info |
| resetReadAttributes | disable | will reset the polling info |
| resetMotiondelay | 30 | time before moving the Motion state to Off. You can use the one from the Domotciz Motion widget |
| allowGroupMembership | enable | will allow the plugin to automaticaly create group membership if known (Legrand) |
| doUnbindBind | disable | will force an unbind before binding a cluster |
| allowReBindingClusters | enable | will rebind clusters if the device is coming back |



## ZiGate Configuration

| parameter | default | description |
| --------- | ------- | ----------- |
| allowRemoveZigateDevice | disable | If enable when removing a device, a request will be done also to Zigate |
| blueLedOnOff | enable | manage the Zigate blue led. |
| resetPermit2Join | enable | will disable permit to join at plugin start |
| Ping | enable | will ping Zigate every 4' to insure the connectivity |
| Certification | CE | CE or FCC certifications |
| channel | 0 | One of those 11, 15, 19, 20, 25 and 26 Zigate channel. 0 means Zigate will select the best one. Channing the channel will require a Soft Reset of Zigate and your already paired devices might need to be repaired |
| TXpower_set | 0 | Power attenuation. 0: 0dBM, 1: -9 dBM, 2: -20dBM, 3: -32dBM |
| extendedPANID | 0 | You can force the Extended PAN Id, this would required a full Erase PDM |

## Over The Air Upgrade

* Works currently for LEDVANCE and TRADFRI products

| parameter | default | description |
| --------- | ------- | ----------- |
| batteryOTA | disable | enable battery upgrade |
| waitingOTA | 3600 | delay in second before starting the Over-the-Air upgrade |

## Verbose

Menu has been moved to the Tool Debug sub menu

| parameter | default | description |
| --------- | ------- | ----------- |
| logDeviceUpdate | enable | display the Widget update message 'UpdateDevice - (DIN-ZiGate - lumi.sensor_motion.aq2_Motion-00158d0003021601-01) 1:On' |
| debugMatchId | ffff | coma separated list of short address that you want to trace in the log |
| debugInput | disable | debuging all incoming messages |
| debugOutput | disable | debuging all outgoing messages |
| debugCluster | disable | debuging incoming clusters |
| debugHeartbeat | disable | debuging recurring activities |
| debugWidget | disable | debuging widget/DomoticZ management |
| debugPlugin | disable | debiging main plugin |
| debugDatabase | disable | debuging plugin database |
| debugCommand | disable | debuging Command/DomoticZ actions |
| debugPairing | disable | debuging pairing process |



## Legrand Specific

| parameter | default | description |
| --------- | ------- | ----------- |
| EnableLedIfOn | enable | blue led if On |
| EnableLedInDark | disable | blue led if Off |
| EnableDimmer | disable | enable dimmer |
| LegrandFilPilote | enable | enable fil pilote |

## Schneider Specific

| parameter | default | description |
| --------- | ------- | ----------- |
| enableSchneiderWiser | disable | Must be enable to pair Schneider Wiser devices |


## Others

| parameter | default | description |
| --------- | ------- | ----------- |
| alarmDuration | 1 | 1s by default, this is the alarm duration |
| enableSchneiderWiser | disable | mainly allow to make the difference between Livolo and Schneider IEEE |
| numTopologyReports | number of Topology reports you want to keep |
| numEnergyReports | number of Energy reports you want to keep |
| PowerOn_OnOff |
| TradfriKelvinStep | 51 | when binding the Ikea Remote with plugin and Zigate you can control
| vibrationAqarasensitivity | medium | low, medium, high for Aqara vibration sensitivity |
