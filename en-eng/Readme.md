# Welcome to the plugin ZigBeeForDomoticZ wiki

[Lien vers le Wiki en français](../fr-fr/Readme.md) - [Link naar de Wiki in het Nederlands](../nl-dut/Readme.md)

We are contributing to this project on our spare time. If you do consider that it fit your needs, you would like to get more devices certified or tested, please feel free to donate, the amount will be dedicated to purchase new equipments and increase the list of compatible/certified devices.
[![PayPal donate](https://camo.githubusercontent.com/d5d24e33e2f4b6fe53987419a21b203c03789a8f/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d50617950616c2d677265656e2e737667)](https://paypal.me/pipiche)

>We want to open the plugin to as many users as possible and, for this, we are looking for people who can help us translate the WebUI.
>
>Today, the plugin's web interface is available in English, French, German, Spanish, Italian and Dutch. If you speak another language, you too can contribute to the distribution of this plugin worldwide.
>
>Each language is a JSON file in the [Domoticz-Zigbee-UI](https://github.com/zigbeefordomoticz/Domoticz-Zigbee-UI/tree/beta/src/translations) repository: copy `en-US.json`, translate the texts and open a pull request. Questions are welcome on [Keybase](https://keybase.io/team/zigateforum) or the [forum](https://www.domoticz.com/forum/viewforum.php?f=68).

## IMPORTANT

* `stable9` (9.1.xxx) is the production branch of the plugin. `stable8` and older branches are out of support: if you are still on one of them, [upgrade to stable9](HowTo_Upgrade-stable8-to-stable9.md).
* We recommend **Domoticz 2026.3**. `stable9` requires Domoticz 2025.1 or newer and Python 3.11 or newer.
* Running several instances of the plugin (several coordinators) with Domoticz 2026.x and Python 3.11 doesn't work because of a Python 3.11 problem ([domoticz/domoticz#6763](https://github.com/domoticz/domoticz/issues/6763)): use Python 3.13 or newer.
* Replacing a device's widget via Domoticz isn't supported (Domoticz doesn't notify the plugin), but you can keep the old device's history with [Replace a Device](HowTo_Replace_Device.md)

## Introduction

* [Start](Info_Home.md) for beginners
* [Compatible coordinators](Coordinators.md)
* [Compatible objects](Objects.md)

## Installation

* Step 1 [Plugin installation](Plugin_Installation.md)
  * [Installation with Docker on a Raspberry Pi](How-To-Install-RPI-Docker.md)
  * [Installation with Docker on a Synology NAS](Info_Install-Domoticz-NAS-Synology-Docker.md)
  * [Installation on a DUSUN IoT gateway](Corner_DUSUN.md)
* Step 2 [Plugin settings](Plugin_Settings.md)
* Step 3 [Plugin configuration](Plugin_Configuration.md)
* Step 4 [Plugin integration](Plugin_Integration.md)

## Plugin updates

* [Plugin update](Plugin_Update.md) — routine updates of `stable9`, going back to a previous release, the plugin branches
* [Upgrading from stable8 to stable9](HowTo_Upgrade-stable8-to-stable9.md) — one-way switch for users still on `stable8` or older

## Backups

* [Backups to do to be able to restore without losing crucial information](Plugin_Backup.md)

## Plugin's web Interface

* [General presentation](WebUI_General-presentation.md)
* Section [Dashboard](WebUI_Dashboard.md)
* Section [Management](WebUI_Management.md)
* Section [Network](WebUI_Network.md)
  * [Mesh graph](WebUI_Network-Mesh.md) — the Zigbee mesh, its relationships, routes and parent/child tree
* Section [Admin](WebUI_Admin.md)
* Section [Settings](WebUI_Settings.md)
* Section [Tools](WebUI_Tools.md)
* Section [About](WebUI_About.md)
* [Statistics](WebUI_Statistics.md)

## How-to

* [How To use Python Virtual Environment](HowTo_PythonVirtualEnv.md)
* [Build a ZigBee mesh network](HowTo_Build-a-ZigBee-network.md)
* [Add a new device](HowTo_Pairing-device.md)
* [Remove a Device](HowTo_Remove-device.md)
* [Replace a Device while keeping its Domoticz history](HowTo_Replace_Device.md)
* [Device parameters](HowTo_Device-parameters.md)
* [Use the plugin tools](HowTo_Using-tools.md)
* [Group Management](HowTo_Group-management.md)
* [Bindings](HowTo_Binding_Legrand.md)
* [Deal with errors](HowTo_Dealing-pluging-error.md)
* [Change the ZigBee Channel](HowTo_Change-ZigBee-channel.md)
* [Upgrading device firmware](HowTo_Update-device-firmware.md)
* [Backup a ZigPy coordinator](HowTo_Backup-zigpy-coordinators.md)
* [Form a ZigPy network](HowTo_Form-network-zigpy.md)
* [Upgrading Firmware of ZiGate](HowTo_Update-ZiGate-firmware.md)
* [Expose the dashboard with basic authentication on a https link](HowTo_Dashboard-Access-Basic-Auth.md)
* [Use a Reverse proxy with Caddy](HowTo_Reverse-Proxy-with-Caddy.md)
* [Use a Reverse proxy with Apache 2](HowTo_Reverse-Proxy-with-Apache2.md)

## How-to add/certified/custom new devices

* [Get devices well integrated with the plugin (device customization)](HowTo_Device-Customization.md)
* [Integrate Tuya TS0601 Devices with the Plugin](HowTo_Device-Customization-TS0601.md)
* [Model name resolution and `Conf/Local-Devices` precedence](Technical/Model-name-resolution.md)

## What to do if the device doesn't behave correctly

* [Dealing with not-optimized devices](Problem_Dealing-with-none-optimized-device.md)
* [Debug mode](Problem_Debuging-mode.md)
* [FAQ ZiGate](FAQ_ZiGate.md)
* [FAQ plugin](Problem_FAQ.md)

## Devices specifics

* [Aqara](Corner_Aqara.md)
* [BlitzWolf](Corner_Blitzwolf.md)
* [Danfoss](Corner_Danfoss.md)
* [Develco / Frient Intelligent Keypad](Corner-Frient-Intelligent-Keypad.md)
* [Eurotronics](Corner_Eurotronics.md)
* [Gamma Troniques TICMeter](Corner_GammaTroniques.md)
* [Ikea Tradfri](Corner_Ikea-Tradfri.md)
  * [Ikea remote control as a pure remote](Corner_Ikea-Remote.md)
  * [Ikea motion sensor](Corner_Ikea-Tradfri-Motion.md)
* [Legrand Netatmo](Corner_Legrand-Netatmo.md)
  * [Get the Legrand firmware for your device](Corner_Retreiving-Legrand-Firmware.md)
* [Livolo](Corner_Livolo.md)
* [Muller Licht](Corner_Tint.md)
* [Philips Gledopto](Corner_Philips-Gledopto.md)
* [Profalux](Corner_Profalux-corner.md)
* [Schneider Wiser](Corner_Schneider_Wiser.md)
  * [Schneider Wiser setup](Corner_Wiser-Setup.md)

## In case of Trouble

* [Troubleshooting pairing or connection](Troubleshooting_Pairing.md)

1. Watch the log, you should find some information if something is going wrong.
1. Use one of the forum channels
   * [English Forum](https://www.domoticz.com/forum/viewforum.php?f=68)
   * [French Forum](https://easydomoticz.com/forum/viewforum.php?f=28)

## Development

* [Technical infos](Technical/Readme.md)

## Scripts

* [How-to check battery levels](../Contrib/CheckBatteryLevel.dzVents) in DzVents
* [How-to check lost devices (version 1)](../Contrib/CheckLastSeen.dzVents) in DzVents
* [How-to check lost devices (version 2)](../Contrib/CheckDeadDevices.lua) in Lua

 [Other examples](../Contrib/Readme.md)

## Informations

* [Understanding a ZigBee network](https://www.blackhillsinfosec.com/understanding-zigbee-and-wireless-mesh-networking/)
* [Firmware list](Info_Firmware-list.md)
* [Widgets Switch Selector Mapping](Info_Widgets-Switch-Selector-Mapping.md)
* [ZiGate limitations](Info_ZiGate-Limitations.md)
* [Coexistence between Wifi and ZigBee](Info_ZigBee-and-Wifi.md)
* [How-to Configure ZiGate in ZigBee Sniffer](Info_Configure-ZiGate-as-Sniffer.md)
* [Legacy - PiZigate installation](Legacy_PiZigate-Installation.md) (ZiGate is no longer supported)

## More

* [A Guide to Wireless range and Repeater](https://blog.smartthings.com/smartthings-updates/a-guide-to-wireless-range-repeaters/)
* [Pairing Aqara/Xiaomi devices and keeping them connected, including with other brands](https://community.hubitat.com/t/xiaomi-aqara-devices-pairing-keeping-them-connected/623)
* ZiGate only (in French): [ZiGate backup & restore](https://zigate.fr/documentation/sauvegardez-et-restaurez-votre-zigate), [ZiGate firmware update](https://zigate.fr/documentation/mise-a-jour-de-la-zigate)
