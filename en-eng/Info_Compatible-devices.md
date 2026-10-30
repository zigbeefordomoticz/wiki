# Certified devices

A **certified** (or *optimized*) device is a device model for which the plugin has a configuration file: its widgets, reporting and specific handling are known and tested. See [Compatible objects](Objects.md) for what this means for you.

## Where to look

* **[zigbee.blakadder.com](https://zigbee.blakadder.com/z4d.html)** lists the devices known to work with the plugin (gateway *Zigbee for Domoticz*), with pictures and pairing tips. Search it first.
* **The [z4d-certified-devices](https://github.com/zigbeefordomoticz/z4d-certified-devices) repository** holds the configuration files the plugin uses, one per Zigbee model, under `z4d_certified_devices/Certified/<brand>/<model>.json`. It is installed with the plugin's Python requirements, and updated when you upgrade the plugin (see [Plugin update](Plugin_Update.md)). A model is certified when a file with its Zigbee model name exists there (see [Model name resolution](Technical/Model-name-resolution.md)).

To find out whether your device is certified, look for its Zigbee model name (shown in *Management > Device Management*, *Model* column) in the repository, or check whether Device Management shows it as *Optimized* once it is paired.

## Certified models by brand

693 configuration files in z4d-certified-devices 10.607 (October 2026). The folder names are those of the repository; some brands are filed under the name of the manufacturer that makes the device (for example `LUMI` for Aqara/Xiaomi, `TDURM0D01` for Müller Licht Tint), and `Others` gathers single models of small brands.

| Brand (folder) | Models |
| -------------- | ------ |
| [Adeo](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Adeo) | 13 |
| [Aeotec](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Aeotec) | 2 |
| [Airzone](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Airzone) | 1 |
| [Aotec](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Aotec) | 1 |
| [Awox](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Awox) | 2 |
| [Bitron](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Bitron) | 7 |
| [Bituo](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Bituo) | 1 |
| [Candeo](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Candeo) | 2 |
| [Casa.ia](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Casa.ia) | 18 |
| [Chameleon](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Chameleon) | 7 |
| [CLEODE](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/CLEODE) | 3 |
| [Custom](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Custom) | 1 |
| [Danalock](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Danalock) | 1 |
| [Danfoss](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Danfoss) | 4 |
| [Develco](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Develco) | 12 |
| [EcoDim](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/EcoDim) | 3 |
| [ENKI-LEXMAN](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/ENKI-LEXMAN) | 3 |
| [Eurotronics](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Eurotronics) | 1 |
| [eWeLink](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/eWeLink) | 5 |
| [Excellux](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Excellux) | 1 |
| [GammaTroniques](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/GammaTroniques) | 1 |
| [Gledopto](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Gledopto) | 17 |
| [Heiman](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Heiman) | 27 |
| [Hobeian](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Hobeian) | 10 |
| [Icasa](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Icasa) | 2 |
| [Idinio](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Idinio) | 1 |
| [Ikea](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Ikea) | 63 |
| [Iluminize](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Iluminize) | 2 |
| [Innr](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Innr) | 8 |
| [Konke](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Konke) | 5 |
| [Legrand](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Legrand) | 15 |
| [LIVOLO](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/LIVOLO) | 1 |
| [Lixee](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Lixee) | 10 |
| [LS-Deutschland-GmbH](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/LS-Deutschland-GmbH) | 1 |
| [LUMI](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/LUMI) | 70 |
| [Namron](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Namron) | 1 |
| [Nexturn](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Nexturn) | 1 |
| [Nodon](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Nodon) | 8 |
| [Orvibo](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Orvibo) | 5 |
| [OSRAM](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/OSRAM) | 10 |
| [Others](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Others) | 18 |
| [Owon](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Owon) | 23 |
| [Philips](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Philips) | 48 |
| [Profalux](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Profalux) | 8 |
| [Robb-Smarrt](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Robb-Smarrt) | 2 |
| [SALUS](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/SALUS) | 1 |
| [Samotech](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Samotech) | 1 |
| [Schneider](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Schneider) | 18 |
| [SmartThings](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/SmartThings) | 1 |
| [Somfy](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Somfy) | 1 |
| [Sonoff](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Sonoff) | 38 |
| [Sunricher](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Sunricher) | 5 |
| [TDURM0D01](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/TDURM0D01) | 3 |
| [Tuya](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Tuya) | 165 |
| [TUYATEC](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/TUYATEC) | 3 |
| [Woolley](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Woolley) | 2 |
| [Ynoa](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Ynoa) | 2 |
| [Ysrai](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Ysrai) | 5 |
| [Zbeacon](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Zbeacon) | 1 |
| [Zehnder](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Zehnder) | 1 |
| [Zemismart](https://github.com/zigbeefordomoticz/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Zemismart) | 1 |

## My device is not in the list

* Many Zigbee 3.0 devices work without a configuration file: the plugin creates the widgets from what the device reports. See [Dealing with a non-optimized device](Problem_Dealing-with-none-optimized-device.md).
* You can write the configuration file yourself in `Conf/Local-Devices`: see [Get devices well integrated with the plugin](HowTo_Device-Customization.md).
