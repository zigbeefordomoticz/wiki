# Welcome to the plugin ZigBeeForDomoticZ wiki !

[Lien vers le Wiki en français](../fr-fr/Readme.md) - [Link naar de Wiki in het Nederlands](../nl-dut/Readme.md)


We are contributing to this project on our spare time. If you do consider that it fit your needs, you would like to get more devices certified or tested, please feel free to donate, the amount will be dedicated to purchase new equipments and increase the list of compatible/certified devices.
[![PayPal donate](https://camo.githubusercontent.com/d5d24e33e2f4b6fe53987419a21b203c03789a8f/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d50617950616c2d677265656e2e737667)](https://paypal.me/pipiche)

>Technically, we opened the plugin to other coordinators. Now, we want to open the plugin to as many users as possible and, for this, we are looking for people who can help us translate the WebUI.
>
>Today, the plugin's web interface is available in English, French, German and Spanish. If you speak other languages, you too can contribute to the distribution of this plugin worldwide.
>
> Come and join our team on [Keybase](https://keybase.io/team/zigateforum) or the [forum](https://www.domoticz.com/forum/viewforum.php?f=68) : the translation is done in an Excel file, there is nothing complicated ;-)


## Upgrading to Release 7

On __14/07/2023__, we released the __stable7__ version of the plugin. The necessary to follow the following procedure : [Plugin_Version-7](Release_7.1.md). If you are runner Buster, you have to upgrade to Bullseye first, and you must have python3.8 or above.
The stable7 is also the minimum to run with DomoticZ 2023.2 otherwise you will have some API errors.



## Introduction

* [Start](Info_Home.md) for beginners
* [Compatibles coordinators](Coordinators.md)
* [Compatibles objects](Objects.md)


## Installation

* Step 1 [Plugin installation](Plugin_Installation.md)
* Step 2 [Plugin settings](Plugin_Settings.md)
* Step 3 [Plugin configuration](Plugin_Configuration.md)
* Step 4 [Plugin integration](Plugin_Integration.md)


## Plugin updates

* [Plugin updates](Plugin_Update.md#plugin-update)
* [Plugin branches](Plugin_Update.md#plugin-branches)


## Backups

* [Backups to do to be able to restore without loosing crucial informations](Plugin_Backup.md)


## Plugin's web Interface

* [General presentation](WebUI_General-presentation.md)
* Section [Dashboard](WebUI_Dashboard.md)
* Section [Management](WebUI_Management.md)
* Section [Network](WebUI_Network.md)
* Section [Admin](WebUI_Admin.md)
* Section [Settings](WebUI_Settings.md)
* Section [Tools](WebUI_Tools.md)
* Section [About](WebUI_About.md)
* [Statistics](WebUI_Stastics)


## How-to

* [Build a ZigBee mesh network](HowTo_Build-a-ZigBee-network.md)
* [Add a new devices](HowTo_Pairing-device.md)
* [Remove a Device](HowTo_Remove-device.md)
* [Device parameters](HowTo_Device-parameters.md)
* [Use the plugin tools](HowTo_Using-tools.md)
* [Group Management](HowTo_Group-management.md)
* [Bindings](HowTo_Binding_Legrand.md)
* [Deal with errors](HowTo_Dealing-pluging-error.md)
* [Change the Zigbee Channel](HowTo_Change-ZigBee-channel.md)
* [Upgrading device firmware](HowTo_Update-device-firmware.md)
* [Backup a ZigPy coordinator](HowTo_Backup-zigpy-coordinators.md)
* [Form a ZigPy network](HowTo_Form-network-zigpy.md)
* [Upgrading Firmware of ZiGate](HowTo_Update-ZiGate-firmware.md)
* [Expose the dashboard with basic authentication on a https link](HowTo_Dashboard-Access-Basic-Auth.md)
* [Use a Reverse proxy with Caddy](HowTo_Reverse-Proxy-with-Caddy.md)
* [Use a Reverse proxy with Apache 2](HowTo_Reverse-Proxy-with-Apache2.md)


## What to do if the device doesn't behave correctly

* [Dealing with not-optimized devices](Problem_Dealing-with-none-optimized-device.md)
* [Debug mode](Problem_Debuging-mode.md)
* [FAQ ZiGate](FAQ_ZiGate.md)
* [FAQ plugin](Problem_FAQ.md)


## Devices specifics

* [Aqara](Corner_Aqara.md)
* [BlitzWolf](Corner_Blitzwolf.md)
* [Eurotronics](Corner_Eurotronics.md)
* [Ikea Tradfri](Corner_Ikea-Tradfri.md)
* [Legrand Netatmo](Corner_Legrand-Netatmo.md)
* [Livolo](Corner_Livolo.md)
* [Muller Licht](Corner_Tint.md)
* [Philips Gledopto](Corner_Philips-Gledopto.md)
* [Profalux](Corner_Profalux-corner.md)
* [Schneider Wiser](Corner_Schneider_Wiser.md)


## Information about releases

* [Release 4.1](Release_4.1.md)


## In case of Trouble

* [Troubleshooting pairing or connection](Troubleshooting_Pairing.md)

1. Watch the log, you should fine some information if something is going wrong.
1. Use one of the forum channels
   * [English Forum](https://www.domoticz.com/forum/viewforum.php?f=68)
   * [French Forum](https://easydomoticz.com/forum/viewforum.php?f=28)


## Development

* [Technical infos](Technical/Readme.md)

## Scripts

* [How-to check battery levels](../Contrib/CheckBatteryLevel.dzVents) in DzVents
* [How-to check lost devices (version 1)](../Contrib/CheckLastSeen.dzVents) in DzVents
* [How-to check lost devices (version 2)](../Contrib/CheckDeadDevices.lua) in DzVents

 [Other examples](https://github.com/zigbeefordomoticz/wiki/tree/master/Contrib)


## ZiGate How-to

 * [ZiGate backup & restore](https://zigate.fr/documentation/sauvegardez-et-restaurez-votre-zigate) in french
 * [ZiGate Update](https://zigate.fr/documentation/mise-a-jour-de-la-zigate) in french


## Informations

* [Firmware list](Info_Firmware-list.md)
* [Widgets Switch Selector Mapping](Info_Widgets-Switch-Selector-Mapping)
* [ZiGate limitations](Info_ZiGate-Limitations.md)
* [Coexistence between Wifi and ZigBee](Info_ZigBee-and-Wifi.md)
* [How-to Configure ZiGate in ZigBbee Sniffer](Info_Configure-ZiGate-as-Sniffer.md)


## More

* [A Guide to Wireless range and Repeater](https://blog.smartthings.com/iot101/a-guide-to-wireless-range-repeaters/)
* [Pairing devices Aqara/Xiaomi](https://community.hubitat.com/t/xiaomi-aqara-devices-pairing-keeping-them-connected/623)
* [Coexistence Xiaomi with other brands](https://community.hubitat.com/t/xiaomi-aqara-devices-pairing-keeping-them-connected/623)
