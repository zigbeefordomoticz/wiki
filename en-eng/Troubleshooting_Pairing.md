<a href="Home.md"><img align="left" width="80" height="80" src="../Images/logo_Z4D.png" alt="Logo"></a>

# Troubleshooting - Best practices to avoid pairing/connection difficulties

</br>

Verify that you try to follow recommended best practices to avoid pairing and/or connection issues:

- If possible try to pair your ZigBee devices in their intended final location, (and not pair it next to the ZigBee coordinator and then need to move it after).
  - Pairing a ZigBee device next to the ZigBee coordinator and then moving it later can result in dropped/lost connections or other issues.
    - If the device you want to add is not brand new and as such never paired before then you always have to make sure to first manually reset the device to its factory default settings before you will be able to add/pair it.
- Some battery-operated ZigBee devices are known to have problems with pairing if they have Low battery voltage.
    - Some people have reported replacing the battery on their newly received Xiaomi/Aqara devices solved pairing issues.
- Check that you have enough ZigBee router devices (also known as ZigBee signal repeaters or range extenders) and if you do not have any, invest and add some mains-powered devices that will work as ZigBee routers.
    - Aim to start out with mains-powered devices before adding battery-operated devices as a "weak" ZigBee network mesh (e.g., the device is too far from the ZigBee coordinator or a ZigBee router) may prevent some devices from being paired. ZigBee router devices are also needed to increase the maximum of devices that can be connected to your ZigBee mesh network.
    - Note that some ZigBee devices are not fully compatible with all brands of ZigBee router devices. Xiaomi/Aqara devices are for example known not to work with ZigBee router devices from Centralite, General Electrics, Iris, Ledvance/OSRAM, LIGHTIFY/Sylvania, Orvibo, PEQ, Securifi, and SmartThings/Samsung. Better results can usually be achieved by using mains-powered devices IKEA and Nue/3A Home or dedicated DIY routing devices based on Texas Instruments CC253x/CC26x2 and XBee Series 2/3 ZigBee radios.
- Be patient as the pairing of some ZigBee devices may require multiple attempts and you may sometimes need to try again and again.
    - Some devices, like example those from Xiaomi/Aqara, are known to not be 100% compliant with the standard ZigBee specifications and may therefore require many paring attempts over 10-20 minutes or longer.
