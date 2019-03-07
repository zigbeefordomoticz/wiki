## 1. Purpose
The purpose is to offer the possibility to use the Zigate (Zigbee) group functionality.

## 2. Glossary
* _ZigateGroupsConfig-xx.txt_: This is a unique file per Zigate Hardware, where you will be able to configure the Groups
* _GroupID_ : This is 4 digits hexa-number which identify the group. It could a number out of your head, but it could also be a number retrieve from the plugin (especially if you want to use the group created by a remote command)
* _GroupList-xx.pck__ : This binary file is containing all operational groups created/updated by the plugin. In case you have added/removed devices, in case you have paired a Remote command to a Bulb and you want to force the discovery, you will have to remove that file and restart the plugin.
* _HardwareID_ : This is the HardwareID of the Zigate plugin. You can find it in the Domoticz Hardware Tab. 
* _Zigate IEEE_ : IEEE (Mac Address) of Zigate key. You can find it in the logs, but also in the Notification Widget.

## 3. Approach
The group will be managed through domoticz Device widgets (not in the group section, but in the switch).

## 4. General Approach

As we don't have any user interface to manage the group, the plugin will rely on 

1. an `Conf/ZigateGroupsConfig-xx.txt` file in which the user will describe the groups to be created/managed by Zigate.
1. any Remote Controller which the user has created group. Automatically the Plugin will retrieve those groups and will create a widget in Domoticz
  For any Zigbee group created from the pairing of a Remote Controller and other hardware that is also paired with the zigate. The Plugin will retrieve those groups and will create widget in Domoticz for this group. (at the plugin starting time and only if domoticz accept new device,  see below more explanation)

Through the Domoticz Device Widget the user will be able to manage ( On/Off, Set Level, Color Control) the set of devices attached to that group

The Device Widget definition will be based on the most powerful device capabilities:
* If we have only switches and plugs in the group, the Group Device widget will be a switch
* If we have switches, plugs, blind and dimable lights, the group Device widget will be a LevelControl light



### 4.1. How to enable it

**You must have a 3.0f or above firmware installed on Zigate**

1. Enable the functionality in the plugin

Edit the file `Conf/PluginConf.txt` and add in the middle the here after line:
`'enablegroupmanagement':'1',`

## 4.2. Using a Remote Controller (Pairing a remote control)

In order to use an IKEA/Tradfri or a Philipps Hue remote:
1. Pair/Commission each single object to the Zigate (including the remote controller)
1. Pair the Remote Control with each Bulb you want to be part of such group
1. Re-Start the plugin and make sure to enable the Group Management (See above Enable the functionality in the plugin)  and to accept new device in Domoticz
   1. During the startup of the Plugin it will check each single main powered device (which have cluster 0x0004 ) and will request the list of group membership.
   1. With all groups discovered during the scan of each device, the plugin will create corresponding Device widget in Domoticz under the name of "`<hardware name> - Zigate Group <group id>`"

### Attention
During the first discovery, you might see quiet a number of group poping-up in Domoticz. These are groups which were created prior and which might relate to some Hub or other commands.

## 4.3. Using  configuration file

