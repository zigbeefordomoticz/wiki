# TICmeter (Gammatronique) Integration

## Overview

Purpose is to describe the integration of the TICMeter device in the plugin and Domoticz

## Configurations

Linky Mode : (0xFF42, 0x002c )
LINKY_MODE = {
    0: { "Mode": ('historique', 'mono'), "Conf": " },
    1: { "Mode": ('standard', 'mono'), "Conf": "" },
    2: { "Mode": ('historique', 'tri'), "Conf": "" },
    3: { "Mode": ('standard', 'tri'), "Conf": "" },
    5: { "Mode": ('standard', 'mono prod'), "Conf": "" },
    7: { "Mode": ('standard', 'tri prod'), "Conf": "" },
}


| Linky Mode | Grid | Contract |  Plugin Configuration |
| ---------- | ---- | -------- |  -------------------- |
| Historique | Mono | Base     |      |
| Historique | Mono | HCHP     |      |
| Historique | Mono | EJP      |      |
| Historique | Mono | TEMPO    |      |
| Historique | Tri  | Base     |      |
| Historique | Tri  | HCHP     |      |
| Historique | Tri  | EJP      |      |
| Historique | Tri  | TEMPO    |      |
| Standard   | Mono | Base     |      |
| Standard   | Mono | HCHP     |      |
| Standard   | Mono | EJP      |      |
| Standard   | Mono | TEMPO    |      |
| Standard   | Tri  | Base     |      |
| Standard   | Tri  | HCHP     |      |
| Standard   | Tri  | EJP      |      |
| Standard   | Tri  | TEMPO    |      |

## Domoticz Widgets

| Ep | Widget    | Mapped Labels                         | Cluster | Attribut |
| -- | ------    | ------------------------------------- | ------- | -------- |
| 01 | P1Meter   | "EASF01", "HCHC", "EJPHN", "BBRHCJB"  | 0x0702  | 0x0100   |
|    | P1Meter   | "EASF02", "HCHP", "EJPHPM", "BBRHCJW" | 0x0702  | 0x0102   |
|    | Power     | "PAPP", "SINSTS"                      | 0x0B04  | 0x050f   |
|    | Ampere    | "IINST"                               | 0x0B04  | 0x0508   |
|    | Ampere3   | "IINST1", "IINST2", "IINST3"          | 0x0B04  | 0x0508,0x0908,0x0A08 |
| f2 | P1Meter   | "EASF03", "BBRHCJW"                   | 0x0702  | 0x0104   |
|    | P1Meter   | "EASF04", "BBRHPJW"                   | 0x0702  | 0x0106   |
| f3 | P1Meter   | "EASF05", "BBRHCJR"                   | 0x0702  | 0x0108   |
|    | P1Meter   | "EASF06", "BBRHPJR"                   | 0x0702  | 0x010a   |
| 01 | _Alarm_ZL | "ADPS"                                | 0xFF42  | 0x0004   |
| 01 | _Alarm_ZL | "ADIR1"                               | 0xFF42  | 0x0005   |
| f1 | _Alarm_ZL | "ADIR2"                               | 0xFF42  | 0x0006   |
| f3 | _Alarm_ZL | "ADIR3"                               | 0xFF42  | 0x0007   |
| 01 | Alarm_ZL2 | "DEMAIN" - Couleur du lendemain       | 0xFF42  | 0x0003   |
| 01 | Alarm_ZL3 | "PTEC" - Période tarifaire en cours   | 0xFF42  | 0x0039   |
| 01 | Alarm_ZL3 | "LTARF" - Période tarifaire en cours  | 0xFF42  | 0x0039   |
