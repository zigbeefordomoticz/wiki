# ORVIBO - Scene controleur



## PairingTouch Classic Switch

1. Device Annoucement

1. Read Attribute 0x0005
   1. response: d0d2422bbf3a4982b31ea843bfedb559
   
1. Write Attribute
   * Cluster: 0x0000
   * FCF: 0x00
   * Attribute: 0x0099
   * DataType: 0x20
   * Value: 0x01

1. Read Attribute 0x4000

1. When Permit to Join 0
1. Write Attributes (Broiadcast)
   * Destination: 0xffff
   * Destination Endpoint: 0xff
   * Cluster: 0x0000
   * FCF: 0x00
   * Write: 0x02
   * Attribute Field
     * Attribute: 0x0088
     * DataType: 0x23
     * Value: 0x00010110
     
  * Unsupported Attribute (in response)

1. Report Attributes ( I'm a live message)
   * Cluster 0x0003
   * Attribute: 0x07c5
   * DataType: 0xfe (IEEE Address)
   * Value: c1eda91a004b1200 => 00 12 4b 00 1a a9 ed c1 (IEEE du device à inverser )
   
     
1. Press Button 1 (Upper)
  * Unknown command 0x08
  * Cluster: 0x0017
  * FCS 0x19
  * Data: 010000 ( 3 Bytes )
  
1. Long Press button 1 ( Upper)
  * Unknown command 0x08
  * Cluster: 0x0017
  * FCS 0x19
  * Data: 020003 ( 3 Bytes )
    
1. Press Button 2 (Middle)
  * Unknown command 0x08
  * Cluster: 0x0017
  * FCS 0x19
  * Data: 020000 ( 3 Bytes )  
  
1. Long Press button 2 ( Middle)
  * Unknown command 0x08
  * Cluster: 0x0017
  * FCS 0x19
  * Data: 020002 ( 3 Bytes )
  
1. Press Button 3 (Bottom)
  * Unknown command 0x08
  * Cluster: 0x0017
  * FCS 0x19
  * Data: 030000 ( 3 Bytes )
  
1. Long Press button 3 ( bottom)
  * Unknown command 0x08
  * Cluster: 0x0017
  * FCS 0x19
  * Data: 030003 ( 3 Bytes )


### In other terms

| Action      | Button | Cluster | Command | Value  |
| short Press | Up     | 0x0017  |  0x08   | 010000 |
| Long Press  | Up     | 0x0017  |  0x08   | 010003 |
| short Press | Middle     | 0x0017  |  0x08   | 020000 |
| Long Press  | Middle     | 0x0017  |  0x08   | 020003 |
| short Press | Bottom     | 0x0017  |  0x08   | 030000 |
| Long Press  | Bottom     | 0x0017  |  0x08   | 030003 |

