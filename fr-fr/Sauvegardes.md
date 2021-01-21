# Sauvegardes du plugin

Cette page présente les éléments à sauvegarder en prévision d'une réinstallation afin de ne pas perdre de données.



## Avant-propos

Les explications suivantes seront données pour :

* Le répertoire des plugins de DomoticZ __/home/pi/domoticz/plugins__ 
* Le répertoire d'installation du plugin Zigate __/home/pi/domoticz/plugins/Domoticz-Zigate__

Modifier les chemins en fonction de votre configuration.


## Procédure de sauvegarde

1. Arrêter DomoticZ

1. Déplacer le répertoire du pluggin Zigate vers votre bureau `mv /home/pi/domoticz/plugins/Domoticz-Zigate   /home/pi`

## Fin de la procédure de sauvegarde

1. Installer une nouvelle version du plugin (voir [Installation](Installation.md))

## Procédure de backup

1. Backup de la base de donnée : copier le répertoire __Data/__ vers le répertoire de la nouvelle installation :

   ```
   cp /home/pi/Domoticz-Zigate/Data/* /home/pi/domoticz/plugins/Domoticz-Zigate/Data
   ```
   
1. Backup de la configuration : copier le répertoire __Conf/PluginCon__ vers le répertoire de la nouvelle installation :

   ```
   cp /home/pi/Domoticz-Zigate/Conf/PluginConf* /home/pi/domoticz/plugins/Domoticz-Zigate/Conf
   ```
   
1. Backup des rapport (pour conserver les anciens rapports) : copier le répertoire __Reports/__ vers le répertoire de la nouvelle installation :

   ```
   cp /home/pi/Domoticz-Zigate/Reports/* /home/pi/domoticz/plugins/Domoticz-Zigate/Reports
   ```
  
 La nouvelle installation est prête à être lancée. Elle sera sur la branche __Stable__.

1. Redémarrer Domoticz
