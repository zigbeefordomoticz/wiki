# Tutoriel - Mettre à jour le firmware d'un objet

Ce tutoriel explique comment mettre à jour le firmware (le logiciel interne) d'un objet ZigBee avec la ZiGate.

## Avant propos

Le plugin est capable d'envoyer une mise à jour de firmware d'un dispositif à condition que celui-ci respect le protocole Zigbee Over-The-Air (OTA). ???
In addition you need to be able to pull the brand firmware for your devices.
Certain fabricant donne un accès libre à firmware de leur dispositif, d'autre ne le font pas.

_La mise a jour du firmware d'un dispositif n'est donc pas possible sur tous les dispositifs.__

## Liste de fabricant partageant leur firmwares

| Fabricant | Dossier contenant les firmwares |
| --------- | ------------ |
| IKEA TRADFRI | Domoticz-Zigate/OTAFirmware/IKEA-TRADFRI |
| LEDVANCE | Domoticz-Zigate/OTAFirmware/LEDVANCE |
| LEGRAND | Domoticz-Zigate/OTAFirmware/LEGRAND |
| Philips Hue | Domoticz-Zigate/OTAFirmware/PHILIPS |

Chaque dossier de fabricant contient un fichier README.md qui décrit ou trouver le firmware.


## Méthodes

### Récupérer les firmwares

### Ikea Tradfri

???

Un script est disponible pour télécharger tous les firmwares depuis le site web d'Ikea.

* Aller dans le dossier du firmware d'Ikea : `cd Domoticz-Zigate\OTAFirmware\IKEA-TRADFRI`

* Lancer le script pour télécharger le firmwares : `../../Tools/ikea-ota-download.py`

* Ne conserver que les firmwares que des dispositifs à mettre à jour (supprimer les autres)

*

 1. Enable Over-the-Air upgrade in the plugin

   This is done via the Web admin menu in Settings

   ![Enable OTA](../Images/OTA.png)


 When the enable OTA is activated (save) restart the plugin, and the plugin will verify each of the devices and if needed the firmware will be updated.

 PS/ There is a tempo of 1H (default) before starting the process.


## Références
 * https://github.com/dresden-elektronik/deconz-rest-plugin/wiki/OTA-Image-Types---Firmware-versions
