#Using the tradfri Motion Sensor with an ikea device (bulb or Outlet) and Stand alone with Zigate 

## 1. Prerequisites
Before you start these are the necessities.
One tradfri motion sensor (MS)
One tradfri bulb or wall outlet (WO)
Zigate domoticz plugin with atleast fw version 3.0f and domoticz version (beta) 4.10900 or higher
Acces to the WebUI: http://yourdomoticzIP:9440 

## 2. Pairing devices with Zigate
In the WebUI switch “accept new hardware” to on. 
Pair the devices with Zigate, by holding them close to the Zigate. Pair the Motion Sensor (MS) by pressing the pair button on the back 4 times and the bulb (switching it off 6 times) or WO (pressing the pin underneath for few seconds). After pairing you should see the devices in the Domoticz Settings  devices. There you should see the paired devices.  

## 3. Pairing devices with each other
Next thing to do pair the bulb and the MS. This can be done by holding MS near the bulb or walloutlet. And press the pair button on the back 10 seconds. When finished the red light in the MS will switch and the bulb will flash and the WO will make a clicking sound or the led will flash. 

## 4. Making a group
First enable the groupmanagement in settings in the WebUI or in the through command prompt go to folder ~/Domoticz-Zigate/Conf and open PluginConf-XX.json and set 
"enablegroupmanagement": 1,  
Automatically: When a bulb or WO is paired with the MS you can go to domoticz setting Hardware and click on the Zigate plugin. Scroll down to setting “Rescan for group membership” and set it to “true”. After that press the update button and the plugin will restart. After some time the new group will be added to the devices tab in Setting. Check the unused devices for a Zigate group.
Open the webUI and go to the management tab of the WebUI and open Groupmanagement there you will find the new group. The new group will be in the overview. 
To make the MS widget active you need to add Zigate to the group. This will show the On /Off status of the widget. Otherwise the widget won’t give status info. To make it active put check mark behind the group line. After that, press Validate en restart the plugin in the admin menu.  When startup of groupmanagement is ready you will see you’re Zigate IEEE in the domoticz log. The checkmark is shown in the groupmanagement page in the WebUI.
Whenever movement is detected by the MS will trigger the bulb or WO to switch on. The Status of the bulb, WO and the MS widget change. Depending on the settings on the MS it will switch of after after the set time. 

## 5. Making the Motion Sensor a standalone device.
The MS can be made standalone by deleting the devices in the group in the groupmanagement page. After validating and restarting the plugin the group will still exist without any devices. The motion sensor is connected to this group in the background. Status changes can be seen in the domoticz log and in the MS Widget. 
Now it is possible to use the MS in a script (LUA, Dzvent or Blockly). This way you are not bound to Zigbee products and you can use it with other devices who run on other protocols like (Zwave, wifi, mqtt or 433mhz). 

## Remarks

### Groupmanagement with active Ikea tradfri remotes and motion sensors
When using tradfri devices like the Ikea 5 button round remote or the Ikea motion sensor the created widgets are not active after pairing. After paring the device widgets are added to Domoticz but actions can not be seen in Domoticz. There you to add those devices to a group. See tutorial  
https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/en-eng/Ikea-Remote.md
To make them active go to webUI management  Groupmanagement and fill the checkmark behind the group where the remote or motion sensor is part of, to make active. After validating, a group rescan and plugin restart the remote or motion sensor will be active. This way you get statusupdate in the widgets and the remote will be capable of using the left and right button. 

## Limitation
This activation of tradfri devices is limited to 5 devices. This is because of limited memoryspace in the Zigatechip. When you add a Zigate to a group for the sixt time the device connection is not established. You get a this error in the domoticz log: We reach the max number of Cycle and didn't succeed in the Group Creation.
