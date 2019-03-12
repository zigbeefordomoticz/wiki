## How to use the Ikea Tradfri Remote control as a pure remote control

If you want to use the Ikea Tradfri 5 buttons remote command and to control anything you want (and not necessarly the Tradfry bulb), here after is the step by step process.


## Context

To start with, you need the following pre-requisites:
1. A zigate  with firmware level above 3.0f
1. A Tradfri remote command (call remote and IEEE= 00158d0001ededde )
1. A Tradfri bulb (we will call it bulb and 2 are used in the example: 00158d0002c63af3 and 90fd9ffffe86c7a1 )
1. Domoticz-Plugin version pre-4.1 or 4.1 or above
1. You know the Hardware ID of the Zigate plugin. You can find it in the Domoticz Hardware Tab. (call it HardwareID and 35 in the example)
1. You known the Zigate IEEE. You can be found in the utility tab under the Text Notification Widget) (call it Zigate IEEE, and is 00158d0001ededde in the example)


## Step-by-step

We assume here the Bulb nor the Remote have been paired with the Zigate. In case it was, make sure they have been removed from Domoticz and the Zigate plugin database.

### Phase 1: bring everyone on the Zigate network

1. Put the Zigate in pairing mode. I suggest that you put 255 for the Permit to Join parameter. 
Make sure that you have also enabled 'accept New Hardware' in Domoticz settings.
1. Enable 'group management' :
   * You must have the following entry in Domoticz-Zigate plugin file Conf/PluginConf.txt 'enablegroupmanagement':'1',
   The file will looks like that:

```   
{
channel':'11,15,19,20,25,26',
vibrationAqarasensitivity':'medium',
resetMotiondelay':'30',
enablegroupmanagement':'1',
logLQI':'0',
logFORMAT':'0'
}
```

1. Restart the plugin by selecting the ZiGate in the Setup/Hardware section and click on Update. In case the 'Group Management' was enabled, it will scan for existing groups and will eventually create those in Domoticz.

1. Pair your bulb(s) with Zigate. For that you have to reset the bulb by doing, from a power on state, 6 times power-off power-on ( in a short time ). At the end of that process, you should have a new Widget in Domoticz which will command the Bulb.
   * You can at that stage note the Bulb IEEE, by looking after the List of Devices (in Domoticz) and the IEEE is the 3rd columns named ID.
   
![List of Devices](https://github.com/pipiche38/Domoticz-Zigate-Wiki/tree/master/Images/Domoticz-ListOfDevices.png])
   
1. Pair the Tradfri remote command with Zigate. For that you have to reset the remote command, by pressing 4 times, the small setup button. At the end of that process, you should have a new widget in Domoticz representing the Remote Command. At that stage the widget do not get any event from the remote - this is normal -. The widget is passive.
1. Pair the Remote Command with the Tradfri Bulbs you want to have in the group. For that, you need to bring the remote command close to each bulb and press the setup button. The light of the bulb will fluctuate, and when you have a peak of intensity, the pairing should have been done. Release the setup button. Check that you can switch off/off the bulb from the remote. If not retry the pairing and make sure that you stay up to the end of this pairing process.

At that stage, you have:
* Bulb(s) paired with Zigate and a corresponding widget in Domoticz
* Remote command paired with Zigate and a corresponding widget in Domoticz
* remote command paired with the bulb(s) and able to command it.

### Phase 2: Receive Remote event in the plugin


1. Remove the file Data/GroupList-xx.pck in the Domoticz-Zigate folder.
1. Restart the plugin
   * This will rescan for groups, and it should discover a new group created when pairing the Remote Command and Bulb.
   * A Group will be created in Domoticz. This group will command the Bulb, so you can cross check that is the right one. Do note the address of that group 'xxxx'
1. Edit (or create if not existing ) the file Conf/ZigateGroupsConfig-xx.txt (where xx is the ID of your Zigate Hardware in Domoticz). And add a new line
	xxxx, Group Remote Command, Zigate IEEE, Bulb IEEE
	
ZigateGroupsConfig-35.txt
```
# Zigate -> 00158d0001ededde
# IKEA Remote 90fd9ffffeea89e8
1001,Groupe Lampes IKEA,90fd9ffffe86c7a1
633a,Groupe IKEA/Tradfri WC,00158d0001ededde,00158d0002c63af3,90fd9ffffe86c7a1
```


1. Restart the plugin


### Phase 3: Testing

After the restart of the plugin and when it is in Ready state, you should be able to see any action done on the Remote visible on the Remote widget in domoticz.
From that if you want to associate actions based on Remote action you can use either Blocky, dzVents or LUA script.

### Option 1: Make Left/Right buttons changing Color schema of the group

By default after Phase3, you cannot see the remote events coming to the Domoticz remote widget and you can't eventually use then via Blocky/dzVents or LUA script.
The plugin allow also to 'natively' interpret Left and Right and change the color of the group the remote belongs too.
In order to enable this feature, you have to edit once more the Conf/ZigateGroupsConfig-xx.txt and add the Tradfri Remote control IEEE to the group you have already added the Zigate IEEE.

ZigateGroupsConfig-35.txt

```
# Zigate -> 00158d0001ededde
# IKEA Remote 90fd9ffffeea89e8
633a,Groupe IKEA/Tradfri WC,00158d0001ededde,00158d0002c63af3,90fd9ffffe86c7a1,90fd9ffffeea89e8
```

### Option 2: Remove the Bulb from the group

If you want to use the Remote only for remote command, and don't have the bulb involved at all, you simply have to remove the Bulb IEEE from the group definition.

1. Edit the file Conf/ZigateGroupsConfig-xx.txt 
   Remote Bulb IEEE, and leave only the Zigate IEEE in that line
	xxxx, Group Name, Zigate IEEE



## For reference

* ZigateGroupsConfig-35.txt

```
# Zigate -> 00158d0001ededde
# IKEA Remote 90fd9ffffeea89e8
1001,Groupe Lampes IKEA,90fd9ffffe86c7a1
633a,Groupe IKEA/Tradfri WC,00158d0001ededde,00158d0002c63af3,90fd9ffffe86c7a1,90fd9ffffeea89e8
```

* List of Devices in Domoticz

![List of Devices](https://github.com/pipiche38/Domoticz-Zigate-Wiki/tree/master/Images/Domoticz-ListOfDevices.png)


