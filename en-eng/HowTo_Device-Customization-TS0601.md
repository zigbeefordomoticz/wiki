
# How-To get Tuya TS0601 devices well integrated with the plugin

## Overview

Tuya has implemented a manufacturer private cluster documented [Tuya Zigbee Generic Interfaces](https://developer.tuya.com/en/docs/iot/tuya-zigbee-universal-docking-access-standard?id=K9ik6zvofpzql)

For that you need to identify the DataPoint which correspond to the Sensor informations. Based with the Dp, you can create the mapping between Widgets and Actions

1. Sensor type ( mapping to Domoticz widgets)
    | sensor_type | description |
    | ----------- | ----------- |
    | battery |     |
    | batteryState |     |
    | calibration |     |
    | ch20 |     |
    | charging_mode |     |
    | co2 |     |
    | cons_metering |     |
    | current |     |
    | distance |     |
    | door |     |
    | heatingstatus |     |
    | humidity |     |
    | illuminance |     |
    | lvl_percentage |     |
    | metering |     |
    | motion |     |
    | mp25 |     |
    | power_factor |     |
    | power |     |
    | presence_state |     |
    | prod_metering |     |
    | setpoint |     |
    | smoke_ppm |     |
    | smoke_state |     |
    | switch |     |
    | tamper |     |
    | temperature |     |
    | TRV6SystemMode |     |
    | TRV7SystemMode |     |
    | TuyaAlarmDuration |     |
    | TuyaAlarmLevel |     |
    | TuyaAlarmMelody |     |
    | TuyaAlarmSwitch |     |
    | TuyaTamperSwitch |     |
    | valveposition |     |
    | voc |     |
    | voltage |     |
    | water_consumption |     |
    | windowsopened |     |

1. Action type ( when an action needs to be sent to the device )

    | action_type | description |
    | ----------- | ----------- |
    | switch | |
    | setpoint | |
    | calibration | |
    | TRV6SystemMode | |
    | TRV7SystemMode | |
    | TuyaAlarmSwitch | |
    | TuyaTamperSwitch | |

1. Concret case : ** Tuya TS0601 Radar Presence

    in the here example you'll see only the specific things.

    ```json
    {
        "TS0601_DP": {
            "01": { "sensor_type": "motion", "DomoDeviceFormat": "str"},
            "09": { "sensor_type": "distance", "EvalExp": "int((value//10)*10)"}, 
            "68": { "sensor_type": "illuminance"},
            "02": { "store_tuya_attribute": "sensitivity"},
            "03": { "store_tuya_attribute": "radar_min_range"},
            "04": { "store_tuya_attribute": "radar_max_range"},
            "65": { "store_tuya_attribute": "radar_detection_delay"},
            "66": { "store_tuya_attribute": "radar_fading_time"}

        },
        "TUYA_REGISTRATION": 13,
        ...
    }
    ```

    * **TS0601_DP** is the attribute which allow to define the TS0601 properties

        * **0x01** (1) is the DataPoint (DP) reporting Motion/Presence detection. By defining "sensor_type": "motion", the plugin will report this value to the _Motion_ widget in Domoticz. "DomoDeviceFormat": "str" will force to convert the value in string.
        * **0x09** (9) is the DP reporting the distance . By defining "sensor_type": "distance", the plugin will report this value to the _Distance_ Widget in Domoticz. "EvalExp": "int((value//10)*10)" will round the value to the tenth value.
        * **0x68** (104) is the DP reporting the illuminance/Lux. By defining "sensor_type": "illuminance", the plugin will report this value to the _Lux_ widget in Domoticz
