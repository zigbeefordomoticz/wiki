# Compatible coordinators

The coordinator is the Zigbee radio (USB dongle, module or network device) that creates and manages your Zigbee network. The plugin talks to it through the [zigpy](https://github.com/zigpy/zigpy) libraries, which support several coordinator families.

## Supported coordinators

| Family | *Coordinator Model* to select | Example hardware | Firmware | Notes |
| ------ | ----------------------------- | ---------------- | -------- | ----- |
| **Texas Instruments** (zigpy-znp) | *Texas Instruments ZNP (via zigpy)* | CC2652P/R/RB and CC1352P/R based: Sonoff ZBDongle-P, SMLIGHT SLZB-06, Electrolama zzh… | Z-Stack coordinator firmware from [Koenkk/Z-Stack-firmware](https://github.com/Koenkk/Z-Stack-firmware/tree/master/coordinator) only | CC2531 and CC2530 are obsolete: not recommended. [Hardware list](https://github.com/zigpy/zigpy-znp#hardware-requirements) |
| **Silicon Labs** (bellows) | *Silicon Labs EZSP (via zigpy)* | EFR32MG21 / MG24 based: Sonoff ZBDongle-E, SMLIGHT SLZB-06M / SLZB-07, Home Assistant SkyConnect / Connect ZBT-1, Elelabs ELU013 / ELU023… | EmberZNet NCP (EZSP) firmware, from the hardware maker | [Hardware list](https://github.com/zigpy/bellows#hardware-requirement) |
| **deCONZ** (zigpy-deconz) | *Conbee/Rasbee I, II, III (via zigpy)* | Phoscon ConBee II, RaspBee II | deCONZ firmware from Phoscon | ConBee III support is deprecated in the plugin because of instability. [Hardware list](https://github.com/zigpy/zigpy-deconz) |
| **Bouffalo Lab** (zigpy-blz) | *Bouffalo Lab Zigbee (via zigpy)* | Bouffalo Lab based coordinators | See [zigpy-blz](https://github.com/bouffalolab/zigpy-blz) | |
| **ZiGate** | *ZiGate* / *ZiGate+* | ZiGate V1, ZiGate+ V2 | | **No longer supported**: see [ZiGate (legacy)](#zigate-legacy). |

Prefer a recent Texas Instruments (CC2652/CC1352) or Silicon Labs (EFR32MG21/MG24) coordinator, with an up-to-date firmware.

### USB or network coordinator

* A **USB** coordinator (or a module on a serial port) is connected with the *USB* connection type and its serial port.
* A **network** coordinator (Ethernet or Wi-Fi, such as the SMLIGHT SLZB-06 family) is connected with the *Socket* connection type, its IP address and its port.

See [Plugin settings](Plugin_Settings.md). Plug a USB coordinator on a USB extension cable, away from the computer and from USB 3 ports, which disturb the 2.4 GHz band.

## Some explanations

### Limited number of devices

A coordinator can only have a limited number of devices attached directly to it (its *children*); the others join through routers (mains-powered devices). The limits depend on the coordinator and its firmware: build your network with enough routers (see [Build a Zigbee network](HowTo_Build-a-ZigBee-network.md)).

On the Domoticz side, the plugin uses the Domoticz *extended* plugin framework: each Zigbee device can have up to 254 widgets, and there is no limit on the number of widgets of the plugin as a whole. You no longer need to delete widgets to stay under a limit.

### Limited number of groups

The coordinator, like any device, can only belong to a limited number of groups, depending on the coordinator and its firmware. This matters when the coordinator must receive the commands of remotes bound to groups (see [Manage Zigbee groups](HowTo_Group-management.md)).

Each device knows the groups it belongs to, and can usually belong to a few groups only (often 5); the exact number depends on the device.

### Transmit power

The transmit power can be raised or lowered with the `TXpower_set` setting (WebUI *Settings*, *Coordinator settings*). More power is not always better: a strong coordinator doesn't help battery devices that answer with low power. See [Change the coordinator transmit power](HowTo_Change-TX-Power.md) for what each coordinator supports and the maximum power of common chips.

## ZiGate (legacy)

ZiGate coordinators are no longer supported by the plugin: we advise moving to a Texas Instruments, Silicon Labs or deCONZ coordinator. For existing users:

| Coordinator | Firmware | Devices in all | Devices attached directly | Groups of the coordinator | Minimum firmware |
| ----------- | -------- | -------------- | ------------------------- | ------------------------- | ---------------- |
| ZiGate V1 (USB, PiZiGate, Wi-Fi, Ethernet) | Legacy | 40 | | 5 | 3.1e |
| ZiGate V1 | OptiPDM | 70 | 20 | 5 | 3.1e |
| ZiGate+ V2 (USB, PiZiGate, Wi-Fi, Ethernet) | | 200 | 20 | 15 | 3.1f |

See the [Legacy ZiGate](Readme.md#legacy-zigate) pages, and on zigate.fr (in French): [ZiGate backup & restore](https://zigate.fr/documentation/sauvegardez-et-restaurez-votre-zigate), [ZiGate firmware update](https://zigate.fr/documentation/mise-a-jour-de-la-zigate).
