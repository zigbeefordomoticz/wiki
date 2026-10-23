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
* [Q10. How do I change the Zigbee channel ?](#q10-how-do-i-change-the-zigbee-channel-)
* [Q11. Can I use the DomoticZ *Replace* button to keep the history of a dead device ?](#q11-can-i-use-the-domoticz-replace-button-to-keep-the-history-of-a-dead-device-)
* [Q12. My ZiGate is no longer supported: what should I replace it with ?](#q12-my-zigate-is-no-longer-supported-what-should-i-replace-it-with-)
* [Q13. How do I uninstall the plugin ?](#q13-how-do-i-uninstall-the-plugin-)

## Troubleshooting

* [T1. My coordinator is not working](#t1-my-coordinator-is-not-working)
* [T2. My object can not be paired](#t2-my-object-can-not-be-paired)
* [T3. My object doesn't work as expected](#t3-my-object-doesnt-work-as-expected)
* [T4. The update from the WebUI says it succeeded, but the plugin version didn't change](#t4-the-update-from-the-webui-says-it-succeeded-but-the-plugin-version-didnt-change)
* [T5. My battery devices lose the connection, and raising the transmit power doesn't help](#t5-my-battery-devices-lose-the-connection-and-raising-the-transmit-power-doesnt-help)
* [T6. The WebUI shows `Unknown error` right after a plugin restart](#t6-the-webui-shows-unknown-error-right-after-a-plugin-restart)
* [T7. The topology shows only the coordinator, or the routers disappear after a restart](#t7-the-topology-shows-only-the-coordinator-or-the-routers-disappear-after-a-restart)
* [T8. With a Texas Instruments coordinator, new devices leave and join again in a loop](#t8-with-a-texas-instruments-coordinator-new-devices-leave-and-join-again-in-a-loop)

## Errors

* [E1. Log error : `No transport, write directive to XXX.XXX.XXX.XXX:8080' ignored`](#e1-log-error--no-transport-write-directive-to-xxxxxxxxxxxx8080-ignored)
* [E4. Log Error : `Error: (FindModule) Domoticz/DomoticzEx modules not found in interpreter`](#e4-log-error--error-findmodule-domoticzdomoticzex-modules-not-found-in-interpreter)
* [E5. Missing module error](#e5-missing-module-error)
* [E6. Error : `Error: <plugin's name> : You need to setup the URL Base to access the Domoticz JSON/API`](#e6-error--error-plugins-name--you-need-to-setup-the-url-base-to-access-the-domoticz-jsonapi)
* [E7. Error when updating python modules: `Building wheel for cryptography (PEP 517) ... error`](#e7-error-when-updating-python-module-building-wheel-for-cryptography-pep-517--error)
* [E9. Error : `ImportError: PyO3 modules may only be initialized once per interpreter process`](#e9-error--importerror-pyo3-modules-may-only-be-initialized-once-per-interpreter-process)
* [E11. Error : `externally-managed-environment` (Debian 12 or newer)](#e11-error--externally-managed-environment-debian-12-or-newer)
* [E12. Error : `Error: <plugin's name> : ModuleNotFoundError: No module named 'cchardet'`](#e12-error--error-plugins-name--modulenotfounderror-no-module-named-cchardet)
* [E13. Error : `AttributeError: module 'lib' has no attribute 'OpenSSL_add_all_algorithms'`](#e13-error--attributeerror-module-lib-has-no-attribute-openssl_add_all_algorithms)
* [E14. AttributeError: module 'lib' has no attribute 'X509_V_FLAG_CB_ISSUER_CHECK'](#e14-attributeerror-module-lib-has-no-attribute-x509_v_flag_cb_issuer_check)
* [E16. Error : `Cannot run the event loop while another loop is running` with several plugin instances](#e16-error--cannot-run-the-event-loop-while-another-loop-is-running-with-several-plugin-instances)
* [E17. `ModuleNotFoundError` although the modules are installed](#e17-modulenotfounderror-although-the-modules-are-installed)
* [E18. Error : `Z4D requires Python 3.11` or `Domoticz version ... not supported`](#e18-error--z4d-requires-python-311-or-domoticz-version--not-supported)
* [E19. Error during an update : `detected dubious ownership in repository` or `You have uncommitted changes`](#e19-error-during-an-update--detected-dubious-ownership-in-repository-or-you-have-uncommitted-changes)
* [E20. Error : `Domoticz widget creation failed ... Check that Domoticz can Accept New Hardware`](#e20-error--domoticz-widget-creation-failed--check-that-domoticz-can-accept-new-hardware)

The errors specific to ZiGate coordinators (`Decode8000`, `Communication error when transmiting a previous command`, `No DNS record configured for Zigate model`, `no decoder registered for MsgType`) are in the [FAQ for ZiGate](FAQ_ZiGate.md#zigate-log-messages).

------------
------------

## Q1. Where can I get support ?

The first source of support is this [Wiki](https://zigbeefordomoticz.github.io/wiki/en-eng).

You can also get support and ask questions :

* The [English Forum](https://www.domoticz.com/forum/viewforum.php?f=68)
* The [French Forum](https://easydomoticz.com/forum/viewforum.php?f=28)
* The [GitHub issues](https://github.com/zigbeefordomoticz/Domoticz-Zigbee/issues) of the plugin, to report a bug
* The [discussions of z4d-certified-devices](https://github.com/zigbeefordomoticz/z4d-certified-devices/discussions), for device configuration files

To get a useful answer quickly, give from the start:

* Your system (OS and version, Raspberry Pi model, Docker or not), the DomoticZ version and the Python version DomoticZ uses (__Setup > About__).
* The plugin version (shown at the bottom of the WebUI) and your coordinator (model and firmware).
* What you did, what you expected and what happened.
* The [plugin log](#q2-where-are-the-logs-) from the plugin start, and the error history exported from __WebUI > Tools > Error(s)__ (see [Deal with plugin errors](HowTo_Dealing-plugin-errors.md)).

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

Yes: add one instance of the plugin (one DomoticZ hardware) per coordinator. Each instance has its own Zigbee network, its own WebUI port and its own files. One instance manages all the devices paired to its coordinator: don't create one DomoticZ hardware per device.

There is one known problem: with DomoticZ 2026.x and **Python 3.11** (for example Debian 12 / Raspberry Pi OS Bookworm), the second instance fails to start with `Cannot run the event loop while another loop is running`. Use Python 3.12 or newer: see [E16](#e16-error--cannot-run-the-event-loop-while-another-loop-is-running-with-several-plugin-instances).

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

## Q10. How do I change the Zigbee channel ?

Changing the channel in the WebUI __Settings__ page and restarting the plugin doesn't move an existing network to another channel. Use one of the methods of [Change the Zigbee channel](HowTo_Change-ZigBee-channel.md): the live channel change from __WebUI > Admin > Coordinator__ keeps the paired devices (older battery devices may need a reset to follow).

Before changing the Zigbee channel, check which Wi-Fi channels are used around you: changing the Wi-Fi channel of your box is often simpler. See [Zigbee and Wi-Fi](Info_ZigBee-and-Wifi.md) and [Real-time interference scan](HowTo_Real-time-interference-scan.md).

------------

## Q11. Can I use the DomoticZ *Replace* button to keep the history of a dead device ?

No. The DomoticZ *Replace* function doesn't work with the widgets of the plugin: after a replace, some widgets of the new device stop being updated.

To replace a dead device by a new one and keep the history of its widgets, pair the new device, then use the `Tools/replace_device.py` tool of the plugin: see [Replacing a Zigbee device while keeping its Domoticz history](HowTo_Replace_Device.md).

------------

## Q12. My ZiGate is no longer supported: what should I replace it with ?

The plugin no longer supports ZiGate coordinators. Pick a Texas Instruments, Silicon Labs, ConBee/RaspBee or Bouffalo Lab coordinator in [Compatible coordinators](Coordinators.md), then follow [Replace or migrate the coordinator](HowTo_Replace-coordinator.md#case-3-from-a-zigate-or-starting-a-new-network): coming from a ZiGate, the devices have to be paired again.

------------

## Q13. How do I uninstall the plugin ?

1. In DomoticZ, __Setup > Hardware__, delete the hardware of the plugin. This also deletes all its widgets, with their history.
1. Delete the plugin folder `domoticz/plugins/Domoticz-Zigbee`.
1. If you installed the Python modules in a [virtual environment](HowTo_PythonVirtualEnv.md) used only for the plugin, you can delete it too.

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

* A blank zigpy coordinator gets a network at the first start (restored from a coordinator backup if there is one, new otherwise). To start a new network on a coordinator that already has one, see [First start and new networks](Plugin_Settings.md#first-start-and-new-networks); if the network can't be formed, see [Form a network with a zigpy coordinator](HowTo_Form-network-zigpy.md).
* Ensure that the serial port is the right one (prefer the `/dev/serial/by-id/...` path).
* Ensure that the __Coordinator Model__ matches your dongle (Texas Instruments ZNP, Silicon Labs EZSP, ConBee/RaspBee or Bouffalo Lab).
* Ensure that the __Coordinator connection type__ matches the baud rate and flow control of your dongle: *USB* is 115200 baud without flow control; some dongles need another *USB, \<baudrate\>, \<flow control\>* entry. If the connection drops right after the start, try the other flow control values.
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

## T4. The update from the WebUI says it succeeded, but the plugin version didn't change

The WebUI shows `Plugin Upgrade process completed without errors.`, but after the restart the plugin still shows the old version. Look at the output of the update for one of these cases:

* __You are on 9.1.004 or 9.1.005.__ These versions updated the Python modules before the plugin code, so the update fails. Update the code by hand once, from the plugin folder, then run the update from the WebUI again to install the Python modules:

  ```bash
  cd domoticz/plugins/Domoticz-Zigbee
  git pull
  ```

  From 9.1.006 on, the WebUI update works again.

* __You are on an older branch (`stable7`, `stable8`).__ The WebUI updates the branch you are on, but can't switch to another one: the question `[y/N]` of the switch script gets no answer and ends with `Aborted by user. No changes made.`. Switch branches on the command line: see [Upgrading from stable8 to stable9](HowTo_Upgrade-stable8-to-stable9.md), and [Know your branch](Plugin_Update.md#know-your-branch).
* __You are on DomoticZ 2026.1 and restarted only the plugin.__ This is a DomoticZ 2026.1 bug: restarting the plugin (from the DomoticZ hardware page or from the WebUI) doesn't load the new code. Restart DomoticZ itself after each plugin update, or upgrade DomoticZ (2026.3 is recommended).
* __The update failed on a git error__ (`dubious ownership`, `uncommitted changes`): see [E19](#e19-error-during-an-update--detected-dubious-ownership-in-repository-or-you-have-uncommitted-changes).

See [Plugin update](Plugin_Update.md) for the manual update.

------------

## T5. My battery devices lose the connection, and raising the transmit power doesn't help

Raising the transmit power of the coordinator lets it talk louder, but doesn't make it hear the devices better: a battery device that is too far away still can't reach it. Zigbee is a mesh network, and the solution is usually in the mesh:

* Add routers (mains powered devices: plugs, bulbs, wired switches, repeaters) between the coordinator and the devices that are far away.
* Move the coordinator away from the server, the Wi-Fi box and USB 3 ports with a USB extension cable, on a USB 2 port.
* Check the Wi-Fi channels around you and choose a Zigbee channel that doesn't overlap them (see [Zigbee and Wi-Fi](Info_ZigBee-and-Wifi.md) and [Q10](#q10-how-do-i-change-the-zigbee-channel-)).
* Some devices are known to lose the network easily, for example the older Aqara sensors.

See [Build a good ZigBee mesh network](HowTo_Build-a-ZigBee-network.md), [Real-time interference scan](HowTo_Real-time-interference-scan.md) and [Transmit power](Coordinators.md#transmit-power).

------------

## T6. The WebUI shows `Unknown error` right after a plugin restart

The WebUI is served by the plugin: while the plugin restarts, the WebUI can't get any answer, and shows errors. Wait a minute or two after a restart before using the WebUI again.

If the error stays, check that the plugin is running in the [logs](#q2-where-are-the-logs-). To investigate, enable the __WebServer__ debug in __WebUI > Tools > Debug__ (see [Debug mode](Problem_Debuging-mode.md)), reproduce the problem and look at the plugin log.

------------

## T7. The topology shows only the coordinator, or the routers disappear after a restart

This answer applies to plugin **9.1.008 and above**, with a zigpy coordinator (Texas Instruments, Silicon Labs, ConBee/RaspBee, Bouffalo Lab).

Before 9.1.008, the zigpy topology scan had a bug: each scan kept the readings of the first one, so the reports could show all the devices linked to the coordinator only, or links to devices that had left the network. If you are on an older version, [update the plugin](Plugin_Update.md) first.

From 9.1.008:

1. Check in the WebUI __Settings__ page (advanced settings) that __ZigpyTopologyReport__ and __TopologyV2__ (*Network Topology based on routing and neighbourghs tables*) are enabled. They are by default.
1. In [WebUI > Network > Topology](WebUI_Network.md#the-reports), delete the reports made by the older versions: they were built the old way and give wrong results.
1. Start a new scan and wait for it to complete: on a large network it takes several minutes, and the report only appears in the list once it is complete.

A battery device doesn't route: it appears only through the router it is attached to, its parent. To see where the battery devices are attached, use the *Associated devices* button of the topology panel, and the [Mesh graph](WebUI_Network-Mesh.md).

------------

## T8. With a Texas Instruments coordinator, new devices leave and join again in a loop

You pair a device: it joins, leaves a few seconds later, joins again, and so on. Pairing never completes, even close to the coordinator. The devices already paired keep working. This happens on networks where many devices have been paired and removed over time.

__The cause: the coordinator's link key table is full.__ A Texas Instruments coordinator (Z-Stack) keeps one *Trust Center Link Key* (TCLK) entry for each Zigbee 3.0 device it has let into the network. The table has a fixed size, set when the firmware is built. With the [Koenkk Z-Stack firmware](https://github.com/Koenkk/Z-Stack-firmware/tree/master/coordinator) it holds __200__ entries (__400__ on a CC2674P10). Removing a device from the plugin doesn't free its entry, and neither does a device leaving the network. When the table is full, the coordinator can't give a new device its key: the device gives up, leaves, and tries again.

__The fix: rewrite the table without the devices that no longer exist.__ Restoring a coordinator backup rewrites the whole table from the backup's device list, so remove the old devices from the backup and restore it:

1. Stop the plugin, then make a backup of the coordinator with zigpy-cli, as described in [Manual backup and restore with zigpy-cli](HowTo_Backup-zigpy-coordinators.md#manual-backup-and-restore-with-zigpy-cli). Keep an untouched copy of the file. Replace `/dev/ttyUSB0` with the port of your coordinator.

   ```bash
   zigpy radio znp /dev/ttyUSB0 backup coordinator-backup.json
   cp coordinator-backup.json coordinator-backup.orig.json
   ```

1. Open the JSON file. Each entry of the `devices` list has an `ieee_address` (16 hex characters, as the plugin shows it). The entries that have a `link_key` are the table entries: if there are close to 200, the table is full.
1. Delete the entries whose `ieee_address` is not one of your current devices (see the device list in the WebUI). Keep the JSON valid (watch the commas).
1. With the plugin still stopped, restore the edited file onto the same coordinator, then start the plugin and pair the device again. The restore is in the same [zigpy-cli section](HowTo_Backup-zigpy-coordinators.md#manual-backup-and-restore-with-zigpy-cli), and in the [zigpy-cli documentation](https://github.com/zigpy/zigpy-cli#network-restore):

   ```bash
   zigpy radio znp /dev/ttyUSB0 restore coordinator-backup.json
   ```

   The zigpy-znp tools do the same: `python -m zigpy_znp.tools.network_backup` and `network_restore`, see [zigpy-znp backup and restore](https://github.com/zigpy/zigpy-znp/blob/dev/TOOLS.md#backup-and-restore). If the restore goes wrong, restore the untouched copy.

Be careful in step 3: a device that still exists and that you removed from the file loses its link key, and must be paired again.

The table fills up again over time if you pair and remove many devices. Repeat the cleanup when it happens.

------------

## E1. Log error : `No transport, write directive to XXX.XXX.XXX.XXX:8080' ignored`

Time to time I see the following error message. Is that a big issue ? How can I get rid of it ?

```log
Error: ZigBee: No transport, write directive to 'XXX.XXX.XXX.XXX:8080' ignored.
```

This error comes from DomoticZ. It appears when a WebUI page was left open and its connection timed out: when the page tries to refresh, DomoticZ has no connection to send the answer to.
You can ignore it.

------------

## E4. Log Error : `Error: (FindModule) Domoticz/DomoticzEx modules not found in interpreter`

```log
Error: (FindModule) Domoticz/DomoticzEx modules not found in interpreter.
```

This error appears when stopping the plugin. Ignore it.

------------

## E5. Missing module error

A `ModuleNotFoundError` or `No module named ...` error at startup (for example `No module named 'zigpy'` or `No module named 'z4d_certified_devices'`) means that the Python modules of the plugin are not installed in the Python environment DomoticZ uses. Don't install the modules one by one: `requirements.txt` installs all of them, with the versions the plugin needs.

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
Error: Zigbee: Call to function 'onStart' failed, exception details:
Error: Zigbee: Traceback (most recent call last):
...
Error: Zigbee:   File ".../cryptography/exceptions.py", line 9, in <module>
Error: Zigbee:     from cryptography.hazmat.bindings.rust import exceptions as rustexceptions
Error: Zigbee: ImportError: PyO3 modules may only be initialized once per interpreter process
```

This is related to a cryptography module more recent than the plugin supports. The plugin pins the versions it needs in `constraints.txt` (`cryptography<=40.0.2`), which `requirements.txt` applies. Reinstall the modules in the Python virtual environment of DomoticZ, from the plugin folder:

``` bash
python3 -m pip install -r requirements.txt --upgrade
```

If the error persists, a more recent cryptography is probably installed system wide and found first: use a Python virtual environment, see [Using Python Virtual Environment](HowTo_PythonVirtualEnv.md).

------------

## E11. Error : `externally-managed-environment` (Debian 12 or newer)

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
Error: Zigbee: (Zigbee) failed to load 'plugin.py', Python Path used was '...:/usr/lib/python3/dist-packages:...'.
Error: Zigbee: Traceback (most recent call last):
...
Error: Zigbee: File "/usr/lib/python3/dist-packages/OpenSSL/crypto.py", line 3279, in <module>
Error: Zigbee: lib.OpenSSLadd_all_algorithms()
Error: Zigbee: AttributeError: module 'lib' has no attribute 'OpenSSL_add_all_algorithms'
```

The root cause is a conflict between the pyOpenSSL of the system (`/usr/lib/python3/dist-packages/OpenSSL`) and the cryptography module installed for the plugin [ref](https://aronhack.com/fix-python-attributeerror-module-lib-has-no-attribute-openssl_add_all_algorithms/).

Use a Python virtual environment for DomoticZ, so that the plugin doesn't load the system modules, and install the modules of the plugin in it (`requirements.txt` applies the `cryptography<=40.0.2` pin of `constraints.txt`): see [Using Python Virtual Environment](HowTo_PythonVirtualEnv.md).

------------

## E14. AttributeError: module 'lib' has no attribute 'X509_V_FLAG_CB_ISSUER_CHECK'

```log
Error: Zigbee: (Zigbee) failed to load 'plugin.py', Python Path used was '...:/usr/lib/python3/dist-packages:...'.
Error: Zigbee: Traceback (most recent call last):
...
Error: Zigbee: File "/usr/lib/python3/dist-packages/OpenSSL/crypto.py", line 1577, in X509StoreFlags
Error: Zigbee: CB_ISSUER_CHECK = lib.X509V_FLAG_CB_ISSUER_CHECK
Error: Zigbee: AttributeError: module 'lib' has no attribute 'X509_V_FLAG_CB_ISSUER_CHECK'
```

It is the same kind of conflict as [E13](#e13-error--attributeerror-module-lib-has-no-attribute-openssl_add_all_algorithms), between the pyOpenSSL of the system and the modules installed for the plugin. The best fix is a Python virtual environment for DomoticZ (see [Using Python Virtual Environment](HowTo_PythonVirtualEnv.md)). Removing the system package also works, if no other software needs it:

```bash
sudo apt remove -y python3-openssl
```

------------

## E16. Error : `Cannot run the event loop while another loop is running` with several plugin instances

```log
encountered a runtime error: Cannot run the event loop while another loop is running
```

With DomoticZ 2026.x and **Python 3.11** (for example Debian 12 / Raspberry Pi OS Bookworm), the second instance of the plugin fails to start with this error. It is a Python 3.11 problem, reported to DomoticZ in [domoticz/domoticz#6763](https://github.com/domoticz/domoticz/issues/6763). Restarting the failed instance (or waiting for it to restart by itself) usually gets both instances running.

DomoticZ itself writes a note about it at start-up on Python 3.11:

```log
Status: Zigbee: Note: Python 3.11 detected. Plugins using asyncio inside sub-interpreters (shared="true" not set) can leak event-loop state between plugins on Python < 3.12 due to a global cache in CPython's _asyncio extension. If multiple asyncio-based plugins are active, prefer Python 3.12+ or set shared="true" in the plugin's XML manifest.
```

The fix is to run DomoticZ with Python 3.12 or newer (for example Debian 13 Trixie, which comes with Python 3.13), with the Python modules of the plugin installed for that version.

------------

## E17. `ModuleNotFoundError` although the modules are installed

The modules were installed for another Python than the one DomoticZ uses: another Python version, or the system Python instead of the virtual environment. The plugin may also report that a module has the wrong version (for example zigpy `0.83.0` found where `2.1.0` is required): an older copy of the modules is found first.

1. Look for the Python version used by DomoticZ in the DomoticZ log: `PluginSystem: Started, Python version '3.13.5'`.
1. Check that your virtual environment was created with the same version (`<venv>/bin/python3 --version`). If not, create it again with `python3.xx -m venv` and reinstall the modules.
1. Check that DomoticZ is started with this virtual environment (`VIRTUAL_ENV` and `PATH` in the service). At start-up, the plugin writes `VIRTUAL_ENV is set to: ...` and `PYTHONPATH is set to: ...` in the DomoticZ log.
1. Don't mix the two methods: if the start script also sets a `PYTHONPATH` from an older installation, the modules of that folder are found first. Remove the `PYTHONPATH` line, see [Older setups with PYTHONPATH](HowTo_PythonVirtualEnv.md#older-setups-with-pythonpath).

If your virtual environment is in a mess, the simplest is to delete it and create it again, see [Using Python Virtual Environment](HowTo_PythonVirtualEnv.md).

------------

## E18. Error : `Z4D requires Python 3.11` or `Domoticz version ... not supported`

The plugin (`stable9`) requires Python 3.11 or newer and DomoticZ 2025.1 or newer, with the Extended Framework. **DomoticZ 2026.3 is the recommended version.**

* `Z4D requires Python 3.11, found 3.x`: DomoticZ runs an older Python. Upgrade your system, or install a newer Python and make DomoticZ use it.
* `Domoticz version ... not supported, please upgrade to a more recent`: upgrade DomoticZ (check your version in __Setup > About__).

See [Plugin installation](Plugin_Installation.md#requirements).

------------

## E19. Error during an update : `detected dubious ownership in repository` or `You have uncommitted changes`

```log
fatal: detected dubious ownership in repository at '/home/pi/domoticz/plugins/Domoticz-Zigbee'
```

```log
Error: You have uncommitted changes. Please commit or stash them first.
```

The plugin folder belongs to another user than the one running the update. It happens when the update runs as `root` (DomoticZ started as root, or a `sudo` command) on a folder owned by your user, or the other way round. git then refuses the folder, or sees every file as modified although you didn't change anything.

Give the plugin folder to the user DomoticZ runs as, then run the update again. For example, if DomoticZ runs as `pi`:

```bash
cd /home/pi/domoticz/plugins/Domoticz-Zigbee
sudo chown -R pi:pi .
git status
```

`git status` must then show no modified file. If it still shows files you really changed, put them aside with `git stash -u` (see [Upgrading from stable8 to stable9](HowTo_Upgrade-stable8-to-stable9.md#if-something-goes-wrong)), or reset them as described in [Plugin update](Plugin_Update.md#in-case-of-error).

------------

## E20. Error : `Domoticz widget creation failed ... Check that Domoticz can Accept New Hardware`

```log
Error: Zigbee: Domoticz widget creation failed for <NwkId>/<Ep> <widget type> (unit <unit>). Check that Domoticz can Accept New Hardware, and see the Domoticz log for the reason it refused.
```

DomoticZ refused to create a widget for a device. The plugin keeps the device and tries again a few times; if it still fails, it stops trying until the next restart.

1. In DomoticZ, __Setup > Settings > System__, check that __Accept new Hardware Devices__ is enabled (see [Add a new device](HowTo_Pairing-device.md#before-you-start-let-domoticz-accept-new-devices)).
1. Look in the DomoticZ log, at the same time, for the reason DomoticZ gave.
1. Then restart the plugin, or use __Recreate widget__ in [WebUI > Admin > Pairing](WebUI_Admin.md#pairing) to create the widgets of the device again.
