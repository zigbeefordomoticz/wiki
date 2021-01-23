# L'interface Web - La section Réglages

Pour accéder à l'interface d'administration du plugin, voir l'étape 3 [Configuration du plugin](Configuration.md).

__La modification des paramètres peut entrainer des disfonctionnements au niveau de la Zigate. Pensez à faire une sauvegarde avant toute modification.__

La section __Réglage__ comporte les modules :

| Modules  | Modules  | Modules  |
| :------------: |:---------------:|:-----:|
| [Liste des services](#liste-des-services)      | [Réglages de la gestion des dispositifs](#reglages-de-la-gestion-des-dispositifs) | [Réglages Legrand Netatmo](#reglages-legrand) |
| [Réglages des groupes](#reglages-des-groupes)     | [Réglages de la Zigate](#reglages-de-la-zigate)       |   [Réglages Philips](#reglages-philips) |
| [DomoticZ URL](#domoticz-url) | [Réglages de l'environnement du plugin](#reglages-de-lenvironnement-du-plugin)        |    [Réglages Ikea Tradfri](#reglages-ikea-tradfri) |
| [Réglages de l'interface web](#reglages-de-linterface-web) | [Autres réglages](#autres-reglages) | [Réglages Enki Lexman](#reglages-enki-lexman) |
|[Interrogation des dispositifs](#interrogation-des-dispositifs)  |  | [Réglages Schneider Wiser](#reglages-schneider-wiser) |

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

## Réglage de l'interface Web

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


## Réglage de la gestion des dispositifs

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


## Réglage de la Zigate

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




Voir les autres pages de l'[interface Web du plugin](Home.md#linterface-web-du-plugin)
