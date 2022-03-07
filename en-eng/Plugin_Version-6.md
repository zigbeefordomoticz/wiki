# How to move from version 5 to version 6

<a href="../fr-fr/Plugin_Version-6.md"><img align="left" width="15" height="15" src="../Images/flag_france.png" alt="Logo"></a>
[Cette page est disponible en français.](../fr-fr/Plugin_Version-6.md)


## Informations about Beta

The Wiki you now have to look at is on [the zigpy branch](https://github.com/zigbeefordomoticz/wiki/blob/zigpy/en-eng/Home.md). This wiki will become the default version when version 6 is released as a stable version.

To make a __new plugin install__, please follow [the install procedure on zigpy branch](https://github.com/zigbeefordomoticz/wiki/blob/zigpy/en-eng/Plugin_Installation.md#2---manual-installation-running-on-linux). For the moment, only the manual installation on Linux has been tested and validated.

To upgrade from version 5 to version 6, the procedure is described below. __It is only valid for manual installation on Linux__.

Testers for other operating systems are welcome!!


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

Open the terminal.

1- Stop DomoticZ. The command is usually :
```
sudo service domoticz.sh stop
```
2- Go in the plugin directory. The command is usually :
```
cd domoticz/plugins/Domoticz-Zigate
```
3- Run the command :
```
git remote set-url origin https://github.com/zigbeefordomoticz/Domoticz-Zigbee
```
4- Install the necessary Python packages with the command :
```
sudo pip3 install voluptuous pycrypto aiosqlite crccheck pyusb attrs aiohttp pyserial-asyncio
```
5- Execute the command by adapting pi:pi if necessary to the user:group used. Be careful to take the point at the end.
```
sudo chown -R pi:pi .
```

6- During the time of the development phase, it is necessary to move on to the new beta6 branch :
```
git checkout beta6
```
7- Run the command :
```
git config --add submodule.recurse true
```
8- Install the missing Python libraries with the command :
```
git submodule update --init --recursive
```
9- Make the __plugin.py__ file executable with the command :
```
sudo chmod +x plugin.py
```
10- Restart DomoticZ. The command is usually :
```
sudo service domoticz.sh start
```


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
