# Reinstall Plugin and keep Database and Configuration

## Overview

Purpose is to do a re-install of the plugin without loosing any data

You have __critical__ files under the Domoticz-Zigbee folder. In case of crash, you might want to have backup to restore. Here after are the files to backup

    Conf/PluginConf-*.json
    Data/*
    Reports/*

Of course you must backup the Domoticz Database `domoticz.db` (check to Domoticz) __at the same time__ in order to have consistency between the two.


## Assumption

* Domoticz plugins are located in ```/home/pi/domoticz/plugins ```
* ZigBeeForDomoticZ plugin has been installed by default under ```/home/pi/domoticz/plugins/Domoticz-Zigbee```

In case this is different, please use your own location


## Procedure

1. Stop domoticz

1. Copy the ZigBeeForDomoticZ plugin folder to your home directory

   ```
   cp /home/pi/domoticz/plugins/Domoticz-Zigbee   /home/pi
   ```

1. Install the fresh version of the plugin

see Instalaltion page

1. Copy the ZigBeeForDomoticZ plugin database to the new installation

   ```
   cp /home/pi/Domoticz-Zigbee/Data/* /home/pi/domoticz/plugins/Domoticz-Zigbee/Data
   ```

1. Copy the Plugin configurations file

   ```
   cp /home/pi/Domoticz-Zigbee/Conf/PluginConf* /home/pi/domoticz/plugins/Domoticz-Zigbee/Conf
   ```

1. Copy the Plugin reports (if you want to keep the old reports)

   ```
   cp /home/pi/Domoticz-Zigbee/Reports/* /home/pi/domoticz/plugins/Domoticz-Zigbee/Reports
   ```

   At that stage you have a copy of the Old plugin in /home/pi/Domoticz-Zigbee and a new version ready to be launched in ```/home/pi/domoticz/plugins/Domoticz-Zigbee```

1. You can now restart DomoticZ
