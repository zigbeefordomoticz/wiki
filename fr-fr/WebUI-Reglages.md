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

![FR_WebIU-Reglages](../Images/FR_WebUI-Reglage.png)
*Cette page est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

------------------------------------------------
## Liste des services

### Les paramètres

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| Activer les Groupes | | Désactivé | | Active l'utilisation des groupes dans le plugin Zigate |
| Activer interrogation des dispositifs | | Désactivé | | Active la fonction Polling |
| Autoriser accès Internet | | Activé | | Autorise le plugin a ce connecté au web pour récupérer les informations de mise à jour|
| Active l'interface Web | | Activé | | Active l'interface Web *La désactivation bloquera l'accès à cette page !!!|
| pingDevices | | Activé | | Active le fonction ping sur tous les dispositifs |


### Les paramètres avancés

Pas de paramètres avancés dans ce module.


------------------------------------------------
## Réglages des groupes

### Les paramètres

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| Groupe est Allumé si un equipement Allumé | | Activé | | Désactivé, le groupe sera à ON si tous les dispositifs sont allumés |
| forceGroupDeviceRefresh | | Activé | | Rafraichi tous les dispositifs d'un groupe après une commande envoyée au groupe |
| reComputeGroupState | | Activé | | Rafraichi les états des groupes régulièrement en fonction des états des dispositifs du groupe |
| Active l'interface Web | | Activé | | Active l'interface Web *La désactivation bloquera l'accès à cette page !!!* |
| pingDevices | | Activé | | ??? |


### Les paramètres avancés

Pas de paramètres avancés dans ce module.


------------------------------------------------
## DomoticZ URL

### Les paramètres

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| Port | | 8080 | | Port de DomoticZ pour l'envoi de requêtes API |

### Les paramètres avancés

Pas de paramètres avancés dans ce module.


------------------------------------------------
## Réglages de l'interface Web

### Les paramètres

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| Lang | | fr-FR | fr-FR, en-US, nl-NL, es-ES| Langue par défaut de l'interface web du plugin |

### Les paramètres avancés

