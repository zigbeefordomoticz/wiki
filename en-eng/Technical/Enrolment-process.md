# Enrolment process

What the plugin does when a new device joins the network. See [Add a new device](../HowTo_Pairing-device.md) for the user side.

## Discovery

1. The device joins and sends a **Device Announcement** with its short address (NwkId), IEEE address and capabilities (router or end device, mains or battery powered).
1. The plugin creates the device in its database and asks the device for its model name (Basic cluster `0x0000`, attribute `0x0005`) and for its **active endpoints** (*Active Endpoint Request*).
1. For each endpoint, the plugin sends a **Simple Descriptor Request**, which returns the profile, the device type and the list of clusters of the endpoint.
1. The plugin also asks for the **Node Descriptor** (manufacturer code, power and receiver capabilities).

When the model name is found in a device configuration file (certified or local, see [Device configuration files](Device_Configuration_file.md)), the plugin can skip part of the discovery and use the configuration file directly.

## Provisioning and widget creation

Once the plugin knows enough about the device:

1. It binds the clusters that must report to the coordinator, configures the attribute reporting, and reads the initial attribute values.
1. It creates the Domoticz widgets:
   * from the device configuration file when the model is known (*optimized* device);
   * otherwise from the clusters found during the discovery (*non-optimized* device), following [the standard cluster / widget association](Clusters_Widget.md).

## When the enrolment fails

The enrolment can stop when the plugin couldn't collect enough information to create the widgets:

* communication problems during the pairing (the device is far, or sleeps before answering);
* the device doesn't follow the Zigbee standard, or isn't supported yet.

What to do:

* pair the device again, close to its final location, and keep a battery device awake during the pairing (press a button every few seconds);
* check the Domoticz log;
* see [Troubleshooting pairing or connection](../Troubleshooting_Pairing.md) and [Dealing with a non-optimized device](../Problem_Dealing-with-none-optimized-device.md).
