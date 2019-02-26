## How to use the Ikea Tradfri Remote control as a pure remote control

If you want to use the Ikea Tradfri 5 buttons remote command and to control anything you want (and not necessarly the Tradfry bulb), here after is the step by step process.


## Context

To start with, you need the following pre-requisites:
1. A zigate  with firmware level above 3.0f
1. A Tradfri remote command
1. A Tradfri bulb
1. Domoticz-Plugin version pre-4.1 or 4.1 or above
1. You know the Hardware ID of the Zigate plugin. You can find it in the Domoticz Hardware Tab.
1. You known the Zigate IEEE. You can be found in the utility tab under the Text Notification Widget)

## Step-by-step


We assume here the Bulb nor the Remote have been paired with the Zigate. In case it was make sure they have been removed from Domoticz and the Zigate plugin database.

### Phase 1: bring everyone on the Zigate network
1. Put the Zigate in pairing mode. I suggest that you put 255 as the Permit to Join parameter. Maike sure that you have also enabled 'accept New Hardware' in Domoticz settings.
1. Enable 'group management' :
   * You must have the following entry in Domoticz-Zigate plugin file Conf/PluginConf.txt 'enablegroupmanagement':'1',

1. Restart the plugin. In case the 'Group Management' was not enabled, it will scan for existing groups and will eventually create those in Domoticz.

1. Pair your bulb with Zigate. For that you have to reset the bulb by doing, from a power on state, 6 times power-off power-on ( in a short time ). At the end of that process, you should have a new Widget in Domoticz which will command the Bulb.
   * You can at that stage note the Bulb IEEE, by looking after the List of Devices (in Domoticz) and the IEEE is the 3rd columns named ID.
1. Pair the Tradfri remote command with Zigate. For that you have to reset the remote command, by pressing 4 times, the small setup button. At the end of that process, you should have a new widget in Domoticz representing the Remote Command. At that stage the widget do not get any event from the remote - this is normal -. The widget is passive.
1. Pair the Remote Command with the Tradfri Bulb. For that, you need to bring the remote command close to the bulb and press the setup button. The light will fluctuate, and when you have a peak of intensity, the pairing should have been done. Check that you can switch off/off the bulb from the remote. If not retry the pairing and make sure that you stay up to the end of this pairing process.

At that stage, you have:
* Bulb paired with Zigate and a corresponding widget in Domoticz
* Remote command paired with Zigate and a corresponding widget in Domoticz
* remote command paired with the bulb and able to command it.

### Phase 2: Receive Remote event in the plugin


1. Remove the file Data/GroupList-xx.pck in the Domoticz-Zigate folder.
1. Restart the plugin
   * This will rescan for groups, and it should discover a new group created when pairing the Remote Command and Bulb.
   * A Group will be created in Domoticz. This group will command the Bulb, so you can cross check that is the right one. Do note the address of that group 'xxxx'
1. Edit the file Conf/ZigateGroupsConfig-xx.txt (where xx is the ID of your Zigate Hardware in Domoticz). And add a new line
	xxxx, Group Remote Command, Zigate IEEE, Bulb IEEE
1. Restart the plugin


### Phase 3: Testing

After the restart of the plugin and when it is in Ready state, you should be able to see any action done on the Remote visible on the Remote widget in domoticz.
From that if you want to associate actions based on Remote action you can use either Blocky, dzVents or LUA script.

### Phase 4: Remove the Bulb from the group

If you want to use the Remote only for remote command, and don't have the bulb involved at all, you simply have to remove the Bulb IEEE from the group definition.

1. Edit the file Conf/ZigateGroupsConfig-xx.txt 
   Remote Bulb IEEE, and leave only the Zigate IEEE in that line
	xxxx, Group Remote Command, Zigate IEEE







