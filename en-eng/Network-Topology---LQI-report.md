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

## 1. Enable the report

## 2. Example of report

The report will take a certain time based on the size of the network ( number of devices and especially number of routers). The output will be put in the domoticz log in the here after format.
A raw format is also provided and is analysed via the Web UI.

** Graphical using the Web User Interface
![Network Toplogy](https://github.com/sasu-drooz/Domoticz-Zigate/blob/master/Images/Network_Topology.png)

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



