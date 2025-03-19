
# Device Specific Parameters

## Overview

Those parameters can be added via the WebUI and can change the behaviour of the device.
They are found on the "Param": {} section

## Table

| Parameter                        | File where it is found                        | JSON Usage File(s)                     |  Description |
|-----------------------------------|-----------------------------------------------|----------------------------------------|---------------|
| AqaraMultiClick                   | ./Modules/pairingProcess.py | lumi.remote.acn003, lumi.remote.acn004 |                      |
| ConfigurationReportChunk          | ./Classes/ConfigureReporting.py | CMS323, ZLinky_TIC-historique-mono, ZLinky_TIC-historique-tri, ZLinky_TIC-standard-mono-prod, ZLinky_TIC-standard-tri-prod, ZLinky_TIC-standard-tri, ZLinky_TIC, ZiPulses, ZLinky_TIC-standard-mono, PIR313-E, PIR313, PIR323-PTH, PIR323 |                      |
| FORCE_COLOR_COMMAND               | ./Modules/actuators.py | Not Used |                      |
| MinDimmerPercentage               | ./Modules/command.py | GL-SD-003P |                      |
| MotionViaIASAlarm1                | ./Z4D_decoders/z4d_decoder_IAS.py | LDSENK10, 90201022, MOSZB-140, 3AFE14010402000D, 3AFE28010402000D, VMS_ADUROLIGHT, PIR313-E, PIR313, 66666-motion, RH3040, TS0202-WHD02, TS0202-_TZ3210_jijr1sss, TS0202, TS0210, TS0225, TY0202 |                      |
| MoveWithOnOff                     | ./Modules/command.py | Not Used |                      |
| RWL021_Dimmer_step                | ./Modules/philips.py | RWL021, RWL022 |                      |
| ReadAttributeChunk                | ./Modules/readAttributes.py | CMS323, MWA1-TIC-standard-mono-base, MWA1-TIC, EMIZB-141, HESZB120, HMSZB-110, MOSZB-140, SMSZB-120, SPLZB-131, SPLZB-132, WISZB-120, ZHEMI101, PIR313-E, PIR313, PIR323-PTH, PIR323, TS0002_relay_switch, TS0003_relay_switch, TY0202, GL-SD-003P |                      |
| SONOFF_HUMI_MAX                   | ./DevicesModules/custom_sonoff.py | Not Used |                      |
| SONOFF_HUMI_MIN                   | ./DevicesModules/custom_sonoff.py | Not Used |                      |
| SONOFF_TEMP_MAX                   | ./DevicesModules/custom_sonoff.py | Not Used |                      |
| SONOFF_TEMP_MIN                   | ./DevicesModules/custom_sonoff.py | Not Used |                      |
| SimulateThermostat6400            | ./Modules/schneider_wiser.py | Not Used |                      |
| TS011F_overCurrentBreaker         | ./Modules/tuyaTS011F.py | TS011F-with_threshold |                      |
| TS011F_overCurrentThreshold       | ./Modules/tuyaTS011F.py | TS011F-with_threshold |                      |
| TS011F_overPowerBreaker           | ./Modules/tuyaTS011F.py | TS011F-with_threshold |                      |
| TS011F_overPowerThreshold         | ./Modules/tuyaTS011F.py | TS011F-with_threshold |                      |
| TS011F_overTemperatureBreaker     | ./Modules/tuyaTS011F.py | TS011F-with_threshold |                      |
| TS011F_overTemperatureThreshold   | ./Modules/tuyaTS011F.py | TS011F-with_threshold |                      |
| TS011F_overVoltageBreaker         | ./Modules/tuyaTS011F.py | TS011F-with_threshold |                      |
| TS011F_overVoltageThreshold       | ./Modules/tuyaTS011F.py | TS011F-with_threshold |                      |
| TS011F_underVoltageBreaker        | ./Modules/tuyaTS011F.py | TS011F-with_threshold |                      |
| TS011F_underVoltageThreshold      | ./Modules/tuyaTS011F.py | TS011F-with_threshold |                      |
| TUYAColorControlRgbMode           | ./Modules/actuators.py | TS0505A-HueSaturation |                      |
| TuyaColorGradiantOffTime          | ./Modules/tuya.py | TS0503B |                      |
| TuyaColorGradiantOnTime           | ./Modules/tuya.py | TS0503B |                      |
| disableBinaryInputCluster         | ./Modules/readZclClusters.py | Shutter switch with neutral, Shutters central remote switch |                      |
| ecCompensation                    | ./Modules/tuyaTS0601.py | TS0601-BLE-YL01 |                      |
| orpCompensation                   | ./Modules/tuyaTS0601.py | TS0601-BLE-YL01 |                      |
| ph7Compensation                   | ./Modules/tuyaTS0601.py | TS0601-BLE-YL01 |                      |
| tempCompensation                  | ./Modules/tuyaTS0601.py | TS0601-BLE-YL01 |                      |