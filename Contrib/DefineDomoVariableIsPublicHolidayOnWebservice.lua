-- dzvents script to set domoticz variable "isPublicHoliday" based on json return of public web service
-- author: hkhk (Hendrik)

local today = os.date("%d-%m-%Y")

return {
	on = { 
	    timer = {'at 00:30 everyday'},
	    httpResponses = {'holidayretrieved'}
	},
	
	execute = function(domoticz, item)
	
    if (item.isTimer) then
    -- at half past midnight call the webservice
      domoticz.openURL({
          url = 'https://kayaposoft.com/enrico/json/v2.0/?action=isPublicHoliday&date="..today.."&country=nld',
          method = 'GET',
          callback = 'holidayretrieved'
      })
    elseif (item.isHTTPResponse) then
    -- if the function is completed, check if teh response was in order and if teh result is json formatted
      if (item.ok and item.isJSON) then -- statusCode == 2xx
        if (item.json.isPublicHoliday) then 
        	-- set the domoticz variable isPublicHoliday to 1 if it is a public holiday, else set it to 0
          domoticz.variables('isPublicHoliday').set(1)
        else
          domoticz.variables('isPublicHoliday').set(0)
        end
      end
    end
  end
}