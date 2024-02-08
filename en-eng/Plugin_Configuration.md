# Plugin configuration

This is the third step of the plugin ZigBeeForDomoticZ installation process.

You should have already finished the [STEP 1 Instalaltion](Plugin_Installation.md) and the [STEP 2 Seetings](Plugin_Settings.md).


## Access to the administration interface

The administration interface gives you an access the following elements :

- A dashboard
- Devices and groups management
- Network topology and ZigBee network quality
- Commands to administrate the coordinator, plugin and devices
- Plugin configuration
- Tools to debug, manage errors and interaction with devices

You can access to the web administration interface with http://IP-domoticz-server:port-number-defined-in-settings.

If your DomoticZ is on a local server and you leave the port by default, the web interface url is http://127.0.0.1:9440.

**Note :** If the user interface is not reachable :
* Check that you use the same port as the one in the DomoticZ parameters of the plugin. 
* Check that your firewall is not blocking the access.

**Caution :** For security reasons, **do not forward the 9440 port outside of your home** otherwise everybody would det access to it.

![Zigate Web Admin Interface](Images/Dashboard.png)
