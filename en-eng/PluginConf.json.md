# PluginConf

This file is used to customized some behaviour of the plugin at run time

If you are updating values in PluginConf, we strongly recommend you to make a copy of it in order to avoid any lost when doing an update of the plugin.

The file is edited directly from the Web Admin page.

ATTENTION: Starting Version 4.5 the Configuration File Name is : PluginConf-xx.json and not '.txt', and respect the json syntax.

The .txt' one is not more used and can be removed


## Services

Those parameters allow the activation or not of services at plugin start.

| parameter | default | description |
| --------- | ------- | ----------- |
| enablegroupmanagement | disable | manage the Groups |
| enableReadAttributes | disable | manage the polling service |
| enableWebServer |  |  manage the Web Admin page |
| allowOTA | disable |  manage the Over-the-Air firmware upgrade |
| pingDevices | enable |  ping every hour each main powered device (see pingDevicesFeq parameter) |

## DomoticzEnvironment

Some of the Domoticz parameters like on which port Domoticz listen for getting access to the domoticz API need to be provided.

| parameter | default | description |
| --------- | ------- | ----------- |
| port      | 8080    | on which port Domoticz listen to accept API requests |


## Web Interface

Those are parameters which will influence the behaviour of the plugin internal web server. We do recommend to not touch it.

| parameter | default | description |
| --------- | ------- | ----------- |
| enableGzip | enable | gzip compression |
| enableDeflate |enable | deflate compression |
| enableChunk | enable | allow file to be chunk |
| enableKeepalive | enable | Keep a live session |
| enableCache | enable | caching |

## Polling

Those parameter manage the Polling activities (if enabled).
We do not recommend to enable it as it will increase the load on the Zigate and on the network. Please do note that reducing the timing will increase the frequency of polling information from the device and can generate bottleneck and even impact async commands.

| parameter | default | description |
| --------- | ------- | ----------- |
| pingDevicesFeq | 3600 | Ping device frequency every hour |
| polling0000 | 8600 | retreiving device basic info every day |
| polling0001 | 86400 | retreving device power info every day |
| pollingONOFF | 900 | retreving device On/off status every 15' |
| pollingLvlControl | 900 | retreiving device Level Control every 15' |
| polling000C | 3600 |   |
| polling0100 | 3600 | retreiving Shade Configuration |
| polling0102 | 900 | retreiving Window Covering info |
| polling0201 | 900 | Thermostat |
| polling0204 | 86400 | Fan Control |
| polling0300 | 900  | Color Control |
| polling0400 | 900 | Illuminance measurement |
| polling0402 | 900 | Temperature measurement |
| polling0403 | 900 | Pressure measurement |
| polling0405 | 900 | Relative Humidity |
| polling0406 | 900 | Occupancy sensing |
| polling0500 | 86400 | |
| polling0502 | 86400 | |
| polling0702 | 900 | Power measure |
| polling000f | 900 | |
| pollingfc01 | 900 | |


## Device Management

| parameter | default | description |
| --------- | ------- | ----------- |
| forcePollingAfterAction | enable | will request a status update of the device state after an action |
| forcePassiveWidget | disable | will allow a Domoticz acion on the widget dispite the fact that the end device cannot receive the command. For exemple you have a Xiaomi battery device. |
| allowForceCreationDomoDevice| disable | Will create a Domotciz Widget even if there is already an existing one. |
| resetPluginDS | disable | will reset the plugin database data structure |
| resetConfigureReporting| disable | will reset the Configure Reporting info |
| resetReadAttributes | disable | will reset the polling info |
| resetMotiondelay | 30 | time before moving the Motion state to Off. You can use the one from the Domotciz Motion widget |
| allowGroupMembership | enable | will allow the plugin to automaticaly create group membership if known (Legrand) |
| doUnbindBind | disable | will force an unbind before binding a cluster |
| allowReBindingClusters | enable | will rebind clusters if the device is coming back |

 

 # Zigate Configuration
 
