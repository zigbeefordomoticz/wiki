# Tutoriel - Gérer les groupes

## Introduction

Ce tutoriel explique comment gérer les groupes d'objets ZigBee directement depuis le Plugin ZigBeeForDomoticZ.

Depuis la mise en place de l'interface Web avec la version 4.7 du Plugin, la gestion des groupes a été simplifiée. Elle se faisait auparavant principalement en ligne de commande.
Des améliorations ont été apportées avec la version 4.9 pour rendre la gestion des groupes plus facile mais il reste encore du travail pour améliorer l'expérience utilisateur.

## Présentation

Un groupe ZigBee permet de regrouper plusieurs objets connectés sur secteur (routeur) sous un seul dispositif dans DomoticZ. Une action sur un Widget sera transmis à tous les objets appartenant au groupe.

__Les objets terminaux ne peuvent pas être associés à un groupe.__

Dans le détail, ce n'est pas le coordinateur qui tient la liste des objets de chaque groupe ; ce sont les objets qui conservent en mémoire dans quels groupes ils appartiennent.
Concrètement le coordinateur envoie la commande à tout le réseau en indiquant que c'est pour le groupe 1001 (par exemple) : tous les objets vont recevoir la demande et si un objet reconnaît le groupe auquel il appartient, il va appliquer la commande.

Pour appliquer une commande pour un groupe, un objet doit écouter le réseau. Les objets terminaux (sur batterie) n'ont pas cette fonction d'écoute, c'est la raison pour laquelle les objets terminaux ne peuvent pas être ajouter dans un groupe ; seuls les routeurs peuvent l'être.

__Ce fonctionnement est complètement indépendant des groupes dans DomoticZ.__

## Pré-requis

* Version du firmware de la ZiGate supérieur à 3.0f
* Version du Plugin supérieur à 4.
* Version de DomoticZ supérieur à 2020.1 (avec l'interface web du Plugin activé)


## Méthode

#### Activer la gestion des groupes

* Aller dans la section [Réglages > Paramètres](WebUI_Reglages.md#les-param%C3%A8tres).
* Activer __Activer les Groupes__.

![Settings for Group Management](../Images/SettingsGroup.png)

* Redémarrer le Plugin.
* Initialiser les groupes (voir ci-dessous).


#### Initialiser les groupes

Comme expliquer dans la présentation, les informations concernant les groupes sont stockées dans les objets. Il est donc nécessaire de scanner le réseau pour interroger tous les objets afin de lister tous les groupes paramétrés.

* S'assurer que tous les objets sont connectés au réseau ZigBee.
* Aller dans la section [Admin > Groupe](WebUI_Admin.md#groupe).
* Lancer une __Analyse complète__.

![Group Management](../Images/AdminGroupMenu.png)

Chaque routeur sera interrogé pour savoir s'il appartient à un groupe.

![Group Management](../Images/GroupManagementMenu.png)


#### Créer un groupe

* Aller dans la section [Management > Gestion des groupes](WebUI_Gestion.md#gestion-des-groupes).

![Adding Group Management](../Images/AddingGroup.png)

* Cliquer sur __Ajouter un groupe__.
* Indiquer le nom du groupe.
* Sélectionner les objets appartenant au groupe en les cliquant un par un. En cas d'erreur, utiliser la petit croix pour retirer un objet de la liste.

Il est possible d'ajouter le coordinateur dans le groupe. Ceci est nécessaire pour récupérer d'une télécommande Ikea (voir [la page des objets Ikea](Les-objets_Ikea.md)).
__Le coordinateur ne peut appartenir qu'à un nombre limité de groupes :__ voir les [caractéristiques des coordinateur](Caracteristiques-des-Coordinateurs.md#nombre-de-groupe-limit%C3%A9).

* Cliquer sur le bouton __Valider__.

La demande sera envoyée à chaque objet listé. Cela peut prendre quelques secondes. *Si le groupe n'appairait pas, rafraîchir la page web.*


#### Mettre à jour un groupe

* S'assurer que tous les objets sont connectés au réseau ZigBee.
* Aller dans la section [Management > Gestion des groupes](WebUI_Gestion.md#gestion-des-groupes).
* Cliquer sur le groupe à modifier.
* Ajouter ou supprimer des objets.
* Cliquer sur le bouton __Valider__.

Idem que pour la création d'un groupe, patientez le temps de l'envoi des infos aux objets.


#### Supprimer un groupe

Il y a deux possibilités :

##### Depuis DomoticZ

* Supprimer le widget correspondant au groupe dans DomoticZ.

##### Depuis L'interface web du Plugin

* Aller dans la section [Management > Gestion des groupes](WebUI_Gestion.md#gestion-des-groupes).
* Sélectionner le groupe à supprimer.
* Cliquer sur la petit icône poubelle à gauche.
* Cliquer sur le bouton __Valider__.

Idem que pour la création d'un groupe, patientez le temps de l'envoi des infos aux objets.


#### Création du groupe 0000

Pour des raisons de facilité, une option est disponible dans le menu [Réglages > Réglages de la ZiGate](#r%C3%A9glages-de-la-zigate) qui permet d'activer rapidement le groupe 0000.
L'activation du groupe 0000 créera le dispositif et le widget correspondant dans DomoticZ.

![Adding Group Management](../Images/SettingsGroup0000.png)


## Avertissements

Le Plugin a un TimeOut de 7 secondes lors d'une analyse du réseau. C'est à dire que si un objet ne répond pas, il attend 7 secondes avant de passer à la commande suivante.
Lors d'une analyse, si des objets ne sont pas connectés sur le réseau ZigBee, le Plugin va attendre 7 secondes avant de passer à l'objet suivant. Si vous essayez d'envoyer une autre commande pendant ce temps là, elle va être mise en attente.
