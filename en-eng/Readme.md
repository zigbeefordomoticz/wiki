# Zigbee for Domoticz plugin wiki

The Zigbee for Domoticz plugin (ZigBeeForDomoticZ, Z4D) connects a Zigbee coordinator to [Domoticz](https://www.domoticz.com): your Zigbee devices become Domoticz widgets, entirely locally, with no cloud.

> This English wiki is under review (October 2026) and is the only maintained version. The [French](../fr-fr/Readme.md) and [Dutch](../nl-dut/Readme.md) wikis are obsolete.

## Before you start

What the current plugin requires. Check this before installing or upgrading.

* `stable9` (9.1.xxx) is the production branch of the plugin. `stable8` and older branches are out of support: if you are still on one of them, [upgrade to stable9](HowTo_Upgrade-stable8-to-stable9.md).
* We recommend **Domoticz 2026.3**. `stable9` requires Domoticz 2025.1 or newer and Python 3.11 or newer.
* Running several instances of the plugin (several coordinators) with Domoticz 2026.x and Python 3.11 doesn't work because of a Python 3.11 problem ([domoticz/domoticz#6763](https://github.com/domoticz/domoticz/issues/6763)): use Python 3.12 or newer.

## 1. Getting started

New to the plugin? What it does, which coordinator to buy, which devices work.

* [Getting started](Info_Home.md)
* [Compatible coordinators](Coordinators.md)
* [Compatible objects](Objects.md) and [certified devices](Info_Compatible-devices.md)

## 2. Installation

Install the plugin, declare it in Domoticz and open its WebUI, in four steps.

* Step 1: [Plugin installation](Plugin_Installation.md)
  * [With Docker](How-To-Install-RPI-Docker.md)
  * [With Docker on a Synology NAS](Info_Install-Domoticz-NAS-Synology-Docker.md)
  * [On a DUSUN IoT gateway](Corner_DUSUN.md)
  * [Python virtual environment for Domoticz](HowTo_PythonVirtualEnv.md)
* Step 2: [Plugin settings](Plugin_Settings.md) — declare the plugin hardware in Domoticz
* Step 3: [Plugin configuration](Plugin_Configuration.md) — open the WebUI and check the settings
* Step 4: [Plugin integration](Plugin_Integration.md) — open the WebUI from the Domoticz menu

## 3. Using the plugin

Everyday tasks: add and remove devices, set them up, use groups and bindings.

* [Build a Zigbee mesh network](HowTo_Build-a-ZigBee-network.md) — pair in the right order, routers first
* [Add a new device](HowTo_Pairing-device.md)
* [Remove a device](HowTo_Remove-device.md)
* [Replace a device while keeping its Domoticz history](HowTo_Replace_Device.md) — Domoticz's own *Replace* doesn't work with the plugin
* [Device parameters](HowTo_Device-parameters.md) — per-device options (LEDs, sensitivity, power-on state, polling…)
* [Manage Zigbee groups](HowTo_Group-management.md)
* [Bind two devices](HowTo_Binding.md) — let a switch command a light directly
* [Change the Zigbee channel](HowTo_Change-ZigBee-channel.md)
* [Update device firmware](HowTo_Update-device-firmware.md) — over-the-air updates

<a name="plugins-web-interface"></a>
## 4. The WebUI

The plugin's own web interface, at `http://<Domoticz server>:9440/z4d/`: one page per menu.

* [General presentation](WebUI_General-presentation.md) — the menu bar, the indicators
* [Dashboard](WebUI_Dashboard.md) — the state of the plugin and the devices at a glance
* [Management](WebUI_Management.md) — devices and groups
* [Network](WebUI_Network.md) — topology and interference level
  * [Mesh graph](WebUI_Network-Mesh.md) — the Zigbee mesh, its relationships, routes and parent/child tree
* [Admin](WebUI_Admin.md) — pairing, group scan, coordinator, plugin upgrade, device firmware
* [Settings](WebUI_Settings.md) — every plugin setting
* [Tools](WebUI_Tools.md) — commands, reporting, binding, debug, errors
  * [Use the plugin tools](HowTo_Using-tools.md) — the data buttons and the REST API
* [Manufacturer](WebUI_Manufacturer.md) — only shown when a CASA.iA, ZLinky, TICmeter or Chameleon device is paired
* [About](WebUI_About.md)

## 5. Keeping it running

Updates, backups, and what to do when the coordinator changes.

* [Plugin update](Plugin_Update.md) — routine updates of `stable9`, going back to a previous release, the plugin branches
* [Upgrading from stable8 to stable9](HowTo_Upgrade-stable8-to-stable9.md) — one-way switch for users still on `stable8` or older
* [Backup and restore](Plugin_Backup.md) — what to back up (plugin files and the Domoticz database), the backup scripts, reinstalling the plugin
* [The scripts of the Tools folder](Plugin_Tools-folder.md) — upgrade, clean-up, repair, watchdog, https certificate, OTA file checks
* [Back up a zigpy coordinator](HowTo_Backup-zigpy-coordinators.md) — automatic backups, zigpy-cli
* [Replace or migrate the coordinator](HowTo_Replace-coordinator.md)
* [Form a network with a zigpy coordinator](HowTo_Form-network-zigpy.md) — when *Initialize Coordinator* fails

<a name="devices-specifics"></a>
## 6. Device-specific notes

Devices that need a specific setup or have known limits, by brand.

* [Aqara](Corner_Aqara.md)
* [BlitzWolf](Corner_Blitzwolf.md)
* [Danfoss](Corner_Danfoss.md)
* [Develco / Frient Intelligent Keypad](Corner-Frient-Intelligent-Keypad.md)
* [Eurotronics](Corner_Eurotronics.md)
* [Gamma Troniques TICmeter](Corner_GammaTroniques.md)
* [Ikea Tradfri](Corner_Ikea-Tradfri.md)
  * [Ikea remote control as a pure remote](Corner_Ikea-Remote.md)
  * [Ikea motion sensor](Corner_Ikea-Tradfri-Motion.md)
* [Legrand Netatmo](Corner_Legrand-Netatmo.md)
  * [Get the Legrand firmware for your device](Corner_Retreiving-Legrand-Firmware.md)
* [Livolo](Corner_Livolo.md)
* [Müller Licht Tint](Corner_Tint.md)
* [Philips Gledopto](Corner_Philips-Gledopto.md)
* [Profalux](Corner_Profalux-corner.md)
* [Schneider Wiser](Corner_Schneider_Wiser.md)
  * [Schneider Wiser setup](Corner_Wiser-Setup.md)

<a name="what-to-do-if-the-device-doesnt-behave-correctly"></a>
## 7. When something goes wrong

A device doesn't pair, doesn't report, or the plugin shows errors: start here.

* [Troubleshooting pairing or connection](Troubleshooting_Pairing.md)
* [Dealing with a non-optimized device](Problem_Dealing-with-none-optimized-device.md)
* [Deal with plugin errors](HowTo_Dealing-plugin-errors.md)
* [Debug mode](Problem_Debuging-mode.md)
* [Plugin FAQ](Problem_FAQ.md)
* [Getting help and reporting a problem](Troubleshooting_Reporting-a-problem.md) — where to ask, expected logs, debug parameters, what to attach
* Ask on the [English forum](https://www.domoticz.com/forum/viewforum.php?f=68) or the [French forum](https://easydomoticz.com/forum/viewforum.php?f=28), with the relevant part of the Domoticz log.

## 8. Advanced

For users who want to go further: describe a device yourself, reach the WebUI from outside, script, or look under the hood.

* Make a device work better:
  * [Get devices well integrated with the plugin (device customization)](HowTo_Device-Customization.md)
  * [Integrate Tuya TS0601 devices](HowTo_Device-Customization-TS0601.md)
  * [Model name resolution and `Conf/Local-Devices` precedence](Technical/Model-name-resolution.md)
* Reach the WebUI from outside:
  * [Reverse proxy with Caddy](HowTo_Reverse-Proxy-with-Caddy.md)
  * [Reverse proxy with Apache 2](HowTo_Reverse-Proxy-with-Apache2.md)
  * [Dashboard access with basic authentication over https](HowTo_Dashboard-Access-Basic-Auth.md)
* [Scripts](../Contrib/Readme.md) — community dzVents scripts: battery levels, lost devices, automation examples
* [Technical information](Technical/Readme.md) — REST API, plugin internals, device configuration files, protocol notes

## Reference

* [Zigbee and Wi-Fi](Info_ZigBee-and-Wifi.md) — choosing a channel away from your Wi-Fi
* [Firmware list](Info_Firmware-list.md) — where to find firmware for coordinators and devices
* [Widgets switch selector mapping](Info_Widgets-Switch-Selector-Mapping.md)
* [Usage statistics](WebUI_Statistics.md) — what the plugin sends anonymously, and how to opt out
* External reading:
  * [Understanding a Zigbee network](https://www.blackhillsinfosec.com/understanding-zigbee-and-wireless-mesh-networking/)
  * [A guide to wireless range and repeaters](https://blog.smartthings.com/smartthings-updates/a-guide-to-wireless-range-repeaters/)
  * [Pairing Aqara/Xiaomi devices and keeping them connected, including with other brands](https://community.hubitat.com/t/xiaomi-aqara-devices-pairing-keeping-them-connected/623)

## Legacy ZiGate

ZiGate coordinators are no longer supported by the plugin: we advise moving to a Texas Instruments, Silicon Labs or deCONZ coordinator (see [Compatible coordinators](Coordinators.md)). These pages are kept for existing ZiGate users and are not maintained.

* [FAQ ZiGate](FAQ_ZiGate.md)
* [ZiGate limitations](Info_ZiGate-Limitations.md)
* [Upgrading the ZiGate firmware](HowTo_Update-ZiGate-firmware.md) (archived)
* [Configure a ZiGate as a Zigbee sniffer](Info_Configure-ZiGate-as-Sniffer.md)
* [PiZigate installation](Legacy_PiZigate-Installation.md)
* [ZiGate internals](Technical/Readme.md#legacy-zigate)
* In French, on zigate.fr: [ZiGate backup & restore](https://zigate.fr/documentation/sauvegardez-et-restaurez-votre-zigate), [ZiGate firmware update](https://zigate.fr/documentation/mise-a-jour-de-la-zigate)

## Contribute and support

The plugin and this wiki are made on spare time. Any help is welcome:

* **Translate the WebUI**: it is available in English, French, German, Spanish, Italian and Dutch. Each language is a JSON file in the [Domoticz-Zigbee-UI](https://github.com/zigbeefordomoticz/Domoticz-Zigbee-UI/tree/beta/src/translations) repository: copy `en-US.json`, translate the texts and open a pull request.
* **Improve the wiki**: report a mistake or a missing page in the [wiki issues](https://github.com/zigbeefordomoticz/wiki/issues), or propose a change with a pull request.
* **Contribute to the code**: report bugs, test new versions, or propose changes on the [plugin repository](https://github.com/zigbeefordomoticz/Domoticz-Zigbee).
* **Fund the project**: even 5 € helps to buy new devices to test, integrate and certify, via [PayPal](https://paypal.me/pipiche).

Questions are welcome on [Keybase](https://keybase.io/team/zigateforum) or the [forum](https://www.domoticz.com/forum/viewforum.php?f=68).
