# Schneider WISER system ( big thanks to @hairv)

## Purpose

Purpose of this page is to share all findings regarding the WISER Zigbee product familly.

* [Thermostat](https://www.se.com/fr/fr/product/EER51000/wiser---thermostat/)
* [Smart Plug](https://download.schneider-electric.com/files?p_Doc_Ref=Wiser-Smartplug_EAV89774-01_EER400xx_10-2016_DA-EN-FR-IT-SV)
* Actuator

Work in progress, so only validated informations are written


## Pairing

* Channel: 15, 11
* Extended PANID: 
  * 0x6734484504015e10 
  * 0x67344845040160d0 - All OK
  * 0x7996484504015e10 - Plug,Thermostat OK
  
  Did test some alternate EPID without success!
  
There is also a strange thing which is the IEEE has the same prefix as the LIVOLO switches !

## Wiser Smart Plug

### Discovery steps

1. Get Active Endpoint List
1. Simple Descriptor Request
1. Get Model name via read attribute 0x0000/0x0005
1. Bind 0x0019
1. Bind 0x0000
1. Bind 0x0009
1. Bind 0x0003
1. Bind 0x0006
1. Bind 0x0702
1. Configure Reporting on Cluster 0x0702 Attribute 0x0000 ( Min: 600, Max: 600)
1. Configure Reporting on Cluster 0x0702 Attribute 0x0400 ( Min:  30, Max: 600)
1. Configure Reporting on Cluster 0x0006 Attribute 0x0000 ( Min: 0, Max 600)
1. Read Attribute 0x0000 Attribute 0x0007 (Power Source)
1. Read Attribute 0x0000 Attribute 0x0013 (Alarm Mask)
1. Read Attribute 0x0000 Attribute 0xe000 (Version logicielle processeur réseau)
1. Read Attribute 0x0000 Attribute 0xe001 (Version logicielle application)
1. Read Attribute 0x0000 Attribute 0xe002 (Version matérielle application)
1. Read Attribute 0x0702 Attribute 0x0000, 0x0400, 0x0300, 0x0301, 0x0302
1. Read Attribute 0x0702 Attribute 0x5a20 (Schneider Specific)
1. Read Attribute 0x0006 Attribute 0x0000 (ON/OFF)
1. Write Attribute 0x0000 Attribute 0xe050 ( Data Type: Bool 0x10; Value: True 0x01 )
1. Write Attribute 0x0000 Attribute 0x0010 (Location Description) ( Data Type: String 0x42; Value: string )


### Metering Attributes

| DEC | HEX	| VALUE | 
| --- | --- | ----- |
| 0	| 0	| currentSummationDelivered| 
| 256	| 100	| currentTier1SummationDelivered| 
| 258	| 102	| currentTier2SummationDelivered| 
| 260	| 104	| currentTier3SummationDelivered| 
| 262	| 106	| currentTier4SummationDelivered| 
| 264	| 108	| currentTier5SummationDelivered| 
| 266	| 10A	| currentTier6SummationDelivered| 
| 2	| 2	| currentMaxDemandDelivered| 
| 6	| 6	| powerFactor| 
| 768	| 300	| unitOfMeasure| 
| 769	| 301	| multiplier| 
| 770	| 302	| divisor| 
| 512	| 200	| meterStatus| 
| 771	| 303	| summationFormatting| 
| 772	| 304	| demandFormatting| 
| 774	| 306	| meterType| 
| 1024	| 400	| instantaneousDemand| 
| 2049	| 801	| Electricity Alarm Mask| 
| 20480	| 5000	| electricCurrentMultiplier| 
| 20481	| 5001	| electricCurrentDivisor| 
| 20737	| 5101	| RMSElectricCurrentPhase1| 
| 20753	| 5111	| maxElectricCurrentPhase1| 
| 20769	| 5121	| RMSElectricCurrentPhase1MaxThreshold| 
| 21760	| 5500	| voltageMultiplier| 
| 21761	| 5501	| voltageDivisor| 
| 22017	| 5601	| RMSVoltagePhase1| 
| 22049	| 5621	| RMSVoltagePhase1MinThreshold| 
| 22050	| 5622	| RMSVoltagePhase1MaxThreshold| 
| 23072	| 5A20	| activePowerAlarmMask| 
| 23073	| 5A21	| activePowerMinThreshold| 
| 23074	| 5A22	| activePowerMaxThreshold| 
| 23296	| 5B00	| apparentPower| 
| 23345	| 5B31	| apparentPowerMultiplier| 
| 23346	| 5B32	| apparentPowerDivisor| 
| 24576	| 6000	| loadConnectedLabel| 
| 28674	| 7002	| numberOfPhases| 
| 28675	| 7003	| supplierContractName| 
| 28688	| 7010	| numberOfTiers| 
| 28690	| 7012	| tiersAlarmMask| 
| 28752	| 7050	| referencePowerFactor| 
| 28753	| 7051	| referenceRMSElectricCurrent| 
| 28758	| 7056	| referenceRMSVoltage| 
| 28766	| 705E	| referenceFrequency| 
| 57600	| E100	| MMSSensorType| 
| 57632	| E120	| MMSAlarmsMask| 
| 57856	| E200	| ctStatusRegister| 
| 57857	| E201	| ctPowerConfiguration| 
| 57858	| E202	| ctCalibrationMultiplier| 

## Wiser Actuator

### Device Informations

```
EP 0b
ProfileID 0104
ZDeviceID 0301
Manufacturer Name : "Schneider Electric"
Model: EH-ZB-HACT

Application Version 0010
Cluster IN Count: 06
Cluster In 1: 0000 (Basic)
Cluster In 2: 0003 (Identify)
Cluster In 3: 0009 (Alarms)
Cluster In 4: 0201 (Thermostat)
Cluster In 5: 0702
Cluster In 6: fe02
Cluster OUT Count: 02
Cluster Out 1: 0019 (Over-the-Air Upgrade)
Cluster Out 2: 0402 (Temperature Measurement)

```


## Wiser Thermostat

### Registration process

The HUB during the pairing process seems to be doing a number of actions on the End Device, something like registration

* Write Attribute 0x0000 Attribute 0xe050 ( Data Type: Bool 0x10; Value: True 0x01 )
* Write Attribute 0x0000 Attribute 0x5011 ( Data Type: Str 0x42; Value: 'en' )


### Device Informations

```
ProfileID : "0104"
ZDeviceID : "0302"
Manufacturer : "105e"
MacCapa: 0x80
DeviceType : "RFD"
LogicalType : "End Device"
PowerSource : "Battery"
ReceiveOnIdle : "Off"
Stack Version : "2"
ZCL Version : "1"
Max Buffer Size : "50"
Max Rx : "00a0"
Max Tx : "00a0"
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

### Decoded scenario ( Schneider HUB, 1 Thermostat, 2 Actuators )

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
   

### Binding Thermostat with Actuator

1. Binding cluster Thermostat of Actuator with Thermostat
   * Source Actuator
   * Target Thermostat
   * Cluster 0x0201

1. Binding cluster Temperature Measurement of Thermostat with Actuator
   * Source Thermostat
   * Target Actuator
   * Cluster 0x0402
   
#### comments

* The HUB is acting as a Zigbee controler but not only as it is responding to cluster 0x0201 (Thermostat)
* Can the Zigate implement Cluster 0x0201 and store Attributes 0x0012, 0x0015, 0x0016 as well as when receiving command 0xe0 store the value into attribute 0x0012
* We should investigate what are the various values of Cluster 0x0201 on Attribute 0xe010 ( 8bit enum)



## Decoding specifc cluster

### Decoding Cluster 0x0201 on Attribute 0xe010

* Data Type: 0x30 (8bit enum)
* 0xff - USER_MODE_USER_UNKNOWN
* 0x06 - USER_MODE_USER_MODE_HOLIDAY_FROST_PROTECTION
* 0x05 - USER_MODE_USER_MODE_HOLIDAY_OFF
* 0x04 - USER_MODE_USER_MODE_SCHEDULE_ENERGY_SAVER
* 0x03 - USER_MODE_USER_MODE_MANUAL_ENERGY_SAVER
* 0x02 - USER_MODE_USER_MODE_SCHEDULE
* 0x01 - USER_MODE_USER_MODE_MANUAL
* 0x00 - USER_MODE_USER_MODE_OFF


### Decoding Cluster 0x0201 Command Specific 0xe0

* This command seems to be used to set Setpoint 
  ```
  ZigBee Cluster Lib Frame: 0x11 
  Sequence number         : 0xc1
  Command                 : 0xe0 
                          : 0x00
  Length                  : 0x01
  Value                   : 0x34 0x08 (Setpoint with LBHB , don't forgett the Endian ;-)
                          : 0xff
  ```   
  
  
  Sources of information:
  * https://studylibfr.com/doc/2872316/compteur-d-%C3%A9nergie-sans-fil-s%C3%A9rie-em4300
  * https://damrexelprod.blob.core.windows.net/medias/1951d12a-39f3-4317-86c8-f95b6fb13ac5
  * http://www.kele.com/Catalog/22%20Thermostats_Controllers/PDFs/SE8000%20Series%20Zigbee%20Pro%20Integration%20Manual-2014.pdf
  
                        
