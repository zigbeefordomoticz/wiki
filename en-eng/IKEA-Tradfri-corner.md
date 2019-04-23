## How to pair a device ?
Just turn off/on 6 times your bulb (not with ikea remote, shut off then on power). Your bulb will send a device announce to your zigate, then your zigate will ask some information to your bulb to know wich model it is and add it to Domoticz. If your model is not in DeviceConf.txt it should take a little longer but it will be automatically add as soon as the zigate will have information need foor this.

![Bulb Device](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Zigate-Bulb-Device.png)

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
  
* A step-by-step approach is presented here: https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/en-eng/Ikea-Remote.md

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

## How to use the Tradfri Motion sensor

1. Paired with Zigate

   * This will create Motion widget
   * If needed you have to reset the Motion sensor by pressing the pairing button 4 times within 5 secondes
   
1. Paired with a bulb 

   * Hold the motion sensor close too the light source you want to add ( no more than 5cm). Press and hold the pairing button for at least 10 seconds. At the end of the pairing process, the light source will flash one time .
   
From that , every time the motion sensor will turn on the light, you'll get as well the motion widget to On.

You might want to align the Time setting of the Motion sensor with the Reset Time of the Motion widget in Domoticz
