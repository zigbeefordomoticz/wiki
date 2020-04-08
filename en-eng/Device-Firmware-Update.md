# Firmware update of a device or a serie of devices

## Overview

The purpose is to describe the steps to launch the automatic device firmware update.


## Brands available

The plugin is able to push firmware update to any brand which respect the Zigbee Over-The-Air (OTA) protocol. 
In addition you need to be able to pull the brand firmware for your devices.
So brand/manufacturer are giving a free access to their firmware, some not.

### Which Manufacturer provides firmware

* Ikea Tradfri
* LEDVANCE
* Philips

### Where to store the Firmware

The plugin host a directory tree to store the firmware for each Manufacturer

| Directory | Manufacturer |
| --------- | ------------ |
| Domoticz-Zigate/OTAFirmware/IKEA-TRADFRI/ | IKEA TRADFRI Firmwares |
| Domoticz-Zigate/OTAFirmware/LEDVANCE | LEDVANCE Firmwares |
| Domoticz-Zigate/OTAFirmware/LEGRAND | LEGRAND Firmwares |
| Domoticz-Zigate/OTAFirmware/PHILIPS | Philips Hue Firmware |


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
 
 
## References:
 * https://github.com/dresden-elektronik/deconz-rest-plugin/wiki/OTA-Image-Types---Firmware-versions
 
 
 
