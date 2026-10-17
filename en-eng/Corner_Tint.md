# Tint by Müller Licht

Tips for the Tint devices that need a specific setup with the plugin.

## Remote Control White (404022)

The Tint white remote control (model `tint-Remote-white`) controls dimmable bulbs and the white temperature of white/white-ambiance bulbs. **It can't control the color of RGB bulbs.**

The remote controls 4 groups, `4003`, `4004`, `4005` and `4006`: use its group selector to move from one group to the other, then act on the selected group with:

* On/Off;
* dim up and down;
* white temperature scenes.

### Plugin integration

Group management must be enabled (see [Manage Zigbee groups](HowTo_Group-management.md)). When the remote is paired, the plugin adds the remote and the coordinator to the 4 groups, and Domoticz gets 5 widgets:

* one widget per group (4 in all), to dim the group and choose its white temperature. A color choice is shown, but it has no effect;
* one widget for the remote itself, showing the last command done on the remote. It is a selector with 18 values, for information only: changing it in Domoticz does nothing.

Then add your bulbs to the 4 groups in *Management > Group Management*.

### Coordinator membership

The coordinator is a member of the 4 groups so that it receives the remote commands and the plugin can update the Domoticz widgets.

* A coordinator can only belong to a limited number of groups, depending on the coordinator (see [Coordinators](Coordinators.md#limited-number-of-groups)). The remote uses 4 of them.
* If you don't use the Domoticz widgets, you can remove the coordinator from the 4 groups in *Management > Group Management*: the remote still controls the bulbs of the groups, but Domoticz no longer sees its commands. A group that has no device left is deleted when the coordinator is removed from it.

### If the groups are missing

If the 4 groups don't exist any more, or were removed, pair the remote again (open the network for pairing and reset the remote, see [Add a new device](HowTo_Pairing-device.md)): the plugin adds the coordinator to the 4 groups again. Then add your bulbs back in *Management > Group Management*.

With a Silicon Labs (EZSP) coordinator, you can instead enable the `zigatePartOfGroupTint` setting (*Settings*, *Group management*, advanced) and restart the plugin: the coordinator is then added to the 4 groups at every start.
