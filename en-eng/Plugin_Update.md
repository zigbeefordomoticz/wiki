<a href="Home.md"><img align="left" width="80" height="80" src="../Images/logo_Z4D.png" alt="Logo"></a>

## Plugin Update

</br>

The plugin is regularly updated. For bug fixing or enhancement. In order to keep the plugin up to date

* Go in your Domoticz directory using a command line and open the plugins directory then the Domoticz-Zigate-Plugin directory.
* Run: `git submodule update --init --recursive`

__Note :__ Since version 6, the git pull is no longer enough.

* In case you have edited/updated some of the plugin controlled file, you might get an error message protecting any update. In such situation you can reset those files with the latest version with the following commands
  ```
  git reset –-hard
  git pull --force
  ```

* Run: `sudo chmod +x plugin.py`
* Restart Domoticz.

* Lancer la commande `git submodule update --init --recursive`



## Plugin branches

The plugin is under constant development in order to bug fix and add new features as well as taking into account new devices.

The code is available under different branches

## About release channels

In order to provide stability and also provide more recent development, Zigate plugin has the following channels

### stable

This is considered as a solid , reliable version.

### beta

We can open the beta channel to provide early version and to stabilize the version priori to be move to the stable channel

## How to switch from one channel to the other

`git pull`

`git checkout stable  // will move you to the stable channel`

`git checkout beta    // will move you to the beta channel`
