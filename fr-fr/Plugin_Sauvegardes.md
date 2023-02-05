# Sauvegardes du Plugin

Cette page présente les éléments à sauvegarder en prévision d'une réinstallation afin de ne pas perdre de données.

Le dossier du plugin ZigBeeForDomoticZ contient des fichiers __critiques__ qu'il faut sauvegarder en plus de la base de données de DomoticZ `domoticz.db`.

En plus de sauvegarder le plugin, pensez à sauvegarder votre coordinateur. Voir les guides sur : [https://zigate.fr/documentation/sauvegardez-et-restaurez-votre-zigate](https://zigate.fr/documentation/sauvegardez-et-restaurez-votre-zigate)

## Avant-propos

Les explications suivantes seront données pour :

* Le répertoire des plugins de DomoticZ __/home/pi/domoticz/plugins__
* Le répertoire d'installation du plugin ZigBeeForDomoticZ __/home/pi/domoticz/plugins/Domoticz-Zigbee__

Modifier les chemins en fonction de votre configuration.

## Procédure de sauvegarde

1. Arrêter DomoticZ
2. Sauvegarder à minima les éléments suivant localisés sous le répertoire d'installation du plugin ZigBeeForDomoticZ :

* Le fichier  Conf/PluginConf-*.json
* Le dossier  Data/*
* Le dossier  Reports/*

Pour information, la commande pour copier tout le répertoire du plugin ZigBeeForDomoticZ vers votre bureau

```
cp -r /home/pi/domoticz/plugins/Domoticz-Zigbee /home/pi
```

3. Sauvegarder __en même temps__ la base de données de DomoticZ `domoticz.db`.

## Fin de la procédure de sauvegarde

1. Installer une nouvelle version du plugin (voir l'[étape 1 Installation du plugin](Plugin_Installation.md))

## Procédure de récupération

1. Récupération de la base de donnée du plugin : copier le répertoire __Data/__ vers le répertoire de la nouvelle installation :

Pour information, la commande pour copier le dossier depuis le bureau vers le répertoire du plugin :

```
cp /home/pi/Domoticz-Zigbee/Data/* /home/pi/domoticz/plugins/Domoticz-Zigbee/Data
```

2. Récupération de la configuration : copier le fichier __Conf/PluginConfXX__ vers le répertoire de la nouvelle installation (XX correspond à deux chiffres) :

  Pour information, la commande pour copier le dossier depuis le bureau vers le répertoire du plugin :

 ```
 cp /home/pi/Domoticz-Zigbee/Conf/PluginConf* /home/pi/domoticz/plugins/Domoticz-Zigbee/Conf
 ```

3. Récupération des rapports (pour conserver les anciens rapports) : copier le répertoire __Reports/__ vers le répertoire de la nouvelle installation :

Pour information, la commande pour copier le dossier depuis le bureau vers le répertoire du plugin :

```
cp /home/pi/Domoticz-Zigbee/Reports/* /home/pi/domoticz/plugins/Domoticz-Zigbee/Reports
```

 La nouvelle installation est prête à être lancée. Elle sera sur la branche __Stable__.

4. Redémarrer DomoticZ
