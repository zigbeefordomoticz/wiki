# The Web interface - Network section

Please refer to STEP 3 [Plugin Configuration](Plugin_Configuration.md) to get access to the Web interface administration.

The section __Network__ contents the pages :

* [Topology](#topology)
* [Interference levels](#interference-level)

------------------------------------------------
## Topology

Here is the __Topology__ page of the plugin Web interface :

![Network Topology](EN_WebUI-Network-Topology.png)

*This picture may have have changed since this documentation was written.*

At plugin start a report is triggered. It could take up to 15' to get the report extracted.
You can after that manually trigger a scan

All available reports are available in the upper-left list, sorted by date. From the list you can either:
* delete a report
* display the report

There are 2 graphical representations of the report.

#### Left: Topology weel

Here are shown on a weel, all links between 2 devices. If you leave the mouse on a link, you'll see the direction and a number which correspond to the Link Quality ( the worst is 0, the best is 255).

#### Right: Topology graph

Here you can see more the hierarchical structure of your Zigbee network.

------------------------------------------------
## Interference level

Here is the __Interference level__ page of the plugin Web interface :

![Network Energy ](EN_WebUI-Network-Interference-level.png)

*This picture may have have changed since this documentation was written.*

Starting Plugin Version: > 4.4, the plugin queries Zigate to get informations on the Energy level per channel.

In the 10 first minutes after plugin start, a Network Energy Level scan will be executed.

The Energy-Level measurement is a value from 0 to 255 given for all Zigate supported channels ( 11, 15, 19, 20, 25 and 26).
It is given in an arbitrary units (didn't find any more information in the NXP Zigbee documentation).



### Graphical presentation

You can get access to the Graphical presentation via the Web Admin Page in the Network Tab and Select Energy Level


![Export Device List raw (json)](../Images/InterferenceLevels2.png)

The plugin allow to generate a Network Topology report based on the LQI ( Detected signal strength ).
It is important to know that the Packet filtering implemented is using the LQI value

| LQI range | Cost |
| ---------| -----|
| >= 51 | 1 |
| 46 - 50 | 2 |
| 41 - 45 | 3 |
| 39 - 40 | 4 |
| 36 - 38 | 5 |

Source: https://www.nxp.com/docs/en/user-guide/JN-UG-3113.pdf

A cost of 5 is used as the packet filtering threshold, which means that above that level packets might be discarded

### 1. Enable the report

### 2. Example of report

The report will take a certain time based on the size of the network ( number of devices and especially number of routers). The output will be put in the domoticz log in the here after format.
A raw format is also provided and is analysed via the Web UI.

** Graphical using the Web User Interface
![Network Toplogy](../Images/Network_Topology.png)

**(Zigate) LQI Results:**

| Node | Child | Relationship | Type | Depth | LQY | Rx on Iddle |
| -----| ----- | ------------ | ---- | ------ | --- | ------------ |
|  0000 | 27a3 |   Child |  End Device |  1 |  86 | Rx-Off |
|  0000 | 9b5f |   Child |  End Device |  1 | 119 | Rx-Off |
|  0000 | 0000 |  Parent | Coordinator |  0 | 254 |  Rx-On |
|  0000 | 1d81 |    None |      Router | 15 | 254 |  Rx-On |
|  0000 | 1df8 |    None |      Router | 15 | 255 |  Rx-On |
|  a6e8 | 0000 |  Parent | Coordinator |  0 | 254 |  Rx-On |
|  a6e8 | 1a19 |    None |      Router | 15 | 255 |  Rx-On |
|  a6e8 | 1d81 |    None |      Router | 15 | 254 |  Rx-On |
|  b218 | 0000 |  Parent | Coordinator |  0 | 254 |  Rx-On |
|  b218 | 1a19 |    None |      Router | 15 | 253 |  Rx-On |
|  b218 | 1d81 |    None |      Router | 15 | 255 |  Rx-On |
|  1d81 | 0000 |    None | Coordinator |  0 | 254 |  Rx-On |
|  1d81 | 1a19 |    None |      Router | 15 |  46 |  Rx-On |
|  1d81 | 1df8 |    None |      Router | 15 | 254 |  Rx-On |
|  1d81 | 27a3 |   Child |  End Device |  1 |  86 | Rx-Off |
|  1d81 | 9b5f |   Child |  End Device |  1 | 119 | Rx-Off |
|  1a19 | 0000 |    None | Coordinator |  0 | 249 |  Rx-On |
|  1a19 | 1d81 |    None |      Router | 15 |  76 |  Rx-On |
|  1a19 | 1df8 |    None |      Router | 15 | 254 |  Rx-On |
|  2657 | 0000 |  Parent | Coordinator |  0 | 254 |  Rx-On |
|  2657 | 1a19 |    None |      Router | 15 | 254 |  Rx-On |
|  2657 | 1d81 |    None |      Router | 15 | 152 |  Rx-On |
|  e86c | 0000 |  Parent | Coordinator |  0 | 254 |  Rx-On |
|  e86c | 1d81 |    None |      Router | 15 | 252 |  Rx-On |
|  e86c | 1df8 |    None |      Router | 15 | 254 |  Rx-On |
|  550f | 0000 |    None | Coordinator |  0 | 254 |  Rx-On |
|  550f | 1d81 |  Parent |      Router | 15 | 255 |  Rx-On |
|  550f | 1df8 |    None |      Router | 15 | 254 |  Rx-On |
|  9ae9 | e86c | Sibling |      Router |  2 |  63 |  Rx-On |
|  9ae9 | b218 | Sibling |      Router |  2 | 156 |  Rx-On |
|  ee05 | 0000 | Sibling | Coordinator |  0 | 216 |  Rx-On |
|  ee05 | 1a19 | Sibling |      Router | 15 |  42 |  Rx-On |
|  ee05 | 1d81 | Sibling |      Router | 15 |  89 |  Rx-On |
|  0c1f | 0000 | Sibling | Coordinator |  0 | 255 |  Rx-On |
|  0c1f | 1a19 | Sibling |      Router | 15 |  46 |  Rx-On |
|  0c1f | 1d81 | Sibling |      Router | 15 |  52 |  Rx-On |
|  8bf6 | 27a3 |   Child |  End Device |  1 |  86 | Rx-Off |
|  8bf6 | 9b5f |   Child |  End Device |  1 | 119 | Rx-Off |
|  1df8 | 0000 |    None | Coordinator |  0 | 249 |  Rx-On |
|  1df8 | 1d81 |    None |      Router | 15 |  76 |  Rx-On |
|  1df8 | 1df8 |    None |      Router | 15 | 254 |  Rx-On |
|  1df8 | 1a19 | Sibling |      Router | 15 |  46 |  Rx-On |
|  06f8 | 0000 |    None | Coordinator |  0 | 254 |  Rx-On |
|  06f8 | 1df8 |    None |      Router | 15 | 252 |  Rx-On |
|  06f8 | 2657 |    None |      Router | 15 |  58 |  Rx-On |
|  27a3 | 27a3 |   Child |  End Device |  1 |  86 | Rx-Off |
|  27a3 | 9b5f |   Child |  End Device |  1 | 119 | Rx-Off |
|  9b5f | 0000 |    None | Coordinator |  0 | 249 |  Rx-On |
|  9b5f | 1d81 |    None |      Router | 15 |  76 |  Rx-On |
|  9b5f | 1df8 |    None |      Router | 15 | 254 |  Rx-On |
|  2c7f | 0000 |    None | Coordinator |  0 | 254 |  Rx-On |
|  2c7f | 1df8 |    None |      Router | 15 | 252 |  Rx-On |
|  2c7f | 2657 |    None |      Router | 15 |  57 |  Rx-On |

* Node: the starting point
  * 0000 is the Zigate itself ( Controller)
* LQI : is the estimated LQI (link quality) value for radio transmissions from the neighbouring node
* Depth: is the tree depth of the neighbouring node (where the Co-ordinator is at depth zero)
* Relationship: is a 3-bit value representing the neighbouring node’s relationship to the local node:
  * 0: Neighbour is the parent
  * 1: Neighbour is a child
  * 2: Neighbour is a sibling (has same parent)


Sources:
* https://www.nxp.com/docs/en/user-guide/JN-UG-3101.pdf ( page 367 - Section 8.2.3.41 ZPS_tsAplZdpMgmtNwkUpdateNotify)
* https://en.wikipedia.org/wiki/Received_signal_strength_indication ( RSSI - Received Signal Strength Indication)


------------------------------------------------
Look at the other pages of the [plugin Web interface](Home.md#plugins-web-interface).
