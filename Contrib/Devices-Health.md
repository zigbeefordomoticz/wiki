# Device health

The plugin follows the health of each device: *Live*, *Not Reachable* (the device doesn't answer), *Not seen last 24hours*, *Disabled*… It is shown in the WebUI (*Dashboard* and *Management > Device Management*) and reported to Domoticz: a device that stops answering is marked as *timed out* (red header on its widgets). The plugin also pings the mains-powered devices regularly to check that they are still alive.

## When a device is seen without a new value

Each time a frame comes from a device, the plugin refreshes the *Last Seen* (`LastUpdate`) of its widgets, at most every 2 minutes, even when the value did not change (meter widgets, such as energy, are not refreshed this way). A widget whose value did not change is not updated: Domoticz only writes the new time in its database.

So:

* The time shown on the widget changes only when the page is reloaded.
* No device event is triggered: a dzVents script on `devices = { ... }` runs only when the value changes.
* In dzVents, `device.lastUpdate` and `device.timedOut` don't see this time. They keep the time of the last value change, so a sensor whose value is stable (a humidity, a door contact…) looks dead while it is still reporting.

The Domoticz JSON API (`json.htm?type=command&param=getdevices`) reads the database, so it returns the real *Last Seen*.

## Monitoring the health of your devices with dzVents

Use a script that runs on a timer and reads `LastUpdate` from the JSON API:

* [CheckLastSeen.dzVents](CheckLastSeen.dzVents): a short script for a list of devices (by idx), with one alert per outage.
* [CheckDeadDevices.lua](CheckDeadDevices.lua): a more complete script for a list of devices (by name), with a threshold per device, notifications and an alert when all devices are back.
* [GetDevicesStatus.lua](GetDevicesStatus.lua): reads the health from the plugin REST API, and shows the number of live and lost devices on an Alert widget.

The JSON API is called from the Domoticz server itself (127.0.0.1): add 127.0.0.1 to *Setup > Settings > Local Networks*, otherwise Domoticz answers *401 Unauthorized*. Set each threshold longer than the reporting interval of the device: some battery devices only report once an hour or less.

Other scripts are listed in [Scripts](Readme.md).
