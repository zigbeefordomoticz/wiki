## Release 4.1

Even if we are just moving from 4.0.8 , release 4.1 is a pretty important release in terms of functionalities coming on board.
The most important one is with the empowerement of Zigate firmware 3.0f we are bringing a native support of Groups management.

While using Domoticz groups which operates then device by device, the plugin native group management allow you to create a
group of devices and to send the same command to all devices of that group at once. Result is a quiet
responsive Domotic system.

Important efforts have been made to support a number of additional devices and especially remotes controllers as well as some others
* Hue remote controller
* Ikea Tradfri remote controller ( 5 buttons and the yellow one)
* Xiaomi Vibration
* Zipato smoke detector
* Hue Motion Sensor

Features like, using Domoticz Temperature and Pressure adjustment can made out of the Domoticz widget. The Motion (off delay)
can also be configured directly from the Domoticz widget.

The plugin has been tested with the new up-coming PiZigate. No special integration have been done, except than providing a
tool (shell script) to switch the PiZigate in **run** mode or in **flash** mode. More information
can be found [here](Plugin_Installation.md).

For more information on the certified list of devices, please check
[List of certified devices](Info_Compatible-devices.md)

Addition work have been also done around the discovery mecanishm in order to speed up the process, but also to handle
as much as possible ZLL and ZHA compliant devices.

## IMPORTANT
* There is not Migration path from 3.x.x to 4.1. If you are still in 3.x.x version you have unfortunately to start from scratch.

* Last but not least, we have also restructured the plugin filesystem in order to have a cleaner situation. As a result,
a short migration step needs to performed by yourself, before restarting the plugin.

   You'll have to move the file DeviceList-xx from the Domoticz-Zigate (plugin directory) to Domoticz-Zigate/Data ( data plugin directory)

   Read with attention [here](https://github.com/sasu-drooz/Domoticz-Zigate/blob/pre-4.1/00-UPGRADE-FROM-STABLE-4.0.md)

## NOTES:
* If you want to have the full power of the plugin, some of the features rely on the latest development of Domoticz.
We recommend using Domoticz V4.10547 or higher. However the plugin remains compatible with the current Domoticz V4.9700.

## KNOWN ISSUES and LIMITATIONS

1. When creating a group of blind/shutter, the plugin will create a group of switch type. Simply edit it and change the Type.
However if there is some group changes later on, the plugin will override this change, and you will have to edit again to Blind Percentage Inverted.

## FOR SUPPORT
Please feel free to ask for support and for that please use the existing Domoticz Forums.

   * [French Forum](https://easydomoticz.com/forum/viewforum.php?f=28)
   * [English Forum](https://www.domoticz.com/forum/viewforum.php?f=68)

## DOCUMENTATION
We are currently translating the wiki for our Dutch users (big thanks to Karsten for the work done).
Anyone willing to improve , translate in other languages are more than welcome

## CONTRIBUTIONS

We would like also to encourage sharing and if you wouldn't to share with the other users some scripts, dzVents, LUA ... please
feel free to get an account on GitHub and push to the plugin [Contrib](../Contrib/Readme.md)

More details can be found in the Release Notes.


Last but not least, we are looking to improve the User Experience and especially the administration part. For that we
would like to develop a set of Web pages based on HTML5, CSS and JAVASCRIPT and we are looking for contributors on this matter.
Please feel free to join us as anything is making the plugin better and greater...
