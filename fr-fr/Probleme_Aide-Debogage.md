<a href="Home.md"><img align="left" width="80" height="80" src="../Images/logo_Z4D.png" alt="Logo"></a>

# Problème - Aide au débogage

</br>

Ce document présente les possibilités pour réaliser un débogage mais également les informations nécessaires pour remonter les soucis.


## Les options de débogage

* Aller dans la section [Outils > Debug](WebUI_Outils.md#debug).

![Debuging Options](../Images/debugingOptions.png)

| Option | Description |
| ------- | -------- |
| debugMatchId | Permet d'indiquer l'adresse réseau ou l'IEEE d'un objet pour n'avoir que les messages de débogage relatif à celui-ci |
| Use Domoticz Log | Activé par défaut. Les logs du plugin sont écrit dans les logs de DomoticZ. Si désactiver, les logs seront écrit dans le dossier __Domoticz-Zigate/Logs/__. Un redémarrage du plugin est nécessaire|

### Les modules du plugin


| Module | Description |
| ------ | ----------- |
| debugInput  | Tous les messages entrant vers le coordinateur |
| debugOutput | Tous les messages sortant depuis le coordinateur |
| debugCluster | Extrait le contenu des messages |
| debugHeartbeat | Exécution toutes les 5 secondes pour réaliser des actions récursives |
| debugWidget | Forcer la mise à jour des Widgets de DomoticZ par rapport au coordinateur |
| debugPlugin | Le programme du plugin |
| debugDatabase | Gérer la base de données du plugin |
| debugCommand | Mettre en attente toutes les actions de DomoticZ pour forcer les actions du coordinateur |


## Cas

### Case 1: Je ne vois pas le capteur mettre à jour les Widgets de DomoticZ


Il faut vérifier qu'il y a des messages entrants, s'ils sont correctement traités et s'ils sont envoyés à DomoticZ pour mise à jour.


1. Activer debugInput, debugCluster and debugWidget.
1. Indiquer l'adresse réseau de ce capteur dans __debugMatchId__ afin de limiter les logs.
1. Désactiver l'utilisation des logs de DomoticZ pour avoir les logs dans un fichier spécifique (redémarrage nécessaire).

1. Essayer de faire envoyer des données par le capteur afin de collecter les logs pour analyse.


### Case 2: J'ai un nouvel objet appairé, mais il semble qu'il n'est pas bien reconnu

1. Activer debugInput, debugCluster, debugWidget, debugOutput and debugCommand.
1. Indiquer l'adresse réseau de cet objet dans __debugMatchId__ afin de limiter les logs.
1. Désactiver l'utilisation des logs de DomoticZ pour avoir les logs dans un fichier spécifique (redémarrage nécessaire).

1. Faire des actions depuis DomoticZ et vérifier les logs ( debugCommand and debugOutput ).
1. Faire des actions sur l'objet pour le rendre actif et vérifier les logs ( deugInput, debugCluster, debugWidget)


## Adresse réseau et IEEE

Pour trouver l'adresse réseau ou l'IEEE d'un objet :
  * via DomoticZ : dans la colonne ID
  * via le Plugin : dans la section Gestion des objets
