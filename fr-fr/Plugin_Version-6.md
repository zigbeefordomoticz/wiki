
# Explications pour passer de la version 5 à la version 6 plugin.

</br>

## Informations concernant la phase Béta (de test)

Le wiki à consulter est disponible sur [la branche du wiki](https://github.com/zigbeefordomoticz/wiki/blob/zigpy/fr-fr/Home.md). Ce wiki deviendra la version par défaut lorsque la version 6 sortira comme version stable.

Pour __une nouvelle installation du plugin__, merci de suivre [la procédure d'installation sur la branche zigpy](https://github.com/zigbeefordomoticz/wiki/blob/zigpy/fr-fr/Plugin_Installation.md#2---installation-manuelle-sous-linux). Pour le moment, seule l'installation manuelle sous Linux a été testée et validée.

Pour passer de la version 5 à la version 6, la procédure est décrite ci-dessous. __Elle n'est valable que pour une installation manuelle sous Linux__.

Les testeurs pour les autres systèmes d'exploitation sont les bienvenus !!

## Prérequis

Avant de commencer la procédure, vous devez :

* Avoir une version de DomoticZ 2021.1 au minimum.
* Être sur la branche __Stable5__ du plugin. Commande `git checkout stable5` si besoin.
* Avoir la dernière version du plugin. Commande `git pull` si besoin.


## Sauvegarde

Même si la procédure a été testé plusieurs fois, il est possible que les choses ne se passent pas comme prévus.
Il est recommandé de faire une sauvegarde complète pour pouvoir revenir en arrière si besoin.
Pensez à sauvegarder :

* DomoticZ
* Les données du plugin
* Le système d'exploitation


## Procédure

* Ouvrir le terminal.
* 1- Arrêter DomoticZ. La commande est normalement :
```
sudo service domoticz.sh stop
```
* 2- Aller dans le répertoire du plugin. La commande est normalement :
```
cd domoticz/plugins/Domoticz-Zigate
```
* 3- Exécuter la commande :
```
git remote set-url origin https://github.com/zigbeefordomoticz/Domoticz-Zigbee
```
* 4- Installer les paquets Python nécessaires avec la commande :
```
sudo pip3 install voluptuous pycrypto aiosqlite crccheck pyusb attrs aiohttp pyserial-asyncio
```
* 5- Exécuter la commande en adaptant __pi:pi__ si nécessaire au __user:group__ utilisé. Attention à bien prendre le point à la fin.
```
sudo chown -R pi:pi .
```

* 6- Le temps de la phase de développement, il faut passer sur la nouvelle branche beta6 :
```
git checkout beta6
```

* 7- Installer les librairies Python manquantes avec la commande :
```
git submodule update --init --recursive
```
* 8- Rendre le fichier __plugin.py__ exécutable en lançant la commande :
```
sudo chmod +x plugin.py
```
* 9- Redémarrer DomoticZ. La commande est normalement :
```
sudo service domoticz.sh start
```


Normalement, le nom du plugin dans matériel est devenu __ZigBee for DomoticZ__.

A partir de maintenant, le terme ZiGate est remplacé par __coordinateur__, plus générique.

Si vous avez déjà un plugin configuré avec une ZiGate comme coordinateur, vous n'avez rien à faire le plugin doit continuer a fonctionner normalement.

## Le paramétrage

Il y a 4 modèles de coordinateurs possibles :

* ZiGate : aucune modification sur le fonctionnement du plugin existant
* ZiGate + : aucune modification sur le fonctionnement du plugin existant
* ZiGate (via zigpy) : le plugin communique avec la ZiGate par le biais des librairies zigpy. C'est uniquement expérimental et aucun support ne sera fait.
* Texas Instruments ZNP : pour les nouveaux coordinateurs de marque TI



## IMPORTANT Mise à jour du plugin

Le `git pull` n'est plus suffisant, il faut maintenant faire la commande `git pull --recurse-submodules`.
