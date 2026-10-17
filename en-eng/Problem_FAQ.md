# Frequently Asked Questions

* [Q1. Where can I get support ?](#q1-where-can-i-get-support-)
* [Q2. Where are the logs ?](#q2-where-are-the-logs-)
* [Q3. Can I debug myself ?](#q3-can-i-debug-myself-)
* [Q4. Where can I find the list of supported Coordinators and Devices ?](#q4-where-can-i-find-the-list-of-supported-coordinators-and-devices-)
* [Q5. Where can I find the coordinator firmwares ?](#q5-where-can-i-find-the-coordinator-firmwares-)
* [Q6. Can I use several coordinators in the same DomoticZ ?](#q6-can-i-use-several-coordinators-in-the-same-domoticz-)
* [Q7. Can I fix the USB Port number ?](#q7-can-i-fix-the-usb-port-number-)
* [Q8. My device is not updated in DomoticZ when interacting via a remote control or manually](#q8-my-device-is-not-updated-in-domoticz-when-interacting-via-a-remote-control-or-manually)
* [Q9. The plugin menu's link is not showed in DomoticZ](#q9-the-plugin-menus-link-is-not-showed-in-domoticz)

## Troubleshooting

* [T1. My coordinator is not working](#t1-my-coordinator-is-not-working)
* [T2. My object can not be paired](#t2-my-object-can-not-be-paired)
* [T3. My object doesn't work as expected](#t3-my-object-doesnt-work-as-expected)

## Errors

* [E1. Log error : `No transport, write directive to XXX.XXX.XXX.XXX:8080' ignored`](#e1-log-error--no-transport-write-directive-to-xxxxxxxxxxxx8080-ignored)
* [E2. Log error : `Decode8000` (ZiGate)](#e2-log-error--decode8000-zigate)
* [E3. Log error : `Error: <plugin's name> Communication error when transmitting a previous command to XXXX ieee XXXXXXXXXXXXXXXX`](#e3-log-error--error-plugins-name-communication-error-when-transmitting-a-previous-command-to-xxxx-ieee-xxxxxxxxxxxxxxxx)
* [E4. Log Error : `Error: (FindModule) Domoticz/DomoticzEx modules not found in interpreter`](#e4-log-error--error-findmodule-domoticzdomoticzex-modules-not-found-in-interpreter)
* [E5. Missing module error](#e5-missing-module-error)
* [E6. Error : `Error: <plugin's name> : You need to setup the URL Base to access the Domoticz JSON/API`](#e6-error--error-plugins-name--you-need-to-setup-the-url-base-to-access-the-domoticz-jsonapi)
* [E7. Error when updating python modules: `Building wheel for cryptography (PEP 517) ... error`](#e7-error-when-updating-python-module-building-wheel-for-cryptography-pep-517--error)
* [E9. Error : `ImportError: PyO3 modules may only be initialized once per interpreter process`](#e9-error--importerror-pyo3-modules-may-only-be-initialized-once-per-interpreter-process)
* [E11. Error on installation under Debian 12 or newer : `This environment is externally managed...`](#e11-error-on-installation-under-debian-12-or-newer--this-environment-is-externally-managed)
* [E12. Error : `Error: <plugin's name> : ModuleNotFoundError: No module named 'cchardet'`](#e12-error--error-plugins-name--modulenotfounderror-no-module-named-cchardet)
* [E13. Error : `AttributeError: module 'lib' has no attribute 'OpenSSL_add_all_algorithms'`](#e13-error--attributeerror-module-lib-has-no-attribute-openssl_add_all_algorithms)
* [E14. AttributeError: module 'lib' has no attribute 'X509_V_FLAG_CB_ISSUER_CHECK'](#e14-attributeerror-module-lib-has-no-attribute-x509_v_flag_cb_issuer_check)
* [E15. error: externally-managed-environment](#e15-error-externally-managed-environment)
* [E16. Error : `Cannot run the event loop while another loop is running` with several plugin instances](#e16-error--cannot-run-the-event-loop-while-another-loop-is-running-with-several-plugin-instances)
* [E17. `ModuleNotFoundError` although the modules are installed](#e17-modulenotfounderror-although-the-modules-are-installed)
* [E18. Error : `Z4D requires Python 3.11` or `Domoticz version ... not supported`](#e18-error--z4d-requires-python-311-or-domoticz-version--not-supported)

------------
------------

## Q1. Where can I get support ?

The first source of support is this [Wiki](https://zigbeefordomoticz.github.io/wiki/en-eng).

You can also get support and ask questions :

* The [English Forum](https://www.domoticz.com/forum/viewforum.php?f=68)
* The [French Forum](https://easydomoticz.com/forum/viewforum.php?f=28)
* The [GitHub issues](https://github.com/zigbeefordomoticz/Domoticz-Zigbee/issues) of the plugin, to report a bug
* The [discussions of z4d-certified-devices](https://github.com/zigbeefordomoticz/z4d-certified-devices/discussions), for device configuration files

------------

## Q2. Where are the logs ?

By default, the plugin writes its logs in its own file: `domoticz/plugins/Domoticz-Zigbee/Logs/PluginZigbee_XX.log`, where XX is the hardware idx of the plugin in DomoticZ (for example `PluginZigbee_05.log`). A new file is started every night, and the last 7 are kept.

Errors, warnings and status messages also go to the DomoticZ log; debug messages only go to the plugin log file. See [Debug mode](Problem_Debuging-mode.md#where-are-the-plugin-logs) for the details and the related settings.

------------

## Q3. Can I debug myself ?

Yes: see [Debug mode](Problem_Debuging-mode.md) to enable the debug messages of the part of the plugin you are interested in, for one device or for all. For pairing and connection difficulties, see also [Troubleshooting pairing or connection](Troubleshooting_Pairing.md).

------------

## Q4. Where can I find the list of supported Coordinators and Devices ?

* Coordinators: [Compatible coordinators](Coordinators.md)
* Devices: [Compatible objects](Objects.md), and the [Zigbee Device Compatibility Repository](https://zigbee.blakadder.com/z4d.html)

------------

## Q5. Where can I find the coordinator firmwares ?

* For __Texas Instrument__, we recommend to use the Z-Stack firmware from @Koenkk available [here](https://github.com/Koenkk/Z-Stack-firmware/tree/master/coordinator). We do not recommend to use _develop_ branch and rely on the _master_.
* For __ZiGate__, the firmwares are available [here for Zigate V1](https://github.com/fairecasoimeme/ZiGate/releases) or [here for ZiGate+ V2](https://github.com/fairecasoimeme/ZiGateV2/releases)
* For __EZNP (Silicon Labs)__, we recommend to follow the [zigpy recommendations](https://github.com/zigpy/zigpy/wiki/Coordinator-Firmware-Updates)

------------

## Q6. Can I use several coordinators in the same DomoticZ ?

Yes: add one instance of the plugin (one DomoticZ hardware) per coordinator. Each instance has its own Zigbee network, its own WebUI port and its own files.

There is one known problem: with DomoticZ 2026.x and **Python 3.11** (for example Debian 12 / Raspberry Pi OS Bookworm), the second instance fails to start with `Cannot run the event loop while another loop is running`. Use Python 3.13 or newer: see [E16](#e16-error--cannot-run-the-event-loop-while-another-loop-is-running-with-several-plugin-instances).

------------

## Q7. Can I fix the USB Port number ?

Some times, when you reboot your system, the USB Port (like _dev/ttyUSB0_) can change its number which cases a communication error with the coordinator. This is more an OS issue, but there are few hints :

* [Assign fixed device name to USB port](https://www.domoticz.com/wiki/Assign_fixed_device_name_to_USB_port)
* [Persistent USB Devices](https://www.domoticz.com/wiki/PersistentUSBDevices)
* The simplest is to use the `/dev/serial/by-id/...` path of the coordinator as __Serial Port__ in the plugin settings: it doesn't change between reboots.

------------

## Q8. My device is not updated in DomoticZ when interacting via a remote control or manually

For example : If you power off an Ikea bulb (with the physical switch) and then switch it on again, the status of the bulb is not updated in DomoticZ. And having the same issue with a remote controller which also doesn't update it's current state to DomoticZ.

If you encounter problems like the above example, it is most likely the automatic reporting is not configured correctly from the device end. Please follow below steps to fix this issue:

1. Go to the Settings page of the WebUI.
1. Activate the advanced settings.
1. Check that the parameter __allowReBindingClusters__ is enabled (it is by default).
1. Switch off the bulb with the physical switch, wait for 10 seconds, then turn it on again.
The rebinding process starts by itself, and the status problems should be fixed.

Some brands (Philips, Gledopto) don't report their status at all: the plugin polls them, see [Philips Gledopto](Corner_Philips-Gledopto.md). Ikea remote controls must have the coordinator in their group, see [Ikea Tradfri](Corner_Ikea-Tradfri.md#remote-controls-and-motion-sensor-how-the-events-reach-domoticz).

------------

## Q9. The plugin menu's link is not showed in DomoticZ

The plugin adds its entry to the DomoticZ __Custom__ menu itself when it starts (setting __Enable Plugin WebUI from Domoticz Custom menu__, enabled by default). If you don't see it:

* Check that the Custom Tab is activated: in DomoticZ, go to __Setup > Users__ and check that the Custom Tab is activated for each user needed.
* Check that the setting is enabled in the WebUI Settings page.

See [Plugin integration](Plugin_Integration.md) for the details, including the cases where the automatic entry doesn't work (DomoticZ over https, reverse proxy).

------------

## T1. My coordinator is not working

I can see in the [log file](#q2-where-are-the-logs-) some messages like that

```log
Error: Zigbee: [ 70] Hard time getting Coordinator Version — likely a communication issue
```

or, after the plugin had started:

```log
Error: Zigbee: Connection to coordinator lost, OSError (device disconnected or in use by another process), plugin restart might be required
```

This indicates a communication problem between the plugin and the coordinator. If the coordinator still doesn't answer after a while, the plugin restarts itself and tries again. Cross-check the following in the DomoticZ Hardware settings of the plugin (see [Plugin settings](Plugin_Settings.md)):

* If this is the first time you are using the Coordinator (no device paired yet), you have to initialize it: set __Initialize Coordinator: True__ when starting the plugin. Once the first startup is ok, set it back to False, otherwise all paired devices are erased at the next restart.
* Ensure that the serial port is the right one (prefer the `/dev/serial/by-id/...` path).
* Ensure that the __Coordinator Model__ matches your dongle (Texas Instruments ZNP, Silicon Labs EZSP, ConBee/RaspBee or Bouffalo Lab).
* Ensure that no other process is using the port (another home automation software, a second plugin instance, ModemManager...).
* If you have connected the coordinator on a USB hub, try to plug it directly into the server, ideally with a USB extension cable.

If it still doesn't work, test the coordinator without DomoticZ and the plugin, with the `zigpy` command line tool installed with the plugin. Stop the plugin, activate the Python virtual environment of DomoticZ, then run an energy scan, for example for a Texas Instruments coordinator on `/dev/ttyUSB0`:

```bash
zigpy radio znp /dev/ttyUSB0 energy-scan
```

Use `ezsp` for Silicon Labs and `deconz` for ConBee/RaspBee. If this doesn't work either, the problem is between the system and the dongle (port, rights, firmware). See also [Real-time interference scan](HowTo_Real-time-interference-scan.md).

------------

## T2. My object can not be paired

* If the coordinator is plugged directly into a USB port on the server, try moving it away with a USB extension cable (don't use a USB HUB). This keeps it away from interference, especially from SSD disks, wifi chips, etc...
* See [Troubleshooting pairing or connection](Troubleshooting_Pairing.md) and [Add a new device](HowTo_Pairing-device.md).

------------

## T3. My object doesn't work as expected

Please refer to [Dealing with not-optimized devices](Problem_Dealing-with-none-optimized-device.md) and, to write a configuration file for it, [device customization](HowTo_Device-Customization.md).

------------

## E1. Log error : `No transport, write directive to XXX.XXX.XXX.XXX:8080' ignored`

Time to time I see the following error message. Is that a big issue ? How can I get rid of it ?

```log
Error: ZigBee: No transport, write directive to 'XXX.XXX.XXX.XXX:8080' ignored.
```

This error is coming from DomoticZ and is related to the fact that you had the WebUI page opened and which timeout, at the time you tried to refresh this page, Domoticz detected that they were no transport/communication anymore.
You shouldn't worry much of this message.

------------

## E2. Log error : `Decode8000` (ZiGate)

This only applies to ZiGate coordinators, which are no longer supported. If you see error logs like here after, this is most-likely an issue with the ZiGate hardware.

```log
Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 22 Status: [ZigBee Error Code Unknown code : 80]
Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 4d Status: [ZigBee Error Code Unknown code : 80]
Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 51 Status: [ZigBee Error Code Unknown code : 80]
Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 52 Status: [ZigBee Error Code Unknown code : 80]
```

* Make sure that you don't have the old __blue__ USB-TTL module (it must be a red one )
* Try to power off the ZiGate by stopping the plugin, removing ZiGate, wait for 1 minute, plug-in back and restart the plugin

cc: [Issue reported on ZiGate](https://github.com/fairecasoimeme/ZiGate/issues/394)

------------

## E3. Log error : `Error: <plugin's name> Communication error when transmitting a previous command to XXXX ieee XXXXXXXXXXXXXXXX`

Here after is an exemple of errors found in the log file.

```log
Error: (Zigbee) Communication error when transmiting a previous command to 9d58 ieee 90fd9ffffe31f150
Error: (Zigbee) Decode8702 - SQN: bc AddrMode: 02 DestAddr: 9d58 SrcEP: 01 DestEP: 01 Status: d4 - Unicast frame does not have a route available but it is buffered for automatic resend
```

This indicates that the device `90fd9ffffe31f150` is not reachable, or that the coordinator has a communication problem with it.

------------

## E4. Log Error : `Error: (FindModule) Domoticz/DomoticzEx modules not found in interpreter`

```log
Error: (FindModule) Domoticz/DomoticzEx modules not found in interpreter.
```

This error appears when stopping the plugin. Ignore it.

------------

## E5. Missing module error

A `ModuleNotFoundError` or `No module named ...` error at startup means that the Python modules of the plugin are not installed in the Python environment DomoticZ uses.

Install them in the Python virtual environment of DomoticZ, from the plugin folder (see [Plugin installation](Plugin_Installation.md#1c---procedure)):

``` bash
source /home/pi/Domoticz_Python_Environment/bin/activate
cd /home/pi/domoticz/plugins/Domoticz-Zigbee
python3 -m pip install -r requirements.txt --upgrade
```

If the modules are installed but still not found, see [E17](#e17-modulenotfounderror-although-the-modules-are-installed).

------------

## E6. Error : `Error: <plugin's name> : You need to setup the URL Base to access the Domoticz JSON/API`

This error appears when the DomoticZ parameter _API base url_ is not correctly filled. More infos on [step 2 Plugin settings](Plugin_Settings.md).

------------

## E7. Error when updating python module: `Building wheel for cryptography (PEP 517) ... error`

When doing the command `pip3 install -r requirements.txt` or `python3 -m pip install -r requirements.txt --upgrade` you get this error.

```log
ERROR: Failed building wheel for cryptography
Failed to build cryptography
ERROR: Could not build wheels for cryptography which use PEP 517 and cannot be installed directly
```

1. upgrade or install the python module wheel, in the Python virtual environment of DomoticZ

    ```bash
    python3 -m pip install wheel --upgrade
    ```

1. make sure your /tmp is large enough
1. make sure you have enough swap, if requires , add some filesystem swap

------------

## E9. Error : `ImportError: PyO3 modules may only be initialized once per interpreter process`

``` log
Status: Zigpy-Elelabs: Transport mode: ZigpyEZSP
Error: Zigpy-Elelabs: Call to function 'onStart' failed, exception details:
Error: Zigpy-Elelabs: Traceback (most recent call last):
Error: Zigpy-Elelabs:   File "/var/lib/domoticz/plugins/Domoticz-Zigbee/plugin.py", line 1537, in onStart
Error: Zigpy-Elelabs:     _plugin.onStart()
Error: Zigpy-Elelabs:   File "/var/lib/domoticz/plugins/Domoticz-Zigbee/plugin.py", line 602, in onStart
Error: Zigpy-Elelabs:     from zigpy.config import (CONF_DEVICE, CONF_DEVICE_PATH,
Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/zigpy/config/init.py", line 32, in <module>
Error: Zigpy-Elelabs:     from zigpy.config.validators import (
Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/zigpy/config/validators.py", line 9, in <module>
Error: Zigpy-Elelabs:     import zigpy.zdo.types as zdo_t
Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/zigpy/zdo/init.py", line 10, in <module>
Error: Zigpy-Elelabs:     import zigpy.util
Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/zigpy/util.py", line 14, in <module>
Error: Zigpy-Elelabs:     from cryptography.hazmat.primitives.ciphers import Cipher
Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/cryptography/hazmat/primitives/ciphers/init.py", line 11, in <module>
Error: Zigpy-Elelabs:     from cryptography.hazmat.primitives.ciphers.base import (
Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/cryptography/hazmat/primitives/ciphers/base.py", line 10, in <module>
Error: Zigpy-Elelabs:     from cryptography.exceptions import (
Error: Zigpy-Elelabs:   File "/usr/local/lib/python3.10/site-packages/cryptography/exceptions.py", line 9, in <module>
Error: Zigpy-Elelabs:     from cryptography.hazmat.bindings.rust import exceptions as rustexceptions
Error: Zigpy-Elelabs: ImportError: PyO3 modules may only be initialized once per interpreter process
```

This is related to a cryptography module more recent than the plugin supports. The plugin pins the versions it needs in `constraints.txt` (`cryptography<=40.0.2`), which `requirements.txt` applies. Reinstall the modules in the Python virtual environment of DomoticZ, from the plugin folder:

``` bash
python3 -m pip install -r requirements.txt --upgrade
```

If the error persists, a more recent cryptography is probably installed system wide and found first: use a Python virtual environment, see [Using Python Virtual Environment](HowTo_PythonVirtualEnv.md).

------------

## E11. Error on installation under Debian 12 or newer : `This environment is externally managed...`

The full error is :

```log
× This environment is externally managed
╰─> To install Python packages system-wide, try apt install python3-xyz, where xyz is the package you are trying to install.

If you wish to install a non-Debian-packaged Python package, create a virtual environment using python3 -m venv path/to/venv.
Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make sure you have python3-full installed.
```

Debian 12 (Bookworm) and newer, and the matching Raspberry Pi OS releases, refuse `pip install` on the system Python. Don't use `--break-system-packages`: install the modules in a Python virtual environment for DomoticZ, as described in [Using Python Virtual Environment](HowTo_PythonVirtualEnv.md) and [Plugin installation](Plugin_Installation.md#1c---procedure).

------------

## E12. Error : `Error: <plugin's name> : ModuleNotFoundError: No module named 'cchardet'`

This error appears when you have several plugin instances and the charset-normalizer module is not the version the plugin expects. The plugin pins it in `constraints.txt` (currently `charset-normalizer==2.0.11`).

Check your version, in the Python virtual environment of DomoticZ:

``` bash
python3 -m pip show charset-normalizer
```

If it is not the pinned version, reinstall the modules of the plugin, from the plugin folder (`requirements.txt` applies `constraints.txt`):

``` bash
python3 -m pip install -r requirements.txt --upgrade
```

------------

## E13. Error : `AttributeError: module 'lib' has no attribute 'OpenSSL_add_all_algorithms'`

```log
2024-04-16 18:31:06.519 Error: zig: (Zigbee) failed to load 'plugin.py', Python Path used was '/home/ben/domoticz/plugins/Domoticz-Zigbee/:/usr/lib/python310.zip:/usr/lib/python3.10:/usr/lib/python3.10/lib-dynload:/usr/local/lib/python3.10/dist-packages:/usr/lib/python3/dist-packages:/usr/lib/python3.10/dist-packages'.
2024-04-16 18:31:06.523 Error: zig: Traceback (most recent call last):
2024-04-16 18:31:06.523 Error: zig: File "/home/ben/domoticz/plugins/Domoticz-Zigbee/plugin.py", line 122, in <module>
2024-04-16 18:31:06.523 Error: zig: from Modules.checkingUpdate import (checkFirmwareUpdate, checkPluginUpdate,
2024-04-16 18:31:06.523 Error: zig: File "/home/ben/domoticz/plugins/Domoticz-Zigbee/Modules/checkingUpdate.py", line 14, in <module>
2024-04-16 18:31:06.523 Error: zig: import dns.resolver
2024-04-16 18:31:06.523 Error: zig: File "/usr/local/lib/python3.10/dist-packages/dns/resolver.py", line 39, in <module>
2024-04-16 18:31:06.523 Error: zig: import dns.query
2024-04-16 18:31:06.523 Error: zig: File "/usr/local/lib/python3.10/dist-packages/dns/query.py", line 48, in <module>
2024-04-16 18:31:06.523 Error: zig: from requests_toolbelt.adapters.source import SourceAddressAdapter
2024-04-16 18:31:06.523 Error: zig: File "/usr/lib/python3/dist-packages/requests_toolbelt/init.py", line 12, in <module>
2024-04-16 18:31:06.523 Error: zig: from .adapters import SSLAdapter, SourceAddressAdapter
2024-04-16 18:31:06.523 Error: zig: File "/usr/lib/python3/dist-packages/requests_toolbelt/adapters/init.py", line 12, in <module>
2024-04-16 18:31:06.523 Error: zig: from .ssl import SSLAdapter
2024-04-16 18:31:06.523 Error: zig: File "/usr/lib/python3/dist-packages/requests_toolbelt/adapters/ssl.py", line 16, in <module>
2024-04-16 18:31:06.523 Error: zig: from .._compat import poolmanager
2024-04-16 18:31:06.523 Error: zig: File "/usr/lib/python3/dist-packages/requests_toolbelt/_compat.py", line 56, in <module>
2024-04-16 18:31:06.523 Error: zig: from requests.packages.urllib3.contrib.pyopenssl \
2024-04-16 18:31:06.523 Error: zig: File "/usr/lib/python3/dist-packages/urllib3/contrib/pyopenssl.py", line 50, in <module>
2024-04-16 18:31:06.523 Error: zig: import OpenSSL.SSL
2024-04-16 18:31:06.523 Error: zig: File "/usr/lib/python3/dist-packages/OpenSSL/init.py", line 8, in <module>
2024-04-16 18:31:06.523 Error: zig: from OpenSSL import crypto, SSL
2024-04-16 18:31:06.523 Error: zig: File "/usr/lib/python3/dist-packages/OpenSSL/crypto.py", line 3279, in <module>
2024-04-16 18:31:06.523 Error: zig: lib.OpenSSLadd_all_algorithms()
2024-04-16 18:31:06.523 Error: zig: AttributeError: module 'lib' has no attribute 'OpenSSL_add_all_algorithms'
2024-04-16 18:32:14.294 Error: zig hardware (35) thread seems to have ended unexpectedly
```

The root cause is a conflict between the pyOpenSSL of the system (`/usr/lib/python3/dist-packages/OpenSSL`) and the cryptography module installed for the plugin [ref](https://aronhack.com/fix-python-attributeerror-module-lib-has-no-attribute-openssl_add_all_algorithms/).

Use a Python virtual environment for DomoticZ, so that the plugin doesn't load the system modules, and install the modules of the plugin in it (`requirements.txt` applies the `cryptography<=40.0.2` pin of `constraints.txt`): see [Using Python Virtual Environment](HowTo_PythonVirtualEnv.md).

------------

## E14. AttributeError: module 'lib' has no attribute 'X509_V_FLAG_CB_ISSUER_CHECK

```log
 2024-04-24 12:29:41.998 Error: Zigbee: (Zigbee) failed to load 'plugin.py', Python Path used was '/home/pi/domoticz/plugins/Domoticz-Zigbee/:/usr/lib/python39.zip:/usr/lib/python3.9:/usr/lib/python3.9/lib-dynload:/usr/local/lib/python3.9/dist-packages:/usr/lib/python3/dist-packages:/usr/lib/python3.9/dist-packages'.
2024-04-24 12:29:42.005 Error: Zigbee: Traceback (most recent call last):
2024-04-24 12:29:42.005 Error: Zigbee: File "/home/pi/domoticz/plugins/Domoticz-Zigbee/plugin.py", line 131, in <module>
2024-04-24 12:29:42.005 Error: Zigbee: from Modules.checkingUpdate import (checkFirmwareUpdate, checkPluginUpdate,
2024-04-24 12:29:42.005 Error: Zigbee: File "/home/pi/domoticz/plugins/Domoticz-Zigbee/Modules/checkingUpdate.py", line 14, in <module>
2024-04-24 12:29:42.005 Error: Zigbee: import dns.resolver
2024-04-24 12:29:42.005 Error: Zigbee: File "/usr/local/lib/python3.9/dist-packages/dns/resolver.py", line 39, in <module>
2024-04-24 12:29:42.005 Error: Zigbee: import dns.query
2024-04-24 12:29:42.005 Error: Zigbee: File "/usr/local/lib/python3.9/dist-packages/dns/query.py", line 48, in <module>
2024-04-24 12:29:42.005 Error: Zigbee: from requests_toolbelt.adapters.source import SourceAddressAdapter
2024-04-24 12:29:42.005 Error: Zigbee: File "/usr/lib/python3/dist-packages/requests_toolbelt/init.py", line 12, in <module>
2024-04-24 12:29:42.005 Error: Zigbee: from .adapters import SSLAdapter, SourceAddressAdapter
2024-04-24 12:29:42.005 Error: Zigbee: File "/usr/lib/python3/dist-packages/requests_toolbelt/adapters/init.py", line 12, in <module>
2024-04-24 12:29:42.005 Error: Zigbee: from .ssl import SSLAdapter
2024-04-24 12:29:42.005 Error: Zigbee: File "/usr/lib/python3/dist-packages/requests_toolbelt/adapters/ssl.py", line 16, in <module>
2024-04-24 12:29:42.005 Error: Zigbee: from .._compat import poolmanager
2024-04-24 12:29:42.005 Error: Zigbee: File "/usr/lib/python3/dist-packages/requests_toolbelt/_compat.py", line 56, in <module>
2024-04-24 12:29:42.005 Error: Zigbee: from requests.packages.urllib3.contrib.pyopenssl \
2024-04-24 12:29:42.005 Error: Zigbee: File "/usr/lib/python3/dist-packages/urllib3/contrib/pyopenssl.py", line 50, in <module>
2024-04-24 12:29:42.005 Error: Zigbee: import OpenSSL.SSL
2024-04-24 12:29:42.005 Error: Zigbee: File "/usr/lib/python3/dist-packages/OpenSSL/init.py", line 8, in <module>
2024-04-24 12:29:42.005 Error: Zigbee: from OpenSSL import crypto, SSL
2024-04-24 12:29:42.005 Error: Zigbee: File "/usr/lib/python3/dist-packages/OpenSSL/crypto.py", line 1556, in <module>
2024-04-24 12:29:42.005 Error: Zigbee: class X509StoreFlags(object):
2024-04-24 12:29:42.005 Error: Zigbee: File "/usr/lib/python3/dist-packages/OpenSSL/crypto.py", line 1577, in X509StoreFlags
2024-04-24 12:29:42.005 Error: Zigbee: CB_ISSUER_CHECK = lib.X509V_FLAG_CB_ISSUER_CHECK
2024-04-24 12:29:42.005 Error: Zigbee: AttributeError: module 'lib' has no attribute 'X509_V_FLAG_CB_ISSUER_CHECK'
```

It is the same kind of conflict as [E13](#e13-error--attributeerror-module-lib-has-no-attribute-openssl_add_all_algorithms), between the pyOpenSSL of the system and the modules installed for the plugin. The best fix is a Python virtual environment for DomoticZ (see [Using Python Virtual Environment](HowTo_PythonVirtualEnv.md)). Removing the system package also works, if no other software needs it:

```bash
sudo apt remove -y python3-openssl
```

------------

## E15. error: externally-managed-environment

```log
error: externally-managed-environment

× This environment is externally managed
╰─> To install Python packages system-wide, try apt install
    python3-xyz, where xyz is the package you are trying to
    install.

    If you wish to install a non-Debian-packaged Python package,
    create a virtual environment using python3 -m venv path/to/venv.
    Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make
    sure you have python3-full installed.

    For more information visit http://rptl.io/venv

note: If you believe this is a mistake, please contact your Python installation or OS distribution provider. You can override this, at the risk of breaking your Python installation or OS, by passing --break-system-packages.
hint: See PEP 668 for the detailed specification.
```

The best is to use the Python virtual environment as described in [Using Python Virtual Environment](HowTo_PythonVirtualEnv.md)

------------

## E16. Error : `Cannot run the event loop while another loop is running` with several plugin instances

```log
encountered a runtime error: Cannot run the event loop while another loop is running
```

With DomoticZ 2026.x and **Python 3.11** (for example Debian 12 / Raspberry Pi OS Bookworm), the second instance of the plugin fails to start with this error. It is a Python 3.11 problem, reported to DomoticZ in [domoticz/domoticz#6763](https://github.com/domoticz/domoticz/issues/6763). Restarting the failed instance (or waiting for it to restart by itself) usually gets both instances running.

The fix is to run DomoticZ with Python 3.13 or newer (for example Debian 13 Trixie), with the Python modules of the plugin installed for that version.

------------

## E17. `ModuleNotFoundError` although the modules are installed

The modules were installed for another Python than the one DomoticZ uses: another Python version, or the system Python instead of the virtual environment.

1. Look for the Python version used by DomoticZ in the DomoticZ log: `PluginSystem: Started, Python version '3.13.5'`.
1. Check that your virtual environment was created with the same version (`<venv>/bin/python3 --version`). If not, create it again with `python3.xx -m venv` and reinstall the modules.
1. Check that DomoticZ is started with this virtual environment (`VIRTUAL_ENV` and `PATH` in the service).

See [Using Python Virtual Environment](HowTo_PythonVirtualEnv.md).

------------

## E18. Error : `Z4D requires Python 3.11` or `Domoticz version ... not supported`

The plugin (`stable9`) requires Python 3.11 or newer and DomoticZ 2025.1 or newer, with the Extended Framework. **DomoticZ 2026.3 is the recommended version.**

* `Z4D requires Python 3.11, found 3.x`: DomoticZ runs an older Python. Upgrade your system, or install a newer Python and make DomoticZ use it.
* `Domoticz version ... not supported, please upgrade to a more recent`: upgrade DomoticZ (check your version in __Setup > About__).

See [Plugin installation](Plugin_Installation.md#requirements).
