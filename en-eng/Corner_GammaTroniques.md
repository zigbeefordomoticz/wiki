# GammaTroniques TICMeter Integration

## Overview

Purpose is to describe the integration of the GamaTroniques's TICMeter which allows to retreive the Linky "tele-info"


## Integration status

The general approach has been to be as generic as possible to handle all TIC and Electrical modes (Historique, Standard, Mono, Tri). The result will be that after pairing a TICMeter you'll get a quiet extensive number of widgets created in Domoticz.
Depending on your Linky setup, some will work, and some others won't.


| Widget Name             | Information reported              | Linky Historique | Linky Standard | Mono-Phase | Tri-phase |
| ----------------------- | --------------------------------- | ---------------- | -------------- | ---------- | --------- |
| Ampere_01               | Intensité                         |      Yes         |     Yes        |            |           |
| Ampere3_01              | Intensité Phase 1, 2,3            |      Yes         |     Yes        |            |   Yes     |
| Voltage_01              | Tension                           |      No          |     Yes        |            |           |
| Meter_01                | Index Total + Puissance apparente |      Yes         |     Yes        |            |           |
| Power_01                | Puissance apparente               |      Yes         |     Yes        |            |           |
| P1Meter_HPHC_01         | Index HC/HP + Puissance apparente |      Yes         |     Yes        |            |           |
| LinkyCurrentTarif_01    | Current Tarif                     |      Yes         |     Yes        |            |           |
| LinkyCurrentDayColor_01 | Current Color                     |    Tempo         |     Tempo      |            |           |
| LinkyNextDayColor_01    | Next Day Color                    |    Tempo         |     Tempo      |            |           |
| P1Meter_HPHC_f2         | Index HC/HP Bleu                  |    Tempo         |     Tempo      |            |           |
| P1Meter_HPHC_f3         | Index HC/HP Rouge                 |    Tempo         |     Tempo      |            |           |
| Power_f4                | Puissance soutirée  L1            |     No           |     Yes        |   No       |  Yes      |
| Power_f5                | Puissance soutirée  L2            |     No           |     Yes        |   No       |  Yes      |
| Power_f6                | Puissance soutirée  L3            |     No           |     Yes        |   No       |  Yes      |


