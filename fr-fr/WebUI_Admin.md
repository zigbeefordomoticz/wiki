# L'interface Web - La section Admin

Pour accéder à l'interface d'administration du plugin, voir l'étape 3 [Configuration du plugin](3_Configuration.md).

La section __Admin__ comporte les pages :

* [Appairage](#appairage)
* [Groupe](#groupe)
* [Zigate](#zigate)
* [Plugin](#plugin)
* [Firmware](#firmware)


------------------------------------------------
## Appairage

Voici la page __Appairage__ de l'interface Web du plugin : 

![FR_WebUI-Admin-Dispositif.png](Images/FR_WebUI-Admin-Dispositif.png)
*Cette page est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet d'appairer les dispositifs avec la Zigate et DomoticZ. 

Elle permet :

* D'ajouter un dispositif avec un retour d'info
* D'activer le mode appairage de la Zigate (permanent ou 4 minutes)
* D'ajouter un dispositif via un routeur particulier

Se reporter à la section [Tutoriels](Home.md#tutoriels) pour plus d'informations. 


------------------------------------------------
## Groupe

Voici la page __Groupe__ de l'interface Web du plugin : 

![FR_WebUI-Admin-Groupe](Images/FR_WebUI-Admin-Groupe.png)
*Cette page est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

Le groupe que vous pourrez créer via ce plugin est vu dans Domoticz comme un unique widget de type Switch et ce indépendament du nombre de dispositifs composant le groupe.
L'action sur le switch (Domoticz) sera alors repercutée simultanement sur tous les dispositifs du groupe.

### Utilisation

Cette page permet de gérer les groupes de dispositifs dans la Zigate.

Elle permet :

* De faire une analyse complète des groupes
* De faire une analyse sélective des groupes

Préallablement à la gestion des groupes, il est nécessaire d'activer la service de groupe (desactivé par défaut) du plugin : Se reporter à la section [Réglages](WebUI_Reglages.md) pour activer les services

Se reporter à la section [Tutoriels](Home.md#tutoriels) pour plus d'informations. 


------------------------------------------------
## Zigate

Voici la page __Zigate__ de l'interface Web du plugin : 

![FR_WebUI-Admin-Zigate](Images/FR_WebUI-Admin-Zigate.png)
*Cette page est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet de gérer le fonctionnement du hardware de la ZiGate.

Elle permet :

* De faire un redémarrage logiciel de la Zigate : Cette action n'entraine **aucune perte des dispositifs appairés**

Se reporter à la section [Tutoriels](Home.md#tutoriels) pour plus d'informations. 


------------------------------------------------
## Plugin

Voici la page __Plugin__ de l'interface Web du plugin : 

![FR_WebUI-Admin-Plugin](Images/FR_WebUI-Admin-Plugin.png)
*Cette page est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet de gérer le fonctionnement du plugin de la Zigate.

Elle permet :

* De faire un redémarrage du plugin de la Zigate

Se reporter à la section [Tutoriels](Home.md#tutoriels) pour plus d'informations. 

------------------------------------------------
## Firmware

Voici la page __Firmware__ de l'interface Web du plugin : 

![FR_WebUI-Admin-Firmware](Images/FR_WebUI-Admin-Firmware.png)
*Cette page est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet de mettre à jour le firmware des dispositifs ZigBee.

Elle permet :

* De faire une mettre à jour le firmware des dispositifs appairés

Se reporter à la section [Tutoriels](Home.md#tutoriels) pour plus d'informations. 


------------------------------------------------
Voir les autres pages de l'[interface Web du plugin](Home.md#linterface-web-du-plugin)
