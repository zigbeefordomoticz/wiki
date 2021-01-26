![zigate.fr](../Images/ZiGate.png)

Bienvenue sur le wiki du plugin Zigate pour DomoticZ !

Le but de ce wiki est de fournir les plus d'informations possible sur l'utilisation du plugin.

Nous développons ce projet sur notre temps libre. Si vous appréciez ce qui est fait, vous pouvez contribuer par un don PayPal; ce don permettra notamment l'achat d’équipements afin d'augmenter la liste de matériels certifiés compatibles avec le plugin ZiGate. [![PayPal donate](https://camo.githubusercontent.com/d5d24e33e2f4b6fe53987419a21b203c03789a8f/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f446f6e6174652d50617950616c2d677265656e2e737667)](https://paypal.me/pipiche)

**Ce wiki en français est en cours de rédaction :** Les pages traduites ont un lien en français. Les autres liens renvoyant vers le wiki EN ont l'indication "en anglais". 


## Introduction

L'objectif de ce plugin est de réaliser une passerelle entre une [Zigate](https://zigate.fr), un récepteur ZigBee et le logiciel de domotique [DomoticZ](https://www.domoticz.com). Ce plugin permettra de gérer tous les dispositifs ZigBee utilisés par DomoticZ.

Le plugin dispose d'une interface utilisateur dédiée accessible depuis votre navigateur web. Cette interface permettra de configurer le plugin et régler le fonctionnement de la Zigate.

Voici une liste non exhaustive des dispositifs compatibles. Ceux présents dans la liste ont été "certifiés" : nous savons qu'ils fonctionnent avec le plugin. Il est possible qu'il y ait d'autres dispositifs ZigBee qui fonctionnent (merci de nous remonter l'info afin que nous mettions la liste à jour)
* [Liste des dispositifs compatibles](../en-eng/Compatible-Devices.md)


## Installation

Il existe plusieurs façons d'installer le plugin Zigate pour DomoticZ qui sont différentes en fonction du système d'exploitation.

Dans tous les cas, le plugin nécessite DomoticZ version 3.87 ou supérieure et Python version 3.5 ou supérieur. Assurez-vous que le paquet __python3-dev__ est installé. Plus d'informations sur la page [DomoticZ Python plugin](https://www.domoticz.com/wiki/Using_Python_plugins).


* Etape 1 [Installation du plugin](1_Installation.md)
* Etape 2 [Paramétrage du plugin](2_Parametrage.md)
* Etape 3 [Configuration du plugin](3_Configuration.md)


## Mise à jour

* [Mettre à jour le plugin](4_Mise-a-jour.md#mettre-à-jour-le-plugin)
* [Les branches de mises à jour](4_Mise-a-jour.md#les-branches-de-mise-à-jour)


## Sauvegardes

* [Sauvegardes à faire pour pouvoir réinstaller le plugin sans perdre de données](5_Sauvegardes.md)


## L'interface Web du plugin

* [Présentation générale](WebUI_Presentation-generale.md)
* La section [Tableau de bord](WebUI_Tableau-de-bord.md)
* La section [Management](WebUI_Management.md)
* La section [Réseau](WebUI_Reseau.md)
* La section [Admin](WebUI_Admin.md)
* La section [Réglages](WebUI_Reglages.md)
* La section [Outils](WebUI_Outils.md)
* La section [A propos](WebUI_A-propos.md)


## Tutoriels

* [Ajouter un nouveau dispositif](Tuto_Appairage-dispositif.md)

* [Remove a Device from ZiGate](../en-eng/RemoteDevice.md) en anglais
* [Change the Zigbee Channel](../en-eng/Channel_Setting.md) en anglais
* [Group Management](../en-eng/Group-Management.md) en anglais
* [Upgrading device firmware](../en-eng/Device-Firmware-Update.md) en anglais
* [Upgrading Firmware of Zigate](../en-eng/Zigate-flash-firmware.md) en anglais
* [Energy Level Reports](../en-eng/EnergyLevels.md) en anglais
* [Bindings](../en-eng/Binding_Legrand.md) en anglais
* [Network status](../en-eng/Network-Status.md) (_4.1_ beta) en anglais
* [Network Topology - Mesh](../en-eng/Network-Topology---LQI-report.md) (4.1_ beta) en anglais
* [Mettre une authenficiation sur interface d'administration du plugin](../en-eng/DashboardAccessBasicAuth.md) en anglais


## Que faire si un dispositif ne fonctionne pas correctement ?

* [Dealing with not certified devices](../en-eng/Dealing-with-none-certified-device.md) en anglais
* [Debug mode](../en-eng/Plugin-debuging-mode.md) en anglais


## Particularités de certains dispositifs

* [Legrand Netatmo](../en-eng/Legrand-Netatmo-corner.md) en anglais
* [Profalux](../en-eng/Profalux-corner.md) en anglais
* [Schneider Wiser](../en-eng/Schneider_Wiser_Corner.md) en anglais
* [Schneider Wiser: How to Setup](../en-eng/Wiser-Setup.md) en anglais
* [Eurotronics](../en-eng/Eurotronics-corner.md) en anglais
* [Livolo](../en-eng/Livolo-corner.md) en anglais
* [IKEA TRADFRI](../en-eng/IKEA-Tradfri-corner.md) en anglais
* [BlitzWolf](../en-eng/Blitzwolf-corner.md) en anglais


## En cas de problèmes

1. Vérifiez les logs de DomoticZ, il devrait y avoir des informations si quelque chose ne fonctionne pas correctement.
2. Venez en discuter sur les forums :

   * [Le forum français](https://easydomoticz.com/forum/viewforum.php?f=28)
   * [Le forum anglais](https://www.domoticz.com/forum/viewforum.php?f=68)



## Divers

* [Interférences entre Wifi et ZigBee : explications](Info_ZigBee-et-Wifi.md)

* [How to Configure ZiGate in Zigbee Sniffer](../en-eng/Zigate-Sniffer.md)  en anglais
* [A Guide to Wireless range and Repeater](https://support.smartthings.com/hc/en-us/articles/209963206-A-guide-to-wireless-range-and-repeaters) en anglais
* [Pairing devices Aqara/Xiaomi](https://community.hubitat.com/t/xiaomi-aqara-devices-pairing-keeping-them-connected/623) en anglais
* [Cohexistence Xiaomi with other brands](https://community.hubitat.com/t/xiaomi-aqara-devices-pairing-keeping-them-connected/623) en anglais 

