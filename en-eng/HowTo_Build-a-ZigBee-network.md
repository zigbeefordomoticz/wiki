# HowTo - Build a good ZigBee mesh network

## Best practices for optimizing reception and transmission to improve ZigBee network range and coverage

Poor signal quality or interference can lead to transmission problems and show symptoms such as or errors when sending and/or receiving Zigbee messages that will cause significant degradation in Zigbee network performance. Below is some fundamental background information and tips for a Zigbee setup starting point to achieve better signal quality, coverage and range.

Following these essential optimization tips will typically resolve many known issues caused by a bad setup of Zigbee Coordinator adapter and Zigbee network mesh or Zigbee devices. At the very least taking these actions should improve most message transmitting and receiving issues caused by not knowing the basics needed to workaround related Zigbee limitations.

#### Understanding common causes of problems in Zigbee setups

- Zigbee Coordinator adapter hardware:
  - Poor placement of the Zigbee Coordinator and/or wrong orientation of Zigbee Coordinator antenna.
  - Poor / outdated / incompatible Zigbee Coordinator firmware on the Zigbee Coordinator adapter.
  - Old, outdated or underpowered Zigbee Coordinator hardware or poor Zigbee Coordinator antenna.
- Zigbee Coordinator and Zigbee devices sensitive to all types of RFI/EMI/EMF interference:
  - Electromagnetic interference (EMI) from electronics caused by Electromagnetic Fields (EMF).
  - USB 3.0 ports and computer peripherals are known culprits of EMI/EMF disrupting Zigbee.
  - 2.4 GHz Radio Frequency Interference (RFI) from Wi-Fi Routers and Wi-Fi Access Points, or others.
  - Radio proximity as well conflicting radio frequencies (Wi-Fi) overlapping used Zigbee frequency.
- Too few or far distance between Zigbee devices in Zigbee network mesh:
  - Too many obstacles between the Zigbee Coordinator or Zigbee Router and Zigbee End Device.
    - Zigbee network mesh depends on Zigbee Router devices to extend range and coverage.
    - All individual Zigbee devices do have poor signal penetration and not long range.
  - Too few Zigbee Router devices Zigbee Coordinator or Zigbee Router and Zigbee End Device.
    - Only mains-powered devices can be repeaters that extend network range and coverage.
    - Any battery-operated products are a Zigbee End Device and will never be a Zigbee Router.

#### Simple actions that should improve most Zigbee setups

- Zigbee Coordinator adapter hardware:
  - Try different physical placement and orientations of Zigbee Coordinator or its antenna.
    - Optimal placement of Zigbee Coordinator is as much in middle of the house as possible.
    - Try to place the Zigbee coordinator at some distance way from walls, ceilings and floors.
    - Try different orientations of your Zigbee antenna (or whole Zigbee coordinator adapter).
  - Update to a later released Zigbee Coordinator firmware on the Zigbee Coordinator adapter.
    - Updating FW is easy and community often provide newer firmware than manufacturer.
  - Buy a more powerful Zigbee Coordinator adapter based on a newer/modern Zigbee chip hardware.
    - Recommended as older adapter might work but have obsolete hardware and/or firmware.
- Zigbee Coordinator and Zigbee devices RFI sensitive as susceptible to all types of EMI/EMF interference:
  - Use a long USB extension cable to place Zigbee Coordinator away from interference and obstacles.
    - Try to make sure the USB extension cable has proper shielded (thick cables usually do).
    - Longer USB extension cable also make it easier to orient Zigbee Coordinator and antenna.
  - Only connect Zigbee Coordinator USB adapter to a USB 2.0 ports (or a powered USB 2.0 hub).
    - USB 3.0 ports and peripherals are infamously known for causing EMI/EMF interference.
  - Shield close unshielded computers and unshielded peripherals by using metal enclosures/chassis.
    - Single-board-computers and USB hard drives are especially known as source of EMI/EMF.
  - Change Wi-Fi Router and Access Points channels to not interfere with the default Zigbee channel.
    - Changing Wi-Fi channel on Wi-Fi devices is recommended over changing Zigbee channel.
  - Change Zigbee channel on Zigbee network if have too many strong sources of overlapping Wi-Fi.
    - Changing Zigbee channel is considered a last resort so make sure to do research before.
      - Normally require re-pairing all, and not all devices support all Zigbee channels.
- Too few or far distance between Zigbee devices in Zigbee network mesh:
  - Zigbee network mesh depends on having Zigbee Router devices to extend range and coverage:
    - Add additional mains-powered Zigbee devices known to be good as Zigbee Router device.
      - Add more Zigbee Router devices to extend network mesh range and coverage.
      - Note that not all mains-powered Zigbee devices act as a Zigbee Router device.
      - Some Zigbee Router devices are know to only work well with same brand devices.  
    - Buy a few known good dedicated Zigbee Router product (ex. “IKEA Tradfri Signal Repeater”).
      - Search community forums for "Zigbee signal repeater" or "Zigbee range extender".
    - Buy a few extra new Zigbee USB adapters to use after flashing with Zigbee Router firmware.
    - Reflash/reuse Zigbee USB adapters to Zigbee Router when upgrading Zigbee Coordinator.

If still have problems troubleshooting connecting/joining network also read -> Best practices to avoid pairing/connection difficulties](Troubleshooting_Pairing.md)

#### External resources for initial Zigbee setup optimizations:

- [ZigBee and Wi-Fi Coexistence (Metageek - Advanced Wi-Fi Lessons and Training)](https://community.home-assistant.io/t/advice-on-zigbee-range-extending/175882/)
- [Choose your Zigbee channel wisely (Liam Alexander Colman - Home Assistant Guide)](https://home-assistant-guide.com/2020/10/29/choose-your-zigbee-channel-wisely/)
- [Smart Home Protocols: ZigBee Explained (Everything Smart Home on YouTube)](https://www.youtube.com/watch?v=UmpDXc3cXbU&ab_channel=EverythingSmartHome)
- [Improve Zigbee network performance and stability with these 3 tips (Home Automation Guy on YouTube)](https://www.youtube.com/watch?v=t-gw7kURXCk&t=2s&ab_channel=HomeAutomationGuy)
- [Zigbee 2022 TIPS with Home Assistant (digiblurDIY on YouTube)](https://www.youtube.com/watch?v=1dcAXkJxzcY&ab_channel=digiblurDIY)
- [How to improve your Zigbee network (Gadget-Freak)](https://gadget-freakz.com/how-to-improve-your-zigbee-network/)
- [Top 5 Reasons for Failures in ZigBee Deployments (NTS)](https://nts.com/services/education/zigbee-best-practices/)
- [Electrolama ZZH Adapter Troubleshooting and FAQ](https://electrolama.com/radio-docs/troubleshooting/)
- [2.4GHz Intra-System (or Self/Platform) Interference Demonstration (Unit 3 Compliance Blog)](https://www.unit3compliance.co.uk/2-4ghz-intra-system-or-self-platform-interference-demonstration/)
- [USB 3.0 Radio Frequency Interference Impact on 2.4 GHz Wireless Devices (Intel White Paper)](https://www.usb.org/sites/default/files/327216.pdf)


Written by [@Hedda](https://github.com/Hedda)
