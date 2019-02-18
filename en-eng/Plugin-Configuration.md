== Configuration ==

In Domoticz, go in Setup&gt;Hardware, in Type select &quot;Zigate plugin&quot;.

[[File:https://github.com/sasu-drooz/Domoticz-Zigate/blob/master/Images/Zigate-Configuration.png|frame|none|alt=|caption ]]

* Name: Select a name for your hardware (here it's zigate)
* Type: Zigate plugin
* Data Timeout: Disabled
* Select your model (USB or Wifi)
** if Wifi enter IP of your Zigate, keep port to 9999 (not possible to change this on the zigate yet)
** if USB, select your device port (always /dev/ttyUSBx under linux, COMx for Windows)
* Software Reset: False ( If you want to do a Software reset of the Zigate at startup, you can set to True

* Set Permit join time, between 0 and 255 to Permit join devices on plugin or Domoticz start
** O stands for do nothing
** 1 to 254 is the time in seconds for which the Zigate will be open for commissioning
** 255 is for all the time open for commissioning new devices (in the case where you have set the Permit to Join to 255 and now you want to disable it, you need a 2 steps approach. (1) you set the value to 1 and you start the plugin, then you set the value to 0 and you can restart it.
* Set Erase Persistent Data to true if you want to clean Zigate memory (devices know list in zigate)
* Set Verbors and Debugging: By default to None.
