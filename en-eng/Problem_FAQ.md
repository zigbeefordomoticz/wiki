# Frequently Asked Questions

* [Q1. Where can I get support ?](#q1-where-can-i-get-support)
* [Q2. Where are the logs ?](#q2-where-are-the-logs-)
* [Q3. Can I debug myself ?](#q3-can-i-debug-myself-)
* [Q4. Where can I find the list of supported Coordinators and Devices ?](#q4-where-can-i-find-the-list-of-supported-coordinators-and-devices-)
* [Q5. Where can I find the coordinator firmwares ?](#q5-where-can-i-find-the-coordinator-firmwares-)
* [Q6. Can I use several coordinators in the same DomoticZ ?](#q6-can-i-use-several-coordinators-in-the-same-domoticz-)
* [Q7. Can I fixe the USB Port number ?](#q7-can-i-fixe-the-usb-port-number-)
* [Q8. My device is not updated in DomoticZ when interacting via a remote control or manually](#q8-my-device-is-not-updated-in-domoticz-when-interacting-via-a-remote-control-or-manually)
* [Q9. Can I run Plugin Version 6 on a Windows system ?](#q9-can-i-run-plugin-version-6-on-a-windows-system)

## Troubleshooting

* [T1. My coordinator is not working](#t1-my-coordinator-is-not-working)
* [T2. My object can not be paired](#t2-my-object-can-not-be-paired)
* [T3. My object doesn't work as expected](#t3-my-object-doesnt-work-as-expected)

## Errors

* [E1. Log error : `No transport, write directive to XXX.XXX.XXX.XXX:8080' ignored`](#e1-log-error--no-transport-write-directive-to-xxxxxxxxxxxx8080-ignored)
* [E2. Log error : `Decode8000`](#e2-log-error--decode8000)
* [E3. Log error : `Error: (Zigate) Communication error when transmitting a previous command to XXXX ieee XXXXXXXXXXXXXXXX`](#e3-log-error--error-zigate-communication-error-when-transmitting-a-previous-command-to-xxxx-ieee-xxxxxxxxxxxxxxxx)
* [E4. Log Error : `Error: (FindModule) Domoticz/DomoticzEx modules not found in interpreter`](#e4-log-error--error-findmodule-domoticzdomoticzex-modules-not-found-in-interpreter)
* [E5. Missing module Error](#e5-missing-module-error)
* [E6. Error : `Error: <plugin's name> : You need to setup the URL Base to access the Domoticz JSON/API`](#e6-error--error-plugins-name--you-need-to-setup-the-url-base-to-access-the-domoticz-jsonapi)
* [E7. Error when updating python modules](#e7-error-when_updating-python-module)
* [E8. Error : `pkg_resources.VersionConflict: (dnspython 2.3.0 (/usr/local/lib/python3.10/site-packages), Requirement.parse('dnspython==2.2.1'))`](#e8-error--pkg_resourcesversionconflict-dnspython-230-usrlocallibpython310site-packages-requirementparsednspython221)
* [E9. Error : `ImportError: PyO3 modules may only be initialized once per interpreter process](#e9-error--ImportError-PyO3-modules-may-only-be-initialized-once-per-interpreter-process)
* [E10. Error : `[WebServer] Deprecated RType (devices) for API request. Handled via fallback (getdevices), please use correct API Command!`](#e10-error--webserver-deprecated-rtype-devices-for-api-request-handled-via-fallback-getdevices-please-use-correct-api-command)
* [E11. Error on installation under Debian 12 : `This environment is externally managed. To install Python packages system-wide, try apt install python3-xyz...`](#e11-error-on-installation-under-debian-12--this-environment-is-externally-managed-to-install-python-packages-system-wide-try-apt-install-python3-xyz)


------------
------------
## Q1. Where can I get support ?

The first source of support is the Wiki :

* [English Wiki](https://zigbeefordomoticz.github.io/wiki/en-eng)
* [French Wiki](https://zigbeefordomoticz.github.io/wiki/fr-fr)
* [Dutch Wiki](https://zigbeefordomoticz.github.io/wiki/nl-dut) ( _Unfortunately outdated. Please contact us if you are willing to contribute in the update of this wiki_)

You can also get support and ask questions :

* The [English Forum](https://www.domoticz.com/forum/viewforum.php?f=68)
* The [French Forum](https://easydomoticz.com/forum/viewforum.php?f=28)
* The [Keybase English channel](https://keybase.io/team/zigateforum)
* The [Keybase French channel](https://keybase.io/team/zigate)


------------
## Q2. Where are the logs ?

Since Stable6, the logs are saved in a file : `domoticz/plugins/Domoticz-Zigbee/Logs/PluginZigbee-XX.log`

The folder __Domoticz-Zigbee__ can also be __Domoticz-Zigate__ if you have installed the plugin  before April 2022.


------------
## Q3. Can I debug myself ?

Please refer to [Troubleshooting pairing or connection](Troubleshooting_Pairing.md)


------------
## Q4. Where can I find the list of supported Coordinators and Devices ?

Please refer to [Zigbee Device Compatibility Repository](https://zigbee.blakadder.com/z4d.html)


------------
## Q5. Where can I find the coordinator firmwares ?

* For __Texas Instrument__, we recommend to use the Z-Stack firmware from @Koenkk available [here](https://github.com/Koenkk/Z-Stack-firmware/tree/master/coordinator). We do not recommend to use _develop_ branch and rely on the _master_.
* For __ZiGate__, the firmwares are available [here for Zigate V1](https://github.com/fairecasoimeme/ZiGate/releases) or [here for ZiGate+ V2](https://github.com/fairecasoimeme/ZiGateV2/releases)
* For __EZNP (Silicon Labs)__, we recommend to follow the [zigpy recommendations](https://github.com/zigpy/zigpy/wiki/Coordinator-Firmware-Updates)


------------
## Q6. Can I use several coordinators in the same DomoticZ ?

We have currently a limitation of the number of instances using Zigpy layer, which prevent having several instances of zigpy based communication.

If you use ZiGate hardware, you can run as many plugin instances ( one instance per ZiGate ) as you wish.
If you use non-ZiGate hardware, like TI CCxxxx or Silicon Labs, you can run only one instance of those 2, but still can mix with as many ZiGate as you want. For more information you can see the progress of that issue on [#1117](https://github.com/zigbeefordomoticz/Domoticz-Zigbee/issues/1117)


------------
## Q7. Can I fixe the USB Port number ?

Some times, when you reboot your system, the USB Port (like _dev/ttyUSB0_) can change its number which cases a communication error with the coordinator. This is more an OS issue, but there are few hints :

* [Assign fixed device name to USB port](https://www.domoticz.com/wiki/Assign_fixed_device_name_to_USB_port)
* [Persistent USB Devices](https://www.domoticz.com/wiki/PersistentUSBDevices)


------------
## Q8. My device is not updated in DomoticZ when interacting via a remote control or manually

For example : If you power off an Ikea bulb (with the physical switch) and then switch it on again, the status of the bulb is not updated in DomoticZ. And having the same issue with a remote controller which also doesn't update it's current state to DomoticZ.

If you encounter problems like the above example, it is most likely the automatic reporting is not configured correctly from the device end. Please follow below steps to fix this issue:

1. Go to the settings page on the WebUI
1. Activate the advanced settings
1. Please check if the parameter __AllowRebindingClusters__.
1. Switch off the Ikea bulb with the physical switch, wait for 10 seconds, then turn it on again.
The rebinding process will start itself, the status problems should now be fixed.


------------
## Q9. Can I run Plugin Version 6 on a Windows system ?


------------
## T1. My coordinator is not working

I can see in the [log file](#q2.-where-are-the-logs) some messages like that

```log
2022-02-25 00:19:41,006 INFO    : [       MainThread] Zigate plugin beta6-6.0.114 started
2022-02-25 00:19:41,384 INFO    : [       MainThread] Plugin Database: DeviceList-2.txt
2022-02-25 00:19:41,466 INFO    : [       MainThread] DeviceConf loaded - 23 confs loaded
2022-02-25 00:19:43,858 INFO    : [       MainThread] DeviceConf loaded - 329 confs loaded
2022-02-25 00:19:43,875 INFO    : [       MainThread] load ListOfDevice
2022-02-25 00:19:43,955 INFO    : [       MainThread] Transport mode: ZigpyZNP
2022-02-25 00:20:45,074 ERROR   : [       MainThread] [ 61] I have hard time to get Coordinator Version. Mostlikly there is a communication issue
2022-02-25 00:20:45,084 ERROR   : [       MainThread] [   ] Stop the plugin and check the Coordinator connectivity.
```

This indicate a miss communication between the plugin and the coordinator. You need to cross-check the following pieces in the DomoticZ Hardware menu :

* If this is the first time you are using the Coordinator (no device paired yet), you have to initialize it, set the __Initialize Coordinator: True__ in the Domoticz Hardware menu when starting the plugin. Once the first startup is ok, then disable this parameter to prevent erasing all paired devices at the next restart.
* Ensure that the serial port is the right one.
* Ensure that the Coordinator Model matchs your dongle (in that case it must be Texas Instrument ZNP (via zigpy))
* Ensure that there is not an other process running on the port
* If the coordinator is connected on a PI, make sure that you use USB2 (and not the USB3 from the PI4)
* If you have connected the coordinator on an USB HUB, try to plug it directly to the server

If it still don't work, you can try to test the coordinator with [making Real time topology](HowTo_Have-a-real-time-topology.md). This test will be done without Domoticz and the plugin. It is only working with TI CCxxx.


------------
## T2. My object can not be paired

* If the coordinator is plugged directly into a USB port on the server, try deporting it using a USB extension cord (don't use an USB HUB). This will keep it away from interference, especially from SSD disks, wifi chips, etc...

Please refer to [Dealing with none certified device](https://zigbeefordomoticz.github.io/wiki/en-eng/Problem_Dealing-with-none-certified-device.html)


------------
## T3. My object doesn't work as expected

Please refer to [Dealing with none certified device](https://zigbeefordomoticz.github.io/wiki/en-eng/Problem_Dealing-with-none-certified-device.html)


------------
## E1. Log error : `No transport, write directive to XXX.XXX.XXX.XXX:8080' ignored`

Time to time I see the following error message. Is that a big issue ? How can I get rid of it ?

```log
Apr 02 13:30:23 pi domoticz[1328]: 2022-04-02 13:30:23.327  Error: ZigBee: No transport, write directive to 'XXX.XXX.XXX.XXX:8080' ignored.
```

This error is coming from DomoticZ and is related to the fact that you had the WebUI page opened and which timeout, at the time you tried to refresh this page, Domoticz detected that they were no transport/communication anymore.
You shouldn't worry much of this message.


------------
## E2. Log error : `Decode8000`

if you see error logs like here after, this is most-likely an issue with the ZiGate hardware.

```log
2022-02-22 18:03:11.851 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 22 Status: [ZigBee Error Code Unknown code : 80]
2022-02-22 18:06:23.656 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 4d Status: [ZigBee Error Code Unknown code : 80]
2022-02-22 18:06:30.282 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 51 Status: [ZigBee Error Code Unknown code : 80]
2022-02-22 18:06:30.499 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 52 Status: [ZigBee Error Code Unknown code : 80]
```

* Make sure that you don't have the old __blue__ USB-TTL module (it must be a red one )
* Try to power off the ZiGate by stopping the plugin, removing ZiGate, wait for 1 minute, plug-in back and restart the plugin

cc: [Issue reported on ZiGate](https://github.com/fairecasoimeme/ZiGate/issues/394)


------------
## E3. Log error : `Error: (Zigate) Communication error when transmitting a previous command to XXXX ieee XXXXXXXXXXXXXXXX`

Here after is an exemple of errors found in the log file.

```log
Apr 24 11:47:47 pi3 domoticz[23926]: 2019-04-24 11:47:47.697  Error: (Zigate) Communication error when transmiting a previous command to 9d58 ieee 90fd9ffffe31f150
Apr 24 11:47:47 pi3 domoticz[23926]: 2019-04-24 11:47:47.697  Error: (Zigate) Decode8702 - SQN: bc AddrMode: 02 DestAddr: 9d58 SrcEP: 01 DestEP: 01 Status: d4 - Unicast frame does not have a route available but it is buffered for automatic resend
```

This indicates that device ```90fd9ffffe31f150```is not reachable or - Zigate get a communication problem with it -


------------
## E4. Log Error : `Error: (FindModule) Domoticz/DomoticzEx modules not found in interpreter`

```log
2022-04-09 07:27:25.699 Error: (FindModule) Domoticz/DomoticzEx modules not found in interpreter.
```

This error appears when stopping the plugin. Ignore it.


------------
## E5. Missing module error

### Make sure that you have correctly installed the plugin

from the plugin home directory _Domoticz-Zigbee_ or _Domoticz-Zigate_ do the following command

``` bash
ls -l external/dnspython/

```

if the response is

```
total 0
```

you need to run

``` bash
git config --add submodule.recurse true
git submodule update --init --recursive

```

#### Make sure that all dependencies have been installed

``` bash
sudo pip3 install -r requirements.txt
```

ATTENTION:

* On windows system, it is a must that the pip3 install command is run from a CMD Administrator window, and it must be the first time. If you have run once already without Administrator windows, you must start removing all already installed modules.


------------
## E6. Error : `Error: <plugin's name> : You need to setup the URL Base to access the Domoticz JSON/API`

This error appears when the DomoticZ parameter _API base url_ is not correctly filled. More infos on [step 2 Plugin settings](Plugin_Settings.md).

## E7. Error when updating python module: `Building wheel for cryptography (PEP 517) ... error`

When doing the command `pip3 install -r requirements.txt` or `python3 -m pip install -r requirements.txt --upgrade` you get this error.

```log
ERROR: Failed building wheel for cryptography
Failed to build cryptography
ERROR: Could not build wheels for cryptography which use PEP 517 and cannot be installed directly
```

1. upgrade or install the python module wheel

    ```bash
    sudo python3 -m pip install wheel --upgrade
    ````

1. make sure your /tmp is large enough
1. make sure you have enough swap, if requires , add some filesystem swap


------------
## E8. Error : `pkg_resources.VersionConflict: (dnspython 2.3.0 (/usr/local/lib/python3.10/site-packages), Requirement.parse('dnspython==2.2.1'))`

This error may appear when you change branch from develop to stable6 : the dnspython module level is not the same.

* Do the following command from the plugin home directory
``` bash
sudo python3 -m pip install -r requirements.txt --upgrade
```

------------
## E9. Error : `ImportError: PyO3 modules may only be initialized once per interpreter process`

```
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.286  Status: Zigpy-Elelabs: Transport mode: ZigpyEZSP
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.632  Error: Zigpy-Elelabs: Call to function 'onStart' failed, exception details:
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.646  Error: Zigpy-Elelabs: Traceback (most recent call last):
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.646  Error: Zigpy-Elelabs:   File "/var/lib/domoticz/plugins/Domoticz-Zigbee/plugin.py", line 1537, in onStart
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.646  Error: Zigpy-Elelabs:     _plugin.onStart()
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.646  Error: Zigpy-Elelabs:   File "/var/lib/domoticz/plugins/Domoticz-Zigbee/plugin.py", line 602, in onStart
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.646  Error: Zigpy-Elelabs:     from zigpy.config import (CONF_DEVICE, CONF_DEVICE_PATH,
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.646  Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/zigpy/config/init.py", line 32, in <module>
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.646  Error: Zigpy-Elelabs:     from zigpy.config.validators import (
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.646  Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/zigpy/config/validators.py", line 9, in <module>
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.646  Error: Zigpy-Elelabs:     import zigpy.zdo.types as zdo_t
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.647  Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/zigpy/zdo/init.py", line 10, in <module>
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.647  Error: Zigpy-Elelabs:     import zigpy.util
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.647  Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/zigpy/util.py", line 14, in <module>
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.647  Error: Zigpy-Elelabs:     from cryptography.hazmat.primitives.ciphers import Cipher
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.647  Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/cryptography/hazmat/primitives/ciphers/init.py", line 11, in <module>
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.647  Error: Zigpy-Elelabs:     from cryptography.hazmat.primitives.ciphers.base import (
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.647  Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/cryptography/hazmat/primitives/ciphers/base.py", line 10, in <module>
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.647  Error: Zigpy-Elelabs:     from cryptography.exceptions import (
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.647  Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/cryptography/exceptions.py", line 9, in <module>
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.647  Error: Zigpy-Elelabs:     from cryptography.hazmat.bindings.rust import exceptions as rustexceptions
Jun 02 16:35:43 rasp domoticz[21346]: 2023-06-02 16:35:43.647  Error: Zigpy-Elelabs: ImportError: PyO3 modules may only be initialized once per interpreter process
```

This is related to the fact that you are using a recent cryptography module.
you can solve this issue by downgrading the cryptography module 

`sudo python3 pip install cryptography==40.0.2 --upgrade`


------------
## E10. Error : `[WebServer] Deprecated RType (devices) for API request. Handled via fallback (getdevices), please use correct API Command!`

This error comes with the API modification of DomoticZ 2023.2

You need to update to the plugin version 7 following the [instructions](../Release_7.1.md).


------------
## E11. Error on installation under Debian 12 : `This environment is externally managed. To install Python packages system-wide, try apt install python3-xyz...` 

The full error is :

```
× This environment is externally managed
╰─> To install Python packages system-wide, try apt install python3-xyz, where xyz is the package you are trying to install.

If you wish to install a non-Debian-packaged Python package, create a virtual environment using python3 -m venv path/to/venv.
Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make sure you have python3-full installed.
```


Operation under Debian 12 Bookworm needs to modify the installation command line by default by adding __--break-system-packages__ at the end :

``` bash
sudo pip3 install -r requirements.txt --break-system-packages
```
__Reminder :__ This command line is only valid on Debian 12 Bookworm systems.