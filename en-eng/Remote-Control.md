## Remote Control and Group
By Vesa @ISO-B

Pre-requisites:
- Zigate firmware 3.0f (release)
- Tradfri remote control

Other option is to get feedback from remote. For this you will need remote and least one bulb. And you will need to build 3.0f binaries for ZiGate or wait until it is released.

## How to ?
1. Pair remote with ZiGate. Initiate process by resetting remote (Press 4 times reset button from remote)
1. Pair bulb with ZiGate. Intiate process by resetting bulb (Turn bulbs power on off 6 times)
1. Pair remote and bulb using remotes touchlink. Keep remote near bulb and press and hold touchlink/reset button from remote for 10sec.
1. Send request group zigbee command to bulb.
1. Add ZiGate to same group with bulb.
1. Press buttons from remote and you should see messages.

## Internals

|Button 	| Press type 	| Response 	| command 	| attr |
| ------------- | ------------- | ------------- | ------------- | ---- |
|down 	| click 	| 0x8085 	| 0x02 	| None |
|down 	| hold 	| 0x8085 	| 0x01 	| None | 
|down 	| release 	| 0x8085 	| 0x03 	| None |
|up 	| click 	| 0x8085 	| 0x06 	| None |
|up 	| hold 	| 0x8085 	| 0x05 	 | None | 
|up 	| release 	| 0x8085 	| 0x07 	| None| 
|middle 	| click 	| 0x8095 	| 0x02 	| None |
|left 	| click 	| 0x80A7 	| 0x07 	| direction: 1 |
|left 	| hold 	| 0x80A7 	| 0x08 	| direction: 1|
|right 	| click 	| 0x80A7 	| 0x07 	| direction: 0 |
|right 	| hold 	| 0x80A7 	| 0x08 	| direction: 0 |
|left/right 	|release 	| 0x80A7 	| 0x09 	| None |

down = brightness down, up = brightness up,
middle = Power button,
left and right = when brightness up is up left is left and right is right.

### Notes:
* Holding down power button for ~10 sec will result multiple commands sent, but it wont send any hold command only release.
* Remote won't tell which button was released left or right, but it will be same button that was last hold. Remote is unable to send other button commands at least when left or right is hold down.