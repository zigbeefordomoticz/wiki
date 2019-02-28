## Installation

Python version 3.5 or higher required &amp; Domoticz version 3.87xx or greater.
For more information on Python requirements we advice you to go to the [Domoticz Python page](https://www.domoticz.com/wiki/Using_Python_plugins).

To install:

1. If you are on a Synology NAS platform
   * [Plugin-Installation on Syno](Plugin-Installation-on-Synology-NAS.md)

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
