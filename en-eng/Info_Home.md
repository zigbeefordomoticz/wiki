# Getting Started with ZigBeeForDomoticZ

## What is this plugin?

ZigBeeForDomoticZ bridges a Zigbee coordinator (USB dongle, module or network coordinator) to [Domoticz](https://www.domoticz.com), your home automation software. Once installed, Zigbee devices paired with the coordinator appear as widgets in Domoticz, where they can be controlled and automated — entirely locally, with no cloud dependency.

## Supported Coordinators

The plugin supports several Zigbee coordinator hardware types:

* **Texas Instruments** (CC2652P/R/RB, CC1352P/R via zigpy-znp)
* **Silicon Labs / EZSP** (EFR32MG21/MG24 and other EFR32MGxx via bellows)
* **deCONZ** (ConBee II, RaspBee II via zigpy-deconz; ConBee III support is deprecated because of instability)
* **Bouffalo Lab** (via zigpy-blz)
* **ZiGate** (V1 and V2): no longer supported, see [Legacy ZiGate](Readme.md#legacy-zigate)

See [Compatible coordinators](Coordinators.md) for example hardware and firmware.

## Key Features

* Automatic device discovery and Domoticz widget creation
* Over-the-air (OTA) firmware updates for supported devices
* Web interface (`http://<Domoticz server>:9440/z4d/`) for device management, network topology, and plugin settings
* Group management — control multiple devices simultaneously
* Network topology map — visualise your Zigbee mesh
* About 690 certified device models; most other Zigbee 3.0 devices work too

## Compatible Devices

* [Certified device list — Zigbee Device Compatibility Repository](https://zigbee.blakadder.com/z4d.html)
* [Certified devices](Info_Compatible-devices.md)

## Where to Start

Follow the four installation steps, then pair your devices:

1. [Install the plugin](Plugin_Installation.md)
2. [Declare the plugin hardware in Domoticz](Plugin_Settings.md)
3. [Open the WebUI and check the settings](Plugin_Configuration.md)
4. [Open the WebUI from the Domoticz menu](Plugin_Integration.md)

Then [pair your first device](HowTo_Pairing-device.md).

If you run into problems, check the [FAQ](Problem_FAQ.md) or the [Troubleshooting guide](Troubleshooting_Pairing.md).
