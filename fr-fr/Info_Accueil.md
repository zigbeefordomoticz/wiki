<img align="left" width="100" height="100" src="../Images/zigbee4domoticz-logo.png" alt="Logo">

# Info - Généralités sur le wiki


Le but de ce wiki est de fournir le plus d'informations possible sur l'utilisation du plugin.

**Ce wiki en français a été traduit à partir du [wiki anglais](../en-eng/home.md) :** nous avons essayé de faire de notre mieux, mais si des choses ne sont pas claires ou approximatives, ne pas hésiter à nous faire un retour. Merci d'avance.


## Introduction

L'objectif de ce plugin est de réaliser une passerelle entre une [ZiGate](https://zigate.fr), un récepteur ZigBee et le logiciel de domotique [DomoticZ](https://www.domoticz.com). Ce plugin permettra de gérer les objets ZigBee utilisés par DomoticZ.

Le plugin dispose d'une interface utilisateur dédiée accessible depuis votre navigateur web. Cette interface permettra de configurer le plugin et régler le fonctionnement de la ZiGate.

Voici une liste non exhaustive des objets compatibles : [https://zigbee.blakadder.com](https://zigbee.blakadder.com). Ceux présents dans la liste ont été "certifiés" : nous savons qu'ils fonctionnent avec le plugin lorsque l’étiquette ZIGATE est présente.


## Lexique

Explication des termes utilisés sur ce Wiki :

| Terme          | Signification |
| -------------- | ------------- |
| Objet          | L'objet physique : sonde, bouton, ampoule, prise, volet, sirène, etc... |
| Routeur        | Un objet branché généralement sur le secteur qui peut recevoir des commandes : une ampoule, une prise, un volet, etc... Il joue un rôle de routeur/répéteur dans le maillage du réseau ZigBee |
| Objet terminal | Un objet généralement sur batterie qui envoi des informations : une sonde, un bouton |
| Dispositif     | Fonction d'un objet qui se trouve dans Menu Configuration / Dispositifs de DomoticZ |
| Widget         | Tuile dans le tableau de bord de DomoticZ correspondante à un dispositif |
