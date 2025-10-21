# Integration of Develco/Frient Intteligent Keypad

We are documenting here the specifc integration of the [Zigbee 3.0 intelligent keypad + RFID reader KEYZB-110 keypad](https://www.onics.com/products/intelligent-keypad) in the Zigbee for Domoticz plugin.

## Overview

The Keypad is supported as for 7.1.024. During the pairing, the following Widgets will be created in Domoticz

- Switch used to report the Emmergency (SOS) button press on the keypad
- Tamper used to detect opening of the unit
- Voltage used to report the battery voltage

- KeypadText used to track all actions done on the keypad (except the SOS)
- KeypadFeedback used to send responses to the keypad

## Modus Operandi

The plugin do not provide a full integration, as we beleive the Keypad is an element of an overall security system. 
The keypad will get all actions reported to the KeypadText (a text widget), and you will have to implement (via an other plugin, a lua script, dzVents script ...) the all logic and use KeypadFeedback for sending response abnd state to the keypad.

### Widget KeypadFeedback

A switch Selector used to send response to keypad

    10: "Disarm"
    20: "ArmAllZones"
    30: "ArmNight"
    40: "ArmHome"
    50: "InvalidCode"
    60: "NotReady"
    70: "ExitDelay"
    80: "EntryDelay"
    90: "InAlarm"

### Example  - entry detection while Alarm armed

1. If you have an Entry Delay (to allow someone to come in and enter Pin Code + Disarm) - Send "80" via KeypadFeedback to inform entry delay
1. After the Entry Delay, if still not Disarm, send "90" via KeypadFeedback to inform Alarm On 

### Example  - Arm with Exit Delay

1. The user will press "Arm All Zone" on the Keypad, and will be reported to the KeypadText
1. your logic (scrip), will detect a new message on the KeypadText, and will detect the request for Arming the securty system
1. inform the kepyad an Exit Delay (to leave time for the user to leave the secured area) - Send "70"
1. when the exit delay is over your logic will enable the Alarm for the secure domain, send "20" via KeypadFeedback to inform that system is Armed.

### Example  - Disarm with Pin Code

1. on the keypad, you press 1234 (as a pin code) followed by Disarm
1. you will get in the KeypadText a text as follow : "Disarm,1234"
1. your logic (script) should validate the PIN Code or Reject it
   1. to reject you have to use KeypadFeedback (a switch selector) level "50", this will send a Invalid Code to Keypad
   1. to approve you have to use KeypadFeedback (a switch selector) level "10", this will send a Disarm state to Keypad



10: ("Disarm", ias_
20: ("ArmAllZones",
30: ("ArmNight", ia
40: ("ArmHome", ias
50: ("InvalidCode",
60: ("NotReady", ia
70: ("ExitDelay", i
80: ("EntryDelay", 
90: ("InAlarm", ias