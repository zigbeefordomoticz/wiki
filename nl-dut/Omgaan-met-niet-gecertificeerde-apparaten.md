# Omgaan met niet gecertificeerde apparaten

Het proces wat hierna volgt helpt ons het probleem te identificeren met niet gecertificeerde apparaten (als deze zich voordoen) deze informatie kan je dus verzamelen om mee te geven als je een probleem aan maakt op GitHub.

1. Zet “Frame discovery archiving” aan bij de plugin instellen in Domoticz.
Het doel hiervan is om alle frames te archiveren tijdens het koppel proces van het apparaat. Koppel dan ook het apparaat als deze modus is ingeschakeld. Pas de [PluginConf.txt] aan (https://github.com/sasu-drooz/Domoticz-Zigate/wiki/PluginConf) en zet 'allowStoreDiscoveryFrames' op '1'. 

LET OP: Laat deze optie niet op “1” staan na de test, dit resulteert namelijk dat het systeem je vorige gekoppelde apparaten niet meer leest vanuit de DeviceConf.txt.

Het volgende proces zal een .json bestand aanmaken na het discovery proces. Je kan dit bestand vinden onder de “ZDatas” folder.

2. Zet “Permit to Join” aan in het plugin menu van Domoticz. 
3. Koppel je nieuwe apparaat, het proces duurt even na een tijdje wordt een nieuw bestand aangemaakt in de “ZDates” folder. Het bestand ziet er dan ongeveer zo uit:
`DiscoveryDevice-00158d00028f8e74.json` . Hier is “ 00158d00028f8e74 “ het IEEE (Mac Adres) van het apparaat.

Het bestand ziet er dan ongeveer zo uit van binnen : 

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



