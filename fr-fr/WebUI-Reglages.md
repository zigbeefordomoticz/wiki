# L'interface Web - La section Réglages

Pour accéder à l'interface d'administration du plugin, voir l'étape 3 [Configuration du plugin](Configuration.md).

__La modification des paramètres peut entrainer des disfonctionnements au niveau de la Zigate. Pensez à faire une sauvegarde avant toute modification.__

La section __Réglage__ comporte les modules :

| Modules  | Modules  | Modules  |
| :------------: |:---------------:|:-----:|
| [Liste des services](#liste-des-services)      | [Réglages de la gestion des dispositifs](#r%C3%A9glages-de-la-gestion-des-dispositifs) | [Réglages Legrand Netatmo](#r%C3%A9glages-legrand-netatmo) |
| [Réglages des groupes](#r%C3%A9glages-des-groupes)     | [Réglages de la Zigate](#r%C3%A9glages-de-la-zigate)       |   [Réglages Philips](#r%C3%A9glages-philips) |
| [DomoticZ URL](#domoticz-url) | [Réglages de l'environnement du plugin](#r%C3%A9glages-de-lenvironnement-du-plugin)        |    [Réglages Ikea Tradfri](#r%C3%A9glages-legrand-ikea-tradfri) |
| [Réglages de l'interface web](#r%C3%A9glages-de-linterface-web) | [Autres réglages](#autres-r%C3%A9glages) | [Réglages Enki Lexman](#r%C3%A9glages-enki-lexman) |
|[Interrogation des dispositifs](#interrogation-des-dispositifs)  | [Transition lumières](#r%C3%A9glages-command-transitions-for-lights) | [Réglages Schneider Wiser](#reglages-schneider-wiser) |

*La disposition dans ce tableau ne correspond pas forcément à la disposition sur la page du plugin.*

Un bouton __Paramètres avancés__ situé en haut à droite permet d'afficher des paramètres avancés.

Voici la page __Réglages__ de l'interface Web du plugin : 

![FR_WebIU-Reglages]()
*Cette page est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

## Liste des services

![FR_WebIU-Reglages-Liste-des-services]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __Activer les Groupes :__ Permet d'activer l'utilisation des groupes dans le plugin Zigate (Désactivé par défaut)
* __Activer interrogation des dispositifs :__ ??? (Désactivé par défaut)
* __Autoriser accès Internet :__ Autorise le plugin à ce connecter au web pour récupérer les informations de mise à jour (Activé par défaut)
* __Active l'interface Web :__ Active l'interface Web (Activé par défaut) *La désactivation bloquera l'accès à cette page !!!*
* __pingDevices :__ ??? (Activé par défaut)


### Les paramètres avancés

Pas de paramètres avancés dans ce module.

## Réglages des groupes

![FR_WebIU-Reglages-des-groupes]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __Groupe est Allumé si un equipement Allumé :__ (Sinon, tous les équipements doivent etre Allumés) (Activé par défaut)
* __forceGroupDeviceRefresh :__ ??? (Activé par défaut)
* __reComputeGroupState :__ ??? (Activé par défaut)
* __Active l'interface Web :__ Active l'interface Web (Activé par défaut) *La désactivation bloquera l'accès à cette page !!!*
* __pingDevices :__ ??? (Activé par défaut)


### Les paramètres avancés

Pas de paramètres avancés dans ce module.

## DomoticZ URL

![FR_WebIU-Reglages-DomoticZ-URL]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __Port :__ Port de l'interface web de DomoticZ (8080 par défaut)

### Les paramètres avancés

Pas de paramètres avancés dans ce module.

## Réglages de l'interface Web

![FR_WebIU-Reglages-de-linterface-web]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __Lang :__ Langue par défaut de l'interface web du plugin (fr-FR, en-US, nl-NL, es-ES)

### Les paramètres avancés

* __enableGzip :__ ??? (Activé par défaut)
* __enableDeflate:__ ??? (Activé par défaut)
* __enableChunk :__ ??? (Activé par défaut)
* __enableKeepalive :__ ??? (Activé par défaut)
* __enableCache :__ ??? (Activé par défaut)


## Interrogation des dispositifs

![FR_WebIU-Reglages-Interrogation-dispositifs]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

Pas de paramètres simple dans ce module.

### Les paramètres avancés

* __pingDevicesFeq :__ ??? (360 par défaut)
* __pollingPhilips :__ ??? (0 par défaut)
* __pollingGledopto :__ ??? (0é par défaut)
* __pollingSchneider :__ ??? (0 par défaut)
* __pollingBlitzwolfPower :__ ??? (0 par défaut)
* __pollingCasaiaAC201 :__ ??? (0 par défaut)
* __pollingONOFF :__ ??? (990 par défaut)
* __pollingLvlControl :__ ??? (990 par défaut)
* __polling0102 :__ ??? (990 par défaut)
* __polling0201 :__ ??? (990 par défaut)
* __polling0202 :__ ??? (990 par défaut)
* __polling0702 :__ ??? (990 par défaut)
* __polling0b04 :__ ??? (990 par défaut)
* __polling0b05 :__ ??? (990 par défaut)


## Réglages de la gestion des dispositifs

![FR_WebIU-Reglages-de-la-gestion-des-dispositifs]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __resetMotiondelay :__ ??? (30 par défaut)
* __Nombre de sec avant de basculer le Selecteur Off :__ ??? (0 par défaut)
* __Workaround Domoticz issue #4143 :__ ??? (Désactivé par défaut)

### Les paramètres avancés

* __Interogation du statut du device après un ordre :__ ??? (Activé par défaut)
* __forcePassiveWidget :__ ??? (Désactivé par défaut)
* __resetConfigureReporting :__ ??? (Désactivé par défaut)
* __reenforceConfigureReporting :__ ??? (Désactivé par défaut)
* __resetReadAttributes :__ ??? (Désactivé par défaut)
* __allowGroupMembership :__ ??? (Activé par défaut)
* __doUnbindBind :__ ??? (Désactivé par défaut)
* __allowReBindingClusters :__ ??? (Activé par défaut)


## Réglages de la Zigate

![FR_WebIU-Reglages-de-la-Zigate]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __Active ou désactive la Led Bleu :__ Gestion de la LED sur la Zigate (Activé par défaut)
* __Certification :__ ??? (CE regulation par défaut ou FCC regulation)
* __Channel :__ Choix du canal ZigBee (Défaut par défaut)

### Les paramètres avancés

* __Creation du Group 0000 :__ ??? (Désactivé par défaut)
* __Suppression dans la ZiGate :__ ??? (Désactivé par défaut)
* __Reset permit to join at startup :__ ??? (Désactivé par défaut)
* __Activer le Ping :__ ??? (Activé par défaut)
* __breakConfigureReporting :__ ??? (Désactivé par défaut)
* __TXpower_set :__ ??? (0dbM par défaut)
* __extendedPANID :__ ??? (0 par défaut)
* __showTimeOutMsg :__ ??? (Désactivé par défaut)

## Réglages de l'environnement du plugin

![FR_WebIU-Reglages-de-lenvironnement-du-plugin]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __Nombre d'historique du fichier DeviceList :__ ??? (12 par défaut)

### Les paramètres avancés

* __pluginData :__ Répertoire contenant les données du plugin (`/home/pi/domoticz/plugins/Domoticz-Zigate/Data/` par défaut sur Raspbian)
* __pluginConfig :__ Répertoire contenant la configuration du plugin (`/home/pi/domoticz/plugins/Domoticz-Zigate/Conf/` par défaut sur Raspbian)
* __pluginOTAFirmware :__ Répertoire contenant les rapports du plugin (`/home/pi/domoticz/plugins/Domoticz-Zigate/OTAFirmware/` par défaut sur Raspbian)
* __pluginReports :__ Répertoire contenant les données du plugin (`/home/pi/domoticz/plugins/Domoticz-Zigate/Reports/` par défaut sur Raspbian)
* __pluginWWW :__ Répertoire contenant l'interface web du plugin (`/home/pi/domoticz/plugins/Domoticz-Zigate/www/` par défaut sur Raspbian)
* __pluginLogs :__ Répertoire contenant les log du plugin (`/home/pi/domoticz/plugins/Domoticz-Zigate/Logs/` par défaut sur Raspbian)



## Autres réglages

![FR_WebIU-Reglages-Autre]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __Livolo :__ ??? (Désactivé par défaut)
* __profaluxOrientBSO :__ ??? (45 par défaut)
* __alarmDuration :__ ??? (1 par défaut)
* __numTopologyReports :__ ??? (4 par défaut)
* __numEnergyReports :__ ??? (4 par défaut)
* __TradfriKelvinStep :__ ??? (51 par défaut)
* __vibrationAqarasensitivity :__ ??? (medium par défaut)

### Les paramètres avancés

* __AqaraOppleBulbMode :__ ??? (Désactivé par défaut)

## Réglages Legrand Netatmo

Permet d'activer des modes spécifiques aux equipements Legrand Netatmo

![FR_WebIU-Reglages-Legrand-Netatmo]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __EnableLedIfOn :__ ??? (Activé par défaut)
* __EnableLedInDark :__ ??? (Désactivé par défaut)
* __EnableLedShutter :__ ??? (Désactivé par défaut)
* __EnableDimmer :__ ??? (Désactivé par défaut)
* __InvertShutter :__ ??? (Activé par défaut)
* __EnableReleaseButton :__ ??? (Désactivé par défaut)
* __LegrandPowerOnAfterOffOn :__ ??? (On par défaut)


### Les paramètres avancés

Pas de paramètres avancés dans ce module.

## Réglages Legrand Philips

Permet d'activer des modes spécifiques aux equipements Legrand Netatmo

![FR_WebIU-Reglages-Philips]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __PhilipsPowerOnAfterOffOn :__ ??? (On par défaut)

### Les paramètres avancés

Pas de paramètres avancés dans ce module.

## Réglages Legrand Ikea Tradfri

Permet d'activer des modes spécifiques aux equipements Legrand Netatmo

![FR_WebIU-Reglages-Ikea-Tradfri]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __IkeaPowerOnAfterOffOn :__ ??? (On par défaut)

### Les paramètres avancés

Pas de paramètres avancés dans ce module.

## Réglages Enki Lexman

Permet d'activer des modes spécifiques aux equipements Legrand Netatmo

![FR_WebIU-Reglages-Enki-Lexman]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __EnkiPowerOnAfterOffOn :__ ??? (On par défaut)

### Les paramètres avancés

Pas de paramètres avancés dans ce module.


## Réglages Command transitions for Lights


Permet d'activer des modes spécifiques aux equipements Legrand Netatmo

![FR_WebIU-Reglages-Transition-lumieres]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

Pas de paramètres simple dans ce module.

### Les paramètres avancés

* __Transition pour Hue :__ ??? (0 par défaut)
* __Transition pour Température :__ ??? (0 par défaut)
* __Transition pour Couleur RVB :__ ??? (0 par défaut)
* __Transition pour variateur :__ ??? (0 par défaut)

Voir les autres pages de l'[interface Web du plugin](Home.md#linterface-web-du-plugin)
