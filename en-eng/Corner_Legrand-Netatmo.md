# Legrand / Netatmo corner

Tips for the Legrand devices "with Netatmo" (Céliane, Mosaic, Dooxie…).

A big thanks to @fgrimaldi, who contributed heavily to this work, and to @Thorgal789. Most of what is known comes from sniffing the Zigbee traffic between the Legrand hub and the devices, and from trial and error.

## Before you start

* Some devices come with a basic firmware that doesn't offer all the features (for example the instant power of the plugs, or the dimmer of the switch without neutral). Updating them with the Legrand hub before moving them to the plugin is worth it: see [Update Legrand firmware](Corner_Retreiving-Legrand-Firmware.md). The plugin can also update them over the air when the firmware file is available (see [Update device firmware](HowTo_Update-device-firmware.md)).
* **If you have a starter pack, don't reset it.** It is factory-paired with its remote, and a reset makes it unusable: it must then be returned to Legrand.

## Devices

Known to work:

* Smart plug, with instant power (after a firmware update via the Legrand hub)
* Switch without neutral, with dimmer (after a firmware update via the Legrand hub)
* Shutter switch with neutral: open, close, stop
* Micromodule switch: on and off
* Double gang remote switch and single gang remote switch: on, off, dimmer
* Mobile outlet: on, off, power (instant power after a firmware update via the Legrand hub)

Not working:

* The *Home/Away* master remote provided with the hub: no Zigbee traffic seen.
* The scene devices can join the network, but they only broadcast group + scene commands.

## Pairing

