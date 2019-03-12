-- dzevents script to check dead devices
-- based on example script from domoticz folder and for notify : https://easydomoticz.com/forum/viewtopic.php?t=6649
-- author : Deufo
-- instead of domoticz variable we use dzvents variable (data) to 'remember' state
-- since these (data) variables are not remembered by domoticz, a domoticz restart will 'forget' the previous state.
-- beware that dzvents variables have to be unique over all dzvents scripts since they are shared.
-- 3 notifications possible: log Error, mail and notify (telegram, kodi, google cloud...)


local devicesToCheck = {
	{ ['name'] = 'Device1', ['threshold'] = 60 },
	{ ['name'] = 'Device2', ['threshold'] = 60 },
	{ ['name'] = 'Device3', ['threshold'] = 120 }
}

local SubSystem =   nil
 --domoticz.NSS_TELEGRAM --domoticz.NSS_PUSHBULLET 
                    --[[ Systèmes de notification disponibles :
                    --    NSS_GOOGLE_CLOUD_MESSAGING NSS_HTTP NSS_KODI NSS_LOGITECH_MEDIASERVER NSS_NMA NSS_PROWL NSS_PUSHALOT NSS_PUSHBULLET NSS_PUSHOVER NSS_PUSHSAFER
                    --    Pour une notification sur plusieurs systèmes, séparez les systèmes par une virgule et entourez l'ensemble par des {}.
                    --    Exemple :{domoticz.NSS_TELEGRAM, domoticz.NSS_HTTP}
                    --]]

local message = '.'

return {
	active = true,
	on = {
		['timer'] = {
			'every 5 minutes'
		}
	},
 
     
  data    =   {   state                 = { initial = ""                  }},    -- thanks waaren for persistent data notification

	execute = function(domoticz)

	local conditionDeviceState              = "Off"        
    -- FUNCTIONS
    local function notification(fenetre, message)

            domoticz.log("State before notify : "  .. domoticz.data.state,domoticz.LOG_DEBUG)
            domoticz.log("State after notify : "  .. conditionDeviceState,domoticz.LOG_DEBUG)
            if conditionDeviceState ~= domoticz.data.state then
                domoticz.log("Notification sending",domoticz.LOG_INFO)
                if SubSystem == nil then 
                    domoticz.notify(fenetre, message)
                else
                    domoticz.notify(fenetre, message, '', '', '', SubSystem)
                end 
                domoticz.log(message, domoticz.LOG_INFO)
                domoticz.data.notificationSent = domoticz.time.raw      -- Store time of notification 
                domoticz.data.state = "On"
            else
                domoticz.log("Nothing to send",domoticz.LOG_INFO)        
            end
    end
	
	-- Devices Check
		local message = ""

		for i, deviceToCheck in pairs(devicesToCheck) do
			local name = deviceToCheck['name']
			local threshold = deviceToCheck['threshold']
			local minutes = domoticz.devices(name).lastUpdate.minutesAgo

			if ( minutes > threshold) then
				message = message .. 'Device ' ..
						name .. ' seems to be dead. No heartbeat for at least ' ..
						minutes .. ' minutes.\r'
			end
		end

		if (message ~= "") then
			--domoticz.email('Dead devices', message, 'me@address.nl')
			conditionDeviceState = "On"
			notification('Warning','Dead devices found: ' .. message)
			domoticz.log('Dead devices found: ' .. message, domoticz.LOG_ERROR)
		end

	
		if domoticz.data.state ~= conditionDeviceState then   -- state change ?
		   domoticz.data.state = conditionDeviceState
		else
		domoticz.log("State Reset no needed",domoticz.LOG_DEBUG)
		end
		domoticz.log("State: "  .. domoticz.data.state,domoticz.LOG_DEBUG)
		domoticz.log("State condition: "  .. conditionDeviceState,domoticz.LOG_DEBUG) 
end
}
