<a href="Home.md"><img align="left" width="80" height="80" src="../Images/logo_Z4D.png" alt="Logo"></a>

# Tutoriel - Coupler deux objets entre euxi

</br>


## Introduction

Ce tutoriel explique comment lier deux objets entre eux afin qu'ils puissent communiquer ensemble directement sans passer par le coordinateur.
Par exemple un interrupteur avec un micro module ou encore le capteur de mouvement et l'ampoule.

__Note :__ Les objets ne sont pas tous compatibles avec cette fonction de lien direct.


## Prérequis

* Avoir appairer deux objets compatibles.

Il est recommandé de donner un surnom a l'objet dans l'interface web du plugin afin de les retrouver plus facilement (voir la section [Management > Gestion des objets](WebUI_Gestion.md#gestion-des-objets).


## Méthode

#### Création du lien

* Aller dans la section [Outil > Couplage](WebUI_Outils.md#couplage)
* Choisir le cluster :

Le cluster est le type de commande qui sera lié. Les clusters possibles sont :
   * __0006 ON/Off__ pour la fonction allumer/éteindre
   * __0008 Dimmer__ pour la fonction variateur
   * __0402 Temprature__ pour la fonction température

* Sélectionner ensuite l'objet' source (généralement la télécommande, l'interrupteur, etc...)
* Sélectionner enfin l'objet cible (celui qui est commandé)
* Cliquer sur le bouton __Couplage__


![Bindings](..Images/Binding.png)

Il est possible de lier plusieurs clusters : il faut alors faire plusieurs liens (un pour chaque cluster).


#### Cas particulier

Certains objets peuvent avoir plusieurs commandes et par conséquent plusieurs widgets créés dans DomoticZ. Les widgets sont différenciés par le -01,-02, etc à la fin de leur nom : il s'agit des EndPoints (EP).

Par exemple un double interrupteur Legrand :
```
DIN Zigate - Double gangs remote switch_LegrandSelector-000474000082702a-01
DIN Zigate - Double gangs remote switch_LegrandSelector-000474000082702a-02
```

Ces EndPoints permettent d'identifier le bon objet source.
