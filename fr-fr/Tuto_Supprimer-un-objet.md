# Tutoriel - Supprimer un objet appairé

## Introduction

Ce tutoriel explique comment supprimer un objet appairé au réseau ZigBee.
Cet objet est donc connu par :
* Le coordinateur
* Le plugin
* DomoticZ (avec un ou plusieurs dispositifs et widgets associés à l'objet)

A la fin de ce tutoriel, il faudra s'assurer que l'objet a été retiré de ces 3 emplacements.



### Avertissement

__Toute suppression entraînera la pertes de toutes les données de l'objet.__


## Méthode

Il existe plusieurs méthodes en fonction du type d'objet :

* [Les objets terminaux](#supprimer-les-objets-terminaux) (sur batterie)
* [Les routeurs](#supprimer-les-routeurs) (sur secteur)


### Supprimer les objets terminaux

Il n'y a pas de suppression automatique : il faut le faire manuellement.

* S'assurer que le Plugin n'est pas en mode Appairage (voir [Tuto_Appairage](Tuto_Appairage-objet.md) : le bouton "Accepter de nouveaux objets" doit être éteint, la LED du coordinateur ne doit pas indiquer l'appairage.
* Faire un __Reset__ sur l'objet (comme pour l'appairer).

Un message similaire à celui-ci devrait apparaître dans les logs de DomoticZ :

`Status: (DIN-Zigbee)  (d009/00158d0002722c67) send a Leave indication and will be outside of the network. LQI: 0`

* Supprimer tous les dispositifs de cet objet dans DomoticZ.


### Supprimer les routeurs

* Supprimer tous les dispositifs de l'objet dans DomoticZ.

Généralement lorsque le dernier dispositifs est supprimé, le Plugin va automatiquement envoyé une demande de __Reset__ à l'objet.

Un message similaire à celui-ci devrait apparaître dans les logs de DomoticZ :

`Status: (DIN-Zigbee)  (d009/00158d0002722c67) send a Leave indication and will be outside of the network. LQI: 0`

Si vous ne voyez pas de message similaire, il faut appliquer la procédure pour [Supprimer les objets terminaux](#supprimer-les-objets-terminaux).


## Information

Si vous supprimez tous les dispositifs d'un objet terminal, le plugin enverra une demande de __Reset__ mais comme un objet terminal ne fait qu'envoyer des informations (il n'écoute pas le réseau), il ne recevra donc jamais la demande Reset envoyée pour lui par le Plugin.
C'est la raison pour laquelle, il faut faire le Reset manuellement sur l'objet.
