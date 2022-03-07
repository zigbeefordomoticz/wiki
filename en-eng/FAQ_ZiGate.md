# FAQ for ZiGate

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
