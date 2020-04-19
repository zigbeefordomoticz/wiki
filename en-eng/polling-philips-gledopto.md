# Polling for On/Off and Level Control

## Introduction

Because some brand as of Philips or Gledopto do not provide instant status in case of async changes (like changes done via a remote),
we have implemented a light polling mecanism to retreive only the On/Off and Dim Level of those brand.

## What to Do ?

From the plugin Web Admin page, go to the settings

1. Select Advanced Settings
1. Make sure to disable the general polling
1. Enable the Philips polling. By default it is disable __0__, if you put a value this is the polling frequency in second. 
we recommend not go below 45 secondes in order to not overload the Zigate. In fact it will really depends on how-many devices
of this type Zigate will have to managed


![Philips Poling](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Philips_Polling.png)
