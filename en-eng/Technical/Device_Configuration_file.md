# Device configuration files

A device configuration file tells the plugin how to handle a device model: the widgets to create, the clusters to bind, the attributes to report and to poll, the device parameters and their defaults, and the device-specific decoding. It is a JSON file named after the Zigbee model of the device, for example `SML001.json` for the Philips Hue motion sensor `SML001`.

## Where the files are

* **Certified files** come with the [z4d-certified-devices](https://github.com/zigbeefordomoticz/z4d-certified-devices) Python package, installed with the plugin, under `z4d_certified_devices/Certified/<brand>/<model>.json`. They are updated with the package: don't edit them there, your changes would be lost at the next update.
* **Your own files** go in the `Conf/Local-Devices` folder of the plugin. Plugin and package updates don't touch this folder, and a file there takes precedence over the certified one.

The model name the plugin looks up is not always the raw model reported by the device: see [Model name resolution and `Conf/Local-Devices` precedence](Model-name-resolution.md).

## Content of a file

* [Device configuration attributes](device-configuration-attributes.md): the keys of a configuration file (`Ep`, `ClusterToBind`, `ConfigureReporting`, `ReadAttributes`…).
* [Device specific parameters ("Param" section)](device_specific-parameters.md): the parameters a configuration file can set.

To write or fix a configuration file, follow [Get devices well integrated with the plugin (device customization)](../HowTo_Device-Customization.md), and [Integrate Tuya TS0601 devices](../HowTo_Device-Customization-TS0601.md) for Tuya TS0601 devices.
