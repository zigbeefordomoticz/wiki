# Zlinky TIC Integration

## Overview

Purpose is to describe the integration of the ZLinky_TIC module in the plugin and Domoticz

## Domoticz Widgets : mapping to TIC attributes

| Widget Name               | Widget Type | Subscription            | TIC Attributes                                           |  Details                                 |
| -----------               | ----------- | ----------------------- | -------------------------------------------------------- | ---------------------------------------- |
| ZLinky_TIC_P1Meter_ZL 01  | P1Meter     | Base, HC/HP, EJP, TEMPO | BASE, HCHP, HCHC, EJPHN, EJPHPM, BBRHCJB, BBRHPJB, PAPP  | 1st: Power in VA, 2nd: Consumption in Wh |
| ZLinky_TIC_P1Meter_ZL f2  | P1Meter     | TEMPO                   | BBRHCJW, BBRHPJW                                         | 1st: Power in VA, 2nd: Consumption in Wh |
| ZLinky_TIC_P1Meter_ZL f3  | P1Meter     | TEMPO                   | BBRHCJR, BBRHPJR                                         | 1st: Power in VA, 2nd: Consumption in Wh |
| ZLinky_TIC_Ampere3        | Current     | Base, HC/HP, EJP, TEMPO | IINST, IINST1, IINST2, IINST3                            | Current in A                             |
| ZLinky_TIC_Alarm 01       | Alarm       | mon and tri-phase L0    | ADPS, ADIR1                                              | 80% - 01, 90% 02 , 98 03, Over 05        |
| ZLinky_TIC_Alarm f2       | Alarm       | tri-phase  L2           | ADIR2                                                    | 80% - 01, 90% 02 , 98 03, Over 05        |
| ZLinky_TIC_Alarm F3       | Alarm       | tri-phase  L3           | ADIR3                                                    | 80% - 01, 90% 02 , 98 03, Over 05        |





|Commande TIC|CLUSTER|Attribut |Droit |data type|unit   |designation                           |valeur par defaut|
|------------|-------|-------- |----- | -------   |-------|----                                  |-----------|
|ADC0        |0x0702 | 0x0308  | RO   | String  |-      | Serial Number                        | NULL|
|OPTARIF     |0xFF66 | 0x0000  | RO   | String  |-      | Option tarifaire                     | BASE|
|ISOUSC      |0x0B01 | 0x000D  |RO    | Uint16  |A      | Intensité souscrite                  | 0|
|IMAX        |0x0B04 | 0x050A  |RO    | Uint16  |A      | Intensité maximale                   | 0xFFFF|
|IMAX1       |0x0B04 | 0x050A  |RO    | Uint16  |A      | Intensité maximale phase 1           | 0xFFFF|
|IMAX2       |0x0B04 | 0x090A  |RO    | Uint16  |A      | Intensité maximale phase 2           | 0xFFFF|
|IMAX3       |0x0B04 | 0x0A0A  |RO    | Uint16  |A      | Intensité maximale phase 3           | 0xFFFF|
|PMAX        |0x0B04 | 0x050D  |RO    | Uint16  |W      | Puissance maximale triphasée atteinte| 0x8000|
|PTEC        |0x0702 | 0x0020  |RO    | String  |-      | Periode tarifaire en cours           | NULL|
|DEMAIN      |0xFF66 | 0x0001  |RP    | String  |-      | Couleur du lendemain                 | NULL|
|HHPHC       |0xFF66 | 0x0002  |RO    | Uint8   |-      | Horaire Heure Pleines Heures Creuses | 0|
|PPOT        |0xFF66 | 0x0003  |RO    | Uint8   |-      | Présence des potentiels              | 0|
| PEJP       |0xFF66 | 0x0004  |RP    | Uint8   |Min    | Préavis début EJP(30min)             | 0|