You can manually configure your existing group or creating new one through a configuration file `Conf/ZigateGroupsConfig-xx.txt` (where xx is the ID of your Zigate Hardware in Domoticz. If HardwareID is 7, then your configuration file will be ZigateGroupsConfig-07.txt

This is a text file with 1 line per group. Each field will be separated by a ','. Usually call csv. You can also put '#' as first caracter and the line will be considered commented

Column description
1. Group Id: this is a 4 digits hexa number ( from 0001 to ffee ) user defined or one that the plugin have discover and created a widget if you want to change the membership of this group
1. Group Name: a series of ASCII characters to name the group. This name will be use for creating the widget into Domoticz. If the purpose is the modification of an discovered and automatically created widget group from the plugin you to put the exact same name. 
1. Device ID List: this is a list of IEEE addresses separated by a ',' The user can find the IEEE in the Domoticz Device list under the column (Device ID). By default the plugin will find the most appropriate Endpoint to use. In case you have a Multi endpoint multi command device, you might want to specify which Endpoint you want to put in the specific group. In such case you can use '/' as a separator between the IEEE and the Endpoint. 
If the first character of the line is '#' then it is interpreted as a comment and the line is not processed.

### To create a group

Edit/create  `Conf/ZigateGroupsConfig-xx.txt`
1. define or retrieve (depend what you want) the group id
2. define or retrieve (depend what you want) a name for this group (you will get it as the widget name created in Domoticz)
3. List the IEEE (mac address) of each devices you want to get in this group

for example:

`0014,Shutters North,20918a0000038f6f,20918a0000038f6f/01,20918a0000038f6f`

In the above example, the plugin will be creating a group name _Shutters North_ which includes 3 devices, and for one of the device, it is specified to use the 01 endpoint only.

### To remove a group

You can either remove the group from Domoticz by removing the corresponding widget, or you can simply leave the group id with no other device listed

for example:

`0014`

In the above example, at the next start, the group Id _0014_ will be removed. This means that any object which belongs to group _0014_ will get their membership removed.

### To Update a group

You want to add or to remove a device from the group, you simply edit the `Conf/ZigateGroupsConfig-xx.txt` file and then you add or remove the device you want to add or remove

for example:

I wanted to remove one shutter '20918a0000038f6f'

My initial setup was:

`0014,Shutters North,20918a0000038f6f,20918a0000038f6f, 

The update configuration will will be : 

`0014,Shutters North,20918a0000038f6f`

### 4.4. Retrieving Remote command events

From that stage, you can eventually add Zigate to this group. It will make each remote controller event seen in Zigate. For that you'll have to use the configuration file and add or create a group where you have the Bulb as well as the Zigate IEEE (Zigate IEEE can be found in the utility tab under the Text Notification Widget). If you only modify the automatically created group widget, you don't have to put the Remote Controller IEEE as it has been already added in the previous stage.

Additionaly, you can also enable the Left/Right commands of the Tradfri 5 buttons remote controller. When you have done 4.4 and everything is working (you are receiving the remote event to the Domoticz corresponding widget), you have to add the IEEE address of the Tradfri 5 buttons remote controller to the group you have initially created with it and for which you have added the IEEE Zigate.
### 4.5 Warnings

* In the current implementation of the Zigate and its plugin, when Zigate is sending a command to an object or a list of objects, there is no guaranty that the object receives the command. 
* If you want to force a rescan of group membership (like if you have added a new device), you can simply remove the file `Data/GroupList-xx.pck` and restart the plugin
* I have seen a better way to work - and discover group membership - when the bulbs are on. I highly recommending when you are configuring your groups to have all existing groups on before , and get all bulbs you want to add to a group On as well.


## 5. Internals

Here after is an abstract on how the Group Management is handled by the plugin. 

### General Process

1. For each device in the Plugin database, 
   1. request its group membership
   1. Build a first list of Groups and device memberships
1. If a `Conf/ZigateGroupsConfig` file exist
   1. Check from the config file, which device must remove their group ownership
   1. Check from the config file, which device must add a group membership
1. If nothing to do ( no add/del group membership ) exist with Creation/Removal of Domoticz Devices
1. Remove the necessary group membership
1. Add the necessary group membership
1. Go back to start ( in order to cross-check that the membership are aligned with the Config file)

1. When the `Conf/ZigateGroupsConfig` has been processed and this is in line with the device group membership, the Group configuration will be stored in a `Data/GroupList-xx.pck` 'pickle' format file (not editable).
1. At start in order to speedup the startup process if the 'pickle' file is newer than the `Conf/ZigateGroupsConfig`, we will simply load the pickle file and finish the process without a full discovery

### Decrypting the Log

What does mean the log produced by the plugin at the end of the Group Processing:



`Feb 14 14:09:03 rasp domoticz[21610]: (Zigate-DEV) Group: 1003 - Groupe Plug Aqara`
`Feb 14 14:09:03 rasp domoticz[21610]: (Zigate-DEV) Group: 1003 - [('c9da', '01')]`
`Feb 14 14:09:03 rasp domoticz[21610]: (Zigate-DEV)   - device: c9da/01 00158d00024d873d`
`Feb 14 14:09:03 rasp domoticz[21610]: (Zigate-DEV) Group: 0000 - Groupe Xiaomi`
`Feb 14 14:09:03 rasp domoticz[21610]: (Zigate-DEV) Group: 0000 - [('c9da', '01')]`
`Feb 14 14:09:03 rasp domoticz[21610]: (Zigate-DEV)   - device: c9da/01 00158d00024d873d`
`Feb 14 14:09:03 rasp domoticz[21610]: (Zigate-DEV) Group: 630d - Groupe IKEA 1`
`Feb 14 14:09:03 rasp domoticz[21610]: (Zigate-DEV) Group: 630d - [('f748', '01'), ('0000', '01')]`
`Feb 14 14:09:03 rasp domoticz[21610]: (Zigate-DEV)   - device: f748/01 90fd9ffffe86c7a1`
`Feb 14 14:09:03 rasp domoticz[21610]: (Zigate-DEV)   - device: 0000/01 00158d0001ededde`
`Feb 14 14:09:03 rasp domoticz[21610]: (Zigate-DEV) Group: 1001 - Groupe Lampes IKEA`
`Feb 14 14:09:03 rasp domoticz[21610]: (Zigate-DEV) Group: 1001 - [('f748', '01')]`
`Feb 14 14:09:03 rasp domoticz[21610]: (Zigate-DEV)   - device: f748/01 90fd9ffffe86c7a1`
`Feb 14 14:09:03 rasp domoticz[21610]: Status: (Zigate-DEV) Group startup done`




Out of the 4 Groups,
* Groupe Plug Aqara
  * groupID: 1003
  * 1 device: c9da/01 00158d00024d873d
* Groupe IKEA 1
  * groupID: 630d
  * 2 devices  f748/01 90fd9ffffe86c7a1 and 0000/01 00158d0001ededde (Zigate)

The Group Ikea 1 has also the Zigate included, which means that if there is a Remote Control associated to this group, the event will be visible at Zigate side


## 5.1 Troubleshooting

If the plugin don’t have created any group widget and you are sure that you have a remote that create zigbee group and this remote is paired with the zigate and an other device that is also paired with the zigate try to:
    1. Remove the file  Data/GroupList-xx.pck
    1. Verify that the group management is enable (section 3.3)
    1. If you have created it remove the file  Conf/ZigateGroupsConfig-xx.txt
    1. Allow new hardware  in Domoticz Configuration
    1. Restart the zigate plugin

