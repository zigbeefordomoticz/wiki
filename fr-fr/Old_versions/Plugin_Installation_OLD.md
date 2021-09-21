# Cette page contient les anciennes informations présentent dans la page Installation du plugin.

__Les informations contenues dans cette page sont dépassées.  Se reporter à la page [Installation du plugin](../Plugin_Installation.md)__



------------
## 3 - Installation sur NAS Synology

Cette méthode est uniquement valable pour les systèmes NAS Synology.

__Note :__ Jahdal a arrêté son développement en 2020. La dernière version disponible est DomoticZ Béta 2020.2 for DSM 6.2.


### 3.A - Prérequis


* Avant tout, Python doit être installé (voir [Domoticz Python page](https://www.domoticz.com/wiki/Synology_installation_folder)).
* Le paquet DomoticZ pour Synology à installer est la version 'avec Python'. Vous pouvez la télécharger depuis Jahdal. Au moment de l'écriture de ces lignes, c'est la version v2020.1 avec Python 3.5.1.
* Le Module Python du Package manager doit être installé (voir [Python Module](https://www.synology.com/en-uk/dsm/packages/PythonModule))
* Le paquet GitHub server pour Synology doit être installé.
* Installer le paquet Git Server via Diskstation. La partie Serveur du paquet Git Server n'est pas nécessaire, juste le 'git command' (pas de configurations spécifiques).
* Vous devez avoir les accès root/admin avec la commande 'sudo'.
* Si besoin, les drivers pour la ZiGate sont disponibles sur le site [jadahl.com](http://www.jadahl.com/drivers_6.2/).


### 3.B - Procédure

* Démarrer une session __Putty__
* Se loguer

* Aller jusqu'au dossier __plugins__ de DomoticZ : `cd /volume1/@appstore/domoticz/var/plugins`
* Faire un clone du Git du plugin ZiGate dans un nouveau dossier : `sudo git clone https://github.com/sasu-drooz/Domoticz-Zigate.git Zigate`
* Arrêter et redémarrer DomoticZ depuis le gestionnaire de paquet.

Le plugin ZiGate doit apparaître dans la liste des matériels.
Passer à l'[étape 2 Paramétrage du plugin](Plugin_Parametrage.md).



### 3.C - Erreurs connues

Il y a des erreurs connues dans Synology qui font planter DomoticZ au lancement du plugin ZiGate.
Il faut désactiver le plugin ZiGate et vérifier s'il y a une mise à jour du plugin ou du firmware.

Éditer le fichier __Domoticz-Zigate/Conf/PluginConf-xx.json__

Et ajouter la ligne (de préférence au milieu du fichier afin de ne pas perturber la syntaxe globale) : `"internetAccess": 0,`


Ou aller dans la section [Réglages > Liste des services](#liste-des-services) et désactiver la fonction __internet access__.
