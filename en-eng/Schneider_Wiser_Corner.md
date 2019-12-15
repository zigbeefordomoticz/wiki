# Schneider WISER system

## Purpose

Purpose of this page is to share all findings regarding the WISER Zigbee product familly.

* [Thermostat](https://www.se.com/fr/fr/product/EER51000/wiser---thermostat/)



## Pairing


* Channel: 15
* Extended PANID: 0x6734484504015e10 
  For now it looks like the Extended PANID must be set to a compatible one. If not doing it, then the pairing process doesn't occur and we just see beacon messages. I'll investigate late if there is a range of Extended PANID (which I suspect)
  
There is also a strange thing which is the IEEE has the same prefix as the LIVOLO switches !


## Device Informations

```
ProfileID : "0104"
ZDeviceID : "0302"
Manufacturer : "105e"
Manufacturer Name : "Schneider Electric"
Model: EH-ZB-RTS

Ep: 0b
Cluster IN Count: 07
Cluster In 1: 0000 (Basic)
Cluster In 2: 0001 (Power Configuration)
Cluster In 3: 0003 (Identify)
Cluster In 4: 0009 (Alarms)
Cluster In 5: 0204 (Thermostat User Interface Configuration)
Cluster In 6: 0402 (Temperature Measurement)
Cluster In 7: fe02
Cluster OUT Count: 02
Cluster Out 1: 0019 (Over-the-Air Upgrade)
Cluster Out 2: 0201 (Thermostat)
```
