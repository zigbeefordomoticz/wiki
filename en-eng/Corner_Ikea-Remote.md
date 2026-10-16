# How to use the Ikea Tradfri Remote control as a pure remote control

If you want to use the Ikea Tradfri 5 buttons remote control to control anything you want (and not necessarily the Tradfri bulb), here is the step by step process.

## Context

The remote doesn't send its commands to the coordinator: it sends them to a Zigbee **group**, created when you pair it with a bulb. To get the remote events in DomoticZ, the coordinator must be a member of that group.

To start with, you need:

1. A Tradfri 5 buttons remote control (we call it remote).
1. At least one Tradfri bulb (we call it bulb). The bulb is needed to create the group: Ikea remotes can only create a group by pairing with a bulb (or an outlet).
1. The group management enabled in the plugin.

## Step-by-step

We assume here that neither the Bulb nor the Remote have been paired with the coordinator. In case they were, make sure they have been removed from DomoticZ and from the plugin (see [Remove a device](HowTo_Remove-device.md)).

### Phase 1: bring everyone on the Zigbee network

1. Enable the group management: in the WebUI [Settings](WebUI_Settings.md), check __Enable Groups__ (`enablegroupmanagement`), validate, and restart the plugin.
1. Put the plugin in pairing mode (see [Add a new device](HowTo_Pairing-device.md)).
1. Pair your bulb(s) with the coordinator. To do so, reset the bulb: from a power on state, power it off and on 6 times (in a short time). At the end of that process, you have a new Widget in DomoticZ which commands the Bulb.
1. Pair the Tradfri remote with the coordinator. To do so, reset the remote by pressing the small pairing button 4 times. At the end of that process, you have a new widget in DomoticZ representing the Remote. At that stage the widget doesn't get any event from the remote - this is normal -. The widget is passive.
1. Pair the Remote with the Tradfri Bulbs you want to have in the group. To do so, bring the remote close to each bulb and press and hold the pairing button. The light of the bulb fluctuates, and when you have a peak of intensity, the pairing is done. Release the pairing button. Check that you can switch on/off the bulb from the remote. If not, retry the pairing and make sure that you hold the button up to the end of the pairing process.

At that stage, you have:

* Bulb(s) paired with the coordinator and a corresponding widget in DomoticZ
* Remote paired with the coordinator and a corresponding widget in DomoticZ
* Remote paired with the bulb(s) and able to control them.

### Phase 2: Receive the Remote events in the plugin

1. In the WebUI, go to **Admin > Group** and run a **Full scan** (or a **Scan** of the bulb only).
   * The plugin asks the bulbs (and the other routers) which groups they belong to, and discovers the group created when pairing the Remote and the Bulb.
   * A Group widget is created in DomoticZ. This group widget commands the Bulb, so you can cross check that it is the right one.
1. Go to **Management > Group Management**. The new group is listed with its **Group id**.
1. Check **Coordinator (in the group)** for this group and click **Validate**.

### Phase 3: Testing

You should now see any action done on the Remote on the Remote widget in DomoticZ.
If you want to trigger actions based on the Remote, you can use Blockly, dzVents or Lua scripts.

### Option 1: Make Left/Right buttons change the Color schema of the group

The plugin can also 'natively' interpret the Left and Right buttons and change the color of the group the remote belongs to.
To enable this feature, edit the group in **Management > Group Management**, add the Tradfri Remote to the devices of the group, and click **Validate**.

### Option 2: Remove the Bulb from the group

If you want to use the Remote only as a remote control, without the bulb involved at all, remove the Bulb from the group: edit the group in **Management > Group Management**, remove the bulb from the devices of the group, keep **Coordinator (in the group)** checked, and click **Validate**.

The group then only contains the coordinator: the remote events still reach DomoticZ, and nothing is switched directly by the remote.

## See also

* [Group Management](HowTo_Group-management.md)
* [Ikea Tradfri corner](Corner_Ikea-Tradfri.md)
