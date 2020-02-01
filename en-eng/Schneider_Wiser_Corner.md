# Schneider WISER system ( big thanks to @hairv)

## Purpose

Purpose of this page is to share all findings regarding the WISER Zigbee product familly.

* [Thermostat](https://www.se.com/fr/fr/product/EER51000/wiser---thermostat/)
* [Smart Plug](https://download.schneider-electric.com/files?p_Doc_Ref=Wiser-Smartplug_EAV89774-01_EER400xx_10-2016_DA-EN-FR-IT-SV)
* Actuator (Heat ACT)
* sMeter (BMS)

Work in progress, so only validated informations are written


## Pairing

* Channel: 15, 11
* Extended PANID: 
  * 0x6734484504015e10 
  * 0x7996484504015e10
  * 0x6734484504015e10
  * 0x1234484504015e10
  * 0x5678484504015e10
  * 0xFefe484504015e10
  
In short your extended PANID must looks like : 0x----484504015e10, where the 1st 4 digits can be any hex digit
  
 

## Wiser Smeter

1. Get Active Endpoint List
   * 6 EndPoints : 0b, 0c, 0d, 0e, 0f, 10
1. Get Model name via read attribute 0x0000/0x0005
   * EH-ZB-BMS
1. For each EndPoint
   1. Simple Descriptor Request
      * Cluster In
        * 0x0000
        * 0x0001
        * 0x0003
        * 0x0009
        * 0x0702
        * 0xfe02
      * Cluster Out
        * 0x0019
   1. Bind 0x0019, 0x0000, 0x0001, 0x0000, 0x0003, 0x0702
   
1. For each EndPoint
   * Configure Reporting Cluster 0x0702 
     * Attribute 0x0000 DataType: 0x25 Uint48 0x0000ffffffffffff , Min: 30, Max: 30
     * Attribute 0x0400 DataType: 0x2a Int24: 400, Min: 30, Max: 30
     * Attribute 0x0002 DataType: 0x25 Uint48 0x0000ffffffffffff, Min: 30, Max: 30
     
1. Read Attribute Cluster 0x0000 Attribute 0x0007
1. Read Attribute Cluster 0x0000 Attribute 0x0013
1. Read Attribute Cluster 0x0000 Attribute 0xe000
1. Read Attribute Cluster 0x0000 Attribute 0xe001
1. Read Attribute Cluster 0x0000 Attribute 0xe002

1. For each EndPoint
   1. Read Attribute Cluster 0x0702 Attribute 0x0000
   1. Read Attribute Cluster 0x0702 Attribute 0x0400  
   1. Read Attribute Cluster 0x0702 Attribute 0x0002
   1. Read Attribute Cluster 0x0702 Attribute 0x0300
   1. Read Attribute Cluster 0x0702 Attribute 0x0301


   1. Read Attribute Cluster 0x0702 Attribute 0x0302
   1. Read Attribute Cluster 0x0702 Attribute 0x0801
   1. Read Attribute Cluster 0x0702 Attribute 0x5000
   1. Read Attribute Cluster 0x0702 Attribute 0x5001

   1. Read Attribute Cluster 0x0702 Attribute 0xe200
   1. Read Attribute Cluster 0x0702 Attribute 0xe201
   1. Read Attribute Cluster 0x0702 Attribute 0xe202

1. Command Specific: Cluster 0x0009 cmd: 0x50 payload 0x00 0x00 0x00
1. Command Specific: Cluster 0x0009 cmd: 0x50 payload 0x01 0x00 0x00

1. On EndPoint 0x0b
  1. Read Attribute Cluster 0x0001 Attribute 0x0035
  1. Read Attribute Cluster 0x0001 Attribute 0x0036
  1. Read Attribute Cluster 0x0001 Attribute 0x0020
  
1. Write Attribute 0x0000 Attribute 0xe050 ( Data Type: Bool 0x10; Value: True 0x01 )

1. Command Specific: Cluster 0x0009 cmd: 0x50 payload 0x10 0x01 0x00
1. Command Specific: Cluster 0x0009 cmd: 0x50 payload 0x10 0x02 0x07
1. Command Specific: Cluster 0x0009 cmd: 0x50 payload 0x11 0x02 0x07
1. Command Specific: Cluster 0x0009 cmd: 0x50 payload 0x16 0x02 0x07


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


1. Device Announcement

1. Active Endpoint Response
1. Read Attribute 0x0000/0x0005
   * Receive : EH-ZB-HACT
1. Simple Descriptor Request
   * Profile: 0x0104
   * DeviceID: 0x0301
   * Input Cluster
     * 0x0000
     * 0x0003
     * 0x0009
     * 0x0201
     * 0x0702
     * 0xfe02
   * Output Cluster
     * 0x0019
     * 0x0402
 1. Bind Cluster 0x0019
 1. Bind Cluster 0x0000
 1. Bind Cluster 0x0009
 1. Bind Cluster 0x0003
 1. Bind Cluster 0x0201
 
 1. Configure Reporting 0x0201 Attr: 0x0012 Type: 0x29  Min: 600 Max: 600
 1. Configure Reporting 0x0702 Attr: 0x0000 Type: 0x25  Min: 600 Max: 600
 1. Configure Reporting 0x0702 Attr: 0x0400 Type: 0x2a  Min: 30 Max: 600

1. Read Attribute 0x0000 / 0x0007
1. Read Attribute 0x0000 / 0x0013
1. Read Attribute 0x0000 / 0xe000  (Manufacturer Specific)
1. Read Attribute 0x0000 / 0xe001  (Manufacturer Specific)
1. Read Attribute 0x0000 / 0xe002  (Manufacturer Specific)
1. Read Attribute 0x0201 / 0x0012
1. Read Attribute 0x0201 / 0x0015
1. Read Attribute 0x0201 / 0x0016

1. Read Attribute 0x0201 / 0xe011 (Manufacturer Specific)


1. Read Attribute 0x0702 / 0x0000
1. Read Attribute 0x0702 / 0x0400
1. Read Attribute 0x0702 / 0x0300
1. Read Attribute 0x0702 / 0x0301
1. Read Attribute 0x0702 / 0x0302

1. Read Attribute 0x0702 / 0x5a20

1. Write Attribute 0x0000 Attribute 0xe050 ( Data Type: Bool 0x10; Value: True 0x01 )
1. Write Attribute 0x0201 Attribute 0x0010 Type: 0x28 Value: 0 
1. Write Attribute 0x0201 Attribute 0xe010 Type: 0x30 Value: 0x01
1. Write Attribute 0x0201 Attribute 0xe011 Type: 0x18 Value: 0x00

1. Write Attribute 0x0000 Attribute 0x5000 (Location Description) ( Data Type: String 0x42; Value: string )

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

### Cluster

0x0000/0xe011 Device Status
0x0000/0xe010 Current Mode
0x0000/0xe050 COMMISSIONING 
0x0000/0x5011 ATTRIBUTE_BASIC_LANGUAGE


0x0201/0xe010 ATTRIBUTE_THERMOSTAT_ZONE_MODE
0x0201/0xe011 HACT Configuration

0x0201/0xe020 Fil Pilot Mode



## Wiser Thermostat

### Discovery process

1. Request Active End Point
1. Simple Descriptor Request
  * Ep: 0b
  * Cluster In:
    * 0x0000
    * 0x0001
    * 0x0003
    * 0x0009
    * 0x0204
    * 0xfe02
  * Cluster Out
    * 0x0019
    * 0x0201
    
1. Read Attribute 0x0000 / 0x0005 ( Model Name )
  * EH-ZB-RTS
1. Read Attribute 0x0000 / 0xe000
  * SNP.R.04.01.14

1. Bind 0x0019
1. Bind 0x0201
1. Bind 0x0402
1. Bind 0x0000
1. Bind 0x0001
1. Bind 0x0009
1. Bind 0x0003
1. Bind 0x0204

1. Configure Reporting 0x0402 on Attribut 0x0000 / Min: 30 Max: 30 /Measured Value 0.01

1. Read Attribute Cluster 0x0000 on attribute 0x0007 ( Power Source )
1. Read Attribute Cluster 0x0000 on attribute 0x0013 ( Alarm Mask)
1. Read Attribute Cluster 0x0000 on attribute 0xe000
1. Read Attribute Cluster 0x0000 on attribute 0xe001
1. Read Attribute Cluster 0x0000 on attribute 0xe002
1. Read Attribute Cluster 0x0001 on attribute 0x0035, 0x0036, 0x0020
1. Read Attribute Cluster 0x0402 on attribute 0x0000 ( Temperature )

1. Write attribute Cluster 0x0000 on attribute 0xe050 DataType: 0x10 Value 0x01
1. Write Attribute Cluster 0x0000 on attribute 0x5011 DataType: 0x42 Value 'en'

1. Read Attribute Cluster 0x0001 on attribute 0x0020
1. Write Attribute Cluster 0x0000 on attribute 0x0010 DataType: 0x42 Value is a string which give the name of the Zone 

At a point of time the device is quering the controler

* Read Attribute Cluster 0x0201 on attribute 0xe010
  * Controler respond: DataType: 0x30 Value: 0x00    

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

## Decoding Cluster 0x0201 on Attribute 0xe011

ATTRIBUTE_THERMOSTAT_HACT_CONFIG


## Reporting Configuration 

```
# Simple Metering, current summation delivered.
# Always report after 30 seconds / 10 minutes whatever the change.
702_0_0_normal_interval_minimum=600
702_0_0_normal_interval_maximum=600
702_0_0_normal_reportable_change=281474976710655
702_0_0_fast_interval_minimum=30
702_0_0_fast_interval_maximum=30
702_0_0_fast_reportable_change=281474976710655

# Simple Metering, current max demand delivered.
# Always report after 30 seconds / 10 minutes whatever the change.
702_2_0_normal_interval_minimum=600
702_2_0_normal_interval_maximum=600
702_2_0_normal_reportable_change=16777215
702_2_0_fast_interval_minimum=30
702_2_0_fast_interval_maximum=30
702_2_0_fast_reportable_change=16777215

# Simple Metering, instantaneous demand.
# Commented out, we want to use values from MeteringFeatureImpl
#702_400_0_normal_interval_minimum=600
#702_400_0_normal_interval_maximum=600
#702_400_0_normal_reportable_change=16777215
#702_400_0_fast_interval_minimum=30
#702_400_0_fast_interval_maximum=30
#702_400_0_fast_reportable_change=16777215

# Temperature Measurement, current measured value, battery device
# Report interval: [1 minute; 10 minutes], change: 1,00 C
402_0_1_normal_interval_minimum=60
402_0_1_normal_interval_maximum=600
402_0_1_normal_reportable_change=100

# On/Off
# Report on-change and always after 10 minutes.
6_0_0_normal_interval_minimum=0
6_0_0_normal_interval_maximum=600
6_0_0_normal_interval_change=1

# Thermostat Set-Point, current measured value, battery device
# Report interval: 10 minutes whatever the change.
201_12_1_normal_interval_minimum=600
201_12_1_normal_interval_maximum=600
201_12_1_normal_reportable_change=32767

# Thermostat Local Temperature, current measured value, battery device
# Report interval: [1 minute; 10 minutes], change: 1,00 C
201_0_1_normal_interval_minimum=60
201_0_1_normal_interval_maximum=600
201_0_1_normal_reportable_change=100

# Thermostat Valve Position, current measured value, battery device
# Report interval: [1 minute; 10 minutes]
201_e030_1_normal_interval_minimum=60
201_e030_1_normal_interval_maximum=600
201_e030_1_normal_reportable_change=10

# Thermostat Open Window Detection Status
# Report on-change or otherwise never
201_e012_0_normal_interval_minimum=10
201_e012_0_normal_interval_maximum=600
201_e012_0_normal_reportable_change=1

# Thermostat Calibration Status, current calibration status, battery device
# Report interval: [0 minute; 10 minutes]
201_e031_1_normal_interval_minimum=10
201_e031_1_normal_interval_maximum=600
201_e031_1_normal_reportable_change=1
```



  
  Sources of information:
  * https://studylibfr.com/doc/2872316/compteur-d-%C3%A9nergie-sans-fil-s%C3%A9rie-em4300
  * https://damrexelprod.blob.core.windows.net/medias/1951d12a-39f3-4317-86c8-f95b6fb13ac5
  * http://www.kele.com/Catalog/22%20Thermostats_Controllers/PDFs/SE8000%20Series%20Zigbee%20Pro%20Integration%20Manual-2014.pdf
  
                        
