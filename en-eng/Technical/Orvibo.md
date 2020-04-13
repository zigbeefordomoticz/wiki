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


## Interupteur Autocolalant

1. Device Annoucement
1. Report Attribute
   * Cluster: 0x0000
   * Attribute: 0x00aa
   * DataType: 0x20
   * Value: 0x00 
1. Reat Attribute
   * Cluster: 0x0000
   * Attribut 0x0005
   
   * Response: 3c4e4fc81ed442efaf69353effcdfc5f
   
1. Write Attribute
   * Cluster: 0x0000
   * Attribut: 0x0099
   * DataType: 0x20
   * Value: 0x01

1. Bind 
   * 0x0001
1. Configure Reporting
   * Cluster: 0x0001
   * Attribut: 0x0021
   * DataType: 0x20
   * Change: 01
   * Minimum: 0x0001 ( 1)
   * Maximum: 0x0258 ( 600 )
1. read Attribute
   * Cluster 0x0001/0x0021
1. Read attribute 
   * Cluster 0x0000/0x4000
   
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

   
   


### In other terms

Decoding Value: 0xxxyyzz

xx -> Identify the Button
yy -> ??
zz -> Identify action
    --> 00 One Click
    --> 02 Long Click
    --> 03 Release


For Touch screen

Top -> 01
Middle -> 02
Bottom -> 03

Interupteur autocollant

HG -> 03
MG -> 07
MD -> 0f
HD -> 0b



