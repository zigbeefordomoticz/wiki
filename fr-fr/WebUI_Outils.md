# L'interface Web - La section Outils

Pour accéder à l'interface d'administration du plugin, voir l'étape 3 [Configuration du plugin](Plugin_Configuration.md).

La section __Outils__ comporte les pages :

* [Outils](#outils)
* [Commande](#commande)
* [Couplage](#couplage)
* [Debug](#debug)
* [Erreur](#erreur)


------------------------------------------------
## Outils

Voici la page __Outils__ de l'interface Web du plugin :

![Device Management](Images/FR_WebUI-Outils-Outils.png)
*Cette page est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet d'exécuter les différents outils disponibles dans le plugin à utiliser pour des fins de débogage ou de développement.

### Liste des outils

| Outils  | Outils   | Outils   | Outils   |
| :-----: |:-------:|:-------:|:-------:|
| [Plugin infos (json)](#plugin-infos-json) | [ZiGate infos (json)](#zigate-infos-json) | [Liste des Widgets DomoticZ (json)](#liste-des-widgets-domoticz-json) | [Liste des équipements (json)](#liste-des-%C3%A9quipements-json) |
| [Liste des groupes (json)](#liste-des-groupes-json) | [Liste des équipements raw (json)](#liste-des-%C3%A9quipements-raw-json) | [Santé plugin (json)](#sant%C3%A9-plugin-json) | [zGroup-1st-devices (json)](#zgroup-1st-devices-json) |
| [Paramètres (json)](#param%C3%A8tres-json) | [Trafic (json)](#trafic-json) | [Liste des dispositifs (json)](#liste-des-dispositifs-json) | [Paramètres DomoticZ (json)](#param%C3%A8tres-domoticz-json) |


#### Plugin infos (json)

Cet outil donne toutes les informations sur les paramètres DomoticZ du plugin.

Usage : Développement
API REST : plugin

#### ZiGate infos (json)

Cet outil donne toutes les informations sur la ZiGate.

Usage : Débogage
API REST : zigate

#### Liste des dispositifs DomoticZ (json)

Cet outil liste tous les dispositifs dans DomoticZ qui sont liés au plugin ZiGate.

Usage : Développement
API REST : device

#### Liste des objets (json)

Cet outil liste tous les objets appairés à la ZiGate et indique leurs paramètres.

Usage : Développement
API REST : zdevice

#### Liste des groupes (json)

Cet outil liste les groupes créé dans le plugin ZiGate.

Usage : Débogage
API REST : zgroup

#### Liste des objets raw (json)

Cet outil liste tous les objets appairés à la ZiGate et indique leurs paramètres en mémoire

Usage : Débogage
API REST : zdevice-raw

#### Santé plugin (json)

Cet outil donne les informations sur le fonctionnement du plugin.

Usage : Débogage
API REST : plugin-health

#### zGroup-1st-devices (json)

Cet outil liste les objets pouvant être intégrer dans un groupe (généralement les routeurs).

Usage : Développement
API REST : zgroup-list-available-device

#### Paramètres (json)

Cet outil liste touts les paramètres du plugin avec leurs valeurs.

Usage : Développement
API REST : settings

#### Trafic (json)

Cet outil donne toutes les statistiques de la ZiGate.

Usage : Débogage
API REST : plugin-stat

#### Liste des dispositifs (json)

Cet outil liste tous les objets. ???

#### Paramètres DomoticZ (json)

Cet outil affiche les paramètres pour accéder à l'API de DomoticZ.

Usage : Développement
API REST : domoticz-env


### L'API REST

Il est possible d'accéder aux données de ces outils sans passer par l'interface d'administration du plugin.

* Ouvrir dans votre navigateur *IP_DomoticZ:Port_Plugin-ZiGate/rest-zigate/1/__API REST__* en remplaçant API REST par celui voulu.

Exemple : http://127.0.0.1:9440/rest-zigate/1/plugin

------------------------------------------------
## Commande

Voici la page __Commande__ de l'interface Web du plugin :

![Group Management](Images/FR_WebUI-Outils-Commande.png)
*Cette page est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet d'exécuter des commandes sur les objets sans passer par DomoticZ.


------------------------------------------------
## Couplage

Voici la page __Couplage__ de l'interface Web du plugin :

![Group Management](Images/FR_WebUI-Outils-Couplage.png)
*Cette page est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet d'exécuter de coupler des objets.

Voir le tutoriel [Coupler deux dispositifs entre eux](Tuto_Coupler-deux-dispositifs.md)

------------------------------------------------
## Debug

Voici la page __Debug__ de l'interface Web du plugin :

![Group Management](Images/FR_WebUI-Outils-Debug.png)
*Cette page est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet d'accéder aux paramètres de débogage et de journalisation.

Voir la page d'[aide au débogage](Probleme_Aide-Debogage.md)


------------------------------------------------
## Erreur

Voici la page __Erreur__ de l'interface Web du plugin :

![Group Management](Images/FR_WebUI-Outils-Erreur.png)
*Cette page est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet de visualiser les erreurs du plugin.


------------------------------------------------
Voir les autres pages de l'[interface Web du plugin](Home.md#linterface-web-du-plugin).
