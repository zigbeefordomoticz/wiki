-- dzvents script to switch (shelly.cloud) switch based on Aqara double switch
-- author: hkhk (Hendrik)
-- instead of domoticz variable we use dzvents variable (data) to 'remember' state
-- since these (data) variables are not remembered by domoticz, a domoticz restart will 'forget' the previous state.
-- beware that dzvents variables have to be unique over all dzvents scripts since they are shared.

return {
	on = {
		devices = {'OutDoorSwitch'},
	},
	data  = {PondOn = {initial = 'Off'},
		       DecklightOnOff = {initial = 'Off'},
	         WoodshedlightOnOff = {initial = 'Off'}
	    },

	execute = function(domoticz, item)
    if (item.isDevice) 
      if ( item.levelName == 'Left Click') then
          if (domoticz.data.PondOn == 'Off') then
              domoticz.devices('ShellyPond').switchOn()
              domoticz.data.PondOn = 'On'
          else
            domoticz.devices('ShellyPond').switchOff()
            domoticz.data.PondOn = 'Off'
        end
      end
      if (item.levelName == 'Right Click') then
          if (domoticz.data.DecklightOnOff == 'Off') then
              domoticz.devices('DeckLight').switchOn()
              domoticz.data.DecklightOnOff = 'On'
          else
            domoticz.devices('DeckLight').switchOff()
            domoticz.data.DecklightOnOff = 'Off'
        end
      end
      if (item.levelName == 'Long Click') then
          if (domoticz.data.WoodshedlightOnOff == 'Off') then
              domoticz.devices('Woodshedlight').switchOn()
              domoticz.data.WoodshedlightOnOff = 'On'
          else
            domoticz.devices('Woodshedlight').switchOff()
            domoticz.data.WoodshedlightOnOff = 'Off'
        end
      end
    end  
	end
}
