# Device Health

Starting Zigate plugin 4.7, device health is provided and reported also to Domoticz "last seen" status.
In addition, the plugin is automatically "pinging" main powered devices to check if they are still alive.


## Use Case: Monitoring the health of your devices

You can also use the following dzVent code to monitor and trigger notification (thanks to @benp / https://easydomoticz.com/forum/viewtopic.php?f=28&t=8251&start=70#p69018 )

The here after exemple monitor 'veilleuse' and 'Hue', so you will have to adapt to your own case


```
return {
	on = {
      devices = {'veilleuse','Hue'},
      httpResponses = {'lastUP' }
	},  
    execute = function(domoticz, item)
        print('trigger:' .. tostring(item.isDevice) .. ' / ' .. tostring(item.isTimer) .. '/' .. tostring(item.isHTTPResponse))

        if (item.name=='veilleuse') then
            domoticz.openURL({
                url = 'http://127.0.0.1:8080/json.htm?type=devices&rid=139'
                callback = 'lastUP'
             })
        end
        
        if (item.name=='Hue') then
            domoticz.openURL({
                url = 'http://127.0.0.1:8080/json.htm?type=devices&rid=143'
                callback = 'lastUP'
             })
        end
        
        if (item.isHTTPResponse and item.ok) then
            local last =item.json.result[1]['LastUpdate']
            local name=item.json.result[1]['Name']
            local HTimeout=item.json.result[1]['HaveTimeout']
            print('------------------http reponse name: ' .. name.. ' last update: ' .. last .. ' Have timeout:' .. tostring(HTimeout))

            if (domoticz.devices(name .. 'T').state=='Off' and not HTimeout) then
                domoticz.devices(name .. 'T'). switchOn()
            end
            if (domoticz.devices(name .. 'T').state=='On' and  HTimeout) then
                domoticz.devices(name .. 'T'). switchOff()
            end
        end
    end
}

```
