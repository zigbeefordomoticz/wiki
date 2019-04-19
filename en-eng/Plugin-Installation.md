## Installation

Python version 3.5 or higher required &amp; Domoticz version 3.87xx or greater.
For more information on Python requirements we advice you to go to the [Domoticz Python page](https://www.domoticz.com/wiki/Using_Python_plugins).

To install:

1. If you are on a Synology NAS platform
   * [Plugin-Installation on Syno](Plugin-Installation-on-Synology-NAS.md)
   
1. If you are installing and be using the Plugin with a PiZigate you have some follow some pre-requisities
   * You must be on a Raspbian distribution
   * You must install the wiringPi package to get access to gpio commands
   
     1. `$ sudo apt-get purge wiringpi`
     
     1. `$ hash -r`
     
     1. In order to test if wiringPi is well installed you can :
     
     `$ gpio -v`
     
     `$ gpio readall`
     
     1. You must also have the Python3 version of wiringPi in order to have the plugin able to set the piZigate in Run mode
     
     `pip install wiringpi`
     
     More information are available [here](http://wiringpi.com/download-and-install/)
     
   * You must be on a plugin version at least equal to 4.1
     Starting with that version, you have a tool available under the plugin Tools folder named `pi-zigate.sh`
     Before starting the plugin, you must set the PiZigate in running mode and for that you have to run
     
     `pi-zigate.sh run`
     
     You'll see the Blue lead on the Pi-Zigate switchin on.
     
     From there go ahead
     
     A Cookbook for PiZigate on an RPI3B+ is available [here](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/en-eng/PiZigate-RPI3B+-Cookbook.md)

1. For Unix system using the Python Plugin Manager
   * If you have [pp-manager](https://github.com/ycahome/pp-manager) installed on your system
   * Just search for "Zigate Plugin" entry and add it.

1. For manual installation
   * Go in your Domoticz directory using a command line and open the plugins directory.
   * Usually you should be under <code>domoticz/plugin</code>
   * Run: `git clone https://github.com/sasu-drooz/Domoticz-Zigate.git`
   * It will create a folder 'Domoticz-Zigate'
   * Make the plugin.py file executable `chmod +x Domoticz-Zigate/plugin.py`
   * Restart Domoticz.

Attention:

* If you are installing the plugin on Synlogy,
  * You need git-server package
  * Domoticz with python


In the web UI, navigate to the Hardware page. In the hardware dropdown there will be an entry called &quot;Zigate plugin&quot;.

## Update

The plugin is regularly updated. For bug fixing or enhancement. In order to keep the plugin up to date

* Go in your Domoticz directory using a command line and open the plugins directory then the Domoticz-Zigate-Plugin directory.
* Run: `git pull`
* In case you have edited/updated some of the plugin controlled file, you might get an error message protecting any update. In such situation you can reset those files with the latest version with the following commands
```
git reset –-hard
git pull --force
```

* Run: `sudo chmod +x plugin.py`
* Restart Domoticz.

## Protect your data

You have some critical files under the Domoticz-Zigate folder. In case of crash, you might want to have backup to restore. Here after are the files to backup

    DeviceList-xx.txt
    PluginConf.txt
    The Domoticz Database domoticz.db (check to Domoticz)

## Plugin branches

The plugin is under constant development in order to bug fix and add new features as well as taking into account new devices.

The code is available under different branches

## About release channels

In order to provide stability and also provide more recent development, Zigate plugin has the following channels

### stable

This is considered as a solid , reliable version.

### beta

We can open the beta channel to provide early version and to stabilize the version priori to be move to the stable channel

### dev

This is where development are under go. This is not a reliable version and could be buggy and even not working depending on the stage of integration we are.
This branch is only for users whom known exactly what they are doing.

## How to switch from one channel to the other

`git pull`

`git checkout stable  // will move you to the stable channel`

`git checkout beta    // will move you to the beta channel`
