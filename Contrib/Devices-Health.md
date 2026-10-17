# Device health

The plugin follows the health of each device: *Live*, *Not Reachable* (the device doesn't answer), *Not seen last 24hours*, *Disabled*… It is shown in the WebUI (*Dashboard* and *Management > Device Management*) and reported to Domoticz: a device that stops answering is marked as *timed out* (red header on its widgets). The plugin also pings the mains-powered devices regularly to check that they are still alive.

## Monitoring the health of your devices with dzVents

dzVents gives the last update time of a widget (`lastUpdate`) and whether Domoticz considers it timed out (`timedOut`) directly, without calling the Domoticz JSON API.

The example below checks a list of devices every 30 minutes and sends a notification for each device that is timed out or hasn't been updated for more than its threshold. Replace the device names and thresholds (in minutes) with yours.

```lua
local devicesToCheck = {
    { name = 'veilleuse', threshold = 120 },
    { name = 'Hue',       threshold = 120 },
}

return {
    on = { timer = { 'every 30 minutes' } },
    execute = function(domoticz)
        for _, d in ipairs(devicesToCheck) do
            local device = domoticz.devices(d.name)
            local minutes = device.lastUpdate.minutesAgo
            if device.timedOut or minutes > d.threshold then
                domoticz.notify('Device check',
                    device.name .. ' has not been seen for ' .. minutes .. ' minutes')
            end
        end
    end
}
```

For more complete scripts, see [CheckDeadDevices.lua](CheckDeadDevices.lua), and [GetDevicesStatus.lua](GetDevicesStatus.lua), which reads the health from the plugin REST API. Other scripts are listed in [Scripts](Readme.md).
