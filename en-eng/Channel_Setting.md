# Setting Zigate Channel


## Introduction

By default, Zigate at initialisation will look for the best possible channel, based on level of interferences around.
However you might want to fix the Channel, because some devices would required a specific one.

* Konke requires channel 15
* Livolo requires channel 26
* Legrand requires channel 11


## Step 1: Set the channel 


![Settings channel](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Channel_setting.png)

Set the channel you want

## Step 2: Apply the changes to Zigate

In order to get Zigate taking into account this new channel, you need to use the `restart`mecanishm

![Restart Zigate](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Restart_Zigate.png)

And voila! Zigate should be on the right channel

## Step 3: Check the Zigate channel

1. Go to Tools -> and select `Infos zigate (json)` 

![Zigate Infos](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Zigate_Infos.png)

2. You'll find the Zigate Information, and the Channel.
The Channel value is expressed here in Hexa, so 0x0b means 11 

