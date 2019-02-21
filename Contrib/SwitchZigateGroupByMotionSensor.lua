-- dzvents script to switch on Ikea Leds based on Original Xiaomi Aqara Human Body Sensor
-- author: hkhk (Hendrik)

local TurnOff = 3			-- automatically switch off leds after x minutes

return {
-- act on 2 events: Montion sensor and timer
	on = {
		devices = {'MotionHal'},
    timer = { 'every 1 minutes' }
	},

	execute = function(domoticz, item)
        -- if activated by motion sensor, switch group of Ikea leds on but only if they are not yet switched on.
        if (item.isDevice and item.active) then
          domoticz.devices('GrpHalBasement').switchOn().checkFirst()
        end
        -- On timer (every minute) check if motion sensor has not been triggerd (by checking lastupdate). 
        -- If this was more than TurnOff minutes ago, switch off the led group
        if (item.isTimer) and (domoticz.devices('MotionHal').lastUpdate.minutesAgo >= TurnOff) then
          domoticz.devices('GrpHalBasement').switchOff().checkFirst()
        end
	end
}
