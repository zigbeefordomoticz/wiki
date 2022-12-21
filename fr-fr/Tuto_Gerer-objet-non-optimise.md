# Tutoriel - Gérer les objets non-optimisés

## Introduction

Ce tutoriel explique comment gérer les objets non-optimisés du plugin ZigBeeForDomoticZ.

## Présentation

La page d'accueil du plugin indique la répartition entre les objets optimisés et non-optimisés dans le plugin.

## Explication

Un objet optimisé indique qu'il n'y a pas eu de travail effectué pour intégrer cet objet dans la configuration du plugin.

Lorsqu'un nouvel objet est appairé,

* soit il est reconnu comme optimisé et il devrait fonctionner comme attendu,
* soit le plugin essaye de découvrir ses fonctionnalités par une découverte, alors 2 cas peuvent se présenter
  1. l'objet de fonctionne pas du tout ou à motié. Dans ce cas un travail d'intégration est à effectuer pour le rendre fonctionnel si compatible
  1. l'objet fonctionne parfaitement . Dans ce cas il faut vérifier si la découverte s'est bien passée et si il n'y a pas des optimisation à faire.

## Méthode

* Aller sur la page de Gestion des objets
* Cliquer sur la petite icône orange. Les informations nécessaires sont alors mises dans le presse papier.
* Contacter de préférence sur [GitHub](https://github.com/zigbeefordomoticz/Domoticz-Zigbee/issues/new?assignees=&labels=Device+Integration&template=certified-device-model.md&title=%5BModel+Certification%5D+-+) , ou éventuellement via Keybase ou les forums pour nous transmettre les données de votre objet.

En remontant les infos des objets non-certifiés, vous participez à l'amélioration de votre instalation et du plugin. Merci
