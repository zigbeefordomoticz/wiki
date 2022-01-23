<a href="Home.md"><img align="left" width="80" height="80" src="../Images/logo_Z4D.png" alt="Logo"></a>

# Configure ZiGate as sniffer

</br>

# ZiGate preparation
ZiGate comes with a CP2102 (red board) usb to ttl converter.
However the sniffer firmare is configured to 1000000 bps which this board does not support.
Hence you need an another chipset that support this type of not standard speed.
I only found the FTDI232 that supports it.

![Zigate pinout](/Images/zigate_pinout.jpg)

![FTDI32](/Images/FTDI232.jpg)

| Color |Zigate  | FTDI232   |
|---|---|---|
| red | 5V  | 5V  |
| black | GND  | GND  |
| green | TX  | RX  |
| blue | RX  | TX  |
| brown | 3V3  | 3V3  |



# ZiGate sniffer
The ZiGate can be flashed to have a firmware for ZigBee sniffing.

1. using a flash programmer
https://github.com/fairecasoimeme/ZiGate/tree/master/Tools/FlashProgrammer

2. flash this firmware
https://github.com/fairecasoimeme/ZiGate/tree/master/Module%20Radio/Firmware/bin/Sniffer

3. Sniffer tool

You can use the following software (get the exe for windows) to inject the packet in the loopback device on windows. Basically it will simulate udp packet that you can then analyze using wireshark
https://github.com/Codemonkey1973/JN51xx-802.15.4-Sniffer-Server

run the following command if your zigate is on COM4 and you want to sniff channel 25
```
JN51xx-802.15.4-Sniffer-Server.exe  -s COM4  -c 25
```


4. Wireshark
In wireshark, then use Capture->Options->in the list of adpaters, choose "Adapter for loopback traffic capture"
then click start
You can filter only zigbee packet with "udp.port == 49999" as a filter
