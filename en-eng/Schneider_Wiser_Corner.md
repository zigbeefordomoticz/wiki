# Schneider WISER system

## Purpose

Purpose of this page is to share all findings regarding the WISER Zigbee product familly.

* [Thermostat](https://www.se.com/fr/fr/product/EER51000/wiser---thermostat/)


## Pairing

* Channel: 15, 11
* Extended PANID: 0x6734484504015e10 
  Did test some alternate EPID without success!
  
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


## Decoded scenario ( Schneider HUB, 1 Thermostat, 2 Actuators )

1. Thermostat sending local Temperature to:
   1. Hub by Report Attribute Cluster 0x0402 Attribute 0x0000
   1. actuators by Report Attribute Cluster 0x0402 Attribute 0x0000
   
1. Thermostat requesting Attribute from the Hub
   1. OccupedHeatingSetPoint by Read Attribute Cluster 0x0201 on Attribute 0x0012
   1. 0xe010 by Read Attribute Cluster 0x0201 on Attribute 0xe010 ( Hub returning Getting 8-Bit enum value: 0x01 )
   1. MaxHeatSetpointLimit by Read Attribute Cluster 0x0201 on Attribute 0x0016 ( Hub returning response 3500 )
   1. MinHeatSetpointLimit by Read Attribute Cluster 0x0201 on Attribute 0x0015 ( Hub returning response 50 ) 

1. each Actuators sending Instantaneous Demand to:
   1. Hub by Report Attribute Cluster 0x0702 Attribute 0x0400
   
At that stage, someone set a target temperature on the Application managing the HUB

1. Thermostat sending SetPoint to:
   1. HUB by using the command 0xe0 on Cluster 0x0201
   1. Actuators by using the command 0xe0 on Cluster 0x0201
   
1. HUB sending SetPoint to:
   1. Actuators by using the command 0xe0 on Cluster 0x0201
   
1. each Actuators sending Instantaneous Demand to
   1. Hub by Report Attribute Cluster 0x0702 Attribute 0x0400
   
### comments

* The HUB is acting as a Zigbee controler but not only as it is responding to cluster 0x0201 (Thermostat)
* Can the Zigate implement Cluster 0x0201 and store Attributes 0x0012, 0x0015, 0x0016 as well as when receiving command 0xe0 store the value into attribute 0x0012
* We should investigate what are the various values of Cluster 0x0201 on Attribute 0xe010 ( 8bit enum)

### Decoding Cluster 0x0201 on Attribute 0xe010

* Data Type: 0x30 (8bit enum)
* 0x06 - Vacation
* 0x05 - 
* 0x04 - 
* 0x03 - Economie
* 0x02 - Programme
* 0x01 - Manuel
* 0x00 - Normal


    

