# Problèmes - L'appairage

Le plugin est développé pour pouvoir communiquer avec les objets respectant les spécifications ZigBee. Par exemple, si le plugin essaye d'appairer un objet inconnu, il va essayer de créer des dispositifs dans DomoticZ en se basant sur les fonctionnalités de l'objet.

## Introduction

L'appairage se réalise à deux niveaux :

1. Au niveau du coordinateur, où l'objet rejoint le réseau ZigBee du coordinateur
2. Au niveau du Plugin, qui va essayer de trouver les fonctionnalités de l'objet comme :
  * Est-ce un routeur (alimenté sur secteur)
  * Est-ce un interrupteur
  * Est-ce un variateur d'intensité
  * Est-ce un variateur de couleur
  * Est-ce un volet
  * Etc ...

## Quels sont les problèmes rencontrés après un appairage ?

* Il n'y a pas de dispositifs dans DomoticZ
* Le(s) dispositif(s) créé(s) n'est (ne sont) pas correct : je peux changer l'intensité mais je n'ai pas de dispositif pour changer la couleur.


## Que faire ?  

Venez nous rejoindre sur le forum français de DomoticZ https://easydomoticz.com/forum. Nous y avons une section dédiée au plugin ZigBeeForDomoticZ dans laquelle vous pourrez créer un sujet et nous faire remonter vos questions ou difficultés.

Merci de suivre ce guide [[A lire avant de poster] Guide pour bien formuler une demande](https://easydomoticz.com/forum/viewtopic.php?f=28&t=10886) afin que nous ayons un maximum d'informations dés le départ.
