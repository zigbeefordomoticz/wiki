# L'interface Web - La section Réglages

Pour accéder à l'interface d'administration du plugin, voir l'étape 3 [Configuration du plugin](Configuration.md).

__La modification des paramètres peut entrainer des disfonctionnements au niveau de la Zigate. Pensez à faire une sauvegarde avant toute modification.__

La section __Réglage__ comporte les modules :

| Modules  | Modules  | Modules  |
| :------------: |:---------------:|:-----:|
| [Liste des services](#liste-des-services)      | [Réglages de la gestion des dispositifs](#r%C3%A9glages-de-la-gestion-des-dispositifs) | [Réglages Legrand Netatmo](#r%C3%A9glages-legrand-netatmo) |
| [Réglages des groupes](#r%C3%A9glages-des-groupes)     | [Réglages de la Zigate](#r%C3%A9glages-de-la-zigate)       |   [Réglages Philips](#r%C3%A9glages-legrand-philips) |
| [DomoticZ URL](#domoticz-url) | [Réglages de l'environnement du plugin](#r%C3%A9glages-de-lenvironnement-du-plugin)        |    [Réglages Ikea Tradfri](#r%C3%A9glages-legrand-ikea-tradfri) |
| [Réglages de l'interface web](#r%C3%A9glages-de-linterface-web) | [Autres réglages](#autres-r%C3%A9glages) | [Réglages Enki Lexman](#r%C3%A9glages-enki-lexman) |
|[Interrogation des dispositifs](#interrogation-des-dispositifs)  | [Transition lumières](#r%C3%A9glages-command-transitions-for-lights) | [Réglages Schneider Wiser](#r%C3%A9glages-schneider-wiser) |

*La disposition dans ce tableau ne correspond pas forcément à la disposition sur la page du plugin.*

Un bouton __Paramètres avancés__ situé en haut à droite permet d'afficher des paramètres avancés.

Voici la page __Réglages__ de l'interface Web du plugin : 

![FR_WebIU-Reglages]()
*Cette page est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

## Liste des services

![FR_WebIU-Reglages-Liste-des-services]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __Activer les Groupes :__ Active l'utilisation des groupes dans le plugin Zigate (Désactivé par défaut)
* __Activer interrogation des dispositifs :__ Active la fonction Pooling (Désactivé par défaut)
* __Autoriser accès Internet :__ Autorise le plugin à ce connecter au web pour récupérer les informations de mise à jour (Activé par défaut)
* __Active l'interface Web :__ Active l'interface Web (Activé par défaut) *La désactivation bloquera l'accès à cette page !!!*
* __pingDevices :__ Active le fonction ping sur tous les dispositifs  (Activé par défaut)


### Les paramètres avancés

Pas de paramètres avancés dans ce module.

## Réglages des groupes

![FR_WebIU-Reglages-des-groupes]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __Groupe est Allumé si un equipement Allumé :__ Désactivé, le groupe sera à ON si tous les dispositifs sont allumés.(Activé par défaut)
* __forceGroupDeviceRefresh :__ Rafraichi tous les device d'un groupe après une commande envoyée au groupe (Activé par défaut)
* __reComputeGroupState :__ Rafraichi les états des groupes régulièremement en fonction des états des dispositifs du groupe (Activé par défaut)
* __Active l'interface Web :__ Active l'interface Web (Activé par défaut) *La désactivation bloquera l'accès à cette page !!!*
* __pingDevices :__ ??? (Activé par défaut)


### Les paramètres avancés

Pas de paramètres avancés dans ce module.

## DomoticZ URL

![FR_WebIU-Reglages-DomoticZ-URL]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __Port :__ Port de DomoticZ pour l'envoi de requêtes API (8080 par défaut)

### Les paramètres avancés

Pas de paramètres avancés dans ce module.



## Réglages de l'interface Web

![FR_WebIU-Reglages-de-linterface-web]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __Lang :__ Langue par défaut de l'interface web du plugin (fr-FR, en-US, nl-NL, es-ES)

### Les paramètres avancés

Ces paramètres vont modifier le fonctionnement interne du plugin. __Il est recommandé de ne pas les modifier__.

* __enableGzip :__ Active la compression gzip (Activé par défaut)
* __enableDeflate:__ Active la comrpession Deflate (Activé par défaut)
* __enableChunk :__ Active les gros fichiers (Activé par défaut)
* __enableKeepalive :__ Active le maintien de la  session active (Activé par défaut)
* __enableCache :__ Active la mise en cache (Activé par défaut)



## Interrogation des dispositifs

* La fonction [Activer interrogation des dispositifs]() doit être activée. 

Il n'est pas recommandé d'activer cette fonction d'interrogation (pooling en anglais) car elle va augmenter la charge sur la Zigate et sur le réseau. Les valeurs sont indiquées en secondes. Réduire le délai vaaugmenter la fréquence d'interrogation pouvant entrainer un ralentissement du réseau jusqu'à la perte de commandes.


![FR_WebIU-Reglages-Interrogation-dispositifs]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

Pas de paramètres simple dans ce module.

### Les paramètres avancés

* __pingDevicesFeq :__ Fréquence d'interrogation de tous les dispositifs (3600  par défaut en secondes)
* __pollingPhilips :__ Les équipements Philips ne renvoient pas automatiquement leur status. Il faut donc activer le polling afin d'avoir un retour d'état. (0 par défaut, 300 ou au-dessus recommandé en secondes)
* __pollingGledopto :__ Les équipements Gledopto ne renvoient pas automatiquement leur status. Il faut donc activer le polling afin d'avoir un retour d'état. (0 par défaut, 300 ou au-dessus recommandé en secondes)
* __pollingSchneider :__ Les équipements Schneider ne renvoient pas automatiquement leur status. Il faut donc activer le polling afin d'avoir un retour d'état. (0 par défaut, 300 recommandé en secondes)
* __pollingBlitzwolfPower :__ Les équipements BlitzWolfo ne renvoient pas automatiquement leur status. Il faut donc activer le polling afin d'avoir un retour d'état. (0 par défaut, 300 recommandé en secondes)
* __pollingCasaiaAC201 :__ ??? (0 par défaut en secondes)
* __pollingONOFF :__ Récupération de l'état On/Off toutes les 15 minutes (990 par défaut)
* __pollingLvlControl :__ Récupération du niveau toutes les 15 minutes (990 par défaut)
* __polling0102 :__ Récupération de l'état des volets roulants (990 par défaut)
* __polling0201 :__ Thermostat (990 par défaut)
* __polling0202 :__ ??? (990 par défaut)
* __polling0702 :__ ??? (990 par défaut)
* __polling0b04 :__ Récupération de l'état des mesures électrique (990 par défaut)
* __polling0b05 :__ ??? (990 par défaut)


## Réglages de la gestion des dispositifs

![FR_WebIU-Reglages-de-la-gestion-des-dispositifs]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __resetMotiondelay :__ Délai avant de remettre à Off l'état de déplacement. Il est possible d'utiliser celui du Widget DomoticZ (30 par défaut en secondes)
* __Nombre de sec avant de basculer le Selecteur Off :__ ??? (0 par défaut)
* __Workaround Domoticz issue #4143 :__ ??? (Désactivé par défaut)

### Les paramètres avancés

* __Interogation du statut du device après un ordre :__ Active une mise à jour de l'état après l'envoi une commande (Activé par défaut)
* __forcePassiveWidget :__ Autorise DomoticZ à envoyer une commande malgrè que le dispositif terminal ne puisse pas recevoir de commande. Par exemple : les dispositifs Xiaomi sur batterie (Désactivé par défaut)
* __resetConfigureReporting :__ Active un reset de l'information de configuration de suivi (Désactivé par défaut)
* __reenforceConfigureReporting :__ ??? (Désactivé par défaut)
* __resetReadAttributes :__ Active un reset des informations de polling (Désactivé par défaut)
* __allowGroupMembership :__ Autorise le plugin à créer automatiquement un groupe si le dispositif est reconnu. Par exemple Legrand (Activé par défaut)
* __doUnbindBind :__ Active une déconnexion avant la connexion d'un cluster (Désactivé par défaut)
* __allowReBindingClusters :__ Autorise la reconnexion du cluster si le dispositif est de retour (Activé par défaut)


## Réglages de la Zigate

![FR_WebIU-Reglages-de-la-Zigate]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __Active ou désactive la Led Bleu :__ Gestion de la LED sur la Zigate (Activé par défaut)
* __Certification :__ ??? (CE regulation par défaut ou FCC regulation)
* __Channel :__ Choix du canal ZigBee (Défaut par défaut)

### Les paramètres avancés

* __Creation du Group 0000 :__ ??? (Désactivé par défaut)
* __Suppression dans la ZiGate :__ Supprime le dispositif dans la Zigate en même temps que la suppression dans DomoticZ (Désactivé par défaut)
* __Reset permit to join at startup :__ Active un appairage au démarrage du plugin  (Activé par défaut)
* __Activer le Ping :__ Active un ping de la Zigate toute les 4 minutes afin de vérifier la connexion (Activé par défaut)
* __breakConfigureReporting :__ ??? (Désactivé par défaut)
* __TXpower_set :__ Attenuation de la puissance (0dbM par défaut, 1: -9 dBM, 2: -20dBM, 3: -32dBM)
* __extendedPANID :__ Force le Extended PAN Id. Necessite un Erase PDM complet!! (0 par défaut)
* __showTimeOutMsg :__ Affiche un message de délai dépassé (Désactivé par défaut)

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
* __alarmDuration :__ Durée de l'alarme (1 par défaut en seconde)
* __numTopologyReports :__ Nombre de rapport de topologie à conserver (4 par défaut)
* __numEnergyReports :__ Nombre de rapport d'interférences à conserver (4 par défaut)
* __TradfriKelvinStep :__ ??? (51 par défaut)
* __vibrationAqarasensitivity :__ Sensibilité du capteur de vibration Aqara (medium par défaut, low, high)

### Les paramètres avancés

* __AqaraOppleBulbMode :__ ??? (Désactivé par défaut)

## Réglages Legrand Netatmo

Permet d'activer des modes spécifiques aux equipements Legrand Netatmo

![FR_WebIU-Reglages-Legrand-Netatmo]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __EnableLedIfOn :__ Allume la LED si le dispositif est allumé (Activé par défaut)
* __EnableLedInDark :__ Allume la LED dans le noir (Désactivé par défaut)
* __EnableLedShutter :__ ??? (Désactivé par défaut)
* __EnableDimmer :__ Active le variateur (Désactivé par défaut)
* __InvertShutter :__ Inverse le sens des volets (Activé par défaut)
* __EnableReleaseButton :__ ??? (Désactivé par défaut)
* __LegrandPowerOnAfterOffOn :__ ??? (On par défaut)


### Les paramètres avancés

Pas de paramètres avancés dans ce module.

## Réglages Legrand Philips

Permet d'activer des modes spécifiques aux equipements Philips

![FR_WebIU-Reglages-Philips]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __PhilipsPowerOnAfterOffOn :__ ??? (On par défaut)

### Les paramètres avancés

Pas de paramètres avancés dans ce module.

## Réglages Legrand Ikea Tradfri

Permet d'activer des modes spécifiques aux equipements Ikea Tradfri

![FR_WebIU-Reglages-Ikea-Tradfri]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __IkeaPowerOnAfterOffOn :__ ??? (On par défaut)

### Les paramètres avancés

Pas de paramètres avancés dans ce module.

## Réglages Enki Lexman

Permet d'activer des modes spécifiques aux equipements Enki Lexman

![FR_WebIU-Reglages-Enki-Lexman]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __EnkiPowerOnAfterOffOn :__ ??? (On par défaut)

### Les paramètres avancés

Pas de paramètres avancés dans ce module.


## Réglages Schneider Wiser

Permet d'activer des modes spécifiques aux equipements Schneider Wiser

![FR_WebIU-Reglages-Schneider-Wiser]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

* __enableSchneiderWiser :__ Active l'appairage de dispositifs Schneider Wiser (Désactivé par défaut)

### Les paramètres avancés

* __reenforcementWiser :__ ??? (300 par défaut)
* __forceWiserRegistration :__ ??? (Désactivé par défaut)


## Réglages Command transitions for Lights

Permet d'activer des transitions graduelles entre l'état actuel et l'état demandé. Applicable pour les lumières et les groupes.

![FR_WebIU-Reglages-Transition-lumieres]()
*Ce module est suceptible d'avoir évoluer depuis l'écriture de cette documentation.*

### Les paramètres

Pas de paramètres simple dans ce module.

### Les paramètres avancés

* __Transition pour Hue :__ Transition   (0 par défaut en dixième de seconde)
* __Transition pour Température :__ Transition pour un changement de température de couleur (0 par défaut en dixième de seconde)
* __Transition pour Couleur RVB :__ Transition pour un changement de couleur (0 par défaut en dixième de seconde)
* __Transition pour variateur :__ Transistion pour un changement d'intensité (0 par défaut en dixième de seconde)



Voir les autres pages de l'[interface Web du plugin](Home.md#linterface-web-du-plugin)
