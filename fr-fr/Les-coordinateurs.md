# Coordinators - Les coordinateurs

Click on the chipset links to get to the inforamtions.
Cliquer sur les liens de chipset pour accéder aux informations.

* [Chipset NXP](#coordinators-with-nxp-chipset)

<table style="width:100%">
    <thead>
        <tr>
            <th style="width:15%">Maker<br>Fabricant</th>
            <th style="width:20%">Coordinator<br>Coordinateur</th>
            <th style="width:15%">Firmware or chip<br>Firmware ou puce</th>
            <th style="width:15%">Objects in all<br>Objets en tout</th>
            <th style="width:15%">Direct objects<br>Objets en direct</th>
            <th style="width:5%">Groups<br>Groupes</th>
            <th style="width:15%">Comments<br>Commentaires</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan=3>Lixee</td>
            <td rowspan=2>ZiGate V1<br>(USB, PiZiGate, Wiifi, Ethernet)</td>
            <td>Legacy</td>
            <td>40</td>
            <td>?</td>
            <td>5</td>
            <td></td>
        </tr>
        <tr>
            <td>OptiPDM</td>
            <td>70</td>
            <td>20</td>
            <td>5</td>
            <td></td>
        </tr>
        <tr>
            <td rowspan=1>ZiGate V2<br>(USB, PiZiGate, Wiifi, Ethernet)</td>
            <td></td>
            <td>200</td>
            <td>20</td>
            <td>15</td>
            <td></td>
        </tr>
    </tbody>
</table>


* [Chipset scilabs](#coordinators-with-scilabs-chipset)

<table style="width:100%">
    <thead>
        <tr>
            <th style="width:15%">Maker<br>Fabricant</th>
            <th style="width:20%">Coordinator<br>Coordinateur</th>
            <th style="width:15%">Firmware or chip<br>Firmware ou puce</th>
            <th style="width:15%">Objects in all<br>Objets en tout</th>
            <th style="width:15%">Direct objects<br>Objets en direct</th>
            <th style="width:5%">Groups<br>Groupes</th>
            <th style="width:15%">Comments<br>Commentaires</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan=2>ELElabs</td>
            <td rowspan=1>ELU013 (USB)</td>
            <td></td>
            <td>?</td>
            <td>?</td>
            <td>?</td>
            <td></td>
        </tr>
        <tr>
            <td rowspan=1>ELU023 (Pi)</td>
            <td></td>
            <td>?</td>
            <td>?</td>
            <td>?</td>
            <td></td>
        </tr>
    </tbody>
</table>



* [Chipset Texas Instruments](#coordinators-with-texas-instruments-chipset)

<table style="width:100%">
    <thead>
        <tr>
            <th style="width:15%">Maker<br>Fabricant</th>
            <th style="width:20%">Coordinator<br>Coordinateur</th>
            <th style="width:15%">Firmware or chip<br>Firmware ou puce</th>
            <th style="width:15%">Objects in all<br>Objets en tout</th>
            <th style="width:15%">Direct objects<br>Objets en direct</th>
            <th style="width:5%">Groups<br>Groupes</th>
            <th style="width:15%">Comments<br>Commentaires</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td rowspan=1>Electrolama</td>
            <td rowspan=1>ZZH RF Stick</td>
            <td>TI CC2652R1</td>
            <td>?</td>
            <td>?</td>
            <td>?</td>
            <td></td>
        </tr>
        <tr>
            <td rowspan=1>Sonoff</td>
            <td rowspan=1>USB Dongle Plus</td>
            <td>TI CC2652P + CP2102N</td>
            <td>40</td>
            <td>21</td>
            <td>?</td>
            <td></td>
        </tr>
        <tr>
            <td rowspan=1></td>
            <td rowspan=1></td>
            <td>TI CC1352P/CC1352R</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td rowspan=1></td>
            <td rowspan=1></td>
            <td>TI CC2531</td>
            <td>20</td>
            <td>?</td>
            <td>?</td>
            <td>Non recommandé</td>
        </tr>
        <tr>
            <td rowspan=1></td>
            <td rowspan=1></td>
            <td>TI CC2530 + CC2591/CC2592</td>
            <td>20</td>
            <td>?</td>
            <td>?</td>
            <td>Non recommandé</td>
        </tr>
        <tr>
            <td rowspan=1></td>
            <td rowspan=1></td>
            <td>TI CC2652P/ CC2652R/ CC2652RB</td>
            <td>20</td>
            <td>?</td>
            <td>?</td>
            <td></td>
        </tr>
    </tbody>
</table>

--------------------

## Some explanations - Quelques explications

### Limited number of objects

The number of objects managed by a coordinator is limited. There is a total number of objects (Objects in all) but also a maximum number of live objects on the coordinator (Direct Objects). The rest of the objects will have to go through routers.

In any case, **DomoticZ limits the number of devices per plugin to 255**.

__Info:__ A Xiaomi / Aqara temperature sensor object occupies 5 devices : Temperature, Hygrometry, Pressure, Temperature + Hygrometry and Temperature + Hygrometry + Pressure. It is possible at any time to remove unused devices (DomoticZ) and thus gain in number.


### Limited number of groups

There is a limit to the number of groups to which a coordinator can belong.

__Info:__ The number of groups to which an object can belong is limited. Typically, an object can belong to 5 different groups. As a reminder, it is the object that knows in which group it belongs. The exact number will depend on each object.


### Nombre d'objets limité

Le nombre d'objets gérés par un coordinateur est limité. Il y a un nombre total d'objets (Objets en tout) mais aussi un nombre maximal d'objets en direct sur le coordinateur (Objets en direct). Le reste des objets devra passer par des routeurs.

Dans tous les cas, **DomoticZ limite le nombre de dispositifs par plugin à 255**.

__Info :__ Un objet capteur de température Xiaomi / Aqara occupe 5 dispositifs : Température, Hygrométrie, Pression, Température + Hygrométrie et Température + Hygrométrie + Pression. Il est possible à tout instant de supprimer les dispositifs (DomoticZ) non utilisés et ainsi gagner en nombre. [Voir le paragraphe Gestion des Dispositifs](Tuto_Appairage-objet.md#gestion-des-dispositifs).

### Nombre de groupes limité

Le nombre de groupes auxquels un coordinateur peut appartenir est limité.

__Info :__ Le nombre de groupes auxquels un objet peut appartenir est limité. Généralement, un objet peut appartenir à 5 groupes différents. Pour rappel, c'est l'objet qui sait dans quel groupe il appartient. Le nombre exact va dépendre de chaque objet.

--------------------
## Coordinators with NXP chipset

### Fimwares compatibily

#### ZiGate V1 Legacy

* Plugin 5.1.017 : firmware 3.1e minimum
* Plugin 4.9.1   : firmware 3.1c minimum

#### ZiGate V1 OptiPDM

* Plugin 5.1.017 : firmware 3.1e minimum

#### ZiGate V2

* Plugin 5.1.01 : firmware 3.1f minimum

### Tutoriels

* [Sauvegarder / Restaurer la ZiGate](https://zigate.fr/documentation/sauvegardez-et-restaurez-votre-zigate)
* [Mettre à jour la ZiGate](https://zigate.fr/documentation/mise-a-jour-de-la-zigate)


--------------------
## Coordinators with SCIlabs chipset

### Fimwares compatibily

#### ELU013 (dongle USB)

*

#### ELU023 (shield Pi)

*

### Tutoriels

### Infos

Exemple hack de la gateway Lidl : https://paulbanks.org/projects/lidl-zigbee/.<br>
Pour plus d'infos sur les coordinateurs possible https://github.com/zigpy/bellows#hardware-requirement.

### Puissance Tx

* EFR32MG24A420xxxxxxxx has a programmable output power up to +19.5dBm and down to -19.5dBm ?
* EFR32MG24A410xxxxxxxx has a programmable output power up to +10dBm and down to -19.5dBm ?
* MGM210P ("P" for embedded Power-Amplifier) has a programmable output power up to +20dBm and down to -30dBm
* MGM210L has a programmable output power up to +12.5dBm and down to -30dBm
* EFR32MG21A020xxxxxxxxx has a programmable output power up to +20dBm and down to -20dBm
* EFR32MG21A010xxxxxxxxx has a programmable output power up to +10dBm and down to -20dBm
* EFR32MG21B020xxxxxxxxx has a programmable output power up to +20dBm and down to -20dBm
* EFR32MG21B010xxxxxxxxx has a programmable output power up to +10.5dBm and down to -20dBm
* MGM13P ("P" for embedded Power-Amplifier) has a programmable output power up to +19dBm and down to -30dBm
* MGM13S has a programmable output power up to +10dBm and down to -30dBm
* EFR32MG13P732xxxxxxxx has a programmable output power up to +10dBm and down to -30dBm
* EFR32MG13P632xxxxxxxx has a programmable output power up to +10dBm and down to -30dBm


--------------------
## Coordinators with Texas Instruments chipset

### Fimwares compatibily

The firmwares installed on the TI keys must __imperatively__ come from https://github.com/Koenkk/Z-Stack-firmware/tree/master/coordinator.<br>
Les firmwares installés sur les clefs TI doivent provenir __impérativement__ de https://github.com/Koenkk/Z-Stack-firmware/tree/master/coordinator.

####

*

### Tutoriels


### Puissance Tx

* CC1352P ("P" for embedded Power-Amplifier) has a programmable output power up to +20dBm (and down to -?dBm).
* CC1352R has a maximum TX power configuration of +5dBm (and down to -?dBm unknown)
* CC2652P ("P" for embedded Power-Amplifier) has programmable output power up to +20dBm (and down to -?dBm)
* CC2652R has a programmable output power up to +5dBm (and down to -?dBm unknown)
* CC2652RB has a programmable output power up to +5dBm (and down to -?dBm unknown)
* CC2538 without a power amplifier chip has a programmable output power up to +7dBm (and down to -?dBm)
* CC2538 + CC2591 or CC2592 power amplifier chip has a programmable output power up to +19dBm (and down to -?dBm)
* CC2531 without has a programmable output power up to +4.5dBm (and down to -?dBm unknown)
* CC2531 with a CC2591 or CC2592 power amplifier chip has programmable output power up to +19dBm (and down to -?dBm)
* CC2530 without has a programmable output power up to +4.5dBm (and down to -?dBm)
* CC2530 with a CC2591 or CC2592 power amplifier chip has programmable output power up to +19dBm (and down to -?dBm)
