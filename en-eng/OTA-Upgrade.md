# Firmware update Over-The-Air

Ikea is providing a lift of Firmware for their Tradfri devices. A copy of those firmware have been made available for you.

The OTA upgrade process implemented in the plugin is pretty basic

```
for each available Firmware
    Do
         For each Device matching the Firmware brand
             Do
                  Propose the firmware to the device
                  if the firmware is accepted for upgrade then
                     Do 
                        Transfert the firmware to the device
                        Upgrade
                     Done
             Done
    Done
```  

## How to enable the OTA update

If you have Ikea/Tradfri main powered devices (for now), you might check if some of your devices are eligeable for Firmware update.
By enable this feature, the plugin will propose to each devices the available firmware version for update. If eligeable the upgrade will be triggered.

1. Edit the file `Conf/PluginConf-xx.txt`

  ```
  'allowOTA':'1',
  'waitingOTA':'3600',
  ```

  * allowOTA set to 1, will enable the OTA upgrade feature in the plugin.
  * waitingOTA is the amount of time (in seconds) the plugin will wait from start before starting the process. Please do consider carefully seting a low value here, as the process can load the Zigate in terms of Traffic, so try to avoid value lower than 300 ( 5 minutes ).
  
## Tracking Upgrade

The plugin is pushing information via the admin Zigate Widget

Here after is a screenshot of the Notification Text widget showing the starting time of the OTA process and its completion.

![Admin Widget showing OTA](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/OTAu.png)

## Warnings

* The Transfer process over the Zigbee network takes time. For an Ikea Tradfri WhiteColor bulb it took me about 15 minutes to get the transfer completed.
* In case the plugin doesn't find any firmware to transfer, then it will hibernate, and be reactivated at the next Plugin start.
* In the case the transfer failed or abort, the plugin will re-try during the next cycle. There is a full cycle every 6 hours

## Files location

All Firmwares are available under the `OTAFirmware` folder
