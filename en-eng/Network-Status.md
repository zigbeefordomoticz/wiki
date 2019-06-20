Plugin Version: > 4.4

In the 10 first minutes after plugin start, a Network Energy Level scan will be executed.

The report will be available in the Logs as well as in the Reports/NetworkEnergy-xx.json
If you use the Web Interface, you will also be able to visualize the report and eventually trigger ad-hoc one.

The Energy-Level measurement a valure from 0 to 255 is given for all Zigate supported channels ( 11, 15, 19, 20, 25 and 26). It is given in an arbitrary units (didn't find any more information in the NXP Zigbee documentation).

* Tx (Total Transmission) is the total number of transmissions (from other networks) detected during the scan
* Failure (Transmission Failure) is the number of failed transmissions detected during the scan
* Energy-Level measurement is a pointer to the first in the set of reported energy-level measurements (the value 255 indicates there is too much interference on the channel)

In short, higher the value is , indicates a high energy received, better it is.
In there here after example, it looks like channel 26 is the most appropriate channel, where channel 15 is good as well


Here is an example : 

```
Jun 20 10:49:02 rasp domoticz[5313]: Status: (zigate) Network Energy Level Report
Jun 20 10:49:02 rasp domoticz[5313]: Status: (zigate) -----------------------------------------------
Jun 20 10:49:02 rasp domoticz[5313]: Status: (zigate) nwkid     Tx  Failure   11   15   19   20   25   26
Jun 20 10:49:02 rasp domoticz[5313]: Status: (zigate)  5b37   9455        0   28   49   31   34   22   58
Jun 20 10:49:02 rasp domoticz[5313]: Status: (zigate)  9787     26        0  165  173  163  161  167  179
Jun 20 10:49:02 rasp domoticz[5313]: Status: (zigate)  84d7     21        1  175  175  168  171  181  174
```


Sources:
* https://www.nxp.com/docs/en/user-guide/JN-UG-3101.pdf ( page 367 - Section 8.2.3.41 ZPS_tsAplZdpMgmtNwkUpdateNotify)
* https://en.wikipedia.org/wiki/Received_signal_strength_indication ( RSSI - Received Signal Strength Indication)
