# Plugin statistics

To understand how the plugin is used, the plugin sends anonymous usage statistics to the project's own [Matomo](https://matomo.org) server (`https://z4d.pipiche.net`). This page describes exactly what is sent, when, and how to stop it.

## How to opt out

The statistics are controlled by the __MatomoOptIn__ setting ("Enable the plugin to collect informations for analytics purposes..."), in the WebUI [Settings](WebUI_Settings.md) page, __Available services__ section. It is **enabled by default**.

**At any time**, uncheck __MatomoOptIn__ and save: the plugin stops sending statistics immediately, no restart needed. Check it again to opt back in.

At each start, the plugin log reminds you that the statistics are on:

`Z4D sends analytics information. (if you need to disable, disable the MatomoOptIn parameter via the WebUI - Settings)`

Note that the __Allow Internet access__ (`internetAccess`) setting doesn't control the statistics: use __MatomoOptIn__.

## What is sent

The statistics are sent by the plugin itself, from your Domoticz host. The WebUI doesn't track you: it has no tracking code and sets no cookie.

### How your installation is identified

Each plugin instance is identified by a SHA-256 hash of the IEEE address of its coordinator. The hash lets us count installations without knowing the address itself: the coordinator IEEE address never leaves your host.

There is one exception: on RoneLabs hardware (detected with the `/etc/modelinfo` file), the raw coordinator IEEE address is sent too, for hardware-specific support.

As with any request over the Internet, the request reaches the Matomo server from the public IP address of your connection. Matomo anonymizes this IP address: the full address is not stored.

### Installation information

Every 6 hours, and when the plugin starts and stops, the plugin sends:

| Information | Example |
| :--- | :--- |
| Domoticz version | `2026.3` |
| Coordinator model (radio type) | |
| Coordinator firmware version | |
| Plugin version | `9.1.007` |
| Version of the certified devices database (z4d-certified-devices) | |
| Network size, as a category | see below |
| Operating system distribution and version | `Debian GNU/Linux 12` |
| Python version and CPU architecture | `python 3.13.5 arch 64bit machine aarch64` |
| Time since the plugin started, as a category | `1 day`, `2 weeks`, ..., `Beyond 6 months` |
| Raspberry Pi model, if any | `Raspberry Pi 4 Model B Rev 1.4` |
| RoneLabs model and raw coordinator IEEE address, only on RoneLabs hardware | |

The network size is the total number of devices (routers and end devices), sent as one of these categories only:

| Category | Devices |
| :--- | :--- |
| unknown | 0 |
| Micro | 1 to 4 |
| Small | 5 to 9 |
| Medium | 10 to 24 |
| Large | 25 to 49 |
| Very Large | 50 to 74 |
| Xtra Large | 75 or more |

The plugin sends nothing about your devices themselves: no device model, name, address, or value.

### Events

The plugin also reports these events:

* plugin started, restarted, stopped;
* the coordinator formed a new Zigbee network;
* plugin upgrade from the WebUI, successful or with errors;
* you enabled or disabled __MatomoOptIn__ (the opt-out itself is the last thing sent).

## Why?

We are a small team of volunteers who share our time to develop this plugin.

With this little feedback, you tell us which coordinators, firmware, Domoticz and Python versions and platforms are really in use, so we can test on them and concentrate our efforts where they are most needed. From time to time, we may publish aggregated trends (for example the share of each coordinator type or plugin version).

Thank you.
