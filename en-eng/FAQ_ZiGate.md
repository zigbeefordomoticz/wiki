# FAQ for ZiGate

> **Legacy ZiGate:** ZiGate coordinators are no longer supported by the plugin. This page is kept for existing ZiGate users only and is not maintained. We advise moving to a Texas Instruments, Silicon Labs or deCONZ coordinator: see [Compatible coordinators](Coordinators.md).

### How to reset a ZiGate Wifi

If you are not able to reach the ZiGate Wifi, there is a tip in order to reset the Wifi module.
You must stop your wifi at home, and they unplug/plug the ZiGate Wifi. Then after a while the ZiGate Wifi will provide a Wifi Access Point ( ZIGATE_xxxx ). You can then connect your laptop to it and edit the SSID, Password and other network parameters.

## USB-TTL Zigate converter ( USB to UART Bridge )

In order to connect the Zigbee module to USB, there is a piece of hardware called USB-TTL converter. The ZiGate is currently shipped with one of 2 USB-TTL converter models

On a linux platform, the best way to check which one is in place

```
dmesg | grep tty
```
* Blue model : pl2303


```
[89616.182002] pl2303 ttyUSB0: usb_serial_generic_read_bulk_callback - urb stopped: -32
[89616.190165] pl2303 ttyUSB0: usb_serial_generic_read_bulk_callback - urb stopped: -32
[89616.385448] pl2303 ttyUSB0: pl2303_set_control_lines - failed: -19
[89616.392016] pl2303 ttyUSB0: error sending break = -19
[89616.397789] pl2303 ttyUSB0: pl2303 converter now disconnected from ttyUSB0
```

* Red model : cp210x


```
[89768.836185] usb 1-1.3: cp210x converter now attached to ttyUSB0
[89768.959865] cdc_acm 1-1.1.2:1.0: ttyACM1: USB ACM device
[89789.691553] cdc_acm 1-1.1.2:1.0: ttyACM1: USB ACM device
[89896.704377] cp210x ttyUSB0: cp210x converter now disconnected from ttyUSB0
[89932.389263] usb 1-1.3: cp210x converter now attached to ttyUSB0
[89963.008376] cp210x ttyUSB0: cp210x converter now disconnected from ttyUSB0
[89995.620182] usb 1-1.3: cp210x converter now attached to ttyUSB0
```

## ZiGate log messages

### `Decode8000`

If you see error logs like here after, this is most-likely an issue with the ZiGate hardware.

```log
Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 22 Status: [ZigBee Error Code Unknown code : 80]
Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 4d Status: [ZigBee Error Code Unknown code : 80]
Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 51 Status: [ZigBee Error Code Unknown code : 80]
```

* Make sure that you don't have the old __blue__ USB-TTL module (it must be a red one, see [above](#usb-ttl-zigate-converter--usb-to-uart-bridge-))
* Try to power off the ZiGate by stopping the plugin, removing ZiGate, wait for 1 minute, plug-in back and restart the plugin

cc: [Issue reported on ZiGate](https://github.com/fairecasoimeme/ZiGate/issues/394)

### `Communication error when transmiting a previous command`

```log
Error: (Zigbee) Communication error when transmiting a previous command to 9d58 ieee 90fd9ffffe31f150
Error: (Zigbee) Decode8702 - SQN: bc AddrMode: 02 DestAddr: 9d58 SrcEP: 01 DestEP: 01 Status: d4 - Unicast frame does not have a route available but it is buffered for automatic resend
```

The device `90fd9ffffe31f150` is not reachable, or the ZiGate has a communication problem with it.

### `No DNS record configured for Zigate model 'None'`

```log
Error: Zigbee: No DNS record configured for Zigate model 'None'.
```

This message comes back every 12 hours, when the plugin checks for a new version: there is no version information published for the ZiGate any more. It is harmless, but the plugin can't tell you that a new version is available: look at [Plugin update](Plugin_Update.md).

### `no decoder registered for MsgType`

```log
Error: Zigbee: _decode_message - no decoder registered for MsgType 8703
```

A recent ZiGate firmware sends a message the plugin doesn't know. It is harmless: the message is ignored.
