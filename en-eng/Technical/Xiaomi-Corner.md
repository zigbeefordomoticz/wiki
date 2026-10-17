# Xiaomi corner

See also [Aqara corner](../Corner_Aqara.md).

## Widgets of the Xiaomi QBKG12LM double switch (`lumi.ctrl_ln2`)

1. Switch for the left button (endpoint 01)
1. Power/Meter for the left button (endpoint 02)
1. Switch for the right button (endpoint 03)
1. Power/Meter for the right button (endpoint 04)

## Why does my Xiaomi sensor change network address?

This is how these devices behave: when they rejoin the network, they may get a new short address. The Zigbee protocol allows it, and the plugin follows the device by its IEEE address. No worries.

## Aqara vibration sensor: change the sensitivity

Set the `vibrationAqarasensitivity` device parameter to `'high'`, `'medium'` or `'low'` in *Management > Device Management*, parameter editor (see [Device parameters](../HowTo_Device-parameters.md)).
