## 1. Purpose
The purpose is to offer the possibility to use the Zigate (Zigbee) group functionality.
Starting Plugon 4.7 and the Plugin Web Admin Interface, the group management is much user friendly, but still need further developement to reach a nice User Experience.

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
You need to restart the plugin in order to check that.

Several minutes ( around 10' ) after plugin start the Group should be ready ( we are envioning to have a status reported in the Web Admin status bar

and you can access the Group User Interface 

![Group Management](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/GroupManagementMenu.png)


### 4.3 Creating a Group

![Adding Group Management](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/AddingGroup.png)

You can specify the Name of the group, and then you can select from the list the devices you want to get into that group

You have also the possibility to add Zigate to that group. This is required for instance if you want to retreive the status of an Ikea Remote.

Save the work and then restart the plugin in order to have the group created

### 4.4 Updating a Group

Just use the Group Management and add or remove devices from that group. 

Save the work and then restart the plugin in order to have the group updated

### 4.5 Remove a Group

You can either remove the group from Domoticz by removing the corresponding widget, or use the Group Management and remove the group you want to.

Save the work and then restart the plugin in order to have the group removed

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
* If you want to force a rescan of group membership (like if you have added a new device), you can simply remove the file `Data/GroupList-xx.pck` and restart the plugin
* I have seen a better way to work - and discover group membership - when the bulbs are on. I highly recommending when you are configuring your groups to have all existing groups on before , and get all bulbs you want to add to a group On as well.


## 5.1 Troubleshooting

If the plugin don’t have created any group widget and you are sure that you have a remote that create zigbee group and this remote is paired with the zigate and an other device that is also paired with the zigate try to:
    1. Remove the file  Data/GroupList-xx.pck
    1. Verify that the group management is enable 
    1. remove the file  Conf/ZigateGroupsConfig-xx.txt
    1. Allow new hardware  in Domoticz Configuration
    1. Restart the zigate plugin