| parameter | default | description |
| --------- | ------- | ----------- |
| allowRemoveZigateDevice | disable | If enable when removing a device, a request will be done also to Zigate |
| blueLedOnOff | enable | manage the Zigate blue led.
| enableAPSFailureReporting | enable | Will manage the Zigbee communication issues |
| Ping | enable | will ping Zigate every 4' to insure the connectivity |
| eraseZigatePDM | disable | if enable will allow a proper erase of Zigate PDM from the Web Admin |
| Certification | CE | CE or FCC certifications |
| channel | 0 | One of those 11, 15, 19, 20, 25 and 26 Zigate channel. 0 means Zigate will select the best one. Channing the channel will require a Soft Reset of Zigate and your already paired devices might need to be repaired |
| TXpower_set | 0 | Power attenuation. 0: 0dBM, 1: -9 dBM, 2: -20dBM, 3: -32dBM |
| extendedPANID | 0 | You can force the Extended PAN Id, this would required a full Erase PDM |


## CommandTransition

* Not implemented

| parameter | default | description |
| --------- | ------- | ----------- |
| moveToHueSatu | 0 | define the tenth of second of transition betwen one level to the next level |
| moveToColourTemp | 0 | define the tenth of second of transition betwen one level to the next level |
| moveToColourRGB | 0 | define the tenth of second of transition betwen one level to the next level |
| moveToLevel | 0 | define the tenth of second of transition betwen one level to the next level |


## Over The Air Upgrade
        'OverTheAirUpgrade': { 'Order': 7, 'param': {
                'batteryOTA':  { 'type':'bool', 'default':0 , 'current': None, 'restart':True , 'hidden':False, 'Advanced':False},
                'waitingOTA':  { 'type':'int', 'default':3600 , 'current': None, 'restart':True , 'hidden':False, 'Advanced':False}
            }},




## Verbose
        'VerboseLogging': { 'Order': 11, 'param': {
                'debugMatchId':  { 'type':'str', 'default':'ffff' , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'logDeviceUpdate':  { 'type':'bool', 'default':1 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':False},
                'logFORMAT':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'capturePairingInfos': { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':False},
                'debugInput':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugOutput':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugTransportTx':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':True, 'Advanced':True},
                'debugTransportRx':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':True, 'Advanced':True},
                'debugCluster':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugHeartbeat':{ 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugWidget':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugPlugin':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugDatabase':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugCommand':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugPairing':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugNetworkMap':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugNetworkEnergy':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugGroups':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugOTA':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugIAS':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugAPS':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugDZDB':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugWebServer':  { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                'debugzigateCmd': { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':True, 'Advanced':True}
                }},

## Legrand Specific
        'Legrand': { 'Order': 12, 'param': {
                'EnableLedIfOn': {'type':'bool', 'default':1, 'current': None, 'restart':False , 'hidden':False, 'Advanced':False},
                'EnableLedInDark': {'type':'bool', 'default':0, 'current': None, 'restart':False , 'hidden':False, 'Advanced':False},
                'EnableDimmer': { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':False},
                'LegrandFilPilote': { 'type':'bool', 'default':1 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':True},
                }},

## Others
        'Others': { 'Order': 13, 'param': {
                'alarmDuration': {'type':'int', 'default':1, 'current': None, 'restart':False , 'hidden':False, 'Advanced':False},
                'enableSchneiderWiser': { 'type':'bool', 'default':0 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':False},
                'numTopologyReports': { 'type':'int', 'default':4 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':False},
                'numEnergyReports': { 'type':'int', 'default':4 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':False},
                'PowerOn_OnOff': { 'type':'int', 'default':255 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':False},
                'TradfriKelvinStep': { 'type':'int', 'default':51 , 'current': None, 'restart':False , 'hidden':False, 'Advanced':False},
                'vibrationAqarasensitivity': { 'type':'str', 'default':'medium' , 'current': None, 'restart':False , 'hidden':False, 'Advanced':False},
                }},

