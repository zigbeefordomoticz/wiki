# Device OTA Firmware List

This page covers OTA (Over-The-Air) firmware files that can be used with the plugin's built-in OTA update feature.

## How OTA Firmware Updates Work

1. Download the firmware file for your device (see sources below)
2. Place the file in the plugin's firmware directory, in the folder for that
   manufacturer (`Domoticz-Zigbee/OTAFirmware/<MANUFACTURER>/`)
3. Restart the plugin — firmware folders are only read at startup
4. Start the update from the WebUI under **Admin → Firmware**, then wait: the transfer
   begins the next time the device asks for an image, which can take hours

For a step-by-step walkthrough, see [Upgrading device firmware](HowTo_Update-device-firmware.md).

## Firmware Sources by Brand

| Brand | Source |
|-------|--------|
| IKEA Tradfri | [IKEA OTA server (community mirror)](https://wazowski.zigate.fr/fw/ikea/) |
| Legrand | [Retrieving Legrand firmware](Corner_Retreiving-Legrand-Firmware.md) |
| Schneider Wiser | Embedded in the Wiser app — see [Schneider Wiser corner](Corner_Schneider_Wiser.md) |
| Texas Instruments coordinators | [Koenkk Z-Stack firmware](https://github.com/Koenkk/Z-Stack-firmware/tree/master/coordinator) |
| ZiGate | [ZiGate V1 releases](https://github.com/fairecasoimeme/ZiGate/releases) / [ZiGate+ V2 releases](https://github.com/fairecasoimeme/ZiGateV2/releases) |
| Silicon Labs coordinators | [zigpy firmware update guide](https://github.com/zigpy/zigpy/wiki/Coordinator-Firmware-Updates) |

## Known OTA Firmware Files

| Product Model | Image type | FW Version | Filename |
|---------------|------------|------------|----------|
| TRADFRI bulb E27 WS clear 950lm | 0x2202 | 2.3.050 | 159695-2.1-TRADFRI-bulb-ws-1000lm-2.3.050.ota.ota.signed |

> **Note:** This table is community-maintained and may be incomplete. If you have tested a firmware file with the plugin successfully, please contribute via a forum post or pull request.
