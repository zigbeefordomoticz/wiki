# Tutoriel - Appairer un objet ZigBee avec la ZiGate


## Introduction

Ce tutoriel explique comment ajouter un nouvel objet connecté ZigBee dans DomoticZ.

## Les limitations

Il y a deux limitations possible au nombre d'objet gérer par une ZiGate. C'est la première limite atteinte qui est bloquante.

### Les limitations des ZiGates

Les ZiGates ont une limite d'objets qu'elles peuvent gérer (voir les [caractéristiques des ZiGates](Info_Caracteristiques-des-ZiGates.md#nombre-dobjet-limit%C3%A9))

### La limitation de DomoticZ

Chaque plugin python dans DomoticZ ne peut pas créer plus de 255 dispositifs (widgets possibles). Ceci est valable avec les version 2020 de DomoticZ. Nous espérons, un jour, que cette limite soit augmentée.

### Cas concret

Sur une ZiGate, il y a :

* 10 prises Ikea prenant chacune 1 dispositif (soit 10 en tout)
* 30 capteurs de température/hygrométrie/baromètre connectés directement sur le ZiGate prenant chacun 6 dispositifs (soit 180 en tout).

La ZiGate V1 autoriserait encore 30 capteurs de température passant les prises Ikea (routeurs). La somme des dispositifs serait alors de `10 + 180 + 180 = 370` c'est au-delà des 255 dispositifs acceptés par DomoticZ pour 1 plugin.
Dans ce cas, le nombre de capteur de température maxi en passant les prises Ikea (routeurs) serait de 10. Le nombre de dispositifs serait alors de 254 pour le plugin.

## Principe

Un réseau ZigBee est un réseau crypté qui permet de sécuriser les communications. Pour appairer un objet, on ouvre le réseau afin d'échanger avec le nouvel entrant et lui transmettre les informations de cryptage afin de pouvoir communiquer une fois le réseau refermé.


## Fonctionnement avec DomoticZ

Le plugin est autonome pour autoriser un appairage et créer les dispositifs dans DomoticZ. Il n'y a pas d'action à faire du coté de DomoticZ.

Il est possible de créer les widgets automatiquement en même temps que les dispositifs : il faut activer __Accepter de nouveau dispositifs pendant 5 minutes__ dans les paramètres Système de DomoticZ puis suivre une des méthodes d'appairage ci-dessous.

## Conseils d'appairage

Il est recommandé :

* D'appairer les objets les un après les autres en relançant une procédure d'appairage entre chaque objets.
* D'appairer les objets à leur emplacement d'utilisation.
* D'appairer les objets en commençant par les routeurs.
* D'appairer les routeurs en commençant par celui le plus proche de la ZiGate et en s'éloignant au fur et à mesure.

Plus de conseils sur la page : [Construire un réseau ZigBee](Tuto_Construire-un-reseau-ZigBee.md)


## Méthodes

Il est recommandé de commencer par appairer les objets de type routeurs afin de créer un réseau maillé avant d'associer les objets terminaux.

* Aller dans la section [Admin > Appairage](WebUI_Admin.md#appairage)

![FR_WebUI-Admin-Dispositif.png](Images/FR_WebUI-Admin-Appairage.png)
*Cette image est susceptible d'avoir évolué depuis l'écriture de cette documentation.*


Il existe plusieurs méthodes :

* Appairage avec l'assistant
* Appairage sur une durée
* Appairage sur un routeur spécifique

**Note :** Vérifier qu'il n'y a pas de particularités pour l'appairage de votre objet. Voir la liste des [Objets avec des particularités](Home.md#particularit%C3%A9s-de-certains-objets).

------------------------------------------------
### 1. Appairage avec le suivi

* Aller dans le module __Appairer un objet avec l'assistant__ et cliquer sur __Appairer__ (le mode appairage sera actif pendant 4 minutes)

![Assisted Provisioning: Start](../Images/Provisionning_2.png)

 La LED bleu de la ZiGate doit clignoter.

* Faire un Reset de l'objet pour le passer en mode appairage. *Se référer à la documentation de l'objet si nécessaire.*

 Lorsque l'appairage est effectué, les informations de l'objet apparaissent dans la fenêtre de l'assistant.

![Assisted Provisioning: Done](../Images/Provisionning_3.png)

**Note :** Lors d'un ré-appairage d'un objet qui était déjà présent dans le réseau, l'assistant n'indique pas sa nouvelle inclusion. Il faut regarder les logs de DomoticZ pour voir que l'objet est revenu dans le réseau.

Si rien ne se produit :

* Vérifier les logs de DomoticZ pour voir s'il n'y a pas d'erreurs.
* Redémarrer le plugin et réessayer l'appairage.


------------------------------------------------      
### 2. Appairage sur une durée

Cette méthode permettra de passer la ZiGate en mode appairage pendant une durée. Les informations d'appairage seront affichées dans la logs de DomoticZ.
*Conseil :* Filtrer les logs afin de ne garder que les lignes concernant la ZiGate.

* Aller dans le module __Appairage sur une durée__.

* Cliquer le bouton __4 minutes__ ou __permanent__ pour choisir la durée du mode appairage souhaitée.

 La LED bleu de la ZiGate doit clignoter.

 * Cliquer le bouton __Stop__ pour arrêter le mode appairage.

 Les résultats d'appairage ne seront visible que dans DomoticZ avec l'ajout de nouveaux dispositifs et les lignes de logs.


------------------------------------------------      
### 3. Appairage sur un routeur spécifique

Par défaut, la ZiGate va déterminer le meilleur chemin pour communiquer avec les objets. Il est cependant possible de spécifier un routeur sur lequel doit s'appairer le nouvel objet.

* Aller dans le module __Appairage sur un routeur spécifique__.

* Sélectionner le routeur désiré dans la liste.

* Cliquer sur le bouton __4 minutes__ pour lancer le mode d'appairage.

Le fonctionnement est identique au paragraphe précédent hormis que la ZiGate cherchera à appairer le nouvel objet sur le routeur choisi.
