

## 1. Purpose
The purpose is to offer the possibility to use the Zigate (Zigbee) group functionality.
Starting Plugon 4.7 and the Plugin Web Admin Interface, the group management is much user friendly, but still need further developement to reach a nice User Experience.
With Plugin 4.9, we have made a great move by removing the "batch" mode and 

## 2. Pre-requisites

* Firmware above 3.0f
* Plugin above 4.
* Domoticz above 4.10901 (in order to have the Web Admin interface enabled)

## 2. Approach
The group will be managed through domoticz Device widgets (not in the group section, but in the switch). Basically for each Zigate group you will be creating you will have a corresponding Domoticz Switch.


## How to proceed

### 4.1. How to enable it

![Settings for Group Management](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/SettingsGroup.png)

Enable the Group Management feature (which is disabled by default)

### 4.2 Check for any pre-existing groups

Before creating any group, you must check if there are no existing group already on the network. 
To do so you can go to the Admin Group sub menu and then request a Full scan.

![Group Management](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/AdminGroupMenu.png)

This will consist in quering each main powered devices for the group membership. As an outcome group could be created and available in the Group Management sub menu.

![Group Management](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/GroupManagementMenu.png)


### 4.3 Creating a Group

![Adding Group Management](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/AddingGroup.png)

You can specify the Name of the group, and then you can select from the list the devices you want to get into that group

You have also the possibility to add Zigate to that group. This is required for instance if you want to retreive the status of an Ikea Remote.

Save the work and the group membership request will be sent to each device listed. This could takes few seconds, so in case you don't see it , just do a refresh of the page.

### 4.4 Updating a Group

Just use the Group Management and add or remove devices from that group. 

Save the work and then restart the plugin in order to have the group updated

### 4.5 Remove a Group

You can either remove the group from Domoticz by removing the corresponding widget, or use the Group Management and remove the group you want to.

Save the work, it will trigger to request group membership removal to the correspondingd devices.

## 5 Special cases ( IKEA REMOTES)

## 5.1. Using a Remote Controller (Pairing a remote control)

In order to use an IKEA/Tradfri:
1. Pair/Commission each single object to the Zigate (including the remote controller)
1. Pair the Remote Control with each Bulb you want to be part of such group
1. Re-Start the plugin 
   1. During the startup of the Plugin it will check each single main powered device (which have cluster 0x0004 ) and will request the list of group membership.
   1. With all groups discovered during the scan of each device, the plugin will create corresponding Device widget in Domoticz under the name of "`<hardware name> - Zigate Group <group id>`"
1. The group created will be then visible under the Group Management


### 5.2. Retrieving Remote command events

From that stage, you can eventually add Zigate to this group. It will make each remote controller event seen in Zigate. 

Additionaly, you can also enable the Left/Right commands of the Tradfri 5 buttons remote controller. 
![](https://user-images.githubusercontent.com/4406440/54182600-3ec50200-44a2-11e9-8be7-c2e6b15b4deb.png)

For that you need to edit the Group and add the  Tradfri 5 buttons to that group


### 5.3. Creating Group 0000

If you need to have the group '0000' created, you can enable it via the Settings Advanced


![Adding Group Management](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/SettingsGroup0000.png)

## 6 Warnings

* In the current implementation of the Zigate and its plugin, when Zigate is sending a command to an object or a list of objects, there is no guaranty that the object receives the command. 
* If you want to force a rescan of group membership (like if you have added a new device), you can go to the Admin Group menu and ether request a Full Scan or a selected scan where you will select the devices you want to query
* I have seen a better way to work - and discover group membership - when the bulbs are on. I highly recommending when you are configuring your groups to have all existing groups on before , and get all bulbs you want to add to a group On as well.
