# How to form a network for coordinators using zigpyradio libarries

## When using this procedure

Usually you should initialise the coordinator via the Coordinator Initialisation parameter when starting the plugin from Domoticz Hardware page.
However we have found that in case of a new coordinator , you are not able to get it started and you get error logs like that:

```
2022-09-01 17:31:33,251 DEBUG   :Using selector: EpollSelector
2022-09-01 17:31:33,252 INFO    : [     ZigpyCom_5 0] Started radio ezsp port: /dev/ttyAMA0
2022-09-01 17:31:33,254 INFO    : [     ZigpyCom_5 0] Form a New Network with Channel: 0(0x00) ExtendedPanId: 0x0000000000000000
2022-09-01 17:31:34,396 WARNING :Couldn't set EzspConfigId.CONFIG_MULTICAST_TABLE_SIZE=16 configuration value: EzspStatus.ERROR_OUT_OF_MEMORY
2022-09-01 17:31:34,503 ERROR   :Couldn't start application
Traceback (most recent call last):
  File "/home/pi/domoticz/plugins/Domoticz-Zigbee/Classes/ZigpyTransport/AppBellows.py", line 61, in initialize
    await self.load_network_info(load_devices=False)
  File "/home/pi/domoticz/plugins/Domoticz-Zigbee/bellows/zigbee/application.py", line 215, in load_network_info
    await self._ensure_network_running()
  File "/home/pi/domoticz/plugins/Domoticz-Zigbee/bellows/zigbee/application.py", line 165, in _ensure_network_running
    raise NetworkNotFormed(f"Failed to init network: {init_status!r}")
zigpy.exceptions.NetworkNotFormed: Failed to init network: <EmberStatus.NOT_JOINED: 147>

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/home/pi/domoticz/plugins/Domoticz-Zigbee/Classes/ZigpyTransport/AppBellows.py", line 108, in startup
    await self.initialize(auto_form=True)
  File "/home/pi/domoticz/plugins/Domoticz-Zigbee/Classes/ZigpyTransport/AppBellows.py", line 78, in initialize
    await self.load_network_info(load_devices=False)
  File "/home/pi/domoticz/plugins/Domoticz-Zigbee/bellows/zigbee/application.py", line 215, in load_network_info
    await self._ensure_network_running()
  File "/home/pi/domoticz/plugins/Domoticz-Zigbee/bellows/zigbee/application.py", line 165, in _ensure_network_running
    raise NetworkNotFormed(f"Failed to init network: {init_status!r}")
zigpy.exceptions.NetworkNotFormed: Failed to init network: <EmberStatus.NOT_JOINED: 147>
```

PS/ We currently are investigating what the issue is, but in between you can use the following steps

## The here after procedure is described for EZSP Coordinators like Elelabs, SonOff E

0. Assumption

The coordinator is accessible via the /dev/ttyAMA0 ( elelabs shield)

1. Install zigpy cli

`pip install git+https://github.com/zigpy/zigpy-cli.git`

as expressed during the pip installation

`export PATH=/home/pi/.local/bin:$PATH`

2. Check the access to the Coordinator

`zigpy radio --baudrate 115200 ezsp /dev/ttyAMA0 info`


3. Form a network

`zigpy radio --baudrate 115200 ezsp /dev/ttyAMA0 form`
