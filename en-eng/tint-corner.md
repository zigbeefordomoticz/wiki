# Tint by Muller Licht

## Overview

purpose is to give tips and hints on the Tint devices confirmed working with the plugin

## Remote Control White ( 404022)

The tint-remote-white remote control is designed to control bulb diming and bulb white/white+ambiance.

The remote can allow to control 4 different groups. you'll be using the group selector to move from one group to the other and you'll be able to act on thos group with

* On/Off
* Dim up and down
* Scene color

### Plugin integration

When pairing the tint remote control device, the plugin will create :

1. A "tint remote white' widget to reflect the actions done on the remote - despite the group selected -
1. 4 groups ( 4003, 4004, 4005, 4006 ) where the ZiGate will belong too (which will allow to get the remote event on the Domoticz widget created )

Then it will be up to the user to associate White color diming bulb to the 4 groups created by using the Group Management menu.

### Tips

In case the 4 groups doesn't exist, or have been removed, you can simply enable via the plugin Settings the parameter `zigatePartOfGroupTint`and restart the plugin. It will automatically re-create the groups

### Important

* a ZiGate can only belongs to a maximum of 5 groups. The Tint remote will require 4 if you want to get the remote event reported to Domoticz Zidget
* If you don't plan to use the Domoticz Widget , we recommend you to remove the ZiGate membership of those 4 groups, it will not impact the remote functionnality to command the 4 groups. ( in case there is no device - bulb - attached to the group and you remove the ZiGate membership, the group will autoamtically be removed )
