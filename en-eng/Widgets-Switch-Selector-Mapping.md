# Provide a Mapping between Generic Switch Selector and what we have found


           if t == "ThermoModeEHZBRTS":
               self.ListOfDevices[NWKID]['Status'] = "inDB"
               unit = FreeUnit(self, Devices)
               Options = {"LevelActions": "||||||", "LevelNames": "Off| Manual| Schedule| Manual Energy Saver| Schedule Energy Saver| Holiday| Holiday Frost Protection",
                          "LevelOffHidden": "false", "SelectorStyle": "1"}
               myDev = Domoticz.Device(DeviceID=str(DeviceID_IEEE), Name=str(t) + "-" + str(DeviceID_IEEE) + "-" + str(Ep),
               
               
               if t == "ThermoMode":
       self.ListOfDevices[NWKID]['Status'] = "inDB"
       unit = FreeUnit(self, Devices)
       Options = {"LevelActions": "|||", "LevelNames": "Off|Auto|Cool|Heat|Force Heat",
                  "LevelOffHidden": "false", "SelectorStyle": "0"}
                  
                  
                  
                if t == "HACTMODE":
                  self.ListOfDevices[NWKID]['Status'] = "inDB"
                  unit = FreeUnit(self, Devices)
                  Options = {"LevelActions": "||", "LevelNames": "Off|Conventional|Set Point|Fil Pilote",
                          "LevelOffHidden": "true", "SelectorStyle": "0"}
                          
                          
                   if t == "FIP":
                    loggingWidget( self, "Debug", "==> hactFIPMode enabled,create FIP widget", NWKID)
                    self.ListOfDevices[NWKID]['Status'] = "inDB"
                    unit = FreeUnit(self, Devices)
                    Options = {"LevelActions": "||||||", "LevelNames": "Off|Confort|Confort -1|Confort -2|Eco|Frost Protection|Off",
                            "LevelOffHidden": "true", "SelectorStyle": "0"}
                            
                            
                            
                  if t == "LegrandFilPilote":
                self.ListOfDevices[NWKID]['Status'] = "inDB"
                unit = FreeUnit(self, Devices)
                Options = {"LevelActions": "||||||", "LevelNames": "Off|Confort|Confort -1|Confort -2|Eco|Hors Gel|Off",
                           "LevelOffHidden": "true", "SelectorStyle": "0"}
                           
                           
                    if t == "AlarmWD": # IAS object / matching 0x0502 Cluster / Alarm/Siren
               self.ListOfDevices[NWKID]['Status'] = "inDB"
               Options = {"LevelActions": "|||||", "LevelNames": "Stop|Alarm|Siren|Strobe|Armed|Disarmed",
                          "LevelOffHidden": "false", "SelectorStyle": "0"}
                          
                          
                if t == 'LegrandSelector':
               self.ListOfDevices[NWKID]['Status'] = "inDB"
               Options = {"LevelActions": "||||", "LevelNames": "Off|On|Move Up|Move Down|Stop",
                           "LevelOffHidden": "false", "SelectorStyle": "1"}
               unit = FreeUnit(self, Devices)
               
               
              if t == "SwitchAQ2":  # interrupteur multi lvl lumi.sensor_switch.aq2
                self.ListOfDevices[NWKID]['Status'] = "inDB"
                if self.ListOfDevices[NWKID]['Model'] == 'lumi.sensor_switch':
                    Options = {"LevelActions": "|||", "LevelNames": "1 Click|2 Clicks|3 Clicks|4+ Clicks",
                            "LevelOffHidden": "false", "SelectorStyle": "1"}
                else:
                    Options = {"LevelActions": "|||", "LevelNames": "1 Click|2 Clicks|3 Clicks|4+ Clicks",
                            "LevelOffHidden": "false", "SelectorStyle": "0"}             
               
               
                if t == "SwitchAQ3":  # interrupteur multi lvl lumi.sensor_switch.aq2
               self.ListOfDevices[NWKID]['Status'] = "inDB"
               Options = {"LevelActions": "||||", "LevelNames": "Click|Double Click|Long Click|Release Click|Shake",
                          "LevelOffHidden": "false", "SelectorStyle": "1"}
               unit = FreeUnit(self, Devices)
               myDev = Domoticz.Device(DeviceID=str(DeviceID_IEEE), Name=deviceName( self, NWKID, t, DeviceID_IEEE, Ep), 
                               Unit=unit, Type=244, Subtype=62, Switchtype=18, Options=Options)
                               
                               
                               
                               
             if t == "DSwitch":  # interrupteur double sur EP different
               self.ListOfDevices[NWKID]['Status'] = "inDB"
               Options = {"LevelActions": "|||", "LevelNames": "Off|Left Click|Right Click|Both Click",
                          "LevelOffHidden": "true", "SelectorStyle": "0"}
               unit = FreeUnit(self, Devices)
               myDev = Domoticz.Device(DeviceID=str(DeviceID_IEEE), Name=deviceName( self, NWKID, t, DeviceID
               
               
                    if t == "DButton":  # interrupteur double sur EP different lumi.sensor_86sw2
                self.ListOfDevices[NWKID]['Status'] = "inDB"
                Options = {"LevelActions": "|||", "LevelNames": "Off|Switch 1|Switch 2|Both_Click",
                           "LevelOffHidden": "true", "SelectorStyle": "1"}
                unit = FreeUnit(self, Devices)       
                               
                               
                if t == "DButton_3":  # interrupteur double sur EP different lumi.sensor_86sw2
                self.ListOfDevices[NWKID]['Status'] = "inDB"
                Options = {"LevelActions": "|||||||||", "LevelNames": "Off|Left Click|Left Double Clink|Left Long Click|Right Click|Right Double Click|Right Long Click|Both Click|Both Double Click|Both Long
                           "LevelOffHidden": "true", "SelectorStyle": "1"}
                unit = FreeUnit(self, Devices)
                myDev = Domoticz.Device(DeviceID=str(DeviceID_IEEE), Name=deviceName( self, NWKID, t, DeviceID_IEEE, Ep),                            
                               
                               
                               
               if t == "Toggle": # Switch selector provding On, Off and Toggle
                self.ListOfDevices[NWKID]['Status'] = "inDB"
                unit = FreeUnit(self, Devices)
                Options = {"LevelActions": "||", "LevelNames": "Off|On|Toggle",
                           "LevelOffHidden": "false", "SelectorStyle": "0"}
                unit = FreeUnit(self, Devices)                            
                               
                               
                               
                if t == "Button_3":  # inter sans fils 1 touche 86sw1 xiaomi 3 States 
                self.ListOfDevices[NWKID]['Status'] = "inDB"
                Options = {"LevelActions": "|||", "LevelNames": "Off|Click|Double Click|Long Click", \
                           "LevelOffHidden": "false", "SelectorStyle": "1"}
                unit = FreeUnit(self, Devices)                           
                               
                               
                  # Create the XCube Widget
                Options = {"LevelActions": "||||||||||",
                           "LevelNames": "Off|Shake|Alert|Free_Fall|Flip_90|Flip_180|Move|Tap|Clock_Wise|Anti_Clock_Wise",
                           "LevelOffHidden": "true", "SelectorStyle": "1"}                             
                               
                               
               
                if t == "Vibration":  # Aqara Vibration Sensor v1
                self.ListOfDevices[NWKID]['Status'] = "inDB"
                Options = {"LevelActions": "|||", "LevelNames": "Off|Tilt|Vibrate|Free Fall", \
                           "LevelOffHidden": "false", "SelectorStyle": "1"}           
               
               
               
              if t == 'INNR_RC110_SCENE': # INNR Remote Control
               self.ListOfDevices[NWKID]['Status'] = "inDB"
               Options = {"LevelActions": "||||||||||||", "LevelNames": "Off|On|click_up|click_down|move_up|move_down|stop|scene1|scene2|scene3|scene4|scene5|scene6", \
                          "LevelOffHidden": "false", "SelectorStyle": "1"}
               unit = FreeUnit(self, Devices)
               myDev = Domoticz.Device(DeviceID=str(DeviceID_IEEE), Name=deviceName( self, NWKID, 'SCENES', DeviceID_IEEE, Ep), 
                               Unit=unit, Type=244, Subtype=62, Switchtype=18, Options=Options)
               myDev.Create()            
               
              if t == 'INNR_RC110_LIGHT': # INNR Remote Control
               self.ListOfDevices[NWKID]['Status'] = "inDB"
               Options = {"LevelActions": "||||||", "LevelNames": "Off|On|click_up|click_down|move_up|move_down|stop", \
                          "LevelOffHidden": "false", "SelectorStyle": "1"}
               unit = FreeUnit(self, Devices)
               myDev = Domoticz.Device(DeviceID=str(DeviceID_IEEE), Name=deviceName( self, NWKID, 'LIGHTS', DeviceID_IEEE, Ep),             
               
               
            if t == "SwitchIKEA":
               self.ListOfDevices[NWKID]['Status'] = "inDB"
               Options = {"LevelActions": "||||", "LevelNames": "Off|On|Push Up|Push Down|Release", \
                          "LevelOffHidden": "false", "SelectorStyle": "1"}              
               
               
            if t == "Ikea_Round_5b": # IKEA Remote 5 buttons round one.
               self.ListOfDevices[NWKID]['Status'] = "inDB"
               Options = {"LevelActions": "|||||||||||||", "LevelNames": "Off|ToggleOnOff|Left_click|Right_click|Up_click|Up_push|Up_release|Down_click|Down_push|Down_release|Right_push|Right_release|Left
                          "LevelOffHidden": "false", "SelectorStyle": "1"}
               unit = FreeUnit(self, Devices)              
                          
