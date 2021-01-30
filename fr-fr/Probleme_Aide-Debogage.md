# Problème - Aide au débogage

Ce document présente les possibilités pour réaliser un débogage mais également les informations nécessaires pour remonter des soucis.


## Les options de débogage

* Aller dans la section [Outils > Debug](WebUI_Outils.md#debug) 

![Debuging Options](../Images/debugingOptions.png)

| Option | Description |
| ------- | -------- |
| debugMatchId | Permet d'indiquer l'adresse courte ou l'IEEE d'un dispositif pour n'avoir que les messages de debogage relatif à celui-ci |
| Use Domoticz Log | Activé par défaut. Les logs du plugin sont écrit dans les logs de DomoticZ. Si désactiver, les logs seront écrit dans le dossier __Domoticz-Zigate/Logs/__. Un redémarrage du plugin est nécessaire|

### Les modules du plugin

| Module | Description |
| ------ | ----------- |
| Input  | Tous les messages entrant de la Zigate |
| Output | Tous les messages sortant vers la Zigate |
| Cluster | decoding incoming messages. This is where we extract information from the messages payload ??? |
| Heartbeat | Exécution toutes les 5 secondes pour réaliser des actions récursives |
| Widget | Forcer la mise à jour des Widgets de DomoticZ par rapport à la Zigate |
| Plugin | Le programme du plugin |
| Database | Gérer la base de données du plugin |
| Command | Mettre en attente toutes les actions de DomoticZ pour forcer les actions de la Zigate |


## Cas 

### Case 1: Je ne vois pas le capteur mettre à jour les Widgets de DomoticZ


Il faut vérifier qu'il y a des messages entrants, s'ils sont correctement traités et s'ils sont envoyés à DomoticZ pour mise à jour.


1. Activer debugInput, debugCluster and debugWidget
1. Indiquer l'adresse courte de ce capteur dans __debugMatchId__ afin de limiter les logs.
1. Désactiver l'utilisation des logs de DomoticZ pour avoir les logs dans un fichier spécifique (redémarrage nécessaire)

1. Essayer de faire envoyer des données par le capteur afin de collecter les logs pour anlayse.


### Case 2: J'ai un nouveau dispositif appairé, mais il semble qu'il n'est pas bien reconnu

1. Activer debugInput, debugCluster, debugWidget, debugOutput and debugCommand
1. Indiquer l'adresse courte de ce capteur dans __debugMatchId__ afin de limiter les logs.
1. Désactiver l'utilisation des logs de DomoticZ pour avoir les logs dans un fichier spécifique (redémarrage nécessaire)

1. Faire des actions depuis DomoticZ et vérifier les logs ( debugCommand and debugOutput )
1. Faire des actions sur le dispositif pour le rendre actif et vérifier les logs ( deugInput, debugCluster, debugWidget)




## Adresse courte et  IEEE

Pour trouver l'adresse courte ou l'IEEE d'un dispositif :
  * via DomoticZ: dans la colonne ID
  * via le Plugin : dans la section Management de dispositifs
