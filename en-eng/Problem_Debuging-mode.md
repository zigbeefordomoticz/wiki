<a href="Home.md"><img align="left" width="80" height="80" src="../Images/logo_Z4D.png" alt="Logo"></a>

# Debuging mode for ZigBeeForDomoticZ Plugin

</br>

## Introduction

The aim of this document is to give you some hints on how to debug and also provide more information to the developper when reporting an issue.

This would required a plugin version greater than 4.8


## The Debuging options

The debugging options are available from the Web admin interface in the Menu Settings, and you have to enable Advanced

![Debuging Options](../Images/debugingOptions.png)

| Option | Purpose |
| ------- | -------- |
| debugMatchId | you can specify here a short address or and IEEE of a specific device you want to track. In that case you will only see debug messages related to that specific address (short or IEEE) |
| Use Domoticz Log | By default enabled, the plugin logs are issued in the Domoticz log. If you disable this, you will have the plugin Logs written in files under the plugin Logs folder ( Domoticz-Zigate/Logs/ ) |

### The Plugin Modules

| Module | Description |
| ------ | ----------- |
| Input  | All incoming messages (from the coordinator) |
| Output | All out going messages (to the coordinator) |
| Cluster | decoding incoming messages. This is where we extract information from the messages payload |
| Heartbeat | executed every 5s to perform recurring actions |
| Widget | Updating Domoticz Widgets, usally call from Input or Cluster modules |
| Plugin | the plugin program |
| Database | Managing plugin database |
| Command | Handling all actions from DomoticZ, usally calling Output to perform cordinator actions |


## Use Cases

### Case 1: I do not see a sensor updating widgets on DomoticZS

In that case you need to check if we have incoming messages, if they are correctly processed, if they are pushed to DomoticZ for update.

1. Enable debugInput, debugCluster and debugWidget
1. set debugMatchId with the Short Address of this particular sensor, so you will limit the logs.
1. You can disable the Use Domoticz Log and then restart the plugin to collect those logs into a specif file.

1. Do what ever to be done to make the sensor sending messages, and collect the logs for analysis


### Case 2: I have a new device paired, but it looks like it is not well recognized

1. Enable debugInput, debugCluster, debugWidget, debugOutput and debugCommand
1. set debugMatchId with the Short Address of this particular sensor, so you will limit the logs.
1. You can disable the Use Domoticz Log and then restart the plugin to collect those logs into a specif file.

1. Perform actions from Domoticz and check the logs ( debugCommand and debugOutput )
1. Perform actions on the device to stimulate activities and check the logs ( deugInput, debugCluster, debugWidget)




## Short Address and IEEE

* You can get the Short Address and/or the IEEE of the Device:
  * via Domoticz: Devices and the IEEE can be found in the ID column
  * via the Plugin Web Interface in the Management -> Device Management menu
