-- dzVents script to check dead devices
-- based on example script from domoticz folder and for notify : https://easydomoticz.com/forum/viewtopic.php?t=6649
-- author : Deufo
-- The last update time is read through the Domoticz JSON API, i.e. from the database,
-- so the 'Last Seen' touch done by the plugin is taken into account even when the
-- value of the device did not change (dzVents device.lastUpdate does not see it).
-- The alert state is kept in dzVents persistent data (per script, kept across restarts).
-- 3 notifications possible: log Error, mail and notify (telegram, kodi, google cloud... update SubSystem)

local cdd_https = false -- true if only https supported
local cdd_port = '8080' -- http or https port
-- The request comes from 127.0.0.1: add it to Setup > Settings > Local Networks,
-- otherwise Domoticz answers 401 (user name and password in the URL are not supported).
local cdd_ReturnNotif = true --Notification on normal condition return
local cdd_mail = nil -- your mail if notification by mail needed, nil if not

local devicesToCheck = {
	{ ['name'] = 'Device1', ['threshold'] = 60 },  -- replace Device1 by your device name (as in Setup > Devices). The threshold is in minutes, longer than the reporting interval of the device.
	{ ['name'] = 'Device2', ['threshold'] = 60 },
	{ ['name'] = 'Device3', ['threshold'] = 120 }
}


local callBackString = "getDevices"

return {
	active = true,
	on      =   {   timer           =   { 'every 10 minutes' },   -- call to url will be done at this set time
	                httpResponses   =   { callBackString }       -- Script will be triggered again when url call comes back with data (= almost immediate)
	            },

	data  =  { state = { initial = "Off" }, messageSent = { initial = "" } },    -- thanks waaren for persistent data notification

	execute = function(dz, trigger)
		local Time = require('Time')
		local conditionDeviceState = "Off"
		local message = ''
		local message_light = 'Device(s): '

		local SubSystem =   nil
		--[[ Notifications available :
			NSS_GOOGLE_CLOUD_MESSAGING NSS_HTTP NSS_KODI NSS_LOGITECH_MEDIASERVER NSS_NMA NSS_PROWL NSS_PUSHALOT NSS_PUSHBULLET NSS_PUSHOVER NSS_PUSHSAFER NSS_TELEGRAM
			If severals needed, use {}.
			Example :{dz.NSS_TELEGRAM, dz.NSS_HTTP}
			must be declared in function block (https://www.domoticz.com/forum/viewtopic.php?f=71&t=33539)
		--]]

		-- FUNCTIONS
		local function notify(subject, text)
			if SubSystem == nil then
				dz.notify(subject, text, dz.PRIORITY_NORMAL)
			else
				dz.notify(subject, text, dz.PRIORITY_NORMAL, '', '', SubSystem)
			end
		end

		local function notification(fenetre, text)
			dz.log("State before notify : "  .. dz.data.state, dz.LOG_DEBUG)
			dz.log("State after notify : "  .. conditionDeviceState, dz.LOG_DEBUG)
			if conditionDeviceState ~= dz.data.state then
				dz.log("Notification sending", dz.LOG_INFO)
				notify(fenetre, text)
				if cdd_mail ~= nil then
					dz.email('Dead devices', text, cdd_mail)
				end
				dz.data.state = "On"
				dz.data.messageSent = text
			else
				dz.log("Nothing to send, message not updated", dz.LOG_INFO)
			end
		end

		local function triggerJSON()
			local URLString = "http"
			if cdd_https then
				URLString = URLString .. 's'
			end
			URLString = URLString .. "://127.0.0.1:" .. cdd_port .. "/json.htm?type=command&param=getdevices&used=true"
			dz.openURL({    url = URLString,
			                method = "GET",
			                callback = callBackString })
		end


		-- main
		if not (trigger.isHTTPResponse) then
			triggerJSON()                              -- call to url
		elseif trigger.ok and trigger.isJSON and trigger.json.result ~= nil then
			local result = trigger.json.result

			for _, deviceToCheck in ipairs(devicesToCheck) do
				local name = deviceToCheck['name']
				local threshold = deviceToCheck['threshold']
				local lastup = nil

				for k in pairs(result) do
					if (result[k].Name == name) then
						lastup = Time(tostring(result[k].LastUpdate))
						break
					end
				end

				if lastup == nil then
					dz.log('Device ' .. name .. ' not found (check its name, and that it is used)', dz.LOG_ERROR)
				elseif (lastup.minutesAgo > threshold) then
					message = message .. 'Device ' ..
							name .. ' seems to be dead. No heartbeat for at least ' ..
							lastup.minutesAgo .. ' minutes at ' .. lastup.raw .. '. '
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
				notification('Warning', message_light)
				dz.log('Dead devices found: ' .. message, dz.LOG_ERROR)
			end

			if dz.data.state ~= conditionDeviceState then   --Normal state return
				dz.data.state = conditionDeviceState
				dz.data.messageSent = ""
				if cdd_ReturnNotif then
					notify('Information', 'Return to normal state, all devices are operational')
				end
			else
				dz.log("State Reset not needed", dz.LOG_DEBUG)
			end
			dz.log("Etat state: "  .. dz.data.state, dz.LOG_DEBUG)
			dz.log("Etat condition: "  .. conditionDeviceState, dz.LOG_DEBUG)
		else
			dz.log("triggerJSON() : Could not get (valid) data, HTTP " .. tostring(trigger.statusCode), dz.LOG_ERROR)
		end
	end
}
