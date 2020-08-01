-- dzevents script to check dead devices
-- based on example script from domoticz folder and for notify : https://easydomoticz.com/forum/viewtopic.php?t=6649
-- author : Deufo
-- instead of domoticz variable we use dzvents variable (data) to 'remember' state
-- since these (data) variables are not remembered by domoticz, a domoticz restart will 'forget' the previous state.
-- beware that dzvents variables have to be unique over all dzvents scripts since they are shared.
-- 3 notifications possible: log Error, mail and notify (telegram, kodi, google cloud... update SubSystem)

local cdd_username = '' --base 64 if local auth is needed (see Local Networks (no username/password) option, add 127.0.0.*)
local cdd_password = '' --base 64
local cdd_https = false -- true if only https supported
local cdd_port = '8080' -- http or https port
local cdd_ReturnNotif = true --Notification on normal condition return
local cdd_mail = nil -- your mail if notification by mail needed, nil if not

local devicesToCheck = {
	{ ['name'] = 'Device1', ['threshold'] = 60 },  -- replace Device1 by your device name. The threshold is in minutes. You can add lines for more devices.
	{ ['name'] = 'Device2', ['threshold'] = 60 },
	{ ['name'] = 'Device3', ['threshold'] = 120 }
}


local callBackString = "getDevices"
local message = ''
local message_light = 'Device(s): '

return {
	active = true,
    on      =   {   timer           =   { 'every 10 minutes' },   -- call to url will be done at this set time
                    httpResponses   =   { callBackString }       -- Script will be triggered again when url call rcomes back with data (= almost immediate)
                },
               
	data  =  {state = { initial = ""}, messageSent = "Nothing" },    -- thanks waaren for persistent data notification
        
	execute = function(dz, trigger)
		local Time = require('Time')
		local conditionDeviceState = "Off"
		
		local SubSystem =   nil
		    --[[ Notifications available :
                    --    NSS_GOOGLE_CLOUD_MESSAGING NSS_HTTP NSS_KODI NSS_LOGITECH_MEDIASERVER NSS_NMA NSS_PROWL NSS_PUSHALOT NSS_PUSHBULLET NSS_PUSHOVER NSS_PUSHSAFER NSS_TELEGRAM
                    --    If severals needed, use {}.
                    --    Example :{domoticz.NSS_TELEGRAM, domoticz.NSS_HTTP}
		    -- must be declared in function block (https://www.domoticz.com/forum/viewtopic.php?f=71&t=33539)
                    --]]

		-- FUNCTIONS
		local function notification(fenetre, message)
			dz.log("State before notify : "  .. dz.data.state,dz.LOG_DEBUG)
			dz.log("State after notify : "  .. conditionDeviceState,dz.LOG_DEBUG)
			if conditionDeviceState ~= dz.data.state then
				dz.log("Notification sending",dz.LOG_INFO)
				if SubSystem == nil then 
					dz.notify(fenetre, message, dz.PRIORITY_NORMAL)
				else
					dz.notify(fenetre, message, dz.PRIORITY_NORMAL, '', '', SubSystem)
				end
				if cdd_mail ~= nil then
					dz.email('Dead devices', message, cdd_mail)
				end
				dz.data.state = "On"
				dz.data.messageSent = message
			else
				dz.log("Nothing to send, message not updated",dz.LOG_INFO)        
			end
		end


		local function triggerJSON()
			local  URLString  = "http"
			if cdd_https then 
				URLString = URLString .. 's'
			end
			if (cdd_password == nil or cdd_username == nil) then
				URLString = URLString .. "://127.0.0.1:"..cdd_port.."/json.htm?type=devices&used=true"
			else
				URLString = URLString .. "://127.0.0.1:"..cdd_port.."/json.htm?type=devices&used=true&username="..cdd_username.."&password="..cdd_password
			end
            		dz.openURL({    url = URLString,
                            method = "GET",
                            callback = callBackString })                      
        	end

        
        -- main 
        if not (trigger.isHTTPResponse) then
            triggerJSON()                              -- call to url
        elseif trigger.ok then                         -- statusCode == 2xx
		if trigger.isJSON then
			local rt = dz.utils.fromJSON(trigger.data)  -- convert json data to Lua table
								
			for i, deviceToCheck in pairs(devicesToCheck) do
				local name = deviceToCheck['name']
				local id = dz.devices(name).id
				local threshold = deviceToCheck['threshold']
				local lastup = Time()

				for k in pairs(rt.result) do
					if (rt.result[k].Name == name) then
						lastup = Time(tostring(rt.result[k].LastUpdate))
						break
					end
				end
				
				--dz.log(name .. ' ' .. lastup.minutesAgo,dz.LOG_DEBUG)				
				if ( lastup.minutesAgo > threshold) then
					message = message .. 'Device ' ..
							name .. ' seems to be dead. No heartbeat for at least ' ..
							lastup.minutesAgo .. ' minutes at ' .. lastup.raw .. '. \n\r'
					message_light = message_light .. name .. ', '
				end					
			end
				
			if (message ~= "") then
				message_light = message_light .. 'seem(s) to be dead'
				dz.log(message_light, dz.LOG_DEBUG)
				dz.log(dz.data.messageSent, dz.LOG_DEBUG)
				if (message_light ~= dz.data.messageSent) then 
					dz.data.state = "Off"  -- force sending if new device added
				end						
				conditionDeviceState = "On"
				notification('Warning',message_light)
				dz.log('Dead devices found: ' .. message, dz.LOG_ERROR)
			end

		
			if dz.data.state ~= conditionDeviceState then   --Normal state return
				dz.data.state = conditionDeviceState
				if cdd_ReturnNotif then
					if SubSystem == nil then 
						dz.notify('Information','Return to normal state, all devices are operational')
					else
						dz.notify('Information','Return to normal state, all devices are operational', '', '', '', SubSystem)
					end
				end
			else
				dz.log("State Reset not needed",dz.LOG_DEBUG)
			end
			dz.log("Etat state: "  .. dz.data.state,dz.LOG_DEBUG)
			dz.log("Etat condition: "  .. conditionDeviceState,dz.LOG_DEBUG)
				
		else
		dz.log("Trig OK but JSON NOK",dz.LOG_DEBUG)
		end
        else
		    dz.log("triggerJSON() : Could not get (valid) data" ,dz.LOG_ERROR)
        end
    end
}
