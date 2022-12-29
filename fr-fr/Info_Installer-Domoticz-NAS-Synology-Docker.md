# Tutoriel - Installation sur Synology avec Docker 

Ce tutoriel explique comment installer DomoticZ et le Plugin avec Docker sur un NAS Synology.

C'est un pré-requis à l'installation du Plugin sous Docker [Installation sur Docker dans un NAS Synology](Plugin_Installation.md#4---installation-sur-nas-synology-avec-docker)

# Avant propos
Ce tutoriel suppose que Docker est déjà installé sur votre NAS (Centre de paquets)

S'il s'agit d'une migration, vous devez :

* Sur la page Paramètre, Sauvegarde / restauration, Sauvegarder la base de données
* Copier et sauvegarder le contenu du dossier Data/ du Plugin



# Installation de DomoticZ

Lancer Docker, vous arrivez sur la Vue d'ensemble.
Cliquer sur Registre :
![Vue d'ensemble](Images/FR_Synology_Docker_Install_Home.png)


Cherchez DomoticZ dans la barre en haut à droite :
![Registre](Images/FR_Synology_Docker_Install_Registre_1.png)


Double cliquez sur l'image souhaité. Je choisis l'officiel, domoticz/domoticz. Il faut choisir sur quelle branche du projet on souhaite être : stable ou beta.
![Stable ou Beta](Images/FR_Synology_Docker_Install_Registre_2.png)


Ensuite, aller dans Image:
![Image](Images/FR_Synology_Docker_Install_Image.png)


Double cliquer sur l'image DomoticZ. Nous arrivons dans les paramètres nécessaires à la création du Conteneur. En premier lieu, nous choisissons l'interface réseau, dans mon cas, bridge.
![Creation](Images/FR_Synology_Docker_Install_Creation_Conteneur.png)

Choisir un nom et cocher "Exécuter le conteneur à l'aide de privilèges élevés", ainsi que "Activer le redémarrage automatique", puis valider "Suivant".
![Redémarrage automatique](Images/FR_Synology_Docker_Install_Param_1.png)

Ensuite, choisir l'onglet Ports et modifier les 'Auto' par des ports fixes.
Le port SSL 443 étant déjà utilisé par le NAS, il faut en choisir un autre :
![Ports](Images/FR_Synology_Docker_Install_Ports.png)

Cette partie est très importante pour le Plugin car elle va permette d'avoir accès aux plugins via File Station.
Il faut cliquer sur "Ajouter un dossier".
![Ajouter un dossier](Images/FR_Synology_Docker_Install_Param_Volume_1.png)


Sélectionner docker puis "Créer dossier" et le nommer domoticz.
![Ajouter un dossier docker/domoticz](Images/FR_Synology_Docker_Install_Param_Volume_2.png)


Une fois le dossier créé, il faut indiquer le chemin d'accès : `/opt/domoticz/userdata`
![/opt/domoticz/userdata](Images/FR_Synology_Docker_Install_Param_Volume_3.png)




Et voilà, la configuration est faite, appliquer et faire suivant.
Le dernier écran propose un résumé avant la création du Conteneur :
![Resume](Images/FR_Synology_Docker_Install_Conteneur_Resume.png)


Aller dans l'onglet Conteneur, notre nouveau Conteneur est créé:
![Conteneur](Images/FR_Synology_Docker_Install_Conteneur.png)


Double cliquer dessus pour accéder aux détails :
![Details](Images/FR_Synology_Docker_Install_Conteneur_Details.png)


DomoticZ est maintenant opérationnel et vous pouvez y accéder.
Un dossier plugins est maintenant créé dans le répertoire __docker/domoticz__.


Vous pouvez continuer l'installation du Plugin en suivant : [Installation sur Docker dans un NAS Synology](Plugin_Installation.md##4---installation-sur-docker)

# Installation des drivers USB
En fonction du modèle de zigate, le driver USB n'est pas le même.
* Pour la première version, il faut le fichier __cp210x.ko__, on le trouve sur le de [jadahl.com](http://www.jadahl.com/). Pour choisir le bon fichier, il faut connaitre le nom du type de CPU sur le site de [Synology](https://kb.synology.com/fr-fr/DSM/tutorial/What_kind_of_CPU_does_my_NAS_have). Il faudra ensuite mettre le fichier dans le repertoire /lib/modules.
* Pour la v2, les clés TI ou la conbee, il faut le fichier __ftdi_sio.ko__, à partir de DSM7.0, celui-ci est déjà présent.
* Pour la conbee 2, il faut également ajouter cdc-acm.ko


Pour charger les drivers, connectez-vous en ssh au NAS et éxécuter les commandes suivantes, en utilisant la commande avec le fichier correspondant à votre modèle de clé :

```
sudo insmod /lib/modules/usbserial.ko

sudo insmod /lib/modules/cp210x.ko
OR
sudo insmod /lib/modules/ftdi_sio.ko
OR/AND
sudo insmod /lib/modules/cdc-acm.ko
````

Pour que les drivers soient chargés au démarage du NAS, vous pouvez :
* Soit utiliser le planificateur de tâches (panneau de configuration) en créeant une tâche déclenchée (j'ai ajouté la copie des fichiers car ils sont supprimés lors des mises à jours de DSM)
![Tache](Images/FR_Synology_Docker_Install_Tache.png)


* Soit ajouter un fichier start-usb-drivers.sh dans le répertoire /usr/local/etc/rc.d/start-usb-drivers.sh

Supprimer la ligne dont vous n'avez pas besoin (cp210x.ko ou ftdi_sio.ko).

```
#!/bin/sh
case $1 in
  start)
    insmod /lib/modules/usbserial.ko > /dev/null 2>&1
    insmod /lib/modules/cp210x.ko > /dev/null 2>&1
    insmod /lib/modules/ftdi_sio.ko > /dev/null 2>&1
    insmod /lib/modules/cdc-acm.ko > /dev/null 2>&1
    ;;
  stop)
    exit 0
    ;;
  *)
    exit 1
    ;;
esac
```

et de le rendre exécutable :
```
chmod +x /usr/local/etc/rc.d/start-usb-drivers.sh
```

(Merci Jadahl)

Rédaction par [@SylvainPer](https://github.com/SylvainPer)
