
## Plugin Configuratie

De kanaal keuze om op de 2.4-GHz band te werken is vooraf geconfigureerd als vast kanaal. Dit kanaal wordt gekozen in de reeks van 11 tot en met 26. Het kanaal wordt automatisch gekozen door de Coördinator dat gebeurd op basis van het kanaal met de minste interferentie.

In het PluginConf.txt bestand is een parameter welke aangepast kan worden om een ander vast kanaal te kiezen. Hieronder een aantal voorbeelden:

`'channel':'0',` ( Standaard en gebruikt dus een kanaal tussen 11 en 26 in )

`'channel':'21',` (Stelt het netwerk vast in op kanaal 21)
`'channel':'11,15,16,21,22',`(Deze optie kiest een kanaal welke het rustigst is uit de opgegeven lijst)

**Om een kanaal wijziging door te voeren dient er een software reset uitgevoerd te worden, dit kan je in Domoticz doen bij de plugin instellingen.

## 1. Kanaal selectie
De kanalen 25 en 26 kunnen worden gebruikt in de Verenigde staten om probleemloos naast Wi-FI kanalen te blijven werken.

Voor het uitrollen van het product in een omgeving waar bandbreedte planning noodzakelijk zijn (zie Sectie 1.2.5 “Kanaal toewijzing”)
Om te compenseren voor een kanaal middenfrequentie is een bandbreedte van 7Mhz aan te raden voor het gebruik van het product naast WI-FI.

Niet overlappende kanalen zijn(1,6 en 11 voor de Verenigde staten & 1, 7 en 13 voor Europa) deze kanalen kunnen dus ook gebruikt worden om geen interferentie te hebben met Wi-FI.

![Kanaal overlap](https://github.com/sasu-drooz/Domoticz-Zigate/blob/dev-grpmgt/images/Channel-Allocations.png)

## 2. Fysieke scheiding
Om de zorgen dat er geen interferentie is op het product wordt het aangeraden om een fysieke scheiding van ongeveer 8m tussen het product en het WI-FI (AP) te hebben. Er kan dan gezorgd worden voor een stabiele verbinding op de IEEE 802.15.4 bandbreedte.

## 3. Mesh Netwerken 
Het ZigBee protocol biedt voordelen zoals een zelf organiserend & zelf helend mesh netwerk. Dit zorgt ervoor dat als een route naar een apparaat wordt gekozen en deze niet te bereiken is, er dan een andere route wordt gekozen.

Bron: https://www.nxp.com/docs/en/application-note/JN-AN-1079.pdf



