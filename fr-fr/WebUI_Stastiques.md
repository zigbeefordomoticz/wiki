# Les statistiques du WebUI

Avec le lancement de la version 6, nous avons ajouté une fonctionnalité de statistique au WebUI. Cela nous permet d'avoir des informations concernant l’utilisation du plugin dans le but de l'améliorer.

La solution utilisée pour récolter ces données est  [Matomo](https://fr.matomo.org)(anciennement Piwik) dont nous hébergeons le serveur nous même.


## Les cookies

Le WebUI étant un mini site web, nous utilisons la fonctionnalité de cookies déposé dans votre navigateur. Lors de la première ouverture du WebUI, un bandeau en bas vous demande votre autorisation pour collecter ces données.
**A tout moment**, il est possible de modifier votre choix de nous envoyer vos données en utilisant le paramètre __PluginAnalytics__ dans la page de réglages du WebUI.


## Transparence

En plus des traditionnelles informations récoltées sur les sites internet (navigateur, système d'exploitation, résolution d'affichage, etc ...), nous collectons les informations suivantes :

* le modèle de coordinateur

* la version du firmware du coordinateur

* la version du Plugin

* la taille du réseau ZigBee


## Exemple de taille du réseau

Les statistiques de taille du réseau peut nous être remontés sous forme graphique :

![Exemple réseau](Images/FR_Statistiques-reseau.png)

L'axe horizontal indique le nombre total d'objets (routeurs + dispositifs terminaux). L'axe vertical indique le nombre d'objets routeurs (en bleu) et d'objets terminaux (en orange).

Dans l'exemple, on voit tout à droite, un réseau avec 56 objets, dont 19 routeurs et 37 objets terminaux.
