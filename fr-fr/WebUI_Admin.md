# L'interface Web - La section Admin

Pour accéder à l'interface d'administration du plugin, voir l'étape 3 [Configuration du plugin](Plugin_Configuration.md).

La section __Admin__ comporte les pages :

* [Plugin](#plugin)
* [Appairage](#appairage)
* [Groupe](#groupe)
* [Coordinateur](#coordinateur)
* [Firmware](#firmware)


------------------------------------------------
## Plugin

Voici la page __Plugin__ de l'interface Web du plugin :

![FR_WebUI-Admin-Plugin](Images/FR_WebUI-Admin-Plugin.png)
*Cette image est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet de gérer le fonctionnement du plugin ZigBeeForDomoticZ.

Elle permet :

* De faire un redémarrage du plugin.

Se reporter à la section [Tutoriels](Readme.md#tutoriels) pour plus d'informations.

------------------------------------------------
## Appairage

Voici la page __Appairage__ de l'interface Web du plugin :

![FR_WebUI-Admin-Dispositif.png](Images/FR_WebUI-Admin-Appairage.png)
*Cette image est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet d'appairer les objets avec la ZiGate et DomoticZ.

Elle permet :

* D'ajouter un objet avec l'assistant
* D'activer le mode appairage du coordinateur
* D'ajouter un objet via un routeur particulier
* De réinitialiser les infos d'appairage d'un objet
* De recréer les dispositifs dans DomoticZ

Se reporter au tutoriel [Ajouter un nouvel objet](Tuto_Appairage-objet.md) pour plus d'informations.

------------------------------------------------
## Groupe

Voici la page __Groupe__ de l'interface Web du plugin :

![FR_WebUI-Admin-Groupe](Images/FR_WebUI-Admin-Groupe.png)
*Cette image est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

Le groupe que vous pourrez créer via ce plugin est vu dans DomoticZ comme un unique dispositif de type Switch et ce indépendamment du nombre d'objets composant le groupe.
L'action sur le Widget (DomoticZ) sera alors répercutée simultanément sur tous les objets du groupe.

### Utilisation

Cette page permet de gérer les groupes d'objets dans le réseau ZigBee.

Elle permet :

* De faire une analyse complète des groupes
* De faire une analyse sélective des groupes

Préalablement à la gestion des groupes, il est nécessaire d'activer la service de groupe (désactivé par défaut) du plugin : se reporter à la section [Réglages](WebUI_Reglages.md) pour activer les services.

Se reporter au tutoriel [Gérer les groupes](Tuto_Gerer-les-groupes.md) pour plus d'informations.


------------------------------------------------
## Coordinateur

Voici la page __Coordinateur__ de l'interface Web du plugin :

![FR_WebUI-Admin-Zigate](Images/FR_WebUI-Admin-Zigate.png)
*Cette image est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet de gérer le fonctionnement du hardware du coordinateur.

Elle permet :

* De faire un redémarrage logiciel du coordinateur : cette action n’entraîne **aucune perte des objets appairés**. (fonctionne uniquement pour les ZiGates)
* De modifier le canal du coordinateur.

Se reporter à la section [Tutoriels](Readme.md#tutoriels) pour plus d'informations.




------------------------------------------------
## Firmware

Voici la page __Firmware__ de l'interface Web du plugin :

![FR_WebUI-Admin-Firmware](Images/FR_WebUI-Admin-Firmware.png)
*Cette image est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet de mettre à jour le firmware des objets ZigBee.

Elle permet :

* De faire une mettre à jour le firmware des objets appairés

Se reporter à la section [Tutoriels](Readme.md#tutoriels) pour plus d'informations.


------------------------------------------------
Voir les autres pages de l'[interface Web du plugin](Readme.md#linterface-web-du-plugin).
