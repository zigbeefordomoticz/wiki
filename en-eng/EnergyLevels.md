# Network Energy levels

Starting Plugin Version: > 4.4, the plugin queries Zigate to get informations on the Energy level per channel.

In the 10 first minutes after plugin start, a Network Energy Level scan will be executed.

The Energy-Level measurement is a value from 0 to 255 given for all Zigate supported channels ( 11, 15, 19, 20, 25 and 26). 
It is given in an arbitrary units (didn't find any more information in the NXP Zigbee documentation).

* Tx (Total Transmission) is the total number of transmissions (from other networks) detected during the scan
* Failure (Transmission Failure) is the number of failed transmissions detected during the scan
* Energy-Level measurement is a pointer to the first in the set of reported energy-level measurements (the value 255 indicates there is too much interference on the channel). Basically what is the Energy Level of the packet when Zigate receive the packets

In short, higher the value is , indicates a high energy received, better it is.

## Graphical presentation

You can get access to the Graphical presentation via the Web Admin Page in the Network Tab and Select Energy Level


![Export Device List raw (json)](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/InterferenceLevels.png)


Sources:
* https://www.nxp.com/docs/en/user-guide/JN-UG-3101.pdf ( page 367 - Section 8.2.3.41 ZPS_tsAplZdpMgmtNwkUpdateNotify)
* https://en.wikipedia.org/wiki/Received_signal_strength_indication ( RSSI - Received Signal Strength Indication)
