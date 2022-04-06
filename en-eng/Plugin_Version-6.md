# How to move from version 5 (stable5) to version 6 (stable6 or beta6)

<a href="../fr-fr/Plugin_Version-6.md"><img align="left" width="15" height="15" src="../Images/flag_france.png" alt="Logo"></a>
[Cette page est disponible en français.](../fr-fr/Plugin_Version-6.md)

To make a __new plugin install__, please follow [the install procedure](Plugin_Installation.md). For the moment, only the manual installation on Linux has been tested and validated.

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

1. Stop DomoticZ. The command is usually :

    ``` bash
    sudo service domoticz.sh stop
    ```

1. Go in the plugin directory. The command is usually :

    ``` bash
    cd domoticz/plugins/Domoticz-Zigate
    ```

1. Run the command :

    ``` bash
    git remote set-url origin https://github.com/zigbeefordomoticz/Domoticz-Zigbee
    ```

1. Install the necessary Python packages with the command :

    go to the plugin folder domoticz/plugins/Domoticz-Zigbee (or Domoticz-Zigate)

    ``` bash
    sudo pip3 install -r requirements.txt
    ```

1. Execute the command by adapting pi:pi if necessary to the user:group used. Be careful to take the point at the end.

    ``` bash
    sudo chown -R pi:pi .
    ```

1. Run the command :

    ``` bash
    git config --add submodule.recurse true
    ```

1. Install the missing Python libraries with the command :

    ``` bash
    git submodule update --init --recursive
    ```

1. Make the __plugin.py__ file executable with the command :

    ``` bash
    sudo chmod +x plugin.py
    ```

1. Restart DomoticZ. The command is usually :

    ``` bash
    sudo service domoticz.sh start
    ```

    Normally, the name of the plugin in hardware has become __ZigBee for DomoticZ__.

    From now on, the term ZiGate is replaced by __coordinateur__, more generic.

    If you already have a plugin configured with a ZiGate as coordinator, you don't have to do anything : the plugin should continue to     work normally.

## Settings

There are 4 possible coordinator models:

* ZiGate : no changes to the existing plugin.
* ZiGate + : no changes to the existing plugin.
* ZiGate (via zigpy) : the plugin communicates with the ZiGate through zigpy libraries. It's only experimental and won't be supported.
* Texas Instruments ZNP : for  TI Brand Coordinators.
* Silicon Labs EZSP: for the Silicon Labs Coordinators.

## IMPORTANT Plugin's update

The `git pull` is no longer sufficient, it is now necessary to make the command `git pull --recurse-submodules`.
