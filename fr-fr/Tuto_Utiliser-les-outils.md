<a href="Home.md"><img align="left" width="80" height="80" src="../Images/zigbee4domoticz-logo.png" alt="Logo"></a>

# Tutoriel - Utiliser les outils

</br>


## Introduction

Ce tutoriel explique comment utiliser les outils du plugin.

## Présentation

Le plugin dispose d'une section regroupant les outils du plugin :  [Outils > Outils](WebUI_Outils.md#outils)


## Liste des outils

| Outils  | Outils   | Outils   | Outils   |
| :-----: |:-------:|:-------:|:-------:|
| [Plugin infos (json)](#plugin-infos-json) | [ZiGate infos (json)](#zigate-infos-json) | [Liste des dispositifs DomoticZ (json)](#liste-des-dispositifs-domoticz-json) | [Liste des objets (json)](#liste-des-%objets-json) |
| [Liste des groupes (json)](#liste-des-groupes-json) | [Liste des objets raw (json)](#liste-des-objets-raw-json) | [Santé plugin (json)](#sant%C3%A9-plugin-json) | [zGroup-1st-devices (json)](#zgroup-1st-devices-json) |
| [Paramètres (json)](#param%C3%A8tres-json) | [Trafic (json)](#trafic-json) | [Liste des objets (json)](#liste-des-objets-json) | [Paramètres DomoticZ (json)](#param%C3%A8tres-domoticz-json) |


### Plugin infos (json)

Cet outil donne toutes les informations sur les paramètres DomoticZ du plugin.

Usage : Développement
API REST : plugin

### ZiGate infos (json)

Cet outil donne toutes les informations sur la ZiGate.

Usage : Débogage
API REST : zigate

### Liste des dispositifs DomoticZ (json)

Cet outil liste tous les dispositifs dans DomoticZ qui sont liés au plugin ZigBeeForDomoticZ.

Usage : Développement
API REST : device

### Liste des objets (json)

Cet outil liste tous les objets appairés à la ZiGate et indique leurs paramètres.

Usage : Développement
API REST : zdevice

### Liste des groupes (json)

Cet outil liste les groupes créé dans le plugin ZigBeeForDomoticZ.

Usage : Débogage
API REST : zgroup

### Liste des objets raw (json)

Cet outil liste tous les objets appairés à la ZiGate et indique leurs paramètres en mémoire

Usage : Débogage
API REST : zdevice-raw

### Santé plugin (json)

Cet outil donne les informations sur le fonctionnement du plugin.

Usage : Débogage
API REST : plugin-health

### zGroup-1st-devices (json)

Cet outil liste les objets pouvant être intégrer dans un groupe (généralement les routeurs).

Usage : Développement
API REST : zgroup-list-available-device

### Paramètres (json)

Cet outil liste touts les paramètres du plugin avec leurs valeurs.

Usage : Développement
API REST : settings

### Trafic (json)

Cet outil donne toutes les statistiques de la ZiGate.

Usage : Débogage
API REST : plugin-stat

### Liste des objets (json)

Cet outil liste tous les objets. ???

### Paramètres DomoticZ (json)

Cet outil affiche les paramètres pour accéder à l'API de DomoticZ.

Usage : Développement
API REST : domoticz-env


## L'API REST

Il est possible d'accéder aux données de ces outils sans passer par l'interface d'administration du plugin.

* Ouvrir dans votre navigateur *IP_DomoticZ:Port_Plugin-ZiGate/rest-zigate/1/__API REST__* en remplaçant API REST par celui voulu.

Exemple : http://127.0.0.1:9440/rest-zigate/1/plugin
