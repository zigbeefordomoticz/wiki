# Les dispositifs de la marque BlitzWolf

Certains dispositifs de la marque BlitzWolf ont besoin d'une configuration particulière pour fonctionner avec le plugin. Ils seront listés dans cette page.

** Cette page n'est pas une liste des dispositifs compatibles.** 

La liste des dipositifs compatibles est sur le site [https://zigbee.blakadder.com/zigate.html](https://zigbee.blakadder.com/zigate.html)


## Sommaire

Les dispositifs nécessitant une configuration particulière :

* [Prise BW-SHP13](Prise commandée avec mesures électriques 16A EU Plug (BW-SHP13))


### Prise commandée avec mesures électriques 16A EU Plug (BW-SHP13)

Ce dispositif apparaîtra une fois appairé sous le nom générique de TS0121.

Pour l'appairage du dispositif, tenir le bouton power enfoncé durant 5s, la lumière bleue flashera jusqu'à la fin complète du processus d'appairage.
Quatre dispositifs sont alors créés et remontés vers DomoticZ :

| Type de widget dans DomoticZ | Description |
| ---------------------------- | ----------- |
| Switch On/Off | La prise commandée |
| Mesure | Tension délivrée par la prise / Voltage |
| Mesure P1Meter | Consommation instantanée en Watt |
| Mesure General KWh| Consommation cumulée |
| Ampere | Intensité instantanée |

Vous pouvez supprimer l'un des dispositifs de mesure de puissance que vous n'utilisez pas. La consommation cumulée est mise à jour tous les 0.01 kWh.

**Attention :** La remontée des informations de consommation nécessite l'activation du polling associé (pollingBlitzwolfPower) voir la section [Réglages > Interrogation des dispositifs](WebUI_Reglages.md#interrogation-des-dispositifs)

**Information :** Pour un lave-linge, une fréquence de 60s est suffisante pour contrôler la fin du cycle.
