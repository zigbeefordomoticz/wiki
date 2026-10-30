# The Web interface - Dashboard page

Please refer to STEP 3 [Plugin Configuration](Plugin_Configuration.md) to get access to the Web interface administration.

The __Dashboard__ is the home page of the WebUI (the first item of the menu bar, with the name of your plugin hardware). It shows at a glance whether the plugin, the coordinator and the devices are doing well, and what needs your attention.

> **Plugin 9.1.009 and later.** This page describes the Dashboard available since plugin 9.1.009. Older versions show a single row of pie charts (*Plugin devices*, *Send & Receive*, *Statistics*, then *Type of devices*, *Battery*, *Optimized devices*) instead of the key figures, the *Needs attention* list and the bars described below.

![Dashboard](Images/EN_WebUI-Dashboard.png)

*This picture may have changed since this documentation was written.*

## Key figures (top row)

| Figure | What it shows |
|--------|---------------|
| **Devices live** | The devices in *Live* health, out of all the devices known to the plugin, and how many are not live. |
| **Received / min** | The messages received per minute, and below them the messages sent per minute, both averaged since the plugin started. |
| **Delivery** | The share of unicast messages acknowledged by the device (APS ack), out of those acknowledged or failed, since the plugin started, with both counts below. Green from 98 %, orange from 90 %, red below. |
| **Coordinator** | The coordinator model, its firmware version and the Zigbee channel. |
| **Plugin** | The plugin version when it runs from a `stable` branch. On any other branch, the branch name and its commit, shown in orange: useful when you test a fix branch. |
| **Uptime** | How long the plugin has been running, and when it started. |
| **Firmware updates** | Only while an OTA firmware transfer runs: the device(s) being updated and the progress, with a link to *Admin > Firmware* (see [Update device firmware](HowTo_Update-device-firmware.md)). |

## Needs attention

This list gathers what may need an action. Only the items that apply are shown; when there are none, the Dashboard says *Nothing needs attention*.

| Item | Meaning |
|------|---------|
| **Not reachable** | Devices the plugin could not reach (health *Not reachable*), or that left the network. |
| **New errors in the plugin log** | The plugin has logged new errors. They are also signalled by the warning icon in the menu bar. Viewing or downloading them marks them as read. |
| **Battery below 15 %** | Battery devices that need a new battery soon, lowest first. |
| **Not seen for *n* h** | Devices that sent nothing for the delay set by the `HealthTimeOut` setting. |
| **Groups with a member not reachable or not seen** | Zigbee groups with at least one member that is not reachable or not seen: a command sent to the group may not reach every member. |
| **Not optimized** | Devices without a certified configuration, handled generically by the plugin. See [Dealing with a non-optimized device](Problem_Dealing-with-none-optimized-device.md). |
| **Firmware update available** | Devices for which the plugin has a newer firmware than the one they run. *Admin > Firmware* lets you start the update. |

Each item has two buttons:

* the **eye** opens the list of the devices concerned (for the log errors, it opens *Tools > Error*, see [WebUI Tools](WebUI_Tools.md#error));
* the **download** button saves the item as a JSON file (`z4d-<item>.json`).

*Export all* saves every item in one file, `z4d-needs-attention.json`. Each file also carries the plugin version, branch and commit, and the coordinator model, firmware and channel: it is ready to attach to a request for support (see [Reporting a problem](Troubleshooting_Reporting-a-problem.md)). It contains no network key or password.

## Plugin Status

* **Statistics**: the messages received and sent per minute over the last 10 minutes, each point counting the last minute. The light bars, on the right axis, show the *Load*: the number of messages waiting in the coordinator's transmit queue. A load that stays high means the coordinator can't keep up (see *MaxLoad* in [The footer](#the-footer)).
* **Since start**: the totals since the plugin started: messages received and sent, retransmissions, APS failures (unicast messages the device did not acknowledge), and the highest queue load reached (*Max queue load*).

Click the ⓘ next to a title to see how the figure is defined.

## Devices

Each family of devices is a bar, split by state. Click a part of a bar, or one of the labels below it, to open the list of the matching devices (short id, IEEE, model, name, status, battery, health). *Device Management →* opens the [Device Management](WebUI_Management.md#device-management) page.

* **Plugin devices**: all the devices known to the plugin, by health: *Live*, *Not seen recently* (no message for the `HealthTimeOut` delay), *Lost* (away from the network), *Unknown*, *Disabled*.
* **Type of devices**: *Routers* (mains-powered devices that relay messages in the mesh) and *End devices* (devices that don't route and sleep most of the time, usually battery powered).
* **Battery**: battery-powered devices by battery level (< 15 %, < 35 %, < 75 %, > 75 %).
* **Optimized devices**: devices for which the plugin has a certified configuration (*Optimized*) and the others (*Non-optimized*), which may not work fully or may generate unexpected traffic. See [Dealing with a non-optimized device](Problem_Dealing-with-none-optimized-device.md).

*Type of devices*, *Battery* and *Optimized devices* leave out the disabled devices.

## Refreshing

The dashboard is not refreshed automatically: click *Refresh* to update it. To have it refresh every 10 seconds, press `Alt`+`Z` (or type `z`, `i`, `g`); press it again to stop.

## The footer

The bar at the bottom of every WebUI page gives, from left to right:

* **Started at**: when the plugin was started.
* **Rx/s, Tx/s**: the messages received and sent per second by the coordinator (per minute or per hour when traffic is low).
* **MaxLoad**: the highest number of messages waiting to be sent by the coordinator. A MaxLoad above 5 can be a sign of congestion, and therefore of a malfunction; devices polled too often are a frequent cause.
* The plugin state (*Ready*, *Busy*…).
* When running: the group scan status, *Topology scan in progress*, and the OTA firmware update in progress (device and progress).
* **Plugin**: the plugin version, followed by the version of the certified-device database in brackets. It is shown in red when an update is available: click it for a link to *Admin > Plugin*, where you can upgrade (see [Plugin update](Plugin_Update.md)).
* **Firmware**: the coordinator firmware version, shown in red when a newer firmware is available (click it for more information).

------------------------------------------------
Look at the other pages of the [plugin Web interface](Readme.md#plugins-web-interface).
