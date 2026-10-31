# Change the coordinator transmit power

## Introduction

The transmit power (TX power) is the power, in dBm, at which the coordinator sends its radio frames. +3 dBm is twice the power, -3 dBm half of it.

By default the plugin doesn't set it: the coordinator keeps its own. You can raise or lower it with the `TXpower_set` setting. Before you do, keep in mind that a Zigbee link works in both directions, and that the TX power only changes one of them.

This page describes the plugin from stable9 9.1.008. For the change from older versions, see [Upgrading from 9.1.007 or older](#upgrading-from-91007-or-older).

## What more power brings

* **Longer direct links from the coordinator.** Devices further away, or behind a wall, hear it better.
* **Fewer hops** for the routers close to the coordinator, so a little less latency.
* **A workaround for a coordinator placed badly** (in a cupboard, next to the computer, behind metal).

## What less power brings

* **Less interference** with your own Wi-Fi and with your neighbours' networks. See [Zigbee and Wi-Fi](Info_ZigBee-and-Wifi.md).
* **Compliance with your country's rules.** The limits apply to the radiated power, antenna gain included, and differ between regions. zigpy, the library the plugin uses for its coordinators, treats 8 dBm as safe in every region.
* **A mesh that relies on routers** instead of on many weak direct links to the coordinator.

## What it costs

More power is not always better:

* **It doesn't improve reception.** The coordinator hears the devices no better than before. A battery device transmits with low power: it may hear the coordinator and still fail to answer it. The link then works in one direction only, which looks like a device that "sometimes" responds.
* **More end devices pick the coordinator as their parent**, because it looks like the strongest router around. The coordinator can only hold a limited number of direct children, which depends on the chip and firmware (see [Compatible coordinators](Coordinators.md#limited-number-of-devices)). Over that limit, new devices fail to join or keep rejoining.
* **Devices may change their parent** after the change, so expect the network to settle for a while.
* **It may be outside what your country allows.** See [What less power brings](#what-less-power-brings).

To cover a large house, adding routers (mains-powered devices) is usually more effective than raising the coordinator's power.

## Increase or decrease

Both are possible on Texas Instruments and Silicon Labs coordinators:

* the value is a whole number of dBm, negative values included (for example `-5` or `10`);
* `0` means "keep the coordinator's own power", so exactly 0 dBm can't be requested: use `-1` or `1`;
* at start, values above 20 dBm are lowered to 20 dBm. A change from the WebUI is limited to the range -22 to +22 dBm;
* the firmware may lower the value further, to what the chip supports. See the [maximum power of common chips](#maximum-power-of-common-chips).

ConBee / RaspBee (deCONZ) and BLZ coordinators don't support it. On a ZiGate V1 it can only be lowered.

## Coordinators and what they support

| Coordinator family | Supported | When a change applies | Kept across a restart |
| ------------------ | --------- | --------------------- | --------------------- |
| Texas Instruments (ZNP): CC2652, CC1352, CC2538… | Yes | At once | No: the firmware's own power comes back at each radio reset, and the plugin sets the value again at every start |
| Silicon Labs (EZSP): EFR32MG21, EFR32MG24, MGM210… | Yes | At the next plugin restart | Yes: the stick saves it to its own memory (when the firmware supports it) |
| ConBee / RaspBee (deCONZ) | No | The value is ignored | — |
| BLZ | No | The value is ignored | — |
| ZiGate V1 (legacy) | 4 levels only: 0, -9, -20 and -32 dBm | At the next plugin restart | — |
| ZiGate+ V2 (legacy) | No: the plugin doesn't set it | — | — |

<!-- Update the Silicon Labs row once Domoticz-Zigbee #2166 is released (planned for 9.1.009): a change from the WebUI then applies at once. -->

### Silicon Labs: the saved value

A Silicon Labs stick keeps the last power it was given, even after the plugin stops setting one:

* setting `TXpower_set` back to `0` does **not** bring the default back: the stick stays at the last value. To return to the default of the radio library, set `8`;
* when the stick forms or restores a network without a TX power, it uses 8 dBm;
* the plugin sets 8 dBm once on a stick that an older plugin version left at 0 dBm (see [Upgrading from 9.1.007 or older](#upgrading-from-91007-or-older)).

### Maximum power of common chips

| Chip | Maximum output power |
| ---- | -------------------- |
| TI CC2652P, CC1352P (embedded power amplifier) | +20 dBm |
| TI CC2652R, CC2652RB, CC1352R | +5 dBm |
| TI CC2538 / CC2531 / CC2530 + CC2591 or CC2592 amplifier | +19 dBm |
| TI CC2538 | +7 dBm |
| TI CC2531, CC2530 | +4.5 dBm |
| Silicon Labs EFR32MG24A420 | +19.5 dBm |
| Silicon Labs EFR32MG24A410 | +10 dBm |
| Silicon Labs EFR32MG21A020, EFR32MG21B020 | +20 dBm |
| Silicon Labs EFR32MG21A010 | +10 dBm |
| Silicon Labs EFR32MG21B010 | +10.5 dBm |
| Silicon Labs MGM210P | +20 dBm |
| Silicon Labs MGM210L | +12.5 dBm |
| Silicon Labs MGM13P | +19 dBm |
| Silicon Labs MGM13S, EFR32MG13P732, EFR32MG13P632 | +10 dBm |

The firmware and the board (antenna, external amplifier) also matter: two sticks with the same chip don't always reach the same range.

## Change it with the plugin

1. Go to *Settings*, *Coordinator settings*, and show the advanced settings (see [WebUI Settings](WebUI_Settings.md#coordinator-settings)).
1. Set `TXpower_set`:
   * Texas Instruments, Silicon Labs: the power in dBm, or `0` to keep the coordinator's own;
   * ZiGate V1: one of the 4 levels in the list.
1. Click *Save* (*Validate* before plugin 9.1.009).
1. On Silicon Labs and ZiGate V1, restart the plugin.

The `Certification` setting (CE or FCC) is only sent to ZiGate coordinators. It doesn't limit the TX power of the other coordinators.

### Check the power

At start, the plugin log shows:

```
Effective TxPower: 5, Max TxPower: 20
```

`Effective TxPower` is the value the plugin sets (`None` when `TXpower_set` is `0`), and `Max TxPower` the upper limit.

On Silicon Labs, the *Network settings* block that follows also gives the power the stick reports (`TX Power:`). On the other coordinators this line shows `None`.

## Upgrading from 9.1.007 or older

Up to 9.1.007, `TXpower_set` = `0`, the default, forced the coordinator to 0 dBm at every start. On Silicon Labs it also forced a power mode (boost and alternate transmitter output). Installations that never changed the setting ran at 0 dBm.

From 9.1.008:

* with `TXpower_set` = `0`, the plugin leaves the coordinator's power alone;
* a Silicon Labs stick still at 0 dBm is set once to 8 dBm, the default of the radio library, at the first start. The log shows:

  ```
  Coordinator TX power is 0 dBm, left by an older plugin version: setting 8 dBm, the radio library's default. Set TX Power in the plugin settings to choose another value
  ```

* a Texas Instruments coordinator goes back to its firmware's own power;
* with any other value, nothing changes.

The coordinator may then reach further than before. Some end devices may pick a different parent after the restart: give the network some time to settle.
