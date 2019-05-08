# APS Failure messages

Starting with plugin version 4.3, the plugin is capable to handle the APS Failure messages provided by Zigate during normale operation.


## How to Enable

There are 2 parameters which are involved in the APS Failure management

```
'enableAPSFailureLoging':'1',
'enableAPSFailureReporting':'1',
```

* enableAPSFailureLoging

  * Default: disable (0)
  * Behaviour: this will simply report in the log any APS communication messages. No action taken by the plugin.


* enableAPSFailureReporting

  * Default: enable (1)
  * Behaviour: Everytime the plugin receives from Zigate an APS communication message, 
  it will associate this to a communication problem with the concerned device. The resuting actions
  will be to 
     * set the Domoticz widget TimedOut to 1.
     * report as an Error in the Log.
     
     
## Use Case: Monitoring the health of your devices

By setting enableAPSFailureReporting to 1 (which is default), you will give the pluging the capability to inform Domoticz in case of Device not reachable and the result will be to have a Red flag on the corresponding Domoticz widget

In some settings, Bulbs are also behind a physical switch, which allow to switch off the main powered. In such case, Zigate and the plugin can get this information and flag it to Domoticz

In order to make that into practice, you'll have to enable a polling mecanishm where the plugin will ping each of the device on a reguar basis.

Here after is the parameter to set to 1 in the corresponding PluginConf file of your environment.

```
'enableReadAttributes':'1',
```

You can also use the following dzVent code to monitor and trigger notification (thanks to @benp / https://easydomoticz.com/forum/viewtopic.php?f=28&t=8251&start=70#p69018 )


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


  
