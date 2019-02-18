
## what are the different widgets created for the 'lumi.ctrl_ln2' Xiaomi QBKG12LM Double Switch
1. Widget switch aligned with left button ( EP 01 )
1. Widgets Power/Meter aligned with left button ( EP 02 )
1. Widget switch aligned with right button (EP 03 )
1. Widgets Power/Meter aligned with right button ( EP 04 )

## Why is my Xiaomi sensor changing network address
This is part of the behaviour of those devices. This is a possibility of the ZigBee protocol. No worries

## Vibration - How to change the sensitivity
If you want to adjust the sensitivity of the Aqara Vibration you can do so , by update the parameter vibrationAqarasensitivity. It can be set to 'high', 'medium' or 'low'. You'll have to update [PluginConf.txt](https://github.com/pipiche38/Domoticz-Zigate-Wiki/master/en-eng/PluginConf) and then restart the plugin/domoticz, and then delete the existing Vibration device, in order to re-do the pairing process .
