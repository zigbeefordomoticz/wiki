## Preamble
The purpose of this document is to help you in the installation of the Zigate plugin on a Synlology platform

## Pre-requisites

* First of all, please go through the  [Domoticz Python page](https://www.domoticz.com/wiki/Synology_installation_folder)
* The Domoticz for Synology package to be installed is the version 'with Python'. You can download it from Jahdal. At this moment it is v4.10717 with Python 3.5.1.
* Python Module from the Package manager must be installed. [Python Module](https://www.synology.com/en-uk/dsm/packages/PythonModule)
* The GitHub server Synology package must be installed . Install Git Server package via Diskstation. We don't need the 'Server' part of the GitHub Server package, just the 'git command', so no specific configurations are required.
* it is assumed that you have 'root'/'admin' right access with the use of 'sudo' command

Attention:
  * You need git-server package
  * Domoticz with python
  * USB drivers for zIgate can be found on [jadahl.com](http://www.jadahl.com/drivers_6.2/)

## Installation of the Plugin
Start a Putty session and login

Navigate to plugin folder domoticz:

cd /volume1/@appstore/domoticz/var/plugins

GIT clone Zigate plugin to new folder Zigate:

sudo git clone https://github.com/sasu-drooz/Domoticz-Zigate.git Zigate

Stop and start domoticz from package manager.

--------------------------------------------------------

In domoticz navigate to Settings -> Hardware

Pick Zigate Plugin from the list, name it and set the wright USB port.

At the first boot you have to set “Erase Persistent Data” to True to build a new network.

Set Permit Join to value 255 to search for a unlimited time for new devices

Click Add and check the log. When the USB TTL is in Permit Join mode the blue and red LEDs are flickering. Now you can add devices the usual way. For example press and hold 3 secs the button at the Aqara sensor.

When you are done adding devices set the permit join value to something lower than 255. 

## Known issue

There is a known issue on Syno which makes Domoticz to crash when starting the plugin. 
You need to disable the feature to check for plugin and firmware update availability.

You have to edit the file Domoticz-Zigate/Conf/PluginConf-xx.json
and add the following line

"internetAccess": 0,

the best is to add it in the middle of the file, so you don't break the all file syntax


