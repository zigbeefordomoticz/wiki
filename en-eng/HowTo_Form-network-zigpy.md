# Form a network with a zigpy coordinator

## When to use this

Normally, a new network is formed by the plugin itself: set *Initialize Coordinator* to *True* in the plugin hardware and restart it (see [Plugin settings](Plugin_Settings.md)).

If that fails, for example with a new coordinator that never had a network, the plugin keeps restarting and the log shows errors while forming the network. This was seen in 2022 with a Silicon Labs (EZSP) module:

```log
2022-09-01 17:31:33,251 DEBUG   :Using selector: EpollSelector
2022-09-01 17:31:33,252 INFO    : [     ZigpyCom_5 0] Started radio ezsp port: /dev/ttyAMA0
2022-09-01 17:31:33,254 INFO    : [     ZigpyCom_5 0] Form a New Network with Channel: 0(0x00) ExtendedPanId: 0x0000000000000000
2022-09-01 17:31:34,396 WARNING :Couldn't set EzspConfigId.CONFIG_MULTICAST_TABLE_SIZE=16 configuration value: EzspStatus.ERROR_OUT_OF_MEMORY
...
zigpy.exceptions.NetworkNotFormed: Failed to init network: <EmberStatus.NOT_JOINED: 147>
```

You can then form the network by hand with `zigpy`, the zigpy command-line tool installed with the plugin, and start the plugin on it.

## Procedure

1. **Stop the plugin** (or Domoticz): only one program can use the coordinator.
1. Activate the Python virtual environment of Domoticz (see [Python virtual environment](HowTo_PythonVirtualEnv.md)); with Docker, open a shell in the container. Don't install zigpy-cli with `pip install --user`: it is already there.
1. Check that the coordinator answers. Replace `ezsp` with `znp` (Texas Instruments) or `deconz` (ConBee/RaspBee), and `/dev/ttyAMA0` with the serial port of your coordinator (or `socket://<ip>:<port>`):

   ```bash
   zigpy radio --baudrate 115200 ezsp /dev/ttyAMA0 info
   ```

   If this fails too, the problem is between the system and the coordinator (port, access rights, firmware), not in the plugin.

1. Form the network:

   ```bash
   zigpy radio --baudrate 115200 ezsp /dev/ttyAMA0 form
   ```

1. In Domoticz, check that *Initialize Coordinator* is *False* on the plugin hardware, and start the plugin.

zigpy-cli doesn't support Bouffalo Lab coordinators: with one of them, use *Initialize Coordinator*.

The `channel` and `extendedPANID` settings of the plugin are not used by `zigpy … form`, which picks a channel itself. To get a specific channel, change it afterwards (see [Change the Zigbee channel](HowTo_Change-ZigBee-channel.md)); for a specific extended PAN ID (legacy Wiser), use *Initialize Coordinator*.

## References

* [zigpy-cli](https://github.com/zigpy/zigpy-cli)
