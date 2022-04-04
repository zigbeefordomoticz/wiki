# Plugin Version 6 running on Windows

## Assumptions

* [Git for Windows](https://gitforwindows.org) is installed, and especially Git Bash

## How to install the python additional modules

You must start a Git Bash windows in with administrator privileges

In order to install modules globally under C:\Program Files\Python310\Lib\site-packages start CMD prompt as administrator and then install modules. But make sure that you didn't install the module before for the user, if that is the case you need to remove them.

Make sure to be in the pluin home directory ( domoticz/plugins/Domoticz-Zigbee )

```bash
pip install -r requirements.txt
```

## Make the Symbolic links correct

a file `symlink.bat` is available on the home directory of the plugin, make sur to execute it with Administrator privileges

## Last check

Go in the Zigbee for Domoticz folder ( Domoticz-Zigbee ). Usally you should be under domoticz/plugins/Domoticz-Zigbee
run: `git config --add submodule.recurse true`
run: `git submodule update --init --recursive`
Restart Domoticz.

## References

* <https://stackoverflow.com/questions/36936212/how-do-i-install-a-pip-package-globally-instead-of-locally>
