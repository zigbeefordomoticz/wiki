# Schneider Wiser: how to set up

How to prepare the plugin for Schneider Wiser devices. See [Schneider Wiser](Corner_Schneider_Wiser.md) for the devices and their protocol notes.

## Which Wiser are you using?

Schneider has two Wiser families, which need a different setup:

| Family | Devices (Zigbee models) | IEEE starts with |
| ------ | ----------------------- | ---------------- |
| **Legacy Wiser** | Thermostat `EH-ZB-RTS`, radiator valve `EH-ZB-VACT`, actuators `EH-ZB-HACT` / `EH-ZB-LMACT`, smart plugs `EH-ZB-SPD` / `EH-ZB-SPD-V2`, energy meter `EH-ZB-BMS` | `00124b` |
| **Wiser Home** and other recent Schneider devices | Thermostat CCTFR6400 (`Wiser2-Thermostat`), radiator valve CCTFR6100 (`iTRV`), micromodules (`PUCK…`), shutter switches, socket outlets… | `588e81` and others |

The recent devices are standard Zigbee 3.0 devices: pair them as usual (see [Add a new device](HowTo_Pairing-device.md)). If the Wiser Home thermostat doesn't talk to the plugin, enable the `Wiser2` setting (see below).

The **legacy Wiser** devices only work on a network with a specific *extended PAN ID*, and with the settings below.

## Settings for legacy Wiser

All these settings are in the WebUI *Settings* page, with *Advanced settings* switched on (see [WebUI Settings](WebUI_Settings.md)).

| Setting | Section | Value | Why |
| ------- | ------- | ----- | --- |
| `enableSchneiderWiser` | *Pairing settings* | on | The plugin asks the legacy Wiser devices for their model during pairing. |
| `Wiser` | *Zigpy CIE specific configuration* (zigpy coordinators) | on | Adds the endpoint `0x0b` the legacy Wiser devices talk to. Needs a plugin restart. |
| `extendedPANID` | *Coordinator settings* | `xxxx484504015e10` | The legacy Wiser devices only join a network whose extended PAN ID ends with `484504015e10`. Replace `xxxx` with any 4 hexadecimal digits, for example `2141484504015e10`. |

For a Wiser Home thermostat (CCTFR6400) that doesn't communicate, enable `Wiser2` in *Zigpy CIE specific configuration* instead: it adds the endpoint `0x03` used by these devices.

### The extended PAN ID requires a new network

The extended PAN ID is only applied when the coordinator forms a new network. **Changing it erases the network: all the devices already paired must be paired again**, whatever their brand. The other brands (Ikea, Philips, Xiaomi, Tuya…) work fine on a network with a Wiser extended PAN ID, so if you plan to use legacy Wiser devices, set it before pairing anything.

1. Set `extendedPANID` (and the other settings above) and click *Validate*.
1. Turn the `autoRestore` setting off (*Zigpy CIE specific configuration*, advanced): otherwise the plugin restores the last coordinator backup, with the old extended PAN ID, instead of forming a new network.
1. Form a new network: in Domoticz, *Setup > Hardware*, select the plugin hardware, set *Initialize Coordinator* to *True* and click *Update* (see [Plugin settings](Plugin_Settings.md); if the network isn't formed, see [Form a network with a zigpy coordinator](HowTo_Form-network-zigpy.md)).
1. The plugin forms the network, then sets *Initialize Coordinator* back to *False* and restarts by itself; check it in the hardware list, and set it back yourself if needed.
1. Pair the devices, then turn `autoRestore` back on.

## Channel

The legacy Wiser devices were tested on channels 11, 15 and 25. See [Change the Zigbee channel](HowTo_Change-ZigBee-channel.md).

## Device parameters

Some Wiser devices have device parameters (room number, lock, open-window detection, shutter travel time…): see [Device parameters](HowTo_Device-parameters.md#schneider-wiser).