Ces paramètres vont modifier le fonctionnement interne du plugin. __Il est recommandé de ne pas les modifier__.

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| enableGzip | | Activé | | Active la compression gzip |
| enableDeflate | | Activé | | Active la compression Deflate |
| enableChunk | | Activé | | Active les gros fichiers |
| enableKeepalive | | Activé | | Active le maintien de la  session active (|
| enableCache | | Activé | | Active la mise en cache |


------------------------------------------------
## Interrogation des dispositifs

* La fonction [Activer interrogation des dispositifs]() doit être activée. 

Il n'est pas recommandé d'activer cette fonction d'interrogation (polling en anglais) car elle va augmenter la charge sur la Zigate et sur le réseau. Les valeurs sont indiquées en secondes. Réduire le délai va augmenter la fréquence d'interrogation pouvant entrainer un ralentissement du réseau jusqu'à la perte de commandes.

### Les paramètres

Pas de paramètre simple dans ce module.

### Les paramètres avancés

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| pingDevicesFeq | seconde | 3600 | | Fréquence d'interrogation de tous les dispositifs |
| pollingPhilips | seconde | 0 | | Les équipements Philips ne renvoient pas automatiquement leur statuts. Il faut donc activer le polling afin d'avoir un retour d'état. (300 ou au-dessus recommandé) |
| pollingGledopto | seconde | 0 | | Les équipements Gledopto ne renvoient pas automatiquement leur statuts. Il faut donc activer le polling afin d'avoir un retour d'état. (300 ou au-dessus recommandé) |
| pollingSchneider | seconde | 0 | | Les équipements Schneider ne renvoient pas automatiquement leur statuts. Il faut donc activer le polling afin d'avoir un retour d'état. (300 ou au-dessus recommandé) |
| pollingBlitzwolfPower | seconde | 0 | | Les équipements BlitzWolf ne renvoient pas automatiquement leur statuts. Il faut donc activer le polling afin d'avoir un retour d'état. (300 ou au-dessus recommandé) |
| pollingCasaiaAC201 | seconde | 0 | | ??? |
| pollingONOFF | seconde | 990 | | Récupération de l'état On/Off toutes les 15 minutes |
| pollingLvlControl | seconde | 990 | | Récupération du niveau toutes les 15 minutes |
| polling0102 | seconde | 990 | | Récupération de l'état des volets roulants |
| polling0201 | seconde | 990 | | Thermostat |
| polling0202 | seconde | 990 | | ??? |
| polling0702 | seconde | 990 | | ??? |
| polling0b04 | seconde | 990 | | Récupération de l'état des mesures électrique |
| polling0b05 | seconde | 990 | | ??? |


------------------------------------------------
## Réglages de la gestion des dispositifs

### Les paramètres

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| resetMotiondelay | seconde | 30 | | Délai avant de remettre à Off l'état de déplacement. Il est possible d'utiliser celui du Widget DomoticZ |
| Nombre de sec avant de basculer le Selecteur Off | | 0 | | ??? |
| Workaround Domoticz issue #4143 | | Désactivé | | ??? |

### Les paramètres avancés

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| Interogation du statut du device après un ordre | | Activé | | Active une mise à jour de l'état après l'envoi une commande |
| forcePassiveWidget | | Désactivé | | Autorise DomoticZ à envoyer une commande malgré que le dispositif terminal ne puisse pas recevoir de commande. Par exemple : les dispositifs Xiaomi sur batterie |
| resetConfigureReporting | | Désactivé | | Active un reset de l'information de configuration de suivi |
| reenforceConfigureReporting | | Désactivé | | ??? |
| resetReadAttributes | | Désactivé | | Active un reset des informations de polling |
| allowGroupMembership | | Activé | | Autorise le plugin à créer automatiquement un groupe si le dispositif est reconnu. Par exemple Legrand |
| doUnbindBind | | Désactivé | | Active une déconnexion avant la connexion d'un cluster (Désactivé par défaut)
| allowReBindingClusters | | Activé | | Autorise la reconnexion du cluster si le dispositif est de retour |


------------------------------------------------
## Réglages de la Zigate

### Les paramètres

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| Active ou désactive la Led Bleu | | Activé | | Gestion de la LED sur la Zigate |
| Certification | | CE regulation | CE regulation, FCC regulation | ???  |
| Channel | | Désactivé | | Choix du canal ZigBee |

### Les paramètres avancés

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| Creation du Group 0000 | | Désactivé | | ??? |
| Suppression dans la ZiGate | | Désactivé | | Supprime le dispositif dans la Zigate en même temps que la suppression dans DomoticZ |
| Reset permit to join at startup | | Activé | | Active un appairage au démarrage du plugin  |
| Activer le Ping | | Activé | | Active un ping de la Zigate toute les 4 minutes afin de vérifier la connexion |
| breakConfigureReporting | | Désactivé | | ??? |
| TXpower_set | dbM| 0 | 0, -9, -20, -32| Attenuation de la puissance |
| extendedPANID | | 0 | | Force le Extended PAN Id. Nécessite un Erase PDM complet!! |
| showTimeOutMsg | | Désactivé | | Affiche un message de délai dépassé |


------------------------------------------------
## Réglages de l'environnement du plugin

### Les paramètres

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| Nombre d'historique du fichier DeviceList | | 12 |  | ??? |

### Les paramètres avancés

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| pluginData | | `/home/pi/domoticz/plugins/Domoticz-Zigate/Data/` pasur Raspbian | | Répertoire contenant les données du plugin |
| pluginConfig | | `/home/pi/domoticz/plugins/Domoticz-Zigate/Conf/` sur Raspbian | | Répertoire contenant la configuration du plugin |
| pluginOTAFirmware | | `/home/pi/domoticz/plugins/Domoticz-Zigate/OTAFirmware/` sur Raspbian | | Répertoire contenant les rapports du plugin |
| pluginReports | | `/home/pi/domoticz/plugins/Domoticz-Zigate/Reports/` sur Raspbian | | Répertoire contenant les données du plugin |
| pluginWWW | | `/home/pi/domoticz/plugins/Domoticz-Zigate/www/` sur Raspbian | | Répertoire contenant l'interface web du plugin |
| pluginLogs | | `/home/pi/domoticz/plugins/Domoticz-Zigate/Logs/` sur Raspbian | | Répertoire contenant les log du plugin |


------------------------------------------------
## Réglages Command transitions for Lights

Permet d'activer des transitions graduelles entre l'état actuel et l'état demandé. Applicable pour les lumières et les groupes.

### Les paramètres

Pas de paramètre simple dans ce module.

### Les paramètres avancés

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| Transition pour Hue | dixième de seconde | 0 | | Transition  |
| Transition pour Température | dixième de seconde | 0 | | Transition pour un changement de température de couleur |
| Transition pour Couleur RVB | dixième de seconde | 0 | | Transition pour un changement de couleur |
| Transition pour variateur | dixième de seconde | 0 | | Transition pour un changement d'intensité |


------------------------------------------------
## Autres réglages

### Les paramètres

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| Livolo | | Désactivé | | ??? |
| profaluxOrientBSO | | 45 | | ??? |
| alarmDuration | seconde | 1 | | Durée de l'alarme |
| numTopologyReports | | 4 | | Nombre de rapport de topologie à conserver |
| numEnergyReports | | 4 | | Nombre de rapport d'interférences à conserver |
| TradfriKelvinStep | | 51 | | ??? |
| vibrationAqarasensitivity | | Medium | Low, Medium, High| Sensibilité du capteur de vibration Aqara (|

### Les paramètres avancés

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| AqaraOppleBulbMode | | Désactivé | | ??? |


------------------------------------------------
## Réglages Legrand Netatmo

Permet d'activer des modes spécifiques aux équipements Legrand Netatmo

### Les paramètres

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| EnableLedIfOn | | Activé | | Allume la LED si le dispositif est allumé |
| EnableLedInDark | | Désactivé | | Allume la LED dans le noir |
| EnableLedShutter | | Désactivé | | ??? |
| EnableDimmer | | Désactivé | | Active le variateur |
| InvertShutter | | Activé | | Inverse le sens des volets |
| EnableReleaseButton | | Désactivé | | ??? |
| LegrandPowerOnAfterOffOn | | On | | ??? |


### Les paramètres avancés

Pas de paramètres avancés dans ce module.


------------------------------------------------
## Réglages Legrand Philips

Permet d'activer des modes spécifiques aux équipements Philips

### Les paramètres

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| PhilipsPowerOnAfterOffOn | | On | | ??? |

### Les paramètres avancés

Pas de paramètres avancés dans ce module.


------------------------------------------------
## Réglages Legrand Ikea Tradfri

Permet d'activer des modes spécifiques aux équipements Ikea Tradfri

### Les paramètres

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| IkeaPowerOnAfterOffOn | | On | | ??? |

### Les paramètres avancés

Pas de paramètres avancés dans ce module.


------------------------------------------------
## Réglages Enki Lexman

Permet d'activer des modes spécifiques aux équipements Enki Lexman

### Les paramètres

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| EnkiPowerOnAfterOffOn | | On | | ??? |

### Les paramètres avancés

Pas de paramètres avancés dans ce module.


------------------------------------------------
## Réglages Schneider Wiser

Permet d'activer des modes spécifiques aux équipements Schneider Wiser

### Les paramètres

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| enableSchneiderWiser | | Désactivé | | Active l'appairage de dispositifs Schneider Wiser |

### Les paramètres avancés

| Paramètre | Unité | Valeur par défaut | Valeurs possibles | Description |
| --------- | ----- | ----------------- | ----------------- | ----------- |
| reenforcementWiser | | 300 | | ??? |
| forceWiserRegistration | | Désactivé | | ??? |



------------------------------------------------
Voir les autres pages de l'[interface Web du plugin](Home.md#linterface-web-du-plugin)
