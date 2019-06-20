Plugin Version: > 4.4

In the 10 first minutes after plugin start, a Network Energy Level scan will be executed.

The report will be available in the Logs as well as in the Reports/NetworkEnergy-xx.json
If you use the Web Interface, you will also be able to visualize the report and eventually trigger ad-hoc one.

The Energy-Level measurement a valure from 0 to 255 is given for all Zigate supported channels ( 11, 15, 19, 20, 25 and 26). It is given in an arbitrary units (didn't find any more information in the NXP Zigbee documentation).

* Tx (Total Transmission) is the total number of transmissions (from other networks) detected during the scan
* Failure (Transmission Failure) is the number of failed transmissions detected during the scan
* Energy-Level measurement is a pointer to the first in the set of reported energy-level measurements (the value 255 indicates there is too much interference on the channel)

In short, higher the value is , indicates a high energy received, better it is.



Here is an example : 

In there here after exemple, it looks like channel 26 is the most appropriate channel, where channel 15 is good as well

```
 Network Energy Level Report
 -----------------------------------------------
 nwkid     Tx  Failure   11   15   19   20   25   26
  5b37   9455        0   28   49   31   34   22   58
  9787     26        0  165  173  163  161  167  179
  84d7     21        1  175  175  168  171  181  174
```

Here is an other exemple:

In the here after exemple, channel 20 would be optimum, while device 0xa838 seems to be always at the same level what ever the channel is.

```
	     11	 15	 19	 20	 25	 26
a838	162	165	164	168	165	164
6a98	163	163	183	184	163	161
a1fe	162	162	166	174	162	161
```

Sources:
* https://www.nxp.com/docs/en/user-guide/JN-UG-3101.pdf ( page 367 - Section 8.2.3.41 ZPS_tsAplZdpMgmtNwkUpdateNotify)
* https://en.wikipedia.org/wiki/Received_signal_strength_indication ( RSSI - Received Signal Strength Indication)
