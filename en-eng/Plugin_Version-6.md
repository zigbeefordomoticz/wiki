
# How to move from version 5 to version 6

</br>

<a href="../fr-fr/Plugin_Version-6.md"><img align="left" width="15" height="15" src="../Images/flag_france.png" alt="Logo"></a>
[Cette page est disponible en français.](../fr-fr/Plugin_Version-6.md)


__Note :__ This how-to is only validated for a Linux installation.


## Prerequisites

Before strating the procedure, you should :

* Have a version of DomoticZ 2021.1 at least.
* Be on plugin's __Stable5__ branch. Command `git checkout stable5` if needed.
* Have the latest version of the plugin. Command `git pull` if needed.


## Backup

Even if the procedure has been tested several times, things may not go as planned.
It is recommended to make a full backup so that you can go back if necessary.
Remember to save :

* DomoticZ
* The plugin's data
* The operating system


## Procedure

1. Open the terminal
2. Stop DomoticZ. The command is usually : `sudo service domoticz.sh stop`
3. Go in the plugin directory. The command is usually `cd domoticz/plugins/Domoticz-Zigate/`
4. Run the command : `git remote set-url origin https://github.com/zigbeefordomoticz/Domoticz-Zigbee`
5 Install the necessary Python packages with the command : `sudo pip3 install voluptuous pycrypto aiosqlite crccheck pyusb attrs aiohttp pyserial-asyncio`
6. Run the commande `sudo chown -R pi:pi .` (attention to take the dot at the end). If needed, replace __pi:pi__ accordingly to the __user:group__ that you are using.

During the time of the development phase, it is necessary to move on to the new beta6 branch : `git checkout beta6`

7. Install the missing Python libraries with the command : `git submodule update --init --recursive`
8. Make the __plugin.py__ file executable with the command : `sudo chmod +x plugin.py`
9. Restart DomoticZ. The command is usually : `sudo service domoticz.sh start`


Normally, the name of the plugin in hardware has become __ZigBee for DomoticZ__.

From now on, the term ZiGate is replaced by __coordinateur__, more generic.

If you already have a plugin configured with a ZiGate as coordinator, you don't have to do anything : the plugin should continue to work normally.


## Settings

There are 4 possible coordinator models:

* ZiGate : no changes to the existing plugin.
* ZiGate + : no changes to the existing plugin.
* ZiGate (via zigpy) : the plugin communicates with the ZiGate through zigpy libraries. It's only experimental and won't be supported.
* Texas Instruments ZNP : for new TI Brand Coordinators.



## IMPORTANT Plugin's update

The `git pull` is no longer sufficient, it is now necessary to make the command `git pull --recurse-submodules`.
