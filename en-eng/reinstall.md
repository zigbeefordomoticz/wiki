# Reinstall Plugin and keep Database and Configuration


## Overview

Purpose is to do a re-install of the plugin without loosing any data



## Assumption

* Domoticz plugins are located in ```/home/pi/domoticz/plugins ``` 
* Zigate plugin has been installed by default under ```/home/pi/domoticz/plugins/Domoticz-Zigate```

In case this is different, please use your own location


## Procedure

1. Stop domoticz

1. Move the Zigate plugin folder to your home directory

   ```mv /home/pi/domoticz/plugins/Domoticz-Zigate   /home/pi```
   
1. Install the fresh version of the plugin

   ```
   cd /home/pi/domoticz/plugins
   git clone https://github.com/pipiche38/Domoticz-Zigate.git
   ```
   
1. Copy the Zigate plugin database to the new installation

   ```
   cp /home/pi/Domoticz-Zigate/Data/* /home/pi/domoticz/plugins/Domoticz-Zigate/Data
   ```
   
1. Copy the Plugin configurations file

   ```
   cp /home/pi/Domoticz-Zigate/Conf/PluginConf* /home/pi/domoticz/plugins/Domoticz-Zigate/Conf
   ```
   
1. Copy the Plugin reports 

   ```
   cp /home/pi/Domoticz-Zigate/Reports/* /home/pi/domoticz/plugins/Domoticz-Zigate/Reports
   ```
   
   At that stage you have a copy of the Old plugin in /home/pi/Domoticz-Zigate and a new version ready to be launched in ```/home/pi/domoticz/plugins/Domoticz-Zigate```

1. By default you'll be on the 'stable' branch, if you want to switch to 'beta' do

   ```
   cd /home/pi/domoticz/plugins/Domoticz-Zigate/
   git pull
   git checkout beta
   ```

1. You can now restart Domoticz
