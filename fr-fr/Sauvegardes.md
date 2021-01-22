# Sauvegardes du plugin

Cette page présente les éléments à sauvegarder en prévision d'une réinstallation afin de ne pas perdre de données.

Le dossier du plugin Zigate contient des fichiers __critiques__ qu'il faut sauvegarder en plus de la base de donnée de DomoticZ `domoticz.db`.

## Avant-propos

Les explications suivantes seront données pour :

* Le répertoire des plugins de DomoticZ __/home/pi/domoticz/plugins__ 
* Le répertoire d'installation du plugin Zigate __/home/pi/domoticz/plugins/Domoticz-Zigate__

Modifier les chemins en fonction de votre configuration.


## Procédure de sauvegarde

1. Arrêter DomoticZ

1. Sauvegarder à minima les éléments suviant :

* Le fichier  Conf/PluginConf-*.json 
* Le dossier  Data/*
* Le dossier  Reports/*

Pour information, la commande pour copier tout le répertoire du pluggin Zigate vers votre bureau 
`mv /home/pi/domoticz/plugins/Domoticz-Zigate   /home/pi`

1. Sauvegarder __en même temps__ la base de données de DomoticZ `domoticz.db`. 


## Fin de la procédure de sauvegarde

1. Installer une nouvelle version du plugin (voir [Installation](Installation.md))

## Procédure de backup

1. Backup de la base de donnée du plugin : copier le répertoire __Data/__ vers le répertoire de la nouvelle installation :

Pour information, la commande pour copier le dossier depuis le bureau vers le répertoire du plugin : 
`cp /home/pi/Domoticz-Zigate/Data/* /home/pi/domoticz/plugins/Domoticz-Zigate/Data`
   
1. Backup de la configuration : copier le répertoire __Conf/PluginCon__ vers le répertoire de la nouvelle installation :

  Pour information, la commande pour copier le dossier depuis le bureau vers le répertoire du plugin : 
  `cp /home/pi/Domoticz-Zigate/Conf/PluginConf* /home/pi/domoticz/plugins/Domoticz-Zigate/Conf`
   
1. Backup des rapport (pour conserver les anciens rapports) : copier le répertoire __Reports/__ vers le répertoire de la nouvelle installation :

Pour information, la commande pour copier le dossier depuis le bureau vers le répertoire du plugin : 
`cp /home/pi/Domoticz-Zigate/Reports/* /home/pi/domoticz/plugins/Domoticz-Zigate/Reports`
  
 La nouvelle installation est prête à être lancée. Elle sera sur la branche __Stable__.

1. Redémarrer Domoticz
