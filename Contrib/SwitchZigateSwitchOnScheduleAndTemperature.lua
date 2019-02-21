-- dzvents script to switch on pump for floorheating
-- author: hkhk (Hendrik)
-- During summer time switch on pump every day for 2 minutes
-- During winter time only switch on if water temp higher than xxx
-- Water temp measured by Original Xiaomi Aqara Temperature Humidity Sensor
-- Pump switched with Osram wall plug

local TurnOff = 5
return {
	on = {
		timer = {'every minute'}
	},

	execute = function(domoticz, device)
			-- define summer = from may till october
    	local Summer = (domoticz.time.month > 4) and (domoticz.time.month < 10)
			-- define midday at noon
      local midday = domoticz.time.matchesRule('at 12:00')
      -- during summertimeswitch on pump every day at noon for 2 minutes
      if (Summer and midday) then 
          domoticz.devices('FloorheatingPump').switchOn().forMin(2)    -- turn on for 2 mintes
      end
      -- during wintertime if water temp higher than 25 degrees, switch on FloorheatingPump
      if (not Summer) and (domoticz.devices('Floorheating - Temp+Hum').temperature >= 25) then   
          domoticz.devices('FloorheatingPump').switchOn() -- turn pump on
    	else
    	-- leave the pump on for at least 5 minutes if temp drops lower than 25 degrees
	    if (domoticz.devices('FloorheatingPump').lastUpdate.minutesAgo >= TurnOff) then
            domoticz.devices('FloorheatingPump').switchOff() -- turn pump off
        end
    end
  end
}
