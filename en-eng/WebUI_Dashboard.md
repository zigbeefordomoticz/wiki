# The Web interface - Dashboard page

Please refer to STEP 3 [Plugin Configuration](Plugin_Configuration.md) to get access to the Web interface administration.

The __Dashboard__ is the home page of the WebUI (the first item of the menu bar, with the name of your plugin hardware). It shows at a glance whether the plugin, the coordinator and the devices are doing well.

![Dashboard](Images/EN_WebUI-Dashboard.png)

*This picture may have changed since this documentation was written.*

## Plugin Status (top row)

* **Plugin devices**: the devices known to the plugin by health — *live*, *lost* (away from the network), *no news* (no message received for the `HealthTimeOut` delay, about 6 hours by default, see [Settings](WebUI_Settings.md)), *disabled*, *unknown*.
* **Send & Receive**: the number of messages sent (*Tx*) and received (*Rx*) since the plugin started.
* **Statistics**: messages sent and received per second (*Tx/s*, *Rx/s*) and the *Load*, the number of messages waiting to be sent by the coordinator, as its current and peak value.

## Status of non-disabled objects (bottom row)

* **Type of devices**: *routers* (mains-powered devices that relay messages in the mesh) and *end devices* (devices that don't route and sleep most of the time, usually battery powered).
* **Battery**: battery-powered devices by battery level (< 15 %, < 35 %, < 75 %, > 75 %).
* **Optimized devices**: devices for which the plugin has a certified configuration (*optimized*) and the others (*non-optimized*), which may not work fully or may generate unexpected traffic. See [Dealing with a non-optimized device](Problem_Dealing-with-none-optimized-device.md).

Click a slice of any of these charts to open the list of the matching devices (short id, IEEE, model, name, status, battery, health).

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
