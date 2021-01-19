In domoticz navigate to Settings -> Hardware

Pick Zigate Plugin from the list, name it and set the wright USB port.

At the first boot you have to set “Erase Persistent Data” to True to build a new network.

Set Permit Join to value 255 to search for a unlimited time for new devices

Click Add and check the log. When the USB TTL is in Permit Join mode the blue and red LEDs are flickering. Now you can add devices the usual way. For example press and hold 3 secs the button at the Aqara sensor.

When you are done adding devices set the permit join value to something lower than 255. 
