# Reinstall Plugin and keep Database and Configuration


## Overview

Purpose is to do a re-install of the plugin without loosing any data



## Assumption

* Domoticz plugins are located in ```/home/pi/domoticz/plugins ``` 
* Zigate plugin has been installed by default under ```/home/pi/domoticz/plugins/Domoticz-Zigate```

In case this is different, please use your own location


## Procedure

1. Stop domoticz

2. Move the Zigate plugin folder to your home directory
   ```mv /home/pi/domoticz/plugins/Domoticz-Zigate   /home/pi```
3. Install the fresh version of the plugin
   ```
   cd /home/pi/domoticz/plugins
   git clone https://github.com/pipiche38/Domoticz-Zigate.git
   ```
4. Copy the Zigate plugin database to the new installation
   ```
   cp /home/pi/Domoticz-Zigate/Data/* /home/pi/domoticz/plugins/Domoticz-Zigate/Data
   ```
5. Copy the Plugin configurations file
   ```
   cp /home/pi/Domoticz-Zigate/Conf/PluginConf* /home/pi/domoticz/plugins/Domoticz-Zigate/Conf
   ```
   
At that stage you have a copy of the Old plugin in /home/pi/Domoticz-Zigate and a new version ready to be launched in /home/pi/domoticz/plugins/Domoticz-Zigate

6. You can now restart Domoticz
