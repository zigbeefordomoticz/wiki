# Debuging mode for ZiGate Plugin for Domoticz

## Introduction

The aim of this document is to give you some hints on how to debug and also provide more information to the developper when reporting an issue.

This would required a plugin version greater than 4.8


## The Debuging options

The debugging options are available from the Web admin interface in the Menu Settings, and you have to enable Advanced

[Debuging Options](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/debugingOptions.png)

| Option | Purpose |
| ------- | -------- |
| debugMatchId | you can specify here a short address or and IEEE of a specific device you want to track. In that case you will only see debug messages related to that specific address (short or IEEE) |
| Use Domoticz Log | By default enabled, the plugin logs are issued in the Domoticz log. If you disable this, you will have the plugin Logs written in files under the plugin Logs folder ( Domoticz-Zigate/Logs/ ) |

### The Plugin Modules

| Module | Description |
| ------ | ----------- |
| Input  | All incoming messages (from ZiGate) |
| Output | All out going messages (to ZiGate) |
| Cluster | decoding incoming messages. This is where we extract information from the messages payload |
| Heartbeat | executed every 5s to perform recurring actions |
| Widget | Updating Domoticz Widgets, usally call from Input or Cluster modules |
| Plugin | the plugin program |
| Database | Managing plugin database |
| Command | Handling all actions from Domoticz, usally calling Output to perform ZiGate actions |


## Basis


