# Eurotronic Spirit Zigbee Thermostat Valve

## Supported Models

| Model | Product Number |
|-------|---------------|
| Spirit Zigbee Thermostat Valve | 700045 |

## Features

The following functions work with the plugin:

* **Setpoint control** — set the target temperature from Domoticz
* **Temperature reporting** — the current measured temperature is reported as a Domoticz sensor widget

## Pairing / Reset Procedure

To pair or re-pair the device with the coordinator, first perform a factory reset:

1. Remove and reinsert the battery
1. Press the **+**, **−** and **Boost** buttons simultaneously and hold for 10 seconds (a countdown will appear on the display)
1. The device resets and will begin joining the network
1. Once paired, it appears as a thermostat widget in Domoticz

## Known Limitations

* Only basic thermostat functions (setpoint + temperature) are confirmed working
* Advanced features such as window-open detection or valve calibration may require additional configuration via [device parameters](HowTo_Device-parameters.md)
