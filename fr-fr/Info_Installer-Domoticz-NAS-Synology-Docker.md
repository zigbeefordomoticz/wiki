# Tutoriel - Installation sur Synology avec Docker

Ce tutoriel explique comment installer DomoticZ et le plugin avec Docker sur un NAS Synology.

C'est un pré-requis à l'installation du plugin sous Docker [Installation sur Docker dans un NAS Synology](Plugin_Installation.md##4---installation-sur-docker)

## Avant propos
Ce tutoriel suppose que Docker est déjà installé sur votre NAS (Centre de paquets)

S'il s'agit d'une migration, vous devez :

* Sur la page Paramètre, Sauvegarde / restauration, Sauvegarder la base de données
* Copier et sauvegarder le contenu du dossier Data/ du plugin


Si besoin, les drivers pour la ZiGate sont disponibles sur le site [jadahl.com](http://www.jadahl.com/)

## Installation de DomoticZ

Lancer Docker, vous arrivez sur la Vue d'ensemble.
Cliquer sur Registre :
![Vue d'ensemble](Images/FR_Synology_Docker_Install_Home.png)


Cherchez DomoticZ dans la barre en haut à droite :
![Registre](Images/FR_Synology_Docker_Install_Registre_1.png)


Double cliquez sur l'image souhaité. Je choisis l'officiel, domoticz/domoticz. Il faut choisir sur quelle branche du projet on souhaite être : stable (latest) ou beta.
![Stable ou Beta](Images/FR_Synology_Docker_Install_Registre_2.png)


Ensuite, aller dans Image:
![Image](Images/FR_Synology_Docker_Install_Image.png)


Double cliquer sur l'image DomoticZ. Nous arrivons dans les paramètres nécessaires à la création du Conteneur. Choisir un nom et cocher "Exécuter le conteneur à l'aide de privilèges élevés", puis sélectionner "Paramètres avancés".
![Creation](Images/FR_Synology_Docker_Install_Creation_Conteneur.png)


Cocher "Activer le redémarrage automatique", puis aller sur l'onglet Volume.
![Redémarrage automatique](Images/FR_Synology_Docker_Install_Param_1.png)


Cette partie est très importante pour le plugin car elle va permette d'avoir accès aux plugins via File Station.
Il faut cliquer sur "Ajouter un dossier".
![Ajouter un dossier](Images/FR_Synology_Docker_Install_Param_Volume_1.png)


Sélectionner docker puis "Créer dossier" et le nommer domoticz.
![Ajouter un dossier docker/domoticz](Images/FR_Synology_Docker_Install_Param_Volume_2.png)


Une fois le dossier créé, il faut indiquer le chemin d'accès : `/opt/domoticz/userdata`
![/opt/domoticz/userdata](Images/FR_Synology_Docker_Install_Param_Volume_3.png)


Ensuite, choisir l'onglet Environnement et modifier le port SSL, le port 443 étant déjà utilisé par le NAS, cela va bloquer.
![Environement](Images/FR_Synology_Docker_Install_Param_Environnement.png)


Onglet Paramètres des ports, remplacer auto par les ports choisis:
![Ports](Images/FR_Synology_Docker_Install_Ports.png)


Et voilà, la configuration est faite, appliquer et faire suivant.
Le dernier écran propose un résumé avant la création du Conteneur :
![Resume](Images/FR_Synology_Docker_Install_Conteneur_Resume.png)


Aller dans l'onglet Conteneur, notre nouveau Conteneur est créé:
![Conteneur](Images/FR_Synology_Docker_Install_Conteneur.png)


Double cliquer dessus pour accéder aux détails :
![Details](Images/FR_Synology_Docker_Install_Conteneur_Details.png)


DomoticZ est maintenant opérationnel et vous pouvez y accéder.
Un dossier plugins est maintenant créé dans le répertoire __docker/domoticz__.


Vous pouvez continuer l'installation du plugin en suivant : [Installation sur Docker dans un NAS Synology](Plugin_Installation.md##4---installation-sur-docker)
