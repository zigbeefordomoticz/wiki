# Device Configuration Attributes

## Overview

Those attributes, are added in the Device Configuration file, when we are Certifying the device with the plugin.
They can define a particular behaviour.


## Table


| Parameter                        | File where it is found                        | JSON Usage File(s)                     |
|-----------------------------------|-----------------------------------------------|----------------------------------------|
| SummationMeteringMultiplier       | ./Modules/lumi.py | lumi.plug.maeu01, ZiPulses, TS000F-Power, TS011F-2gang-plug, TS011F-plug-Elivco, TS011F-plug, TS011F-with_threshold, TS0121, TS011F-din |
| SummationMeteringDivisor          | ./Modules/lumi.py | lumi.plug.maeu01, ZiPulses, TS000F-Power, TS011F-2gang-plug, TS011F-plug-Elivco, TS011F-plug, TS011F-with_threshold, TS0121, TS011F-din |
| RMSVoltageDivisor                 | ./Modules/lumi.py | SPLZB-131, SPLZB-132, lumi.plug.maeu01, outletv4 |
| RMSVoltageMultiplier              | ./Modules/lumi.py | Not Used |
| RMSCurrentDivisor                 | ./Modules/lumi.py | SPLZB-131, SP 120, lumi.plug.maeu01, SOCKETOUTLET2, SOCKETOUTLET1, TS000F-Power, TS011F-2gang-plug, TS011F-plug-Elivco, TS011F-plug, TS011F-with_threshold, TS0121, TS011F-din |
| RMSCurrentMultiplier              | ./Modules/lumi.py | Not Used |
| PowerMeteringMultiplier           | ./Modules/lumi.py | Not Used |
| PowerMeteringDivisor              | ./Modules/lumi.py | SOCKETOUTLET2, SOCKETOUTLET1 |
| XIAOMI_METER_EP                   | ./Modules/lumi.py | lumi.plug.maeu01 |
| PowerOnOffStateAttribute8002      | ./Modules/onoff_settings.py | TS0001, TS0002, TS0002_relay_switch, TS0003_relay_switch, TS0004-_TZ3000_excgg5kb, TS0004-_TZ3000_u3oupgdy, TS0004-relay_switch, TS0004, TS000F-Power, TS000F-TYZGTH4CH-D1RF, TS000F, TS0012, TS0013, TS0115, TS011F-2Gang-switches, TS011F-multiprise, TS011F-plug-Elivco, TS011F-plug, TS011F-with_threshold, TS0121, TS011F-din, TS0012-manufs, TS0013-manufs, TS0011-manufs |
| HUE_RWL                           | ./Modules/philips.py | RWL021, RWL022 |
| HUE_RWL                           | ./Modules/philips.py | RWL021, RWL022 |
| TUYA_CMD_FE                       | ./Modules/tuya.py | Not Used |
| TUYA_DATA_REQUEST                 | ./Modules/tuya.py | TS0601-BAB-1413Pro-E, TS0601-BLE-YL01, TS0601-ME168 |
| TUYA_DATA_REQUEST_POLLING         | ./Modules/tuya.py | TS0601-BAB-1413Pro-E, TS0601-BLE-YL01, TS0601-ME168 |
| TUYA_DATA_REQUEST_POLLING_ADDITIONAL | ./Modules/tuya.py | Not Used |
| TUYA_DATA_REQUEST_POLLING_CONSECUTIVE_ELAPSE | ./Modules/tuya.py | Not Used |
| TY_DEFAULT_RESPONSE               | ./Modules/tuya.py | TS0601-BLE-YL01 |
| WSRangeForTradfri                 | ./Modules/actuators.py | FLOALT panel WS 30x90, FLOALT panel WS 60x60, TRADFRI bulb E12 WS opal 400lm, TRADFRI bulb E14 WS 470lm, TRADFRI bulb E14 WS opal 400lm, TRADFRI bulb E14 WS opal 600lm, TRADFRI bulb E26 WS clear 950lm, TRADFRI bulb E26 WS opal 980lm, TRADFRI bulb E27 W opal 470lm, TRADFRI bulb E27 WS clear 806lm, TRADFRI bulb E27 WS clear 950lm, TRADFRI bulb E27 WS globe 1055lm, TRADFRI bulb E27 WS opal 1000lm, TRADFRI bulb E27 WS opal 950lm, TRADFRI bulb E27 WS opal 980lm, TRADFRI bulb E27 opal 470lm, TRADFRI bulb GU10 WS 345lm, TRADFRI bulb GU10 WS 400lm, TRADFRIbulbE14WScandleopal470lm, TRADFRIbulbE14WSglobeopal470lm, TRADFRIbulbE27WSglobeopal1055lm, TRADFRIbulbGU10WS345lm, TRADFRIbulbT120E27WSopal470lm, TRADFRI bulb E14 WS globe 470lm |
| FORCE_COLOR_COMMAND               | ./Modules/actuators.py | TS0505A-HueSaturation |
| NoColorCapabilitie                | ./Modules/actuators.py | Not Used |
| PowerOnOffStateAttribute8002      | ./Modules/basicOutputs.py | TS0001, TS0002, TS0002_relay_switch, TS0003_relay_switch, TS0004-_TZ3000_excgg5kb, TS0004-_TZ3000_u3oupgdy, TS0004-relay_switch, TS0004, TS000F-Power, TS000F-TYZGTH4CH-D1RF, TS000F, TS0012, TS0013, TS0115, TS011F-2Gang-switches, TS011F-multiprise, TS011F-plug-Elivco, TS011F-plug, TS011F-with_threshold, TS0121, TS011F-din, TS0012-manufs, TS0013-manufs, TS0011-manufs |
| BatteryDevice                     | ./Modules/batterieManagement.py | LDSENK08, LDSENK10, AV201024A, AV201029A, CDWS312, CMS323, CTHS317ET, LYWSD03MMC, V3-BTZB, AQSZB-110, SPZB0001, COSensor-EF-3.0, COSensor-EM, COSensor-N, DoorBell-EF-3.0, GASSensor-EF-3.0, RC-EF-3.0, SMOK_V16, SMOK_YDLV10, SRHMP-I1, SceneSwitch-EM-3.0, SmokeSensor-EF-3.0, SmokeSensor-EM, SmokeSensor-N-3.0, SmokeSensor-N, TS0216, WarningDevice-EF-3.0, WarningDevice, FYRTUR block-out roller blind, KADRILJ roller blind, PARASOLL DoorWindow Sensor, TRADFRI motion sensor, TRADFRI openclose remote, 3AFE140103020000, 3AFE14010402000D, 3AFE170100510001, 3AFE220103020000, 3AFE28010402000D, lumi.airmonitor.acn01, lumi.curtain.acn002, lumi.light.aqcn02, lumi.remote.acn003, lumi.remote.acn004, lumi.remote.b186acn01, lumi.remote.b186acn02, lumi.remote.b1acn01, lumi.remote.b286acn01, lumi.remote.b286acn02, lumi.remote.b286opcn01-bulb, lumi.remote.b286opcn01, lumi.remote.b28ac1, lumi.remote.b486opcn01-bulb, lumi.remote.b486opcn01, lumi.remote.b686opcn01-bulb, lumi.remote.b686opcn01, lumi.sen_ill.agl01, lumi.sen_ill.mgl01, lumi.sensor_ht.agl02, Remote motion sensor, Remote switch Wake up Sleep, Remote switch, Remote toggle switch, TRV-4-1-00, STPH-4-1-00, 50938c4c3c0b4049923cd5afbc151bde, 898ca74409a740b28d5841661e72268d, VMS_ADUROLIGHT, DWS312-E, DWS312, PIR313-E, PIR313, PIR323-A, PIR323-PTH, PIR323, THS317-ET, RWL021, RWL022, SML001, SML002, SML003, SML004, EH-ZB-BMS, EH-ZB-RTS, EH-ZB-VACT, 66666-motion, 66666-temphumi, 66666, DS01, MS01, SNZB-01P, SNZB-02, SNZB-02D, SNZB-02P, SNZB-03P, SNZB-04P, SNZB-06P, TH01, TRVZB, WB-01, WB01, HK-SENSOR-4IN1-A, RH3001, RH3040, RH3052, TS0041, TS0043, TS0044, TS004F-_TZ3000_xabckq1v, TS004F, TS0201-Temp-Humi-10, TS0201-Temp-Humi-IH-K009, TS0201-_TZ3000_mxzo5rhf, TS0201-_TZ3000_qaaysllp, TS0201, TS0202-WHD02, TS0202-_TZ3210_jijr1sss, TS0202, TS0203, TS0205, TS0207-rain-detector, TS0207-waterleak, TS0212, TS0219, TS0222, TS0601-BLE-YL01, TS0601-Luminance-Door, TS0601-SZ-T04, TS0601-Solar-Siren, TS0601-_TZE200_t1blo2bj, TS0601-motion, TS0601-sirene2, TS0601-soil-sensor, TS0601-temphumi-2, TS0601-temphumi, TS0601-temphumix10, TY0201, TY0202 |
| BatteryPercentageConverter        | ./Modules/batterieManagement.py | LDSENK08, LDSENK10, CDWS312, CMS323, CTHS317ET, V3-BTZB, eT093WRG, eT093WRO, eTRV0100, SPZB0001, COSensor-EF-3.0, COSensor-EM, COSensor-N, DoorBell-EF-3.0, HS3AQ-EFA-3.0, RC-EF-3.0, SMOK_V16, SRHMP-I1, SceneSwitch-EM-3.0, SmokeSensor-EM, SmokeSensor-N, TS0216, WarningDevice-EF-3.0, WarningDevice, FYRTUR block-out roller blind, KADRILJ roller blind, TRADFRI openclose remote, ZiPulses, TRV-4-1-00, STPH-4-1-00, 50938c4c3c0b4049923cd5afbc151bde, 898ca74409a740b28d5841661e72268d, VMS_ADUROLIGHT, DWS312-E, DWS312, PIR313-E, PIR313, PIR323-A, PIR323-PTH, PIR323, THS317-ET, RWL021, RWL022, SML001, SML002, SML003, SML004, CCT592011_AS, 66666-motion, 66666-temphumi, 66666, DS01, MS01, SNZB-01P, SNZB-02, SNZB-02D, SNZB-02P, SNZB-03P, SNZB-04P, SNZB-06P, TH01, TRVZB, WB-01, WB01, HK-SENSOR-4IN1-A, RH3001, RH3040, RH3052, TS0041, TS0043, TS0044, TS004F-_TZ3000_xabckq1v, TS004F, TS0201-Temp-Humi-10, TS0201-Temp-Humi-IH-K009, TS0201-_TZ3000_mxzo5rhf, TS0201-_TZ3000_qaaysllp, TS0201, TS0202-WHD02, TS0202-_TZ3210_jijr1sss, TS0202, TS0203, TS0205, TS0207-rain-detector, TS0207-waterleak, TS0212, TS0219, TS0222, TS0601-Luminance-Door, TS0601-temphumi-2, TY0201, TY0202 |
| MaxBatteryVoltage                 | ./Modules/batterieManagement.py | EH-ZB-BMS, EH-ZB-RTS, EH-ZB-VACT |
| MinBatteryVoltage                 | ./Modules/batterieManagement.py | EH-ZB-BMS, EH-ZB-RTS, EH-ZB-VACT |
| PollingEnabled                    | ./Modules/heartbeat.py | MWA1-TIC-historique-mono-base, MWA1-TIC-historique-mono-ejp, MWA1-TIC-historique-mono-hchp, MWA1-TIC-historique-mono-tempo, MWA1-TIC-standard-mono-base, MWA1-TIC, V3-BTZB, RV001, eT093WRG, eT093WRO, eTRV0100, SPZB0001, TICMeter-historique-mono-base, TICMeter-historique-mono-tempo, TICMeter, TICMeter-standard-mono-base, TICMeter-historique-tri-hchp, TICMeter-historique-tri-tempo, TICMeter-historique-mono-hchp, TICMeter-historique-tri-base, ZLinky_TIC-historique-mono, ZLinky_TIC-historique-tri, ZLinky_TIC-standard-mono-prod, ZLinky_TIC-standard-tri-prod, ZLinky_TIC-standard-tri, ZLinky_TIC, ZLinky_TIC-standard-mono, TRV-4-1-00, EH-ZB-RTS, EH-ZB-VACT, TS0201-_TZ3000_qaaysllp, TS0601-BAB-1413Pro-E, TS0601-BLE-YL01, TS0601-eTRV5, TS0601-eTRV6, TS0601-eTRV7, TS0601-ME168 |
| FC01_FUNCTIONALITIES              | ./Modules/legrand_netatmo.py | Dimmer switch wo neutral, Dimmer switch wo neutral evo |
| CreateWidgetDomoticz              | ./Modules/pairingProcess.py | WG001-Z01, TRADFRI Signal Repeater, 122-120-12-2, MAI-ZTS, Telecommande-Profalux, DONGLE-E_R, TS0207-extender |
| TUYA_REGISTRATION                 | ./Modules/pairingProcess.py | TS011F-with_threshold, TS0224, TS0505A-HueSaturation, TS0601-BAB-1413Pro-E, TS0601-BLE-YL01, TS0601-Moes-Curtain, TS0601-PC311-Z-TY, TS0601-PC321-Z-TY, TS0601-PJ-1203A, TS0601-Ronelabs-SEM101, TS0601-Ronelabs-SEM301, TS0601-Smart-Energy-1P+N, TS0601-Solar-Siren, TS0601-XOCA-DAC2161C, TS0601-mWave-radar, TS0601-radar, TS0601-temphumi, TS0601-temphumix10, TS110E-SMD-02Z, TS0601-Clamp-Meter, TS0601-ME168, TS0601-ZBN-J-63 |
| TUYA_RESET_CMD                    | ./Modules/pairingProcess.py | TS0601-BLE-YL01 |
| TUYA_DATA_REQUEST_POLLING         | ./Modules/pairingProcess.py | TS0601-BAB-1413Pro-E, TS0601-BLE-YL01, TS0601-ME168 |
| TUYA_MAGIC_READ_ATTRIBUTES        | ./Modules/pairingProcess.py | TS0502B, TS0601-BLE-YL01, TS0601-Moes-Curtain, GL-SD-003P |
| TuyaCommandF0                     | ./Modules/pairingProcess.py | TS0505A-HueSaturation |
| LightingColorControl              | ./Modules/pairingProcess.py | TS0505A |
| DisableOnOffPolling               | ./Modules/readAttributes.py | TS110E-SMD-02Z |
| DisableOnOffPolling               | ./Modules/readAttributes.py | TS110E-SMD-02Z |
| DisableLevelControlPolling        | ./Modules/readAttributes.py | TS110E-SMD-02Z |
| DisableLevelControlPolling        | ./Modules/readAttributes.py | TS110E-SMD-02Z |
| MainPoweredDevice                 | ./Modules/tools.py | lumi.light.aqcn02, lumi.switch.l0agl1, TS0011, TS0011-manufs |
| BatteryPoweredDevice              | ./Modules/tools.py | Remote Control N2, lumi.airmonitor.acn01, lumi.curtain.acn002, lumi.sen_ill.agl01, lumi.sen_ill.mgl01 |
| BatteryPoweredDevice              | ./Modules/tools.py | Remote Control N2, lumi.airmonitor.acn01, lumi.curtain.acn002, lumi.sen_ill.agl01, lumi.sen_ill.mgl01 |
| MainPoweredDevice                 | ./Modules/tools.py | lumi.light.aqcn02, lumi.switch.l0agl1, TS0011, TS0011-manufs |
| attribute                         | ./Modules/tools.py | Not Used |
| RELY_ON_EVAL_EXP                  | ./Modules/tuyaTS0601.py | TS0601-PC311-Z-TY, TS0601-PC321-Z-TY |
| TWO_COMPLEMENT_TST                | ./Modules/tuyaTS0601.py | TS0601-PC311-Z-TY, TS0601-PC321-Z-TY, TS0601-Ronelabs-SEM101, TS0601-Ronelabs-SEM301 |
| TWO_COMPLEMENT_VAL                | ./Modules/tuyaTS0601.py | TS0601-PC311-Z-TY, TS0601-PC321-Z-TY, TS0601-Ronelabs-SEM101, TS0601-Ronelabs-SEM301 |
| MeteringUnit                      | ./Modules/zclClusterHelpers.py | ZiPulses, TS000F-Power, TS011F-2gang-plug, TS011F-plug-Elivco, TS011F-plug, TS011F-with_threshold, TS0121, TS011F-din |
| PowerMeteringMultiplier           | ./Modules/zclClusterHelpers.py | Not Used |
| PowerMeteringDivisor              | ./Modules/zclClusterHelpers.py | SOCKETOUTLET2, SOCKETOUTLET1 |
| SummationMeteringMultiplier       | ./Modules/zclClusterHelpers.py | lumi.plug.maeu01, ZiPulses, TS000F-Power, TS011F-2gang-plug, TS011F-plug-Elivco, TS011F-plug, TS011F-with_threshold, TS0121, TS011F-din |
| SummationMeteringDivisor          | ./Modules/zclClusterHelpers.py | lumi.plug.maeu01, ZiPulses, TS000F-Power, TS011F-2gang-plug, TS011F-plug-Elivco, TS011F-plug, TS011F-with_threshold, TS0121, TS011F-din |
| custom_divisor_key                | ./Modules/zclClusterHelpers.py | Not Used |
| IgnoreWindowsCoverringValue50     | ./Modules/zclClusterHelpers.py | TS0302 |
| WindowsCoverringInverted          | ./Modules/zclClusterHelpers.py | 1GANGSHUTTER1, TS0302 |
| StandardZigbeeCommand             | ./Modules/command.py | TS000F-TYZGTH4CH-D1RF |
| MoveWithOnOff                     | ./Modules/command.py | GL-SD-003P |
| StandardZigbeeCommand             | ./Modules/command.py | TS000F-TYZGTH4CH-D1RF |
| MoveWithOnOff                     | ./Modules/command.py | GL-SD-003P |
| MoveWithOnOff                     | ./Modules/command.py | GL-SD-003P |
| ForceSwitchOnformoveToLevel       | ./Modules/command.py | TS110E-SMD-02Z |
| MoveWithOnOff                     | ./Modules/command.py | GL-SD-003P |
| READ_ATTRIBUTE_AFTER_COMMAND      | ./Modules/command.py | TS0601-BAB-1413Pro-E, TS0601-ME168 |
| READ_ATTRIBUTE_AFTER_COMMAND      | ./Modules/command.py | TS0601-BAB-1413Pro-E, TS0601-ME168 |
| READ_ATTRIBUTE_AFTER_COMMAND      | ./Modules/command.py | TS0601-BAB-1413Pro-E, TS0601-ME168 |
| AllowSwitchLvlControl             | ./Modules/domoCreate.py | GL-SD-003P |
| DoNotOverWriteOptions             | ./Modules/domoMaj.py | TS0601-PC321-Z-TY |
| XIAOMI_POWER_EP                   | ./Modules/readClusters.py | lumi.plug.maeu01 |
| Aqara_Buton_3                     | ./Modules/readClusters.py | lumi.remote.acn004 |
| IASAlarmMerge                     | ./Modules/readClusters.py | aeotec-button, aeotec-water, TS0215A-sos |
| HUE_RWL                           | ./Modules/readClusters.py | RWL021, RWL022 |
| HeimanDoorBellButton              | ./Z4D_decoders/z4d_decoder_IAS.py | DoorBell-EF-3.0 |
| DisableTamper                     | ./Z4D_decoders/z4d_decoder_IAS.py | PIR313-E, PIR313, SNZB-04P |
| IASAlarmMerge                     | ./Z4D_decoders/z4d_decoder_IAS.py | aeotec-button, aeotec-water, TS0215A-sos |
| DO_NOT_READ_ATTRIBUTE_RSP_CLUSTER_0006 | ./Z4D_decoders/z4d_decoder_Read_Attribute_Rsp.py | TS0505A-HueSaturation |
| REMOTE_SCENE_MAPPING              | ./Z4D_decoders/z4d_decoder_Remotes.py | SNZB-01P |
| HUE_RWL                           | ./Z4D_decoders/z4d_decoder_Remotes.py | RWL021, RWL022 |
| REMOTE_SCENE_MAPPING              | ./Z4D_decoders/z4d_decoder_Remotes.py | SNZB-01P |
| TUYA_REMOTE                       | ./Z4D_decoders/z4d_decoder_Remotes.py | TS0041, TS0042, TS0043, TS0044, TS0046, TS004F-_TZ3000_xabckq1v, TS004F |
| HUE_RWL                           | ./Z4D_decoders/z4d_decoder_Remotes.py | RWL021, RWL022 |
| REMOTE_SCENE_MAPPING              | ./Z4D_decoders/z4d_decoder_Remotes.py | SNZB-01P |
| enableZclDuplicatecheck           | ./Zigbee/zclDecoders.py | Not Used |