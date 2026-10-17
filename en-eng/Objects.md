# Compatible objects

Most Zigbee devices work with the plugin. Some are **optimized** (or *certified*): the plugin has a configuration file for their model, so their widgets and behaviour are known and tested. The others are handled from what they report during pairing, which works for most Zigbee 3.0 devices.

## Is my device optimized?

* Look for it on [zigbee.blakadder.com](https://zigbee.blakadder.com/z4d.html), under the gateway **Zigbee for Domoticz**, or in the list of [certified devices](Info_Compatible-devices.md).
* Once paired, check the *Optimized* column of *Management > Device Management* in the WebUI (green: optimized, orange: not optimized), or the *Optimized devices* chart of the Dashboard.

Some optimized devices still need a specific setup: see the [Devices specifics](Readme.md#devices-specifics) pages.

## My device is not optimized

* **It works**: tell others. Add it to [zigbee.blakadder.com](https://zigbee.blakadder.com/z4d.html) (red *Edit Page* button at the top right of a device page), and share its data so that it can be certified: see [Dealing with a non-optimized device](Problem_Dealing-with-none-optimized-device.md).
* **It doesn't work, or only partly**: see [Dealing with a non-optimized device](Problem_Dealing-with-none-optimized-device.md) and [What to do if the device doesn't behave correctly](Readme.md#what-to-do-if-the-device-doesnt-behave-correctly). The *Tools > Tools* page has a **Non-optimized devices** button that shows the discovery data of these devices.
* **You want to fix it yourself**: describe the device in a configuration file in the `Conf/Local-Devices` folder of the plugin. See [Get devices well integrated with the plugin](HowTo_Device-Customization.md) and [Model name resolution and `Conf/Local-Devices` precedence](Technical/Model-name-resolution.md).