1. Remove the device cover to reach the factory-reset hole or button (don't confuse it with the LED).
1. Open the network for pairing (see [Add a new device](HowTo_Pairing-device.md)).
1. Press and hold the reset button:
   * after a few seconds the LED flashes **green/red** (keep pressing);
   * after about 8 seconds it flashes **red**: release, and click the reset button once more;
   * when the LED turns **green**, the pairing is done.

Alternative: when the LED is red (not paired), press the reset button until the LED flashes green 3 times; when the LED comes back to red, click the reset button once.

While the network is open for pairing, the LED of the Legrand devices is green.

If a device has trouble joining, enable the `LegrandCompatibilityMode` setting (*Settings > Pairing settings*): the plugin then answers the Legrand devices like the Legrand hub does (operating time, attribute `0x0000/0xf000`, see [How the pairing works](#how-the-pairing-works)).

## Device parameters

The Legrand options are **device parameters**, set per device in *Management > Device Management*, parameter editor (see [Device parameters](HowTo_Device-parameters.md#legrand--netatmo)). They replace the old global settings `EnableLedIfOn`, `EnableLedInDark`, `EnableDimmer`…

| Parameter | Use | Devices |
| --------- | --- | ------- |
| `netatmoLedIfOn` | 1: the LED is on (blue) when the device is on | Connected outlet, mobile outlet, dimmer switch without neutral, shutter switch with neutral, micromodule switch |
| `netatmoLedInDark` | 1: the LED is on when the device is off, to find it in the dark | Same as above |
| `netatmoLedShutter` | 1: LED of the shutter switch | Shutter switch with neutral |
| `netatmoEnableDimmer` | 1: enable the dimmer of the switch without neutral | Dimmer switch without neutral |
| `netatmoInvertShutter` | 1: invert open and close | Shutter switch |
| `netatmoReleaseButton` | 1: report the button release of the remotes | Remote switches |

## Commanding devices directly

A Legrand remote switch can command a micromodule or a switch directly, without Domoticz: see [Bind two devices](HowTo_Binding.md), which uses the double gang remote and the micromodule as its example. The *Remote Shutter* doesn't accept bindings.

## Notes from the ZiGate era

These findings were made with a ZiGate coordinator and haven't been checked with other coordinators:

* The dimmer of the switch without neutral needed ZiGate firmware 3.1b.
* Pairing on channel 11 worked for all devices; on channel 13 only the switch without neutral paired, on channel 15 the micromodule and the switch without neutral.
* Group membership was easy to add just after pairing, but failed later. Workaround: power the device off and on, open the network for pairing, then add the group membership.

## Internals (protocol notes)

### How the Pairing works

* At HUB reset (or OFF/ON), the HUB is sending a Write Attribute No Response and broadcast to Cluster 0x0000 , Attribute 0xf000 with a value of 0x00000000
* During the pairing of a device, this device, will request in unicast mode via a Read Attribute each of the existing main powered devices (including the controler ) for Cluster 0x0000 Attrribute 0xf000 value
* As described a little bit later 0x0000/0xf000 reflects the operation time since the latest reset or power on.

### Wireless devices

* Not able to use the Tap-Tap for pairing the wireless with an equipment.
* Wireless devices are using a proprieatory Cluster 0xfc01 to send some commands. I suspect that Managemet of Pairing.
* Requires bindings of 0x0001, 0x000f and 0x0003 (in that order) - @Thorgal789 mentioned that 0x000f bind is not required.
* Use the Present Value ( cluster 0x000f / 0x0055 ) to get On/Off or Shutter Up and Down
* While with the Legrand HUB, there is no binding of cluster 0x0006 and 0x0008 for the remote switch, in order to get the Level Control when you do long press/long release, there is a need to bind Cluster 0x0006 and 0x0008

* The Remote coming with the hub is named : 'Master remote SW Home / Away', and was not able to pair with Zigate

#### Analysis of Double gangs remote switch

* Model ( 0x0000/0x0005) : Double gangs remote switch
* Manufacturer: ( 0x0000/0x0004 ): Legrand 1021
* Manufacturer Code:
* ProfileID: 0104
* DeviceID 0104
* Application Version 0001
* Cluster IN Count: 02
* Cluster In 1: 0003 (Identify)
* Cluster In 2: 000f (Binary Input (Basic))
* Cluster OUT Count: 03
* Cluster Out 1: 0003 (Identify)
* Cluster Out 2: 0006 (On/Off)
* Cluster Out 3: 0008 (Level Control)


### Scenes

* From Master remote SW Home / Away
 * Away : GroupId 0xfff6, SceneId 0x01
 * Home : GroupId 0xfff7, SceneId 0x01
 * Wakeup: GroupdId: 0xfff5, SceneId 0x01
 * Going to Sleep: GroupId: 0xfff4, SceneId 0x01

### Groups when pairing a remote with a wired devices

* Looks that group numbering is started at 0xfeff and going down to 0xfe00  ( 255 Wireless Gang )

### Wired devices

* It looks like when using Groups for actions llike On/Off, there is not state return from the end device ! It might be related to the fact that Scene should be used instead of Group alone.

#### Plug-in Unit: Connected outlet

1. Add Group 0xfff7   
   1. Add SceneId 0x01 / Cluster 0x0006
1. Add Group 0xfff5
   1. Add SceneId 0x01 / Cluster 0x0006
1. Bind Cluster 0x0006
1. Configure Report 0x0006 / 0x0001
1. Bind Cluster 0x0b04
1. Configure Report 0x0b04 / 0x050b
1. Bind Cluster 0x0003


#### Micromodule: Micromodule switch

1. Add Group 0xfff6
   1. Add Scene 0x01 / Cluster 0x0006
1. Add Group 0xfff4
   1. Add Scene 0x01 / Cluster 0x0006
1. Bind 0x0006
1. Configure Report 0x0006 / 0x0001
1. Bind 0x000f
1. Bind 0x0003

#### Inter w/o neutral: Dimmer switch w/o neutral

1. Add Group 0xfff6
   1. Add Scene 0x01 / Cluster 0x0006
   1. Add Scene 0x01 / Cluster 0x0008
1. Add Group 0xfff4
   1. Add Scene 0x01 / Cluster 0x0006   
   1. Add Scene 0x01 / Cluster 0x0008
1. Bind 0x0006
1. Configure Report 0x0006 / 0x0001   (Bind and Configure Reporting on 0x0008, will be done when enabling dimmer)
1. Bind 0x000f
1. Bind 0x0003


#### Shutter: Shutter switch with neutral

1. Bind 0x000f
1. Bind 0x0003
1. Configure Report 0x0102

##### Commands

* Open: 0x05 value 0x64
* Close: 0x05 value 0x00
* (not open, not close): 0x05 value 0x02

Status return ( 0xff: Open, 0x00: Closed, 0x50: in between )
Ad Hoc status can be obtain by a read Attribute



### Other findings and decoding

#### Attributes

* Cluster 0x0000 / Attribute 0xf000 : Operating time in seconds

#### Suite  à Device Annoucement after Power Off/On

After a main Power Off, On, the device is sending a Device Annoucement , in response the Legrand HUB is sending a Wrte Attribute No Response in Broadcast
  * Command: 0x05 ( Write Attribute No Response )
  * Cluster: 0x0000
  * Attribute: 0xf000
  * Data Type: 0x23
  * Data: 0x00000000

#### Cluster 0x0003
* With the help of @cemonneau

__ATTENTION WIP / UNDER INVESTIGATIONS __

##### Command: 0x40

* Hub -> Device
* Format: FCF ( 0x15 ), Manuf ( 0x1021), SQN, 0x40, Value: 2 bytes
* Value:
  * 1 bytes is effectid: possible values are: 0x00 (blink 3 times), 0x01 (fixed for around 3 seconds), 0x02(blink in green), 0x03 (blink in blue)
  * 1 bytes is effectvariant: /!\\ only works with effectid=0x00 or 0x01: 0x00(default color: blue), 0x01(red), 0x02(green), 0x03(blue), 0x04(light blue), 0x05(yellow), 0x06(pink), 0x07(white)

* Expect : LED effect on the device

#### Cluster 0xfc01
* With the help of @Thorgal789

| Device | Attribute | Values | Data Type |
| ------ | --------- | ------ | --------- |
| Dimmer switch w/o neutral | 0x0000 | 0x0101/0x0000 enable/disbale Dimmer mode ( cluster 0x0008 should be binded) | 0x09 (16bit data) |
| Dimmer switch w/o neutral | 0x0001 | 0x01/0x00 enable/disbale Led in Dark | 0x10 ( Bool )|
| Dimmer switch w/o neutral | 0x0002 | 0x01/0x00 enable/disable Led if On | 0x10 |
| Connected outlet          | 0x0002 | 0x01/0x00 enable/disable Led if On | 0x10 |
| Shutter switch with neutral | 0x0001 | 0x01/0x00 enable/disable Led if On | 0x10 |
| Fil Pilote                | 0x0000 | 0x0001/0x0002 enable/disable fil pilote | 0x0x09 (16 bit data)

__ATTENTION WIP / UNDER INVESTIGATIONS __

##### Comamnd: 0x02

* Device -> Hub
* Format: FCF ( 0x15 ), Manuf ( 0x1021), SQN, 0x02, Value: 1 byte
* Value:
  * 1byte: 0x00

##### Command: 0x03

* Device -> Hub
* Format: APS fcf (0x40 ack=true), ZCL FCF ( 0x15 ), Manuf ( 0x1021), SQN, 0x03, Value: 1 byte
* Value:
  * 1byte: 0xff

##### Command: 0x05 (wireless switch)

* Device -> Hub
* Format: APS fcf (0x40 ack=true), ZCL FCF ( 0x15 ), Manuf ( 0x1021), SQN, 0x03, Value: 8 bytes
* Value:
  * 8byte: 0x4d17af0000740400

##### Command: 0x08 set group id (wireless single remote)

* Device -> Hub
* Format: APS fcf (0x40 ack=true), ZCL FCF ( 0x1d ), Manuf ( 0x1021), SQN, 0x03, Value: 2 bytes
* Value:
  * 2byte: group id

##### Commande: 0x09 (Checked)

* Device -> Hub
* Format: FCF ( 0x15 ), Manuf ( 0x1021), SQN, 0x09, Value: 9 bytes
* Value:
  * 8 bytes are the MacAddress of the Source Device
  * 1 bytes seems to be a counter

* Expect : Command 0x0c from the Hub to Device


##### Command: 0x0a

* Device -> Hub
* Format: FCF ( 0x15 ),  Manuf ( 0x1021 ), SQN, 0x0a, Value: 12 bytes
* Value: eg. fefe a4091f0000740400 0101
  * 2 bytes: Most likely Group Membership
  * 8 bytes: IEEE ( Target address ??? ):
  * 2 bytes: ( 0x0101 )

* Expect: Command 0x10 fromHub to Device
 
##### Commande: 0x0c set group id (wireless double remote)

* Hub -> Device
* Format: FCF ( 0x1d ), Manuf ( 0x1021 ), SQN, 0x0c, Value: 3 bytes
* Value:
  * 2 bytes: Most Likely Group Membership ( 0xfefe, 0xfdfe, 0xf6fe, 0xf4fe, 0xfffe )
  * 1 byte: seems to correspond to Left remote and Right remote ( 01/02 )

##### Command: 0x0d

* Device -> Hub
* Format: FCF ( 0x1d ),  Manuf ( 0x1021 ), SQN, 0x0a, Value: 24 bytes
* Value: eg. ffffffffffffffffffffffffffffffffffffffffffffffff


* Expect: Command 0x10 fromHub to Device  

##### Command: 0x10

* Hub -> Device
* Format: FCF ( 0x1d ), Manuf ( 0x1021 ), SQN, 0x10, Value: 11 bytes
* Value: 00 0101 a4091f0000740400
  * 1 byte: status
  * 2 bytes: last 2 bytes from 0x0a command
  * 8 bytes: IEEE 00 0101 a4 09 1f 00 00 74 04 00



#### Cluster 0xfc40
* Contirbution from @Thorgal789

| Attribute | Heating Mode | Value | Data Type |
| --------- | ------------ | ----- | --------- |
| 0x0000    | Confort      | 0x00  | 0x30 (Enum8) |
|           | Contort -1   | 0x01  | 0x30 (Enum8) |
|           | Confort -2   | 0x02  | 0x30 (Enum8) |
|           | Eco          | 0x03  | 0x30 (Enum8) |
|           | Hors Gel     | 0x04  | 0x30 (Enum8) |
|           | Off          | 0x05  | 0x30 (Enum8) |  

#### Specific Commands

| Cluster | Command | Data Type | Data Value | Description |
| ------- | ------- | --------- | ---------- | ----------- |
| 0xfc01  | 0x02    | 1 byte    | 0x00       |             |


## OTA

* Manfufacturer Code: 0x1021
* Block size for transfer: 64 bytes

| OTA Code | Manuf Code | Image Type | Product              | Size (B.) | App. Rel. | App Build | Stack Rel. | Stack Build |
| -------- | ---------- | ---------- | -------------------- | ----      | --------- | --------- | ---------- | ----------- |
|  NLF     | 0x1021     | 0x000e (14)| Switch w/o neural    | 229319    | 0         | 43        | 0          | 0           |
|  NLM     | 0x1021     | 0x0010 (16)| Micromodule          | 221655    | 0         | 32        | 0          | 0           |
|  NLP     | 0x1021     | 0x0011 (17)| Hub Plug             |           | 0         | 35        | 0          | 0           |
|  NLP     | 0x1021     | 0x0011 (17)| Mobile outlet        |           |           | 35        | 0          | 0           |
|  NLP     | 0x1021     | 0x0011 (17)| Connected outlet     |           |           | 35        | 0          | 0           |
|  NLT     | 0x1021     | 0x0012 (18)| Main Remote          |           | 0         | 33        | 0          | 0           |
|  NLV     | 0x1021     | 0x0013 (19)| Shutter              |           | 0         | 43        | 0          | 0           |
|  NLD     | 0x1021     | 0x0016 (22)| Double Remote Switch |           | 0         |  6        | 0          | 0           |
|          | 0x1021     |            | Remote Shutter       |           |           | 18        |            |             |
|  NLC     | 0x1021     | 0x0015 (21)| Cable outlet         |           |           | 10        |            |             |


* App. Rel. is shown on the MyHome application as Software Release
* Firmware are available : http://fw.netatmo.net/

More informations/scripts .... can be found here: https://github.com/pipiche38/Capture-OTA-from-Wireshark

## Pairing mechanism

The HUB seems in addition of having Time Server, seems to store in the 0x0000/0xf000 the time since the HUB has been powered on. This attribute server as of time of operation.
At Pairing, the HUB is broadcasting this value to other devices, and the up coming devices is requesting this attribute also from the oher already connected devices. The Operating time ( 0x0000/0xf000) is reset to 0 after Power Off/On



## Reference

* https://faire-ca-soi-meme.fr/domotique/2018/09/24/test-legrand-celiane-by-netatmo-zigate/
* https://www.legrand.fr/catalogue/maison-connectee/prise-connectee
* https://www.legrand.fr/catalogue/maison-connectee/interrupteur-connecte
* https://github.com/Koenkk/zigbee2mqtt/issues/2399
