# Tutoriel - Mettre à jour le firmaware d'un dispositif

Ce tutoriel explique comment mettre à jour le firmware (le logiciel interne) d'un dispositif ZigBee avec la Zigate.

## Avant propos

Le plugin est capable d'envoyer une mise à jour de firmware d'un dispositif à condition que celui-ci rescpect le protocole Zigbee Over-The-Air (OTA).
In addition you need to be able to pull the brand firmware for your devices.
Certain fabricant donne un accès libre à firmware de leur dispositif, d'autre ne le font pas.

_La mise a jour du firmaware d'un dispositif n'est donc pas possibile sur tous les dispositifs.__

## Liste de fabricant patagant leur firmwares

| Fabricant | Dossier contenant les firmwares |
| --------- | ------------ |
| IKEA TRADFRI | Domoticz-Zigate/OTAFirmware/IKEA-TRADFRI |
| LEDVANCE | Domoticz-Zigate/OTAFirmware/LEDVANCE |
| LEGRAND | Domoticz-Zigate/OTAFirmware/LEGRAND |
| Philips Hue | Domoticz-Zigate/OTAFirmware/PHILIPS |


## Retreive Firmware

In each of the Manufacturer directory a README.md file is available and describe where to find the firmware.

### For IKEA TRADFRI

For the IKEA TRADFRI we are providing a script to retreive all Firmware from the IKEA web site.

1. Go to the IKEA Firmware folder

   ```cd Domoticz-Zigate\OTAFirmware\IKEA-TRADFRI ```
   
1. Launch the script to retreive the firmware

   ```../../Tools/ikea-ota-download.py```
   
1. Optionaly remove some unecessary firmware file

   If you are for instance looking to upgrade only your Signal Repeater, or the Ikea Tradfri outlet, remove all files but keep
   
   * the file which contains `TRADFRI-control-outlet`for the Control Outlet
   * the file which contains `TRADFRI-signal-repeater`for the Signal Repeater
 
 1. Enable Over-the-Air upgrade in the plugin
 
   This is done via the Web admin menu in Settings
   
   ![Enable OTA](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/OTA.png)
   
 
 When the enable OTA is activated (save) restart the plugin, and the plugin will verify each of the devices and if needed the firmware will be updated.
 
 PS/ There is a tempo of 1H (default) before starting the process.
 
 
## Références 
 * https://github.com/dresden-elektronik/deconz-rest-plugin/wiki/OTA-Image-Types---Firmware-versions
 
 
 
