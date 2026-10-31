# Using the Tradfri Motion Sensor with an Ikea device (bulb or Outlet) and Stand alone

## 1. Prerequisites

1. One Tradfri motion sensor (MS)
1. One Tradfri bulb or wall outlet (WO)
1. The group management enabled in the plugin: in the WebUI [Settings](WebUI_Settings.md), check __Enable Groups__ (`enablegroupmanagement`), validate, and restart the plugin.

## 2. Pairing the devices with the coordinator

* Put the plugin in pairing mode (see [Add a new device](HowTo_Pairing-device.md)).
* Pair the devices with the coordinator, by holding them close to it.
* Pair the Motion Sensor (MS) by pressing the pairing button on the back 4 times, and the bulb (switching it off and on 6 times) or the WO (pressing the pin underneath for a few seconds).

After pairing, you should see the devices in DomoticZ, **Setup > Devices**.

## 3. Pairing the devices with each other

Next, pair the bulb and the MS:

* Hold the MS near the bulb or wall outlet, and press the pairing button on the back for 10 seconds.

When finished, the red light in the MS switches, the bulb flashes, and the WO makes a clicking sound or its led flashes.

## 4. Getting the group and adding the coordinator

The MS sends its commands to a Zigbee group, created when you paired it with the bulb or WO. To get the motion events in DomoticZ, the coordinator must be a member of that group.

1. In the WebUI, go to **Admin > Group** and click **Scan all** (or tick the bulb or WO and click **Scan N selected**; **Full scan** or **Scan** before plugin 9.1.009). The routers answer over the next minutes. The plugin finds the new group and creates a group widget in DomoticZ.
1. Go to **Management > Group Management**: the new group is in the list.
1. Check **Coordinator (in the group)** for this group and click **Validate**.

Whenever movement is detected, the MS switches on the bulb or WO. The status of the bulb, the WO and the MS widget change. Depending on the settings of the MS, it switches off after the set time.

## 5. Making the Motion Sensor a standalone device

The MS can be made standalone by removing the bulb or WO from the group in **Management > Group Management**, keeping **Coordinator (in the group)** checked. After validating, the group still exists, with only the coordinator in it. The motion sensor still sends to this group in the background: its status changes can be seen in the MS widget.

Now it is possible to use the MS in a script (Lua, dzVents or Blockly). This way you are not bound to Zigbee products and you can use it with devices running other protocols (Z-Wave, wifi, mqtt or 433MHz).

## Remarks

### Group management with Ikea Tradfri remotes and motion sensors

When using Tradfri devices like the Ikea 5 button round remote or the Ikea motion sensor, the widgets are not active after pairing: they are added to DomoticZ, but the actions can't be seen in DomoticZ until the coordinator is a member of their group. See [Ikea remote control as a pure remote](Corner_Ikea-Remote.md).

## Limitation (ZiGate only)

With a ZiGate coordinator, the coordinator can only be a member of 5 groups, because of the limited memory of the ZiGate chip. When you add the ZiGate to a group for the sixth time, the membership is not established, and you get this error in the DomoticZ log: `We reach the max number of Cycle and didn't succeed in the Group Creation.`
