# Legrand group
in order to make a legrand switch control an actuator you need to create a zcl group id and have all the devices aware of this group id
## set group id to switch
set the group id for the switch with the command by sending the following command to the device
- Cluster : 0xfc01 (legrand specific)
- Profile : 0x0104
- Destination EP : 0x01
- aps fcf : 0x40 (ack = true)
- zcl fcf : 0x1d (frame type : cluster specific , manuf specific = 0x1, Direction : 0x1. Disable default response : 0x1)
- Command : 0x08
- group id : 2 bytes

## add actuator to group id
add actuator to group 
- Cluster : 0x0004
- Profile : 0x0104
- Destination EP : 0x01
- aps fcf : 0x40 (ack = true)
- zcl fcf : 0x11 (frame type : cluster specific , manuf specific = 0x0, Direction : 0x0. Disable default response : 0x1)
- Command : 0x00
- group id : 2 bytes
- Length : 0x0 (1 byte)
