# Collection of information around the NXP Firmware for JN516X


## ZiGate technical Specs

ZiGate V1 is based on the JN5168 chip.
* 512 kB Flash 
* 32 kB RAM
* 4 kB EEPROM


## Experimental test #1 - 23 Dec. 2020

Documentation used: https://www.nxp.com/docs/en/user-guide/JN-UG-3113.pdf

The general idea is to build a small version to see quickly the boundaries.
Target: 5 devices in total , with 3 max connected directly to the ZiGate

| Parameter                | Value | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| ------------------------ | ----- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| MaxNumberNodes           | 5     | The maximum number of nodes for the wireless network. This setting controls the size of tables when adding new devices to the network to ensure adequate resources are available for cor-rect operation a network of the specified size.                                                                                                                                                                                                                                                                                                                                                                                                      |
| ActiveNeighbourTableSize | 26    | Size of the active Neighbour table. Each routing node (Co-ordinator or Router) has a Neighbour table which must be large enough to accommodate entries for the node’s immediate children, for its own parent and, in a Mesh network, for all peer Routers with which the node has direct radio communication.                                                                                                                                                                                                                                                                                                                                 |
| RoutingTableSize         | 70    | Size of the Routing table. This table stores the information required for the node to participate in the routing of message packets. Each table entry con-tains the destination address, the status of the route, various flags and the net-work address of the next hop on the way to the destination. A Routing table entry is made when a new route is initi-ated by the node or routed via the node. The entry is stored in the Routing table and is read whenever that route is used; the entry is only deleted if the route is no longer valid. A node is said to have routing capacity if there are free entries in the routing table. |
| AddressMapTableSize      | 3     | Size of the address map, which maps 64-bit IEEE addresses to 16-bit network (short) addresses. Should be set to the number of nodes in the network                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| MacTableSize             | 29    | The MAC Address table on a node is used to store the address-pairs of other network nodes - that is, the IEEE/MAC address and network address of each of these nodes. The entries in the MAC Address table are referenced from entries of both the Neighbour table and Address Map table. Therefore, the MAC Address table should be sized according to the combined sizes of the Neighbour table and Address Map table.                                                                                                                                                                                                                      |
| ChildTableSize           | 3     | Size of the persisted sub-table of the active Neighbour table. This sub-table contains entries for the node’s parent and immediate children. This value therefore determines the number of chil-dren that the node is allowed to have - it is one greater than the permitted num-ber of children, e.g. with the default value of 5, up to 4 children are allowed. This value must not be greater than two-thirds of the Active Neighbour Table Size value.                                                                                                                                                                                    |
| DeviceTableSize          | 5     | The size of the Trust Centre's device table.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ZNC\_MAX\_TCLK\_DEVICES  | 5     | The size of the Trust Centre's device table.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |




## References:

* https://community.nxp.com/t5/Wireless-Connectivity/ZPS-XS-E-NO-FREE-EXTENDED-ADDR-Which-Table-to-increase-size/td-p/1196795/jump-to/first-unread-message

* https://community.nxp.com/t5/Wireless-Connectivity/How-to-check-number-of-nodes-router-and-end-device-joined-and/m-p/1061173

* https://community.nxp.com/t5/Wireless-Connectivity/When-the-sleepy-device-be-joined-through-Router/m-p/810242

* https://community.nxp.com/t5/Wireless-Connectivity/Zigbee3-0-Extended-status-0x81-No-free-APDUs/m-p/912888


* https://community.nxp.com/t5/Wireless-Connectivity/about-TCLK-of-zigbee/m-p/896162/highlight/true
