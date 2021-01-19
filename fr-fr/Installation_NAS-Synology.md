## Préambule
L'objectif de ce document est de présenter l'installation du plugin Zigate sur un NAS Synology


## Pre-requis

* Avant tout, Python doit ête installé : voir [Domoticz Python page](https://www.domoticz.com/wiki/Synology_installation_folder)
* Le paquet Domoticz pour Synology a installé est la version 'avec Puthon'. Vous pouvez la télécharger depuis Jahdal. Au moment de l'écriture de ces lignes, c'est la version v4.10717 avec Python 3.5.1. 
* Le Module Python du Package manager doit être installé. Voir [Python Module](https://www.synology.com/en-uk/dsm/packages/PythonModule)
* Le paquet GitHub server pour Synology doit être installé. 
* Installer le paquet Git Server via Diskstation. La partie Serveur du paquet Git Server n'est pas nécessaire, juste le 'git command' (pas de configurations spécifiques).
* Vous devez avoir les accès root/admin avec la commande 'sudo'.
* Si besoin, les drivers pour la Zigate sont disponible sur le site [jadahl.com](http://www.jadahl.com/drivers_6.2/)


## Installation du plugin

Démarrer une session Putty 

Se loguer

Aller jusqu'au dossier __plugins__ de Domoticz : <code>cd /volume1/@appstore/domoticz/var/plugins</code>

Faire un clone du Git du plugin Zigate dans un nouveau dossier : <code>sudo git clone https://github.com/sasu-drooz/Domoticz-Zigate.git Zigate</code>

Arréter et redémarer Domoticz depuis le gestionnaire de paquet.

--------------------------------------------------------

Conitnuer avec la configuration du plugin Zigate dans DomoticZ.



## Erreurs connues

Il y a des erreurs connues dans Synollogy qui font planté DomoticZ au lancement du plugin Zigate.
Il faut désactiver le plugin Zigate et vérifier s'il y a une mise à jour du plugin ou du firmware.

Editer le fichier Domoticz-Zigate/Conf/PluginConf-xx.json

Et ajouter la ligne suivante (de préférence au milieu di fichier afin de ne pas perrtuber la syntaxe globale :

"internetAccess": 0,
