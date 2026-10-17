# Aqara corner

Tips for the Aqara (Xiaomi Lumi) devices that need a specific setup with the plugin.

* [Opple wireless switches](#opple-wireless-switches)
* [Presence detector FP1 (RTCZCGQ11LM)](#presence-detector-fp1-rtczcgq11lm)

The device parameters mentioned on this page are set per device in *Management > Device Management*, parameter editor: see [Device parameters](HowTo_Device-parameters.md).

## Opple wireless switches

Models WXCJKG11LM, WXCJKG12LM and WXCJKG13LM (Zigbee models `lumi.remote.b286opcn01`, `lumi.remote.b486opcn01`, `lumi.remote.b686opcn01`): wireless switches with 2, 4 or 6 buttons.

### In Domoticz

After pairing, the plugin switches the remote to its *Opple* mode, where it sends every button action to the coordinator. One selector widget is created per button, showing the last action on that button: *Click*, *Double click*, *Triple click*, *Long click* and *Release*. Use these widgets in Domoticz scenes or scripts.

### Commanding devices directly

The switches can also command lights directly, without Domoticz: see [Bind two devices](HowTo_Binding.md) and [Manage Zigbee groups](HowTo_Group-management.md).

The `AqaraOppleBulbMode` setting (*Settings > Pairing settings*, advanced), which used to select a "bulb" mode with fewer widgets (On/Off for the first row, dimmer and color for the other rows), has no effect in the current plugin.

## Presence detector FP1 (RTCZCGQ11LM)

The FP1 (Zigbee model `lumi.motion.ac01`) is a presence sensor, not a motion sensor: it detects whether someone is in the room, even when they barely move, and reports when the room becomes empty.

The certified configuration of the device sets these device parameters at pairing; change them in the parameter editor if needed:

| Parameter | Values | Default |
| --------- | ------ | ------- |
| `resetMotiondelay` | Seconds before the plugin switches the widget back to *Off* on its own. Keep `0`: the FP1 reports itself when the room is empty. With another value, the widget goes *Off* after that delay even if someone is still there. | `0` |
| `RTCZCGQ11LMMotionSensibility` | Sensitivity: 1 low, 2 medium, 3 high | `2` |
| `RTCZCGQ11LMApproachDistance` | Approach distance: 0 far, 1 medium, 2 close | `1` |
| `RTCZCGQ11LMMonitoringMode` | 0 undirected, 1 left/right: also tells whether someone enters or leaves from the left or the right | `0` |
