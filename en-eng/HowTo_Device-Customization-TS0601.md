# How-To: Integrate Tuya TS0601 Devices with the Plugin

## Overview

Tuya devices using Zigbee model `TS0601` communicate through a manufacturer-private cluster (`0xEF00`) documented in the
[Tuya Zigbee Generic Interfaces](https://developer.tuya.com/en/docs/iot/tuya-zigbee-universal-docking-access-standard?id=K9ik6zvofpzql).

Unlike standard Zigbee devices, TS0601 devices carry all their data in numbered **Data Points (DPs)** rather than standard
cluster attributes. The plugin cannot auto-discover the meaning of each DP — you must provide a JSON configuration file
that maps DP numbers to Domoticz widgets and actions.

This guide explains how to write or customize that JSON configuration file.

---

## Step 1 — Identify Your Device

You need two strings from your device's Zigbee announcement:

| Field | Example | Where to find it |
|---|---|---|
| `ZigbeeModel` | `TS0601` | Always `TS0601` for this guide |
| `ManufacturerName` | `_TZE200_lyetpprm` | Plugin logs or device page in Domoticz |

Use these to locate an existing file in
[z4d_certified_devices/Certified/Tuya/](https://github.com/pipiche38/z4d-certified-devices/tree/main/z4d_certified_devices/Certified/Tuya)
or to create a new one.

---

## Step 2 — Identify the Data Points

Use the [Tuya developer portal](https://developer.tuya.com), a Zigbee sniffer, or community resources such as
[Zigbee2MQTT supported devices](https://www.zigbee2mqtt.io/supported-devices/) and
[Blakadder's Zigbee Device Compatibility Repository](https://zigbee.blakadder.com/) to learn which DP number
reports which sensor value or accepts which command.

---

## Step 3 — Create or Update the JSON Configuration File

### 3.1 Full File Structure

```json
{
    "_comment": "Human-readable description of the device",
    "_version": "1",
    "_source": "URL of the issue or reference used",
    "_blakadder": "https://zigbee.blakadder.com/...",
    "_description": "Device marketing name",

    "Identifier": [
        [ "TS0601", "_TZE200_xxxxxxxx" ],
        [ "TS0601", "_TZE204_yyyyyyyy" ]
    ],

    "Ep": {
        "01": {
            "0000": "",
            "0004": "",
            "0005": "",
            "ef00": "",
            "000a": "",
            "0019": "",
            "Type": "Motion/Lux/Distance"
        }
    },

    "Type": "",
    "ClusterToBind": [],
    "ConfigureReporting": {},
    "ReadAttributes": {
        "0000": [ "0004", "0000", "0001", "0005", "0007", "fffe" ],
        "ef00": []
    },

    "TS0601_DP": {
        "01": { "sensor_type": "motion", "DomoDeviceFormat": "str" },
        "09": { "sensor_type": "distance", "EvalExp": "int((value//10)*10)" }
    },

    "TUYA_REGISTRATION": 13,
    "TY_DATA_QUERY": true,
    "BatteryDevice": 1,
    "PollingEnabled": 1,

    "Param": {
        "SomeParameter": 7
    }
}
```

### 3.2 Metadata Fields (ignored by the plugin)

| Field | Description |
|---|---|
| `_comment` | Free-text note (device name, model, etc.) |
| `_version` | Config file revision |
| `_source` | URL of the GitHub issue or forum post used as source |
| `_blakadder` | Link to the Blakadder device page |
| `_description` | Marketing description of the device |

### 3.3 `Identifier`

A list of `[ZigbeeModel, ManufacturerName]` pairs. The plugin uses this to automatically select the correct
configuration when a device announces itself.

```json
"Identifier": [
    [ "TS0601", "_TZE200_lyetpprm" ],
    [ "TS0601", "_TZE204_ztc6ggyl" ]
]
```

A single JSON file can cover multiple hardware variants that share the same DP layout.

### 3.4 `Ep` — Endpoint and Widget Type Declaration

Declares which Zigbee clusters are present on each endpoint and, most importantly, which Domoticz **widget types**
to create under the `Type` key.

```json
"Ep": {
    "01": {
        "0000": "",
        "ef00": "",
        "Type": "Temp/ThermoSetpoint/ThermoMode_7/HeatingStatus"
    }
}
```

The `Type` value is a `/`-separated list of Domoticz widget types. Common values for TS0601 devices:

| Widget Type string | Domoticz widget created |
|---|---|
| `Switch` | On/Off switch |
| `Motion` | Motion sensor |
| `Lux` | Illuminance (lux) |
| `Temp` | Temperature |
| `Humi` | Humidity |
| `TempHumi` | Combined Temperature + Humidity |
| `Distance` | Distance sensor |
| `Door` | Door/Window contact |
| `Smoke` | Smoke detector |
| `Meter` | Energy meter (kWh) |
| `Power` | Power (W) |
| `Voltage` | Voltage (V) |
| `Ampere` | Current (A) |
| `ThermoSetpoint` | Thermostat setpoint |
| `ThermoMode_2` | Thermostat mode (TRV7 style) |
| `ThermoMode_7` | Thermostat mode (TRV6 style) |
| `HeatingStatus` | Heating on/off indicator |
| `Valve` | TRV valve position |
| `TuyaSiren` | Siren/alarm control |

### 3.5 `ClusterToBind`

List of cluster IDs to bind to the coordinator during pairing. For most TS0601 devices that only use `ef00`:

```json
"ClusterToBind": [ "0000", "ef00" ]
```

---

## Step 4 — Configure the `TS0601_DP` Mapping

`TS0601_DP` is the heart of the configuration. It maps each DP number (as a two-character hex string) to its
behaviour in Domoticz.

```json
"TS0601_DP": {
    "01": { ... },
    "0f": { ... },
    "68": { ... }
}
```

> **Important:** DP keys must be lowercase two-character hex strings (e.g. `"01"`, `"0f"`, `"68"`).

### 4.1 DP Entry Fields

Each DP entry is a JSON object that may contain any combination of the following fields:

#### `sensor_type` (string)
Maps the incoming DP value to a Domoticz widget update. See the full reference table in §4.2.

```json
"01": { "sensor_type": "motion" }
```

#### `action_type` (string)
Enables Domoticz-to-device commands on this DP. When a user interacts with a widget, the plugin sends the
appropriate Tuya command. See §4.3 for the full list.

```json
"02": { "sensor_type": "TRV6SystemMode", "action_type": "TRV6SystemMode" }
```

#### `store_tuya_attribute` (string)
Stores the **raw** (pre-evaluation) DP value in the device's internal attribute store under the given name.
No Domoticz widget is updated. Useful for configuration DPs that don't map to a widget.

```json
"03": { "store_tuya_attribute": "radar_min_range" }
```

#### `store_tuya_value` (string)
Like `store_tuya_attribute` but stores the **computed** (post-`EvalExp`) value instead of the raw data.

#### `EvalExp` (string)
A Python expression that transforms the raw received value before it is sent to Domoticz or stored.
The variable `value` holds the decoded numeric value.
Available functions: `int`, `float`, `round`, `abs`, `min`, `max`.

```json
"09": { "sensor_type": "distance", "EvalExp": "int((value//10)*10)" }
"04": { "sensor_type": "setpoint",  "EvalExp": "int((value//10)*10)", "domo_divisor": 10, "domo_round": 2 }
```

#### `action_Exp` (string)
A Python expression that transforms the value **coming from Domoticz** before it is sent as a Tuya command.
The variable `value` holds the raw Domoticz value.

```json
"04": { "action_type": "setpoint", "action_Exp": "int(((value/10)//10)*10)" }
```

#### `domo_divisor` (number)
Divides the (possibly `EvalExp`-transformed) value by this number before sending to Domoticz.
Useful when the device reports values in tenths, hundredths, etc.

```json
"05": { "sensor_type": "temperature", "domo_divisor": 10, "domo_round": 2 }
```

#### `domo_round` (integer)
Number of decimal places to keep after dividing by `domo_divisor`.

#### `DomoDeviceFormat` (string)
Applies a string conversion to the value before passing it to Domoticz. Useful when Domoticz expects a
specific format.

| Value | Effect |
|---|---|
| `"str"` | Convert to plain string (`"true"` / `"false"` for booleans) |
| `"str_2digits"` | Zero-padded 2-digit integer string |
| `"str_4digits"` | Zero-padded 4-digit integer string |
| `"strhex"` | Lowercase hex string |
| `"str2hex"` | 2-character hex string |
| `"str4hex"` | 4-character hex string |

```json
"01": { "sensor_type": "motion", "DomoDeviceFormat": "str" }
```

#### `data_type` (string)
Overrides the Tuya data type used when sending a command. Values follow the Tuya DP type specification:

| Value | Tuya type |
|---|---|
| `"01"` | Boolean |
| `"02"` | 32-bit signed integer |
| `"04"` | Enum |

#### `domo_ep` (string)
Overrides the endpoint used when updating the Domoticz widget (advanced multi-endpoint devices).

---

### 4.2 `sensor_type` Reference

#### Environmental

| `sensor_type` | Domoticz widget | Notes |
|---|---|---|
| `temperature` | Temperature | Raw value ÷ `domo_divisor` |
| `humidity` | Humidity | |
| `illuminance` | Lux | |
| `illuminance_20min_average` | Lux | 20-minute rolling average |
| `distance` | Distance | |
| `co2` | Air Quality (ppm CO₂) | |
| `voc` | VOC index | |
| `ch20` | Formaldehyde (CH₂O) | |
| `mp25` | PM2.5 particulate | |
| `rain_intensity` | Rain intensity | |

#### Power & Energy

| `sensor_type` | Domoticz widget | Notes |
|---|---|---|
| `voltage` | Voltage (V) | |
| `current` | Current (A) | |
| `power` | Instantaneous power (W) | |
| `power_factor` | Power factor | |
| `metering` | Energy meter (kWh) | Accumulates deltas |
| `cons_metering` | Energy meter (kWh) | Direct raw value |
| `prod_metering` | Energy meter (kWh) | Injection/production |
| `water_consumption` | Water meter | |

#### Security & Detection

| `sensor_type` | Domoticz widget | Notes |
|---|---|---|
| `motion` | Motion sensor | Use `"DomoDeviceFormat": "str"` when device reports text |
| `presence_state` | Motion / Presence | Tuya-specific presence output |
| `door` | Door/Window contact | |
| `tamper` | Tamper switch | |
| `smoke_state` | Smoke sensor (state) | |
| `smoke_ppm` | Smoke concentration (ppm) | |
| `vibration` | Vibration sensor | |
| `tilt` | Tilt angle | |
| `vibration_tilt_x` | Tilt X-axis | Raw acceleration axis |
| `vibration_tilt_y` | Tilt Y-axis | Raw acceleration axis |
| `vibration_tilt_z` | Tilt Z-axis | Raw acceleration axis |
| `charging_mode` | Battery charging status | |

#### HVAC / Thermostats (TRV)

| `sensor_type` | Domoticz widget | Notes |
|---|---|---|
| `setpoint` | Thermostat setpoint | Usually combined with `domo_divisor: 10` |
| `heatingstatus` | Heating status indicator | |
| `valveposition` | Valve position (%) | |
| `windowsopened` | Window open detection | |
| `calibration` | Temperature offset | |
| `TRV6SystemMode` | Thermostat mode | Avatto / Beca / ME167 style |
| `TRV7SystemMode` | Thermostat mode | GTZ06 style |
| `TRV8SystemMode` | Thermostat mode | Variant |
| `KeypadLockout` | Child lock | |

#### Curtains & Blinds

| `sensor_type` | Domoticz widget | Notes |
|---|---|---|
| `curtain_state` | Blind / curtain | Open / Close / Stop |
| `curtain_level` | Blind position (%) | |
| `curtain_calibration` | Calibration state | |
| `curtain_motor_steering` | Motor direction | |

#### Switch & Dimmer

| `sensor_type` | Domoticz widget | Notes |
|---|---|---|
| `switch` | On/Off switch | |
| `dimmer` | Dimmer (0–100%) | Device scale 0–1000 converted automatically |
| `lvl_percentage` | Level percentage | |

#### Liquid & Water Quality

| `sensor_type` | Domoticz widget | Notes |
|---|---|---|
| `liquid_installation_height` | — (stored) | Installation height configuration |
| `liquid_depth_max` | — (stored) | Maximum depth setting |
| `liquid_level_percent` | Fill level (%) | |
| `liquid_depth` | Liquid depth | |
| `liquid_state` | Level state | Low / Medium / High |
| `phMeter` | pH level | |
| `ec` | Electrical conductivity | |
| `orp` | Oxidation-Reduction Potential | |
| `freeChlorine` | Free chlorine | |
| `salinity` | Salinity | |
| `tds` | Total Dissolved Solids | |
| `phCalibration1` / `phCalibration2` | — (stored) | pH calibration points |
| `ecCalibration` / `orpCalibration` | — (stored) | EC / ORP calibration |

#### Siren / Alarm

| `sensor_type` | Domoticz widget | Notes |
|---|---|---|
| `TuyaAlarmSwitch` | Siren switch | |
| `TuyaAlarmMelody` | Melody selector | |
| `TuyaAlarmDuration` | Duration selector | |
| `TuyaAlarmLevel` | Volume / level | |
| `TuyaTamperSwitch` | Tamper siren | |

#### Battery

| `sensor_type` | Domoticz widget | Notes |
|---|---|---|
| `battery` | Battery level (%) | Also updates the Domoticz battery icon |
| `batteryState` | Battery state | Text: charging / low / etc. |
| `cleaning_reminder` | Maintenance reminder | |

---

### 4.3 `action_type` Reference

`action_type` on a DP entry means the plugin will **send a Tuya command** on that DP when the user
changes the corresponding widget in Domoticz.

| `action_type` | Widget that triggers it | Notes |
|---|---|---|
| `switch` | On/Off switch | |
| `setpoint` | Thermostat setpoint | Use with `action_Exp` if device uses a different scale |
| `calibration` | Calibration offset | Legacy format |
| `Calibration` | Calibration offset | Corrected/newer format |
| `TRV6SystemMode` | Thermostat mode (TRV6) | |
| `TRV7SystemMode` | Thermostat mode (TRV7) | |
| `TRV8SystemMode` | Thermostat mode (TRV8) | |
| `TuyaAlarmSwitch` | Siren switch | |
| `TuyaTamperSwitch` | Tamper siren | |
| `KeypadLockout` | Child lock switch | |

---

## Step 5 — Top-Level Behaviour Flags

### `TUYA_REGISTRATION` (integer)
Controls the Tuya-specific registration/handshake sequence the plugin uses when pairing the device.

| Value | Use case |
|---|---|
| `13` | Standard Tuya TS0601 registration (most sensors, radars) |
| `19` | Extended registration with data query (energy meters, some sensors) |

### `TY_DATA_QUERY` (boolean)
When `true`, the plugin sends a Tuya data query command after connection to force the device to report all
current DP values. Useful for devices that do not report spontaneously.

```json
"TY_DATA_QUERY": true
```

### `BatteryDevice` (integer)
Set to `1` to indicate the device is battery-powered. The plugin will handle battery reporting correctly
and avoid unnecessary wake-up traffic.

```json
"BatteryDevice": 1
```

### `PollingEnabled` (integer)
Set to `1` to enable periodic polling of the device. Required for TRV devices and others that do not push
updates automatically.

```json
"PollingEnabled": 1
```

---

## Step 6 — The `Param` Section

`Param` holds default values for device-configurable settings. These are sent to the device during
pairing or when the user triggers a configuration action. The keys correspond to commands in the
plugin's `TS0601_COMMANDS` table.

Common `Param` keys:

| Key | Description |
|---|---|
| `calibration` | Default temperature calibration offset |
| `TRV7WindowDetection` | Enable window detection on TRV7 (0/1) |
| `TRV7ChildLock` | Child lock default (0/1) |
| `RadarMotionSensitivity` | Radar sensitivity default |
| `RadarMotionMinRange` | Radar minimum detection range (cm) |
| `RadarMotionMaxRange` | Radar maximum detection range (cm) |
| `RadarMotionDelay` | Radar detection delay (s) |
| `RadarMotionFading` | Radar fading time (s) |
| `TuyaRadarSensitivity` | Radar sensitivity (alternative key) |
| `TuyaRadarMinRange` | Radar min range (alternative key) |
| `TuyaRadarMaxRange` | Radar max range (alternative key) |
| `TuyaFadingTime` | Fading time (alternative key) |
| `TuyaRadarDetectionDelay` | Detection delay (alternative key) |
| `PowerOnAfterOffOn` | Power-on state after power cut (255=previous) |
| `LightIndicator` | LED indicator on/off (0/1) |

---

## Examples

### Example 1 — Human Presence Radar (5.8 GHz)

```json
{
    "_description": "Human Presence Detector 5.8GHz Wall Mount",
    "Identifier": [
        [ "TS0601", "_TZE200_lyetpprm" ],
        [ "TS0601", "_TZE204_ztc6ggyl" ]
    ],
    "Ep": {
        "01": {
            "0000": "", "ef00": "",
            "Type": "Motion/Lux/Distance"
        }
    },
    "Type": "",
    "ClusterToBind": [],
    "ConfigureReporting": {},
    "ReadAttributes": {
        "0000": [ "0004", "0000", "0001", "0005", "0007", "fffe" ],
        "ef00": []
    },
    "TS0601_DP": {
        "01": { "sensor_type": "motion", "DomoDeviceFormat": "str" },
        "02": { "store_tuya_attribute": "sensitivity" },
        "03": { "store_tuya_attribute": "radar_min_range" },
        "04": { "store_tuya_attribute": "radar_max_range" },
        "09": { "sensor_type": "distance", "EvalExp": "int((value//10)*10)" },
        "65": { "store_tuya_attribute": "radar_detection_delay" },
        "66": { "store_tuya_attribute": "radar_fading_time" },
        "68": { "sensor_type": "illuminance" }
    },
    "TUYA_REGISTRATION": 13,
    "Param": {
        "RadarMotionSensitivity": 7,
        "RadarMotionMinRange": 60,
        "RadarMotionMaxRange": 690,
        "RadarMotionDelay": 1,
        "RadarMotionFading": 150
    }
}
```

**Explanation:**
- DP `01` → Motion widget. `DomoDeviceFormat: "str"` because the device sends `"true"`/`"false"`.
- DP `02`–`04`, `65`–`66` → stored as attributes (device config values), no widget.
- DP `09` → Distance widget, rounded down to the nearest 10 cm by `EvalExp`.
- DP `68` → Lux widget.

---

### Example 2 — TRV Thermostat (eTRV6 / Avatto ME167)

```json
{
    "_comment": "Tuya TRV / Avatto ME167",
    "Identifier": [
        [ "TS0601", "_TZE200_bvu2wnxz" ],
        [ "TS0601", "_TZE200_6rdj8dzm" ]
    ],
    "Ep": {
        "01": {
            "0000": "", "ef00": "",
            "Type": "Temp/ThermoSetpoint/ThermoMode_7/HeatingStatus"
        }
    },
    "Type": "",
    "ClusterToBind": [ "0000", "ef00" ],
    "ConfigureReporting": {},
    "ReadAttributes": {
        "0000": [ "0004", "0000", "0001", "0005", "0007", "fffe" ]
    },
    "TS0601_DP": {
        "02": { "store_tuya_attribute": "SystemMode",
                "sensor_type": "TRV6SystemMode", "action_type": "TRV6SystemMode" },
        "03": { "store_tuya_attribute": "HeatingMode",
                "sensor_type": "heatingstatus", "EvalExp": "int(not value)" },
        "04": { "store_tuya_attribute": "SetPoint",
                "sensor_type": "setpoint",
                "EvalExp": "int((value//10)*10)", "domo_divisor": 10, "domo_round": 2,
                "action_type": "setpoint", "action_Exp": "int(((value/10)//10)*10)" },
        "05": { "store_tuya_attribute": "Temperature",
                "sensor_type": "temperature",
                "EvalExp": "int((value//10)*10)", "domo_divisor": 10, "domo_round": 2 },
        "07": { "store_tuya_attribute": "ChildLock" },
        "2f": { "store_tuya_attribute": "Calibration", "action_type": "calibration" }
    },
    "PollingEnabled": 1,
    "Param": {}
}
```

**Explanation:**
- DP `02` → Both reads the system mode into the ThermoMode widget **and** accepts commands from it.
- DP `03` → Heating status; `EvalExp: "int(not value)"` inverts the boolean (device sends `1` for idle).
- DP `04` → Setpoint in tenths of a degree; `domo_divisor: 10` converts to °C for Domoticz. `action_Exp` converts the Domoticz °C value back to tenths for sending.
- DP `05` → Measured temperature, same scaling as setpoint.
- DP `2f` → Calibration offset, command-only (no widget).

---

### Example 3 — Clamp Energy Meter

```json
{
    "_comment": "Tuya Zigbee Clamp Meter",
    "Identifier": [
        [ "TS0601", "_TZE204_cjbofhxw" ],
        [ "TS0601", "_TZE284_cjbofhxw" ]
    ],
    "Ep": {
        "01": {
            "0000": "", "ef00": "",
            "Type": "Meter/Power/Voltage/Ampere"
        }
    },
    "Type": "",
    "ClusterToBind": [ "0019", "ef00" ],
    "ConfigureReporting": {},
    "ReadAttributes": {
        "0000": [ "0000", "0001", "0002", "0003", "0004", "0005", "0007" ]
    },
    "TUYA_REGISTRATION": 19,
    "TS0601_DP": {
        "12": { "store_tuya_attribute": "Current",
                "sensor_type": "current",
                "EvalExp": "value / 1000", "domo_round": 2 },
        "13": { "store_tuya_attribute": "Power",
                "sensor_type": "power",
                "EvalExp": "value / 10", "domo_round": 2 },
        "14": { "store_tuya_attribute": "Voltage",
                "sensor_type": "voltage",
                "EvalExp": "value / 10", "domo_round": 2 },
        "65": { "store_tuya_attribute": "Meter",
                "sensor_type": "metering",
                "EvalExp": "value" }
    },
    "Param": {}
}
```

**Explanation:**
- `TUYA_REGISTRATION: 19` — extended registration for metering devices.
- Current is in milliamps → divided by 1000 to get Amperes.
- Power and voltage are in tenths → divided by 10.
- DP `65` → accumulative energy meter (kWh).

---

### Example 4 — Soil Moisture & Temperature Sensor

```json
{
    "_comment": "Tuya Soil sensor",
    "Identifier": [
        [ "TS0601", "_TZE200_myd45weu" ],
        [ "TS0601", "_TZE284_myd45weu" ]
    ],
    "Ep": {
        "01": {
            "0000": "", "0019": "",
            "Type": "Temp/Humi"
        }
    },
    "Type": "",
    "ClusterToBind": [ "0000" ],
    "ConfigureReporting": {},
    "ReadAttributes": {
        "0000": [ "0004", "0005", "0000", "0001", "0007", "ffe2", "fffe" ],
        "ef00": []
    },
    "TS0601_DP": {
        "03": { "store_tuya_attribute": "soil_moisture", "sensor_type": "humidity" },
        "05": { "sensor_type": "temperature", "domo_round": 1 },
        "0e": { "store_tuya_attribute": "battery_state" },
        "0f": { "sensor_type": "battery" }
    },
    "BatteryDevice": 1,
    "Param": {}
}
```

**Explanation:**
- Soil moisture is mapped to the `humidity` widget (0–100%).
- DP `0e` stores the battery state text, DP `0f` reports the numeric battery percentage.
- `BatteryDevice: 1` tells the plugin this is battery-powered.

---

## Step 7 — Testing Your Configuration

1. Copy your JSON file to the plugin's certified devices folder.
2. Re-pair the device (or force a plugin restart so it re-reads configs).
3. Check the plugin logs for the device pairing messages. Look for lines mentioning `TS0601_DP` to confirm the mapping was loaded.
4. Trigger each sensor on the physical device and verify the corresponding Domoticz widget updates correctly.
5. If a DP appears in the logs with an unknown type, add a `store_tuya_attribute` entry for it to capture its value for investigation.

---

## Contributing

Once your configuration works, please open a Pull Request on
[z4d-certified-devices](https://github.com/pipiche38/z4d-certified-devices) with your JSON file under
`z4d_certified_devices/Certified/Tuya/`. Include:

- The device name and model in the file name, e.g. `TS0601-MyDevice-ModelXYZ.json`
- A populated `_description`, `_comment`, `_source`, and optionally `_blakadder` field
- A complete `Identifier` list covering all known manufacturer codes
