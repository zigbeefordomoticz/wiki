local Alertidx = 126 -- Change to your idx for the Virtual Alert sensor you have created for this script
local hostWebUI = "192.168.1.68" -- Change to your local ip (127.0.0.1 most of the time)
local portWebUI = "9440"  -- Change WebUI port 
local protocol = 'http' -- http or https
local user = ''  -- '' if no user/password
local password = '' -- '' if no user/password

-- no changes needed below this section (except timer if you want to change frequency)
local apiPath = '/rest-z4d/1/zdevice-name'
local devicesLive=0
local devicesLost=0
local devicesUndefined=0


return {
	logging = {
	    level = domoticz.LOG_ERROR,
		marker = '(Zigate Status)'
	},
	on = {
		timer =  {'every 15 minutes'},   
		httpResponses = {'triggerSA'} -- must match with the callback passed to the openURL command
    	},
	execute = function(domoticz, item)

	if (item.isTimer) then
	   domoticz.devices(Alertidx).updateAlertSensor(domoticz.ALERTLEVEL_GREY, "Requesting ...")
        if (user == '') then
            fullURL = protocol .. '://' .. hostWebUI .. ':' .. portWebUI .. apiPath
        else
            fullURL = protocol .. '://' .. user .. ':' .. password .. '@' .. hostWebUI .. ':' .. portWebUI .. apiPath
        end
	    domoticz.openURL({
    	    url = fullURL,
			method = 'GET',
			callback = 'triggerSA' -- see httpResponses above.
		})
	end

	if (item.isHTTPResponse) then
		if (item.ok) then
			if (item.isJSON) then

				local result_table = item.json
				local tc = #result_table
				
				for i = 1, tc do
				    if result_table[i].Health == "Live" then
                        devicesLive=devicesLive+1
                    elseif result_table[i].Health == "Not Reachable" then
                        devicesLost=devicesLost+1
                    else
                        devicesUndefined=devicesUndefined+1
                    end
                end
				
				
				if devicesLost == 0 and devicesUndefined==0 then
				    level = domoticz.ALERTLEVEL_GREEN 	-- domoticz.ALERTLEVEL_GREY, ALERTLEVEL_GREEN, ALERTLEVEL_YELLOW, ALERTLEVEL_ORANGE, ALERTLEVEL_RED
				    AlertText = devicesLive	
				elseif devicesLost==0 then
				    level = domoticz.ALERTLEVEL_ORANGE 	
				    AlertText = devicesUndefined
				else 
				    level = domoticz.ALERTLEVEL_RED 	
				    AlertText = devicesLost
                end
                AlertText="Live: " .. devicesLive .. "\nUnknown: " .. devicesUndefined .. "\nLost: " ..devicesLost 
				-- update device in Domoticz
				domoticz.devices(Alertidx).updateAlertSensor(level, AlertText)
			end
		else
			domoticz.log('There was a problem handling the request' .. url, domoticz.LOG_ERROR)
            domoticz.devices(Alertidx).updateAlertSensor(domoticz.ALERTLEVEL_RED, "Unable to retrieve devices status ... check plugin and settings")
		end

	end
end
}
