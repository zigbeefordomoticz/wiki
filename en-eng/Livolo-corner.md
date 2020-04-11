# Livolo corner and faq

## Overview

Purpose is to document the findings around the Livolo switches and how to get them working with Zigate and the plugin.
It is the result of Google findings and own sniffing 

## Warning

Livolo seems __not following__ the Zigbee standard. Some of the results are :
* Stability might be an issue, time to time the switch get disconnected , and it was challenging to get it back. Once I had to do an erase PDM in order to redo the full pairing.
* Scalability (capacity to get a lot of devices) could be a problem and could negatively impact other devices.

## Prerequisites

* The Livolo switches ( 1 gang or double gang ) can be paired only on channel 26, however I found the possibility to switch them back to channel 11.
* Firmware 3.1b (if you have only firmware 3.1a you won't get any switch feedback like if you manualy switch On or Off).
* Plugin above 4.6 (included)
* You must leave the Zigate in pairing mode all of the time

## Pairing process

1. Put the Zigate on Channel 26. 
   1. You can use the Web GUI by going into Settings page and then putting 26 for the channel.
   1. Still on the Web GUI, you need to go to the Admin page and then do a Software Reset of the Zigate.
   
   The the Zigate should be on Channel 26. You can cross-check that in the Logs, or in the notifications widget.
   
1. Switch the Zigate into Pairing mode, make sure that Domoticz accept new hardware

1. Trigger the pairing process on the Livolo switch by pressing the livolo switch 6 seconds until you hear a bip

After a while the Livolo should be paired and 2 Widgets should have been created on Domoticz.

PS: 
* Even if you have a Single Bang Livolo switch, 2 switch widgets will be created. There is no way at that time to detect a Single gang to a Double gang,
you can remove the Widget LivoloSWR which is not going to be used.

* @Kiwic16 has found a way to get the Livolo switch remaining paired with the Zigate. Check with him if you need this information. http://kiwihc16.free.fr/Livolo.html


## Livolo on channel 11

It looks like a paired Livolo switch on channel 26, can be moved to channel 11. In order to get the Livolo switch to channel 11 - and only 11 - follow the following steps:

The Livolo switch must already be paired on channel 26.

1. Setup the Zigate channel to 11. Use the Web GUI Settings page and set the channel to 11
1. Do a Zigate Software reset. Use the Web GUI Admin page and do Zigate Reset

After a while, the Livolo should be switching automatically to channel 11.

Unfortunatly, if you get power outage, you'll have to delete the corresponding widgets from Domoticz and redo the pairing process on Channel 26.

## One model name for 2 products

* what ever you have a single or double gang switch, this will be seen as a __TI0001__ Model name, and from that the plugin is not able to find if it is a single or double gang. After the provisionning process in Domoticz in case you have a single gang, you will have to remove the __Right__ command widget.

## On and OFF

On and OFF are not based on the Cluster 0x0006, but rather on cluster 0x0008. Don't ask me why ... Livolo migh have a reason for that !

On the Cluster 0x0008 (Level Control) Livolo are using those 2 parameters.
1. Level which the level you want to move. This is used for the On or Off command
1. Transition period which express the time to move from the current state to the new one. This is used for the Gang selection (Left or Righ)

| Command | Level |
| ------- | ----- |
| On      | 0x6C (108) |
| Off     | 0x01 (1) |

| Gang selection | Transition |
| -------------- | ---------- |
| Left           | 0x0001 (1) |
| Right          | 0x0002 (2) |

For exemple if you want to Switch On Gang Right, you'll have to do Level 0x6C with Transition 0x0002


## Advanced 

* It could happen that the switch is out of the network and failed every time to rejoin the network. Usally a Power Off/On or a simple reset ( Press 6 seconds on the left button) make the trick. In case it doesn't happen, you may try to go to the Settings and enable the __rebindLivolo__ parameter from the experimental section.

## References

* https://github.com/fairecasoimeme/ZiGate/issues/148
* https://github.com/KiwiHC16/Abeille/issues/570
* http://kiwihc16.free.fr/Livolo.html
