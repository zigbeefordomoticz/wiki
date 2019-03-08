## How to pair a device ?
Just turn off/on 6 times your bulb (not with ikea remote, shut off then on power). Your bulb will send a device announce to your zigate, then your zigate will ask some information to your bulb to know wich model it is and add it to Domoticz. If your model is not in DeviceConf.txt it should take a little longer but it will be automatically add as soon as the zigate will have information need foor this.

[Bulb Device](https://github.com/pipche38/Domoticz-Zigate-Wiki/blob/master/Images/Bulb-Device.png)

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
