# Polling for On/Off and Level Control (Philips, Gledopto)

## Introduction

Some brands, such as Philips (Hue) and Gledopto, don't report their status when it changes in another way than through the plugin (for example with a remote control or the Hue app). To keep DomoticZ up to date, the plugin can poll these lights: it reads the On/Off state and the dimming level at a regular interval.

## How polling is configured

Polling is a **per-device** setting: the [device parameter](HowTo_Device-parameters.md) `OnOffPollingFreq`, in seconds.

* The certified configurations of the Philips and Gledopto lights set `OnOffPollingFreq` to **300** (every 5 minutes) when the device is paired.
* `0` disables the polling for this device.

To change it for a light:

1. Open the plugin WebUI and go to **Management > Device Management**.
1. Click the **Parameters** button of the light (last column).
1. Set `OnOffPollingFreq` to the value you want, for example `120` to poll every 2 minutes, and click **Save parameters**. Keep the other parameters of the device as they are.

## Which interval to choose?

Each poll sends two read requests to the light. With many lights, a short interval loads the Zigbee network: we recommend not to go below 45 seconds, and to keep a longer interval if you have many lights of these brands. The plugin skips a poll when the coordinator is busy.

If you only need the status when you look at DomoticZ, the default 300 seconds is usually enough.
