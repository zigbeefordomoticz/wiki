# Livolo corner

Findings about the Livolo Zigbee switches (single and double gang), from web searches and our own sniffing.

## Warning

Livolo switches **don't follow the Zigbee standard**:

* Stability can be an issue: from time to time the switch drops out of the network, and getting it back can be hard.
* Many Livolo devices on one network could hurt the other devices.

## Setup with a zigpy coordinator

Livolo switches send their messages to endpoint `0x08` of the coordinator. With a zigpy coordinator (Texas Instruments, Silicon Labs, ConBee/RaspBee…), enable the `Livolo` setting before pairing them: WebUI *Settings*, *Advanced settings* on, section *Zigpy CIE specific configuration*, **Enable the Livolo specific endpoint** (see [WebUI Settings](WebUI_Settings.md#zigpy-cie-specific-configuration)). Then restart the plugin.

## Pairing

1. Open the network for pairing (see [Add a new device](HowTo_Pairing-device.md)).
1. Press the Livolo switch for about 6 seconds, until you hear a beep.

After a while the switch is paired, and 2 widgets are created in Domoticz (`LivoloSWL` and `LivoloSWR`, left and right).

### One model name for two products

Single and double gang switches report the same Zigbee model, `TI0001`: the plugin can't tell them apart and always creates the 2 widgets. With a single gang switch, delete the `LivoloSWR` (right) widget.

## Notes from the ZiGate era

These findings were made with a ZiGate (firmware 3.1b or later needed to get the switch state when switched by hand) and haven't been checked with other coordinators:

* The switches could only be paired on channel **26**, and the ZiGate had to be left in pairing mode all the time.
* A switch paired on channel 26 could then be moved to channel 11 (and only 11): set the channel to 11 and restart the coordinator; after a while the switch follows. After a power cut, the switch had to be deleted and paired again on channel 26.
* When the switch drops out of the network and fails to rejoin, a power off/on or a reset (press the left button for 6 seconds) usually brings it back.

## On and Off

Livolo doesn't use the On/Off cluster (`0x0006`) to switch, but the Level Control cluster (`0x0008`), with two values:

* the level gives the command: On or Off;
* the transition time selects the gang: left or right.

| Command | Level |
| ------- | ----- |
| On      | 0x6C (108) |
| Off     | 0x01 (1) |

| Gang | Transition |
| ---- | ---------- |
| Left | 0x0001 (1) |
| Right | 0x0002 (2) |

For example, to switch the right gang on, send level `0x6C` with transition `0x0002`.

## References

* <https://github.com/fairecasoimeme/ZiGate/issues/148>
* <https://github.com/KiwiHC16/Abeille/issues/570>
