# Dealing with none-certified device

If the device is not correctly associated - means that there is some miss-match in the Domoticz widget -

The here after process will help to identify as much information from this device and could be given with the Issue you might create on GitHub

1. Enable frame discovery archiving
Purpose is to archive the discovery frames during the pairing process.
To do so, edit [PluginConf.txt](https://github.com/sasu-drooz/Domoticz-Zigate/wiki/PluginConf) and set 'allowStoreDiscoveryFrames' to '1'. 

ATTENTION: do not leave it to 1 after the test, as it will force the system and the DeviceConf.txt (where you have pre-configured devices) will never be look at.
This will create a json file at the end of the discovery process under `Zdatas` directory

1. `Enable Permit to Join` in the Hardware plugin menu
Pair your new device, the process will take a while, and will be completed when a file like  `DiscoveryDevice-00158d00028f8e74.json` will be created under `Zdatas` directory. Where 00158d00028f8e74 is the IEEE (Mac Address) of that device

Here after are the informations you can find : 

`cat DiscoveryDevice-00158d00028f8e74.json`

`{"004d": "55ab00158d00028f8e7480", "8043": {"01": "210055ab200101045f010105000000030019ffff00120700000004000300050019ffff0012", "02": "230055ab140201045f02010200030012040004000300050012", "03": "240055ab140301045f0301020003000c04000400030005000c"}, "8045": "200055ab03010203", "Ep": {"01": {"0000": {}, "0003": {}, "0019": {}, "ffff": {}, "0012": {}, "0004": {}, "0005": {}, "ClusterType": {"857": "Button_3"}}, "02": {"0003": {}, "0012": {}, "0004": {}, "0005": {}, "ClusterType": {}}, "03": {"ClusterType": {}, "0003": {}, "000c": {}, "0004": {}, "0005": {}}}, "MacCapa": "80", "IEEE": "00158d00028f8e74", "ProfileID": {"0104": "03"}, "ZDeviceID": {"5f01": "01", "5f02": "02", "5f03": "03"}, "Model": "lumi.remote.b186acn01", "App_Version": "8", "NbEP": "3"}`

| Field | Description |
| ----- | ----------- |
| 004d  | Frame received with the 0x004d code |
| 8045  | Frame received with the 0x8045 code |
| 8042  | Frame received with the 0x8041 code |
| 8043 xx | Frame received with the 0X8053 for Ep |
| ProfileID | |
| ZDeviceID | |
| Model | |
| Manufacturer | |
| DeviceType   | |
| LogicalType  | Controler / Router / End device |
| PowerSource  | Main / Battery |
| ReceiveOnIdle | Ether accept or not receiving messages when idle |



