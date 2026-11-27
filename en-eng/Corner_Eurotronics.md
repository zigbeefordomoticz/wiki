# Eurotronic Spirit Zigbee Thermostat Valve

## Supported Models

| Model | Product Number |
|-------|---------------|
| Spirit Zigbee Thermostat Valve | 700045 |

## Features

The following functions work with the plugin:

* **Setpoint control** — set the target temperature from Domoticz
* **Temperature reporting** — the current measured temperature is reported as a Domoticz sensor widget

## Setpoint

From plugin 9.1.011:

* A setpoint changed in Domoticz is written to the standard Occupied Heating Setpoint attribute (`0x0012`), as ZHA and Zigbee2MQTT do. The valve applies it and reports its current setpoint (attribute `0x4003`), which updates the setpoint widget.
* A setpoint changed with the **+** / **−** buttons of the valve is reported the same way and shown in Domoticz.

Before plugin 9.1.011:

* The setpoint was written to the manufacturer attribute `0x4003`. Some valves ignore that write, even with the same firmware as valves that accept it: the setpoint widget changes in Domoticz, but the valve keeps its previous setpoint.
* The report of the current setpoint was lost for many values (for example 12, 15, 17, 19, 20 °C): the log shows `could not convert string to float` for the valve.

To go back to the previous behaviour, give the valve the parameter `EurotronicSetpointAttribute` with the value `4003` (see [Device parameters](HowTo_Device-parameters.md#eurotronic)).

## Pairing / Reset Procedure

To pair or re-pair the device with the coordinator, first perform a factory reset:

1. Remove and reinsert the battery
1. Press the **+**, **−** and **Boost** buttons simultaneously and hold for 10 seconds (a countdown will appear on the display)
1. The device resets and will begin joining the network
1. Once paired, it appears as a thermostat widget in Domoticz

## Known Limitations

* Only basic thermostat functions (setpoint + temperature) are confirmed working
* Advanced features such as window-open detection or valve calibration may require additional configuration via [device parameters](HowTo_Device-parameters.md)
* To find the firmware of the valve, open its details in *Management > Devices* (click its row), then click *Copy device info*: the copied text holds `App Version`, `Stack Version` and `SWBUILD_1` (date code)
