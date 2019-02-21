-- dzvents script to control living room light.
-- author: hkhk (Hendrik)

-- lights are controller by schedule or switch
-- switch is Xiaomi Aqara Upgrade Wireless Switch Single Button
-- when using functions, you need to pass the domoticz object along to the function

function RoomOn(domoticz)
	-- function to switch groups on
	-- switching all groups at the same time leads to 'misses' so we delay with afterSec()
	domoticz.devices('GrpLedsLivingRoom').switchOn().checkFirst().afterSec(0)
	domoticz.devices('GrpPlugsLivingRoom').switchOn().checkFirst().afterSec(1)
	domoticz.devices('GrpBulbsLivingRoom').switchOff().afterSec(2)
	domoticz.data.RoomOnUit = 'On'
end

function RoomOff(domoticz)
	-- switching all groups at the same time leads to 'misses' so we delay with afterSec()
	domoticz.devices('GrpLedsLivingRoom').switchOff().checkFirst().afterSec(0)
	domoticz.devices('GrpPlugsLivingRoom').switchOff().checkFirst().afterSec(1)
	domoticz.devices('GrpBulbsLivingRoom').switchOff().afterSec(2)
	domoticz.data.RoomOnUit = 'Off'
end

-- script is triggered by switch or timer.

return {
	on = {
		devices = {'KamerSwitch'},
    timer = { 'every 1 minutes' }
	},
	data = {RoomOnOff = {initial = 'Off'}
	},
-- instead of domoticz variable we use dzvents variable (data) to 'remember' state
-- since these (data) variables are not remembered by domoticz, a domoticz restart will 'forget' the previous state.
-- beware that dzvents variables have to be unique over all dzvents scripts since they are shared.

	execute = function(domoticz, item)
		-- if switched by the Aqara switch, isDevice is trigerred
		-- Since the Aqara switch has no 'state', we need something to remember it.
    if (item.isDevice) then
      if (domoticz.data.RoomOnOff == 'Off')
      then
          RoomOn(domoticz)
      else
          RoomOff(domoticz)
      end
    end
        
    if (item.isTimer) then
			-- at defined times switch on light groups
	    if (domoticz.time.matchesRule('at 07:00 on mon,tue,wed,thu,fri') or 
	    		domoticz.time.matchesRule('at 8:00 on sat,sun') or 
	    		domoticz.time.matchesRule('at 30 minutes before sunset')) then
	        RoomOn(domoticz)
      end
			-- at defined times switch off light groups
      if (domoticz.time.matchesRule('at 08:25 on mon,tue,wed,thu,fri') or 
      		domoticz.time.matchesRule('at 00:45 on mon,tue,wed,thu,fri') or 
      		domoticz.time.matchesRule('at 02:30 on sat,sun')) then  
        	RoomOff(domoticz)
      end
    end
  end
}
