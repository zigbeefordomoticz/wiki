# Dealing with pairing issues

The plugin is developped in a way that it is capable to handle devices which respect ZigBee specifications.
For instance if the plugin see an unknown device type, it will try to create widgets based on the Device capabilities.

## What type of issues

* At the end of the pairing process, I do not see any widget in Domoticz
* The Widget created in Domoticz is not correct

## What to do

If you have a plugin version 4.4 or above

* During the pairing process, what every the pairing is successful or unsuccessfull, all important information captured during the pairing process will be save in the file `Reports/PairingInfos-xx-ieee.json` where xx is the Zigate plugin hardware Id (from Domoticz) and ieee is the IEEE address of the Device. You might also be able to identify the file with its date/time.

  1. identify the corresponding PairingInfos file
  1. Use the French or English Forum to create a post and describe the problem
     1. attach the PairingInfos file
     1. attach the domoticz log file at the time of the pairing ( not mandatory, but welcome )
     1. Provide as much informations on the device. References, URL, 
     1. Provide screenshoot of the Widget(s) created on Domoticz
     1. Provide a description of what would be expected
   
If the plugin version you are running is below 4.4, we advice you to switch to the beta branch and redo the pairing process.

 * to switch to beta branch
   ```
   git pull
   git checkout beta
   git pull
   ```
   
   
   
## Forums to post the issue

* [English forum](https://www.domoticz.com/forum/viewforum.php?f=68)
* [French forum](https://easydomoticz.com/forum/viewforum.php?f=28&sid=babfcfc5e2a5cd7b6e3cbbe24b02062c)

