# Updating the firmware of a Zigbee device (OTA)

## Overview

The plugin can update the firmware of a Zigbee device over the air (OTA), for any
manufacturer that follows the Zigbee OTA Upgrade cluster.

The important thing to understand first: **the plugin is an OTA server.** The device
downloads its new firmware; the plugin answers its requests. When you start an update
from the WebUI, the plugin sends the device an *Image Notify* ("a new image is ready
for you"). A mains-powered device usually asks for the image within a second. A
battery-powered device sleeps, misses the notification, and asks on its own schedule,
which belongs to its firmware: typically hours, sometimes a day or more. The plugin
keeps the update ready for it.

An update is slow by design: about 35 minutes for a 250 KB image on a busy network
(see [What to expect](#what-to-expect)).

> **Note:** the following are available from plugin version **9.1.009**:
>
> * updating several devices at once (the [queue](#several-devices-the-queue));
> * the four-column Firmware page with its live **Transfers** column;
> * [cancelling an update](#cancelling-an-update);
> * loading a new firmware file without restarting the plugin;
> * the Status lines and refusal reasons described on this page.
>
> Earlier versions update one device at a time and read the firmware folders only at
> startup. A request for several devices, or made while another update runs, is refused
> with a Warning in the log.

You also have to obtain the firmware yourself. Some manufacturers publish their
images, many do not, and the plugin never downloads an image for you.

## How an update actually happens

1. The device sends a *Query Next Image Request* carrying its manufacturer code, its
   image type and its current version.
2. The plugin looks through the images it has loaded (at startup, and again when the
   firmware folders change: see [Step 3](#step-3--load-the-image-and-check-it)) for one
   matching that **manufacturer code and image type**. The brand name and the folder play no part in
   this match — both come from the image's own header.
3. If it has a matching, newer image *and* you authorised the update, it serves the
   image block by block until the device reports *Upgrade End*. The device then
   reboots on its new firmware.
4. If it has a matching, newer image but no update is planned for that device, it says
   so once in the log (from plugin version **9.1.009**):

   ```
   Firmware 1021-0013-003f45ff-NLV.zigbee (version 0x003F45FF) is available for NLV Legrand [d841], which runs version 0x00234203: start the update from the WebUI
   ```
5. If it has no matching image, it can look the device up in an online firmware index
   and tell you in the log that an update exists and where to put it.

Step 5 is usually how you find out an update is available at all.

## Step 1 — Find out that a firmware exists

With `checkFirmwareAgainstZigbeeOTARepository` enabled (it is, by default), the plugin
checks devices against published firmware indexes and reports what it finds:

```
Z4D detects a potential new firmware for device Kitchen bulb [1a2b]
   current version: 419499589
     firmware type: 432
    newest version: 423638661
     firmware type: 432
   URL to download: https://raw.githubusercontent.com/Koenkk/zigbee-OTA/master/images/...
   Folder to store: INNR
```

That last line is the one to act on: it names the folder the image belongs in.

The indexes consulted are the [Koenkk zigbee-OTA
index](https://github.com/Koenkk/zigbee-OTA), IKEA's own firmware feed and Sonoff's
firmware feed. All three are configurable — see [Settings](#settings).

If instead of a folder you see this:

```
   to get this Manufacturer supported: 4454
   provide those informations: {...}
```

then the plugin has no entry for that manufacturer — see
[When your manufacturer is not supported](#when-your-manufacturer-is-not-supported).

## Step 2 — Put the firmware in the right folder

Download the image and save it under the plugin's `OTAFirmware/` directory, in the
folder matching the manufacturer:

| Brand (as shown in the WebUI) | Manufacturer code | Firmware folder(s) |
| --- | --- | --- |
| Danfoss | `0x1246` | `OTAFirmware/DANFOSS/` |
| devbis | `0xDB15` | `OTAFirmware/XIAOMI/` |
| Develco-frient | `0x1015` | `OTAFirmware/GENERIC-1015/`<br>`OTAFirmware/DEVELCO/` |
| EcoDim | `0x126A` | `OTAFirmware/ECO-DIM/` |
| Eurotronic-LiXee-Lumi | `0x1037` | `OTAFirmware/GENERIC-1037/`<br>`OTAFirmware/EUROTRONICS/`<br>`OTAFirmware/LIXEE/`<br>`OTAFirmware/LUMI/` |
| Ikea | `0x117C` | `OTAFirmware/IKEA-TRADFRI/` |
| Innr | `0x1166` | `OTAFirmware/INNR/` |
| Ledvance | `0x1189` | `OTAFirmware/LEDVANCE/` |
| Legrand | `0x1021` | `OTAFirmware/LEGRAND/` |
| Namron | `0x1224` | `OTAFirmware/NAMRON/` |
| Nodon | `0x128B` | `OTAFirmware/NODON/` |
| Osram1 | `0xBBAA` | `OTAFirmware/OSRAM/` |
| Osram2 | `0x110C` | `OTAFirmware/LEDVANCE/` |
| Philips | `0x100B` | `OTAFirmware/PHILIPS/` |
| Salus | `0x1078` | `OTAFirmware/SALUS/` |
| Schneider | `0x105E` | `OTAFirmware/SCHNEIDER-WISER/` |
| SonOff | `0x1286` | `OTAFirmware/SONOFF/` |
| Xiaomi | `0x115F` | `OTAFirmware/XIAOMI/` |
| z03mmc | `0x0084` | `OTAFirmware/XIAOMI/` |

Each folder contains a `README.md` naming where that manufacturer publishes its
firmware.

A few things worth knowing:

- **The file name does not matter.** The plugin reads the manufacturer code, image
  type and version out of the image header, so you can rename files freely. Keep only
  `README.md` and firmware images in these folders.
- **Several brands can share a folder**, and that is fine — `Xiaomi`, `devbis` and
  `z03mmc` all read from `OTAFirmware/XIAOMI/`.
- **The root is configurable.** `pluginOTAFirmware` (an advanced setting) can point
  the whole tree somewhere else, for instance to keep large images off an SD card.

### Why some folders are named `GENERIC-<code>`

A Zigbee manufacturer code is not unique to a company. `0x1037` is used by Eurotronic,
LiXee **and** Lumi; `0x1015` by Develco and frient. Since an image is matched on its
manufacturer code and image type, there is no way — and no need — to tell those
vendors apart.

Those codes therefore have a single entry covering all of their vendors, with a
`GENERIC-<code>` folder as the place to put new images. The former per-vendor folders
(`EUROTRONICS/`, `LIXEE/`, `LUMI/`, `DEVELCO/`) are still read, so firmware you
already put there keeps working and nothing needs moving.

## Step 3 — Load the image and check it

**From plugin version 9.1.009, no restart is needed.** Open, or reload, **Admin →
Firmware** in the WebUI. When the page asks for the firmware list, the plugin checks
whether a file was added, removed or replaced in the firmware folders, and if so reads
them again. The new file then shows up in the Firmware column, and the log lists what
was loaded:

```
The OTA firmware folders changed: firmware images reloaded
Z4D loads the firmware images
 --> Brand: Legrand Image File: 1021-0013-003f45ff-NLV.zigbee
```

Nothing is reread, and nothing is logged, when the folders did not change. Updates in
progress are not affected: each keeps serving the image it started with, even if you
replace or delete its file.

**With earlier versions, the firmware folders are read once, when the plugin
starts.** Restart the plugin after adding a file; the same lines appear in the log at
startup.

If your file is not listed, see [Troubleshooting](#troubleshooting).

## Step 4 — Run the update

Go to **Admin → Firmware** in the WebUI. From plugin version **9.1.009** the page has
four columns, from left to right:

![Firmware page: brands, firmware, devices and transfers](Images/WebUI-Admin-Firmware-columns.png)

1. **Brands**, as spelled in the table above, with the number of firmware files loaded
   for each.
2. **Firmware**: the files of that brand, with their image type and version.
3. **Devices**: the devices of that manufacturer, each compared with the selected
   firmware, using what the device reported the last time it asked for an image:

   | Badge | Meaning | Can be selected |
   | --- | --- | --- |
   | `update available` | The device runs an older version | Yes |
   | `up to date (Force update)` | The device already runs this version | Only with `force update` |
   | `runs a newer version (Force update)` | The device runs a newer version | Only with `force update` |
   | `version unknown until the device asks` | The plugin has not yet seen the device ask for an image, so it does not know its version | Yes: the plugin checks when the device asks |
   | `Queued`, `Notified`, `Waiting…`, `Transfer` | An update is already planned or running for it | No |

   Devices that reported another image type are folded under **Other image types
   (N)**: this firmware is not for them.
4. **Transfers**: every update queued or in progress, and the last ones that ended. See
   [What you see in the WebUI](#what-you-see-in-the-webui).

Tick the devices, then click **Update (N)** and confirm. Each device gets its own
message: *Firmware update queued for …* or, in orange, *Firmware update rejected for
…* with the reason (see [When an update is refused](#when-an-update-is-refused)).

You can select **several devices at once**, and start more updates while others are
running, even with different firmware images.

With earlier versions, the page has three drop-down lists (brand, firmware, devices)
instead.

`force update` lets the image be served to a device that is not on an older version —
use it to re-flash or to go back to an earlier version. Without it, a device is only
offered an image strictly newer than what it runs.

### Several devices: the queue

> **Note:** available from plugin version **9.1.009**.

The plugin upgrades **three devices at a time**. Each update you start takes a
*transfer slot* if one is free, otherwise it waits in the queue:

* A device with a slot is notified at once and is served when it asks.
* The other devices wait, oldest request first. When a transfer ends (success, failure,
  or no block requested for 5 minutes), the next device in the queue gets the slot
  and is notified.
* A **battery-powered** device that asks on its own while the three slots are taken
  gets a fourth slot: it might not ask again for hours. Mains-powered devices never use
  it.
* A device that does not answer its notifications (10 tries, 5 seconds apart) gives its
  slot back so the queue keeps moving, but stays authorised for **24 hours**. If it
  asks within that time it is served; after that the request is dropped and the
  notification widget says so.

With a ZiGate in native mode, the coordinator holds one image at a time: one transfer
at a time.

While several transfers run, the plugin spaces the blocks of each device by the number
of transfers (twice as much for two, four times for four, up to one second), so that
together they load the network about as much as a single transfer.

### What you see in the WebUI

> **Note:** available from plugin version **9.1.009**.

The **Transfers** column of the Firmware page lists every update, whatever brand and
firmware are selected:

![Three transfers in progress](Images/WebUI-Admin-Firmware-transfers.png)

The header counts the updates holding a transfer slot (`active`) and the others
(`queued`). Each update shows its device, its file and its state:

| State | Meaning |
| --- | --- |
| `Queued` | Waits for a free transfer slot, since the time shown |
| `Notified` | Holds a slot; the device was notified and has not asked yet |
| `Waiting for the device to ask` | Did not answer its notifications: no slot, but still authorised for 24 hours |
| `Transfer` | Being downloaded: progress bar, percentage, KB downloaded of the image size, speed and estimated time left |

The speed is measured since the transfer started, so the first minutes are rough. The
time left assumes the speed stays the same: it grows when more transfers start, since
the blocks of each device are then spaced further apart.

Below, **Finished** lists the last 10 updates that ended, newest first, with their
outcome: `Success`, `Failed`, `Aborted`, `Transfer stalled` (no block requested for 5
minutes), `Device never asked` (24 hours), `Not needed` (the device already runs it, or
its hardware is not supported), `Cancelled`, or `Success, another image needed`. The
list is kept in memory: a plugin restart empties it.

Updates of the selected firmware are highlighted; clicking one selects its brand and
firmware. The column refreshes every 5 seconds while an update is queued or running,
every 30 seconds otherwise.

The footer of every page shows the devices holding a slot, then their progress, in the
same order:

![Two transfers in progress](Images/WebUI-Admin-Firmware-two-transfers.png)

`OTA: 4333, b1b7 30%, 35%` reads: `4333` at 30%, `b1b7` at 35%. A device that was
notified but has not asked yet shows `Notified`. Devices waiting in the queue are not
shown in the footer. When the last transfer ends, the footer keeps its outcome
(`Success`, `Timeout`, …).

### What you see in the log

> **Note:** available from plugin version **9.1.009**.

Each update you start gets one Status line saying whether it took a slot, followed by
the state of the queue:

```
Firmware update started for 4333 with 1021-0010-004445ff-NLM.zigbee: the device is notified (active: 4333 - queued: none)
Firmware update started for b1b7 with 1021-000e-004e45ff-NLF.zigbee: the device is notified (active: 4333, b1b7 - queued: none)
Firmware update started for d841 with 1021-0013-003f45ff-NLV.zigbee: the device is notified (active: 4333, b1b7, d841 - queued: none)
Firmware update queued for 9a9a with 1021-0013-003f45ff-NLV.zigbee: waits for a free transfer slot (active: 4333, b1b7, d841 - queued: 9a9a)
```

Then, while it runs:

```
Firmware transfer for b1b7/01 - Progress:  5.0%
...
OTA upgrade completed with success - b1b7/01 0019 Version: 0x004e45ff Type: 0x000e Code: 0x1021 Status: 00
Firmware update started for 9a9a with 1021-0013-003f45ff-NLV.zigbee: the device is notified (active: 4333, d841, 9a9a - queued: none)
```

Progress is logged once per 5% step. A device that asks on its own (battery device,
or one that missed its notifications) gets `…: the device asked for it (…)`.

### Cancelling an update

> **Note:** available from plugin version **9.1.009**.

Click the red **✕** of the update in the Transfers column, then **Cancel the update**:

| State when cancelled | What happens |
| --- | --- |
| `Queued`, `Waiting for the device to ask` | The update leaves the queue |
| `Notified` | The update leaves the queue; its transfer slot goes to the next device |
| `Transfer` | The plugin answers the device's next block request with *ABORT*: the device stops the download at once and keeps its current firmware. Its slot goes to the next device |

The log shows it, here for a device in transfer:

```
Firmware update of d841 with 1021-0013-003f45ff-NLV.zigbee cancelled (it was Transfer)
Firmware transfer of d841 was cancelled: ABORT sent to its request
Firmware transfer of d841 stopped after the cancel: the device discarded the download (Upgrade End status 0x96)
```

The update then shows in **Finished** as `Cancelled`. With `autoServeOTA`, a cancelled
device is not updated automatically again until the plugin restarts or you pick it
again on the Firmware page.

### When an update is refused

> **Note:** available from plugin version **9.1.009**.

Some requests are refused straight away. The Firmware page shows the reason in an orange
message for that device, and the log has a Warning or Status line:

| Reason | What to do |
| --- | --- |
| Unknown brand / Unknown firmware file | The file is not loaded any more: it was removed or renamed after the page was opened. Reload the page: the plugin reads the folders again. |
| Unknown device / Unknown endpoint | The device was removed or re-paired; reload the page. |
| A firmware update is already queued or in progress for this device | Nothing to do: it is on its way. |
| The device already runs this firmware version or a newer one | The device reported that version the last time it asked. Use `force update` to install it anyway. |

A device that asks and turns out to run that version already, or whose hardware
version the image does not support, has its request dropped with the reason in the
log and in the notification widget.

### What to expect

Field measurements on an EZSP coordinator, Legrand devices, 250 KB images:

| Situation | Speed | 250 KB image |
| --- | --- | --- |
| One transfer | about 220 bytes/s | about 20 minutes |
| Two transfers at the same time | about 115 bytes/s each | about 35 minutes each |
| Three or four transfers | the same total, shared: about 75 or 55 bytes/s each (estimate) | about 55 or 75 minutes each (estimate) |

After *Upgrade End* the device reboots on its new firmware (about one minute for these
devices), announces itself again, and reports its new version the next time it asks.

**Stopping or restarting the plugin forgets the queue and the transfers in
progress.** Start the update again from the Firmware page afterwards. To stop a single
update, [cancel it](#cancelling-an-update) instead. Whether the
device continues its download depends on the device: the Legrand devices tested
continued where they stopped, but started again from the beginning after a power cut.

### Updating without picking devices by hand

Enabling `autoServeOTA` makes the plugin serve any matching image to any device that
asks for one, without going through the Firmware page. Convenient if you keep a
curated set of images; be aware it will update every device matching an image you have
placed in the folders. The queue applies: a device that asks while the slots are taken
is queued and notified when its turn comes, and a device whose update you cancelled is
left alone until the plugin restarts (both from plugin version **9.1.009**).

## Settings

All under **Settings → OTA** in the WebUI.

| Setting | Default | What it does |
| --- | --- | --- |
| `autoServeOTA` | off | Serve a matching image to any device that asks, without selecting it in the WebUI |
| `checkFirmwareAgainstZigbeeOTARepository` | on | Look devices up in the online indexes and report available firmware in the log |
| `EnableOTATracing` | off | Verbose OTA transfer tracing (advanced; useful when reporting a problem) |
| `ZigbeeOTA_Repository` | Koenkk `index.json` | URL of the main firmware index (advanced) |
| `IkeaTradfri_Repository` | IKEA feed | URL of the IKEA firmware feed (advanced) |
| `Sonoff_Repository` | Sonoff feed | URL of the Sonoff firmware feed (advanced) |

> OTA support is enabled by default and no longer has a visible on/off switch. Older
> versions of this page described an "Enable OTA" checkbox under *Available services*;
> that setting is now internal, and there is nothing to turn on.

## When your manufacturer is not supported

If the log prints a bare manufacturer code instead of a folder:

```
   to get this Manufacturer supported: 4454
   provide those informations: {'fileName': '...', 'manufacturerCode': 4454, ...}
```

the plugin recognises that a firmware exists but has nowhere to file it, and it will
not read the image even if you download it. Adding a manufacturer is a small change —
please [open an
issue](https://github.com/zigbeefordomoticz/Domoticz-Zigbee/issues/new/choose) and
paste those two lines in full. The `provide those informations` line carries
everything needed.

## IKEA: downloading the whole catalogue

For IKEA TRÅDFRI a helper script fetches every published image:

```bash
cd Domoticz-Zigbee/OTAFirmware/IKEA-TRADFRI
../../Tools/ikea-ota-download.py
```

That pulls a lot of files. If you only want to update, say, the signal repeater or the
control outlet, keep the images whose names contain `TRADFRI-signal-repeater` or
`TRADFRI-control-outlet` and delete the rest — fewer images means a faster startup
scan.

## Troubleshooting

**The image is not listed.**
Check in order: it is in a folder from the table above; you reopened the Firmware page
after putting it there (with versions before 9.1.009: you restarted the plugin); the file is a real `.ota`/`.zigbee` image rather than an HTML error
page saved under the wrong name; and the folder contains nothing but `README.md` and
images.

**`another firmware with the same ImageType and another brand is already loaded`.**
Two images declare the same image type. Only one can be kept; remove the one you do
not need.

**The device never starts the transfer.**
Check the Transfers column, or the log, first: the update may be `Queued` behind three
others (`waits for a free transfer slot`). If it shows `Waiting for the device to ask`, a battery device starts when it next asks, which can be
hours; it stays authorised for 24 hours. Some mains-powered devices ignore the
notification too and only ask at power-on: switching the device off and on makes it
ask within a few seconds.

**The transfer starts and stalls.**
Usually a mesh problem: move the device closer to a router, or retry when the network
is quieter. The plugin keeps per-manufacturer timing settings (block size, delay,
retries); if a particular manufacturer stalls consistently, report it with
`EnableOTATracing` turned on so the timing can be adjusted.

**The device reports a version that does not change after a successful update.**
Some devices only report the new version after a power cycle. After a `force update`
of the same file, the device reports the same version as before: that is expected.

**The progress goes back to 0%.**
The device restarted its download, usually after a power cut. The plugin serves it
again from the beginning.

## See also

* [Device OTA firmware list and sources](Info_Firmware-list.md)
* [Retrieving Legrand firmware](Corner_Retreiving-Legrand-Firmware.md)
* [Updating the ZiGate coordinator firmware](HowTo_Update-ZiGate-firmware.md) — a
  different procedure, for the coordinator rather than a device

## References

* [Koenkk zigbee-OTA — image repository and index](https://github.com/Koenkk/zigbee-OTA)
* [deCONZ OTA image types and firmware versions](https://github.com/dresden-elektronik/deconz-rest-plugin/wiki/OTA-Image-Types---Firmware-versions)
* [Older IKEA-specific procedure (archived)](Archives/IKEA-OTA-Upgrade-old.md)
