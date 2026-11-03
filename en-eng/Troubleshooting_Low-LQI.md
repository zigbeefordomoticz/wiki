# Troubleshooting - A device shows a low LQI: a worked case

> This page uses the **device details** window of **Management > Device Management**, available
> from plugin version **9.1.009**, and the **Network > Mesh graph** page, available from version
> **9.1.008**. With an older version, update the plugin first (see [Plugin update](Plugin_Update.md)).

This page follows one real investigation from start to finish. Two radiator thermostats showed an
LQI of 25-30, and the question was: *are they routed through bad routers?*

The short answer turned out to be **no**. Both thermostats had a good link to their parent router.
The low number described a different link: the one between that router and the coordinator. The
steps below show how to reach that conclusion on your own network, and what to check before you
move or replace anything.

*The network is a production ZNP network (CC2652, Z-Stack 3.30+) of 62 devices, the same one used
for the screenshots of the [Mesh graph](WebUI_Network-Mesh.md) page. The device names are the ones
its owner gave them. The topology figures come from three scans taken in October 2026. The device
LQIs and the plugin log are from 1 November 2026.*

## Contents:

* [The symptom](#the-symptom)
* [What the LQI of a device measures](#what-the-lqi-of-a-device-measures)
* [Step 1 - Find the parent of the device](#step-1---find-the-parent-of-the-device)
* [Step 2 - Read the link from the parent to the coordinator](#step-2---read-the-link-from-the-parent-to-the-coordinator)
* [Step 3 - Read both directions, and know whose scale you are reading](#step-3---read-both-directions-and-know-whose-scale-you-are-reading)
* [Step 4 - Look at what the coordinator hears overall](#step-4---look-at-what-the-coordinator-hears-overall)
* [Step 5 - Check whether it actually hurts](#step-5---check-whether-it-actually-hurts)
* [What it came to, and what to do](#what-it-came-to-and-what-to-do)
* [Checklist](#checklist)
* [See also](#see-also)

------------------------------------------------

## The symptom

In **Management > Device Management** (see [Device Management](WebUI_Management.md#device-management)),
two battery thermostats showed a red LQI bar. Their [device details](WebUI_Management.md#device-details)
gave the last 10 readings:

| Device | Model | Latest LQI | Last 10 readings, oldest first |
| ------ | ----- | ---------- | ------------------------------ |
| BT Nico #2 (`a7b1`) | Tuya TS0601 thermostatic valve | 29 | 36, 32, 32, 32, 32, 32, 32, 32, 32, 29 |
| BT Sdb #2 (`59b6`) | Danfoss eTRV0100 | 25 | 25, ten times |

Other thermostats of the same house were at 60-150. The obvious reading is "these two are badly
placed, or they hang off a bad router". The first part of that reading is wrong.

## What the LQI of a device measures

The LQI of the device list and of the device details is measured by the **coordinator's radio**,
on each frame it receives from the device. A frame from a device that is not a direct neighbour of
the coordinator arrives through one or more routers, and the coordinator can only measure the
**last hop**: the link between the last router and itself.

> The LQI of a device is the quality of the last radio hop into the coordinator. It says nothing
> about the link between the device and its parent, unless the device talks to the coordinator
> directly.

[What the LQI and RSSI measure](WebUI_Management.md#what-the-lqi-and-rssi-measure) explains why,
and how the plugin files the value. For this case, the consequence is simple: a battery device
behind a router that the coordinator hears badly shows a low LQI, however good its own link is. To
find the weak link, you need the neighbour tables of a topology scan, which is what the
[Mesh graph](WebUI_Network-Mesh.md) shows.

## Step 1 - Find the parent of the device

Run a topology scan (see [How a scan is performed](WebUI_Network-Mesh.md#how-a-scan-is-performed))
and click the device in the Mesh graph. In the [node panel](WebUI_Network-Mesh.md#5-the-node-panel),
**Attached to** names the router that declares the device as its own. The neighbour table rows show
how well that router hears it.

In this case, the same in all three scans:

| Device | Parent (Attached to) | Parent hears the device at |
| ------ | -------------------- | -------------------------- |
| BT Nico #2 | Volet Fifi (`80da`, Profalux shutter) | 255 |
| BT Sdb #2 | Switch Buanderie (`ea10`, Tuya TS0001) | 97-112 |

Both thermostats are well heard by their parent. Neither of them has a radio problem of its own.

A battery device is not a router and has no neighbour table, so its own reading of the link is not
in the scan; only the parent's is. See
[Battery devices are expected to be missing from the link views](WebUI_Network-Mesh.md#battery-devices-are-expected-to-be-missing-from-the-link-views).

## Step 2 - Read the link from the parent to the coordinator

Now click the parent, and find the row in which the **coordinator** hears it. Open the parent's
device details too: as a router, its own LQI is often its direct link with the coordinator.

| Router | Coordinator hears it at | Its LQI in the device details (last 10) |
| ------ | ----------------------- | --------------------------------------- |
| Volet Fifi | 35, 38, 29 (three scans) | 29-43 |
| Switch Buanderie | 17 (last scan) | 14-29 |

This is the match:

* **BT Nico #2** reads 29-36, and the coordinator hears Volet Fifi at 29-38. In two of the three
  scans, the coordinator's routing table also sends frames for the thermostat to Volet Fifi as next
  hop. The thermostat's LQI is the Volet Fifi → coordinator hop.
* **BT Sdb #2** reads a constant 25. Its parent, Switch Buanderie, is heard by the coordinator at 17
  and its own LQI is 14-29. Switch Buanderie's own parent, Prise Aspirateur, is also heard at 17.
  Either way the last hop is a weak one. The scan cannot say which of the two routers delivered the
  frames.

So the weak links are real, but they are **router → coordinator** links, not **thermostat →
router** links.

## Step 3 - Read both directions, and know whose scale you are reading

The Mesh graph keeps the reading of each end of a link (see
[Direction, and why both are drawn as one link](WebUI_Network-Mesh.md#direction-and-why-both-are-drawn-as-one-link)).
Click the link between the coordinator and Volet Fifi, and the two readings disagree completely:

| Router | It hears the coordinator at | The coordinator hears it at |
| ------ | --------------------------- | --------------------------- |
| Volet Fifi (Profalux) | 254 | 29 |
| Volet Nico (Profalux) | 254 | 21 |
| Volet Cuisine (Profalux) | 255 | 20 |
| Volet Parent (Profalux) | 254 | 23 |
| Prise Aspirateur (Computime SPE600) | 254 | 17 |
| Switch Buanderie (Tuya TS0001) | 26 | 17 |

The Profalux shutters and the Computime plug report 245-255 for nearly **every** neighbour they
have, the coordinator included: the median of what each of them reports is between 245 and 254.
The Philips and IKEA bulbs, the frient plugs and the Tuya switch spread their readings over the
whole range, as one would expect.

This is not a link that is excellent one way and poor the other. **Each radio maker computes the
LQI its own way** (see
[What the LQI and RSSI measure](WebUI_Management.md#what-the-lqi-and-rssi-measure)), and some
radios, Silicon Labs ones in particular, report close to 255 for any link they can decode at all.
Volet Nico's IEEE address starts with `00:0D:6F`, a Silicon Labs prefix. A reading of 254 from such
a radio means "I can decode this", not "this link is excellent".

What to take from it:

* **Do not judge a link from a router that reports almost everything at 250+.** Use the reading
  from the other end, or from routers whose readings spread out.
* Compare LQI values **measured by the same radio** (for example, what the coordinator hears from
  each router), not values from different makers.
* Whether those near-255 readings also make these routers look attractive to their neighbours when
  routes are chosen is plausible, but this case does not prove it. Many routes in this network do go
  through Volet Fifi and Prise Aspirateur. See
  [Computed routes](WebUI_Network-Mesh.md#computed-routes) for why the rule that turns an LQI into a
  link cost differs between makers.

## Step 4 - Look at what the coordinator hears overall

Click the coordinator and sort its neighbour table rows on **LQI**. In this case, the coordinator
listed 23 routers as neighbours:

| The coordinator hears them at | Routers |
| ----------------------------- | ------- |
| above 100 | 4: Lampe Entree 199, Lampe Salon 148, General Counter 132, Volet Salon 109 |
| 45 to 100 | 8 |
| under 45 | 11, including Volet Bureau at 6 and Prise Bureau Info at 1 |

Most of the mesh reaches the coordinator through a weak last hop. That is why many devices, not
only the two thermostats, show an orange or red LQI in Device Management. The weak point is the
**coordinator's reception**, not one router.

## Step 5 - Check whether it actually hurts

A low LQI is a reason to look, not proof of a failure. Before changing anything, check how the
device behaves:

* **Health** in Device Management. Both thermostats were *Live*.
* The plugin log, for send failures to the device: delivery errors, `NWK_NO_ROUTE`, `MAC_NO_ACK`,
  retries. There were none for either thermostat over the day of the log. See
  [Deal with plugin errors](HowTo_Dealing-plugin-errors.md).
* Whether reports arrive on time and commands (a setpoint change) take effect. The **Messages
  received since plugin start** counters of the device details show that reports keep coming.
* To follow a weak device over time, the `LQIthreshold` debug setting logs every report received
  at or under a given LQI (see [Debug mode](Problem_Debuging-mode.md)).

Here, both thermostats worked normally at an LQI of 25-30. On this ZNP coordinator, that is a weak
but working link. The colour bands are a rough guide, not a verdict: Device Management shows red
under 40, and the Mesh graph bands everything up to 100 as *Poor* (see
[A note on LQI](WebUI_Network-Mesh.md#a-note-on-lqi)).

A ZNP coordinator reports no RSSI. On a Silicon Labs (EZSP) or deCONZ coordinator, the RSSI chart of
the device details is worth a look too: being in dBm, it compares better between radios than the
LQI.

## What it came to, and what to do

* **The thermostats were fine.** Their links to their parents were good to excellent.
* **The routers were not "bad".** Volet Fifi and Switch Buanderie relay correctly. They are simply
  heard poorly by the coordinator, like most of the mesh.
* **Volet Fifi's 254 for the coordinator was misleading.** That radio reports close to 255 for
  nearly everything.
* **The coordinator's reception was the weak point**, and improving it should raise most last-hop
  values at once.

The actions, cheapest first:

1. **Improve the coordinator's placement**: a shielded USB extension cable, a USB 2.0 port, away
   from the host computer, USB 3.0 devices and the Wi-Fi access point. See
   [Build a Zigbee mesh network](HowTo_Build-a-ZigBee-network.md).
2. **Add a good router near the coordinator**, preferably one whose LQI readings spread over the
   range, so the shutters and plugs get a strong link into the coordinator.
3. If one area stays weak (here, the Fifi and Nico rooms), add a router between that area and the
   coordinator.
4. **Run a new scan after each change**, and compare what the coordinator hears from each router,
   rather than the LQIs of the devices.

Do not re-pair the thermostats or replace their parent routers: neither changes the router →
coordinator link.

## Checklist

When a device shows a low LQI:

1. Remember that it is the **last hop into the coordinator**, not the device's own link.
2. Find the device's **parent** (Mesh graph, node panel, *Attached to*), and read how well the
   parent hears it.
3. Read how well the **coordinator** hears that parent. If it matches the device's LQI, the weak
   link is parent → coordinator.
4. Read **both directions** of each link. Set aside the readings of a router that reports almost
   everything at 250+.
5. Sort the coordinator's neighbours by LQI. If most are low, work on the coordinator, not on the
   device.
6. Check **Health** and the log before acting. A low but stable LQI with no delivery errors is a
   working link.

## See also

* [Device Management](WebUI_Management.md#device-management) - the device list, the device details
  and [what the LQI and RSSI measure](WebUI_Management.md#what-the-lqi-and-rssi-measure)
* [Mesh graph](WebUI_Network-Mesh.md) - neighbour tables, routes, associated devices, and how a scan
  is taken
* [Build a Zigbee mesh network](HowTo_Build-a-ZigBee-network.md) - coordinator placement,
  interference, routers
* [Troubleshooting pairing or connection](Troubleshooting_Pairing.md)
* [Getting help and reporting a problem](Troubleshooting_Reporting-a-problem.md) - what to attach if
  you need help reading your own scan
