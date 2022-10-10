## How to pair a device ?
Just turn off/on 6 times your bulb (not with ikea remote, shut off then on power). Your bulb will send a device announce to your zigate, then your zigate will ask some information to your bulb to know wich model it is and add it to Domoticz. If your model is not in DeviceConf.txt it should take a little longer but it will be automatically add as soon as the zigate will have information need foor this.

![Bulb Device](../Images/Zigate-Bulb-Device.png)

You should find between 1 and 3 new devices in your Domoticz Device list :

* simple switch, to turn on or off your bulb
* Level Control (LvlControl), to set brigthness level of your bulb
* Color Control (ColorControl), to set color of your bulb


## How to reset the round remote control
4 times (fast) of the pairing button

## How to reset a Bulb
power off few minutes
Then you can simply switch On and it will send a Device Annoucement to start the Pairing process

## How to use the Remote Control
With Zigate firmware 3.0f you can get the remote control event in domoticz (via a switch selector). In order to do that you must have at least 1 Ikea Bulb, 1 Remote control , 1 Zigate.
* Pair the Ikea Bulb to Zigate, this will create a Switch widget
* Pair the Ikea Remote to Zigate, this will create a Switch selector
* Pair the Ikea Remote with the Ikea Bulb (in order to get them associated , and create a group)
* Enable the Group Management (if not yet done)
  * Let's the plugin do the work and identify the Group created by the Ikea Bulb/Control association
  * You then need to associate the Zigate to this group (see in the Group Management on how to do that )

* A step-by-step approach is presented here: [Ikea remote](Corner_Ikea-Remote.md)

## How to use the tiny Remote switch On/off (squared usally sold with plug )

Here is the method to get a Widget associated in Domoticz and then to get it updated.

ATTENTION:
The switch is controling group 0x0000 (which is usally a group used by Xiaomi plugs and switches).  You might have to do some cleanup in group membership, if you want to avoid the tiny switch controling unexpected plug
In case you want to use the swicth for something else, you will have to remove all devices from group memebership 0000

1. Paired with Zigate

   * This will create a Switch widget on Domoticz and you'll get On and Off event

   * To paired the switch with Zigate, press 4 times in 5 secondes when the Zigate and the Plugin are in Permit to Join mode.


1. Make sure that Zigate IEEE is member of Group 0000

   * Edit ZigateGroupsConfig-xx.txt and have a similar line. Here only the Zigate is part of this group and not any other devices

   ```
   0000,Groupe 0000, 00158d0001ededde
   ```

   Where 00158d0001ededde is the IEEE of Zigate which can be find in the Log or in the Zigate notfication widget .

1. To add devices to the group

   * Don't use the the Remote switch pairing button to pair devices, otherwise you'll loose the connectivity with Zigate and the events capture in Domoticz.
   * You have to add the list of IEEE devices to group 0000 in ZigateGrouspConfig


[More info](Corner_Ikea-Remote.md)

## How to use the Tradfri Motion sensor

1. Paired with Zigate

   * This will create Motion widget
   * If needed you have to reset the Motion sensor by pressing the pairing button 4 times within 5 secondes

1. Paired with a bulb

   * Hold the motion sensor close too the light source you want to add ( no more than 5cm). Press and hold the pairing button for at least 10 seconds. At the end of the pairing process, the light source will flash one time .

1. You need to add Zigate to the same group created by the Motion sensor.
   * Enable the Group Management (if not yet done)
   * Let's the plugin do the work and identify the Group created by the Ikea Bulb/Control association
   * You then need to associate the Zigate to this group (see in the Group Management on how to do that )

   * A [step-by-step approach](Corner_Ikea-Remote.md) is presented here for the Ikea Remote ( Phase1, Phase 2 and Phase3 Testing ), Option1 and Option2 are Remote Controller specific

From that , every time the motion sensor will turn on the light, you'll get as well the motion widget to On.

You might want to align the Time setting of the Motion sensor with the Reset Time of the Motion widget in Domoticz

[More info](Corner_Ikea-Tradfri-Motion.md)

## How to use Fyrtur connected roller blind

When IKEA Fyrtur blind is purchased, it comes in package which contains blind, wireless remote controller and wireless repeater.
All three are connected together out-of-the box, and remote controller can be used to control blind.
Additional blind(s) can be purchased, and additional blind(s) can be added to remote controller by following IKEA instructions.

You can factory reset blind/remote/repeater, and pairing all three together you get the out-of-the box functionality back.

Using blind, blind remote and repeater paired with Zigate in Domototicz is accomplished with following:

   1. put Zigate/Domoticz into pairing mode and factory reset repeater. 
   * Repeater will pair with Zigate and act as general purpose Zigbee repeater in Zigate network.
   2. put Zigate/Domoticz into pairing mode and factory reset blind (long press on both blind buttons).  
   * Blind will pair with Zigate, and Domoticz widget is created.  Widget can be used to control blind. 
   3. put Zigate/Domoticz into pairing mode and factory reset blind remote (clicking remote's pairing button rapidly four times).
   * Befor pairing make sure "Create Group 0000" is enabled in Zigate advanced settings.  
   * Repeater will pair with Zigate, and Domoticz widget is created.  Widget can be used to receive remote's button presses. 

After steps 1-3 remote can be used by receiving the button presses with Domoticz, and using Domoticz scripting to control blind with blind widget.

Using following additional steps we can add Zigate group containing blind(s) and remote.  Remote will then control blind directly, and Domoticz scripting is not necessary

   4. In Zigate Web UI Management->Group Management, press "Add New Group" and select blind(s) into group. Press "Validate" and group is created.  Refresh Web UI page to see created group, and note "Group ID"
   * Domoticz group widged is also created and can be added in Domoticz device management.  
   5. Use Zigate REST api with following command to first un-bind remote grouping and then bind remote into group created in Zigate
   * Find out remote IEEE address from Web UI ->Device Management.  We will use IEEE address 680ae2fffeaae6cb in this example
   * unbind remote through REST API, for example using curl: 
   *     curl -X PUT -d '{"sourceIeee":"680ae2fffeaae6cb", "sourceEp": "01", "groupId": "0000", "cluster": "0102"}' http://127.0.0.1:9440/rest-zigate/1/unbinding-group
   * bind remote to group containg blind(s), using "Group ID" from step.  We will use group id 0002 in this example, again using curl and REST api
   *     curl -X PUT -d '{"sourceIeee":"680ae2fffeaae6cb", "sourceEp": "01", "groupId": "0002", "cluster": "0102"}' http://127.0.0.1:9440/rest-zigate/1/binding-group
   * remote will not appear in Web UI Group Management page, but if everything went well it will control the blind(s) in group. 
   
Test that remote is controlling blind(s).  Test that blind Domoticz widget is controlling blind.
If you need to read remote button presses from Domotiz widged of remote, add Zigate into same group with blinds from Web UI group management

If you need to re-do grouping of remote, it is best to remove pairing to Zigate (remove Domoticz widget) and do steps 2. and 5. again.
