# Les objets de la marque Aqara

Certains objets de la marque Aqara ont besoin d'une configuration particulière pour fonctionner avec le Plugin. Ils seront listés dans cette page.

**Cette page n'est pas une liste des objets compatibles.**

La liste des objets compatibles est sur le site [https://zigbee.blakadder.com/z4d.html](https://zigbee.blakadder.com/z4d.html).


## Sommaire

Les objets nécessitant une configuration particulière :

* [Lumi Presence Detector FP1 RTCZCGQ11LM](#Lumi-Presence-Detector-FP1-RTCZCGQ11LM)


## Lumi Presence Detector FP1 RTCZCGQ11LM

Ce capteur n'est pas capteur de mouvement mais de presence, il est capable de detecter si il y a une presence dans une piece.

Pas de zone de detection

4 paramètres pour ce module


1. Il est impératif de mettre en paramètre : "resetMotiondelay': 0" sinon vous by passer la fonction presence du module
2. Les autres paramètres :

* RTCZCGQ11LMMotionSensibility = Sensibilité de mouvement : 1=faible 2=moyenne 3=haute
* RTCZCGQ11LMApproachDistance =	Sensibilité de Distance de detection :  0=loin 1=moyenne 2=proche
* RTCZCGQ11LMMonitoringMode =	type de detection : 0=global 1=gauche/droite capacité de detecter les entrée/sortie a droite/gauche

