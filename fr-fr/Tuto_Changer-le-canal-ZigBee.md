# Tutoriel - Changer le canal ZigBee de la Zigate


## Introduction

Ce tutoriel explique comment changer le canal ZigBee du réseau de la Zigate.

Lors de son initialisation, la Zigate va par défaut rechercher le meilleur canal possible en calculant les niveaux d'interférences.

Il est cependant possible de fixer le canal pour :
* Eviter des interférences avec les réseaux Wifi (voir [Interférences entre Wifi et ZigBee : explications](Info_ZigBee-et-Wifi.md)
* Utiliser des dispositifs qui utilisent un canal spécifique :
  * Konke utilise le canal 15
  * Livolo utilise le canal 26
  * Legrand utilise le canal 11

## Méthodes

#### Définition du canal

* Aller dans la section [Réglages > Réglage de la Zigate](WebUI_Reglages.md#r%C3%A9glages-de-la-zigate)
* Activer les paramètres avancés
* Indiquer le canal souhaité

![Settings channel](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Channel_setting.png)

#### Redémarer la Zigate pour appliquer les changements

* Allez dans la section [Admin > Zigate](WebUI_Admin.md#zigate)
* Cliquer sur __Redémarrage logiciel__

![Restart Zigate](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Restart_Zigate.png)


#### Vérifier le canal de la Zigate

* Aller dans [Outils > Outils](WebUI_Outils.md#outils)
* Cliquer sur le bouton __Infos zigate (json)__

![Zigate Infos](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Zigate_Infos.png)

Le canal ZigBee est indiqué en Héxadécimal : 0x0b = 11
