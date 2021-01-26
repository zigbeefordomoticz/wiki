# Blitzwolf corner

## Dispositifs Blitzwolf connus
* [Capteur de contact (BW-IS2)](https://zigbee.blakadder.com/BlitzWolf_BW-IS2.html) - (Eng)
* [Prise commandée avec mesures électriques 16A EU Plug (BW-SHP13)](https://zigbee.blakadder.com/BlitzWolf_BW-SHP13.html)
* [Détecteur de mouvement PIR (Passive InfraRed) (BW-IS3)](https://zigbee.blakadder.com/BlitzWolf_BW-IS3.html)
* [Capteur Température & Humidité avec écran (BW-IS4)](https://zigbee.blakadder.com/BlitzWolf_BW-IS4.html)
* [Capteur d'innondation (BW-IS5)](https://zigbee.blakadder.com/BlitzWolf_BW-IS5.html)

Pour le moment seule la prise connectée a été testée, cependant tous les produits Blitzwolf sont basés sur Tuya et devraient avoir un fonctionnement similaire.
Le capteur de température & humidité (BW-IS4) s'appuie sur un modèle au nom générique de Tuya TS0201 (https://zigbee.blakadder.com/Tuya_TS0201.html).

## Prise commandée avec mesures électriques 16A EU Plug (BW-SHP13)

Ce dispositif apparaitra une fois appairé sous le nom générique de TS0121.

Pour l'appairage du dispositif, tenir le bouton power enfoncé durant 5s, la lumière bleue flashera jusqu'à la fin complète du processus d'appairage.
Quatre dispositifs sont alors créés et remontés vers DomoticZ :

| Type de widget dans DomoticZ | Description  |
| Switch On/Off | La prise commandée |
| Mesure | Tension délivrée par la prise / Voltage |
| Mesure P1Meter | Consommation instantanée en Watt |
| Mesure General KWh| Consommation cumulée |  

Vous pouvez supprimer l'un des dispositifs de mesure de puissance que vous n'utilisez pas. La consommation cumulée est mise à jour tous les 0.01 kWh.
** Attention : ** La remontée des informations de consommation nécessite l'activation du polling associé (pollingBlitzwolfPower) voir [section Réglages](WebUI_Reglages.md)

** Information :** Pour un lave-linge, une fréquence de 60s est suffisante pour controler la fin du cycle.
