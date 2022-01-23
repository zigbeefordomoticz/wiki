<a href="Home.md"><img align="left" width="80" height="80" src="../Images/zigbee4domoticz-logo.png" alt="Logo"></a>

# ZigBee and Wifi

</br>
## Plugin Configuration

The choice of 2.4-GHz band channel for the network is pre-configured as either a fixed channel (in the range 11-26) or a set of channels from which the best channel will be selected by the Coordinator. In the latter case, the Coordinator performs an energy scan of the possible channels and chooses the quietest channel.

There is a parameter in the PluginConf.txt file

`'channel':'0',` ( Default and is used for ALL channels between 11 to 26 )

`'channel':'21',` will configure the network to the 21 as a fixed channel

`'channel':'11,15,16,21,22',`will configure the network with a set of channels from which the Zigate will be able to choose the quietest

**In order to take a Channel change in consideration, the coordinator requires a Software Reset** ( currently done at Plugin start in the options)

## 1. Channel Selection
The channels 25 and 26 can be used in North America for operation clear of Wi-Fi interference.
For deployment in an environment where resource planning and bandwidth allocation can be guaranteed (see Section 1.2.5
 ‘Channel Allocation’), a channel centre-frequency offset of 7 MHz is recommended to ensure acceptable co-existence with Wi-Fi.   The non-overlapping channels (1, 6 and 11 for North America, 1, 7 and 13 for Europe) can also be used
to avoid Wi-Fi interference where non-overlapping Wi-Fi channels have been allocated.

![Channel overlap](../Images/Channel-Allocations.png)


## 2. Physical Separation
Ensuring a physical separation of at least 8 m from a Wi-Fi Access Point (AP) will ensure acceptable co-channel IEEE 802.15.4 performance.

## 3. Mesh Networking
The ZigBee protocol offers the additional benefits of a self-organising and self-healing dynamic mesh network. In this kind of environment, path diversity offers better channel use. If a chosen path fails as a result of interference, the network will select a different path

Source: https://www.nxp.com/docs/en/application-note/JN-AN-1079.pdf
