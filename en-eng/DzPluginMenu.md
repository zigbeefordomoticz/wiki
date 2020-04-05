# Domoticz Plugin Menu Description


## Overview

Explain all parameters and options which can be found on the Domoticz Hardware menu for the plugin


## Description

![Domoticz Hardware Menu for Plugin](https://raw.githubusercontent.com/pipiche38/Domoticz-Zigate-Wiki/master/Images/DzMenu.png)


| Id | Short Description | Full Description |
| -- | ----------------- | ---------------- |
| 1  | Plugin Name       | This is the name you want to set for the instance of the plugin. In case you run several Zigate, you'll have several instance of this Plugin Hardware and so the name will help you to distinguish each of them|
| 2  | Hardware Type     | `Zigate plugin` is the name of the Hardware Type |
| 3  | Zigate Model      | You can select between several model of Zigate ( USB, DIN, PI, WifI |
| 4  | IP                | Only needed if you use the WifI model and in that case you put the IP address of the Wifi ZIgate |
| 5  | Port              | Only needed if you use the Wifi model and in conjuction of the IP address, you will specify the Port number (9999 is default) |
| 6  | Serial Port       | Used for USB, DIN and PiZigate, this is the Serial Port to access the Zigate |
| 7  | Erase PDM         | Will Erase all pairing information on the Zigate, this is required for the first use of Zigate. In such case put it to True and restart the plugin |
| 8  | Port for Web Admin| Port number to reach the plugin Web Admin page (default 9440), you must change it of you run several instance of the plugin |
| 9  | Update            | You will activate the new values of this page, and it will restart the plugin |
