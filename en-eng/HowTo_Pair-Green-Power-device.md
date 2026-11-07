# Pair a Green Power device

This how-to explains how to pair a Zigbee Green Power device (switch, remote, sensor) with the plugin, and how to follow the pairing on the *Admin > Provisionning* page of the WebUI.

## What is different with Green Power

A Green Power device is built to use as little energy as possible: some run on the energy of the button press itself, others on a battery that lasts for years. To save that energy:

* it **does not join** the Zigbee network like other devices: it only sends short frames, and the coordinator (or a router close to it) picks them up;
* it **does not listen**: it never gets an answer. Nothing tells the device that it is paired, so **you have to take it out of its pairing mode yourself**;
* it **sends on one channel**. Some devices start their pairing mode on channel 11 and move to the next channel at each press, until they reach the channel of your network.

The plugin learns about a Green Power device from the pairing request (*Commissioning*) the device sends in its pairing mode, while the plugin pairing is open. Without a view on what happens, it is hard to know whether the device reaches the network: the *Green Power* card of the *Admin > Provisionning* page shows it as it happens.

## Before you start

* **Enable Green Power pairing in the plugin.** In the WebUI *Settings*, switch on the advanced settings, then in the *Zigpy* section enable **Accept Green Power devices when pairing is open** (`GreenPowerEnable`). No restart is needed. While it is off, opening the pairing accepts Zigbee devices only, and the *Green Power* card says so.
* **Let Domoticz accept new devices**, as for any pairing: see [Add a new device](HowTo_Pairing-device.md#before-you-start-let-domoticz-accept-new-devices).
* **Know your network channel.** The *Green Power* card shows it: *Network on channel N*. A device you set to a channel by hand must use this one. Green Power devices use channels 11 to 26.
* **Coordinator.** Tested with a Silicon Labs (EZSP) coordinator. With a deCONZ (ConBee, RaspBee) coordinator, Green Power pairing stays closed. Other coordinators have not been tested yet.

## Pairing

1. Open the WebUI, *Admin > Provisionning*, and click *Open for 4 minutes* (see [Add a new device](HowTo_Pairing-device.md#1-anywhere-on-the-network)).
1. Wait until the *Green Power* card shows **Accepting Green Power devices** and the line **Pairing opened**.
1. Put the device in its pairing mode, as its manual says (see [the Sunricher switch](#sunricher-zgp2801k2-dim) for an example).
1. Watch the *Green Power* card: each frame the network hears from a Green Power device is listed, newest first, with the device ID (for example `0xC220BD02`), what it sent and the signal strength.
1. As soon as the card shows **Paired**, **take the device out of its pairing mode**, as its manual says (often: press another button). Left in its pairing mode, some devices change channel at the next press, and the network no longer hears them.
1. The card then shows **Widgets created**, and the device appears in **Devices that joined** with a *Green Power* badge, its model and its widget.

### What the Green Power card tells you

| Line | Meaning | What to do |
|------|---------|------------|
| *Heard: Commissioning* · *Pairing request heard on the network's channel* | The device is in its pairing mode, on the right channel | Wait for *Paired* |
| *Paired* · *Now take the device out of its pairing mode* | The plugin has paired the device | Take the device out of its pairing mode, now |
| *Widgets created (…)* | The Domoticz widget exists | Done |
| *Heard: On* (or another command) · *The device reaches the network, but is not in its pairing mode* | A device not paired yet, on the right channel, used normally | Put it in its pairing mode |
| *Heard: Commissioning* · *Pairing request refused: pairing is closed* | The plugin pairing was not open | Open the pairing, then repeat |
| *Heard an encrypted frame* · *A device not paired yet* | A device not paired yet, used normally | Put it in its pairing mode |
| *Paired, but no widget for this device* | The device is paired, but no configuration gives it a widget | Report it, with the plugin log |
| *The device is paired but still in its pairing mode* | A paired device still sends pairing requests | Take it out of its pairing mode |
| Nothing at all | The network does not hear the device | Check the channel (see below), move closer to the coordinator, check the pairing mode |
| *Pairing opened, without Green Power devices (setting off)* | `GreenPowerEnable` is off | Enable it (see [Before you start](#before-you-start)), open the pairing again |

## Sunricher ZGP2801K2-DIM

Green Power switch with an *On* and an *Off* button: a short press sends *On* or *Off*, holding a button dims up or down until it is released. Tested on 7 November 2026 with a Silicon Labs coordinator on channel 11.

1. Open the pairing on the plugin side, and wait for **Pairing opened** on the *Green Power* card.
1. Put the switch in its pairing mode, always with the **On** button:
   1. press and hold *On* for more than 10 seconds, then release it;
   1. press *On* once, then release it;
   1. press and hold *On* for more than 10 seconds again, then release it.
1. Wait for a second, then press *On*, and keep pressing *On* every second or two.
1. As soon as the *Green Power* card shows **Paired**, close the pairing mode of the switch: press **Off** once.

Each press of *On* in the pairing mode sends a pairing request and moves the switch to the next channel, starting at channel 11: keep pressing until the card shows *Paired*. A press of the other button ends the pairing mode.

The plugin creates an **On/Off** widget: the switch declares itself as an On/Off switch (Green Power device type `0x02`) and gives neither its manufacturer nor its model. The dimming commands (*Move Up*, *Move Down*, *Stop*) reach the plugin, but are not used yet.

## Check a paired device

*Tools > Data > Green Power devices (raw)* shows what the plugin keeps for each Green Power device: its ID, its device type, the security level, the last frame counter, its model and its widgets. The security key of the device is never shown.

A Green Power device is not listed in *Device names*, *Devices (raw)* or *Management > Devices*, which only show Zigbee devices.

## Remove a Green Power device

Delete its widget in Domoticz (*Setup > Devices*). When the last widget of a Green Power device is deleted, the plugin removes the device from its list and from the network.

To pair it again, follow [Pairing](#pairing) from the start.
