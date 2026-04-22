# Getting Started with ZigBeeForDomoticZ

## What is this plugin?

ZigBeeForDomoticZ bridges a Zigbee coordinator (USB dongle or module) to [Domoticz](https://www.domoticz.com), your home automation software. Once installed, Zigbee devices paired with the coordinator appear as widgets in Domoticz, where they can be controlled and automated — entirely locally, with no cloud dependency.

## Supported Coordinators

The plugin supports several Zigbee coordinator hardware types:

* **ZiGate** (V1 and V2 — USB, PiZiGate, WiFi, Ethernet)
* **Texas Instruments** (CC2652P/R/RB, CC1352P/R via zigpy-znp)
* **Silicon Labs / EZSP** (EFR32MGxx series via zigpy-bellows)
* **deCONZ** (ConBee II/III, RaspBee II via zigpy-deconz)

See [Compatible coordinators](Coordinators.md) for the full list and firmware requirements.

## Key Features

* Automatic device discovery and Domoticz widget creation
* Over-the-air (OTA) firmware updates for supported devices
* Web interface (accessible at `/z4d`) for device management, network topology, and plugin settings
* Group management — control multiple devices simultaneously
* Network topology map — visualise your Zigbee mesh
* Support for ~500 certified devices; any Zigbee 3.0-compliant device may also work

## Compatible Devices

* [Certified device list — Zigbee Device Compatibility Repository](https://zigbee.blakadder.com/z4d.html)
* [Locally certified devices](Info_Compatible-devices.md)

## Where to Start

Follow these four steps in order:

1. [Install the plugin](Plugin_Installation.md)
2. [Configure initial settings](Plugin_Settings.md)
3. [Set up Domoticz integration](Plugin_Configuration.md)
4. [Pair your first device](HowTo_Pairing-device.md)

If you run into problems, check the [FAQ](Problem_FAQ.md) or the [Troubleshooting guide](Troubleshooting_Pairing.md).
