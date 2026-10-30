# The Web interface - Tools section

Please refer to STEP 3 [Plugin Configuration](Plugin_Configuration.md) to get access to the Web interface administration.

The __Tools__ menu contains the pages:

* [Tools](#tools) — display and export the plugin's data
* [Command](#command) — send commands to a device
* [Reporting](#reporting) — configure attribute reporting (zigpy coordinators only)
* [Binding](#bindings) — bind and unbind devices
* [Debug](#debug) — debug logging settings
* [Error(s)](#error) — the errors recorded by the plugin


------------------------------------------------
## Tools

The __Tools__ page (*Tools > Tools*) has one button per piece of plugin data (plugin and coordinator info, devices, groups, battery state, traffic, plugin health, plugin logs…). Click a button to display the data as JSON; *Export* downloads it.

![WebUI-Tools-tool.png](../Images/WebUI-Tools-tool.png)
*This page may have changed since this documentation was written.*

Refer to [Use the plugin tools](HowTo_Using-tools.md) for the list of buttons and what each one returns.

------------------------------------------------
## Command

The __Command__ page (*Tools > Command*) sends commands to a device directly from the WebUI, without going through Domoticz. It has two panels.

![WebUI-Tools-command.png](../Images/WebUI-Tools-command.png)
*This page may have changed since this documentation was written.*

### Direct commands

Interact with a device using the actions its capabilities allow:

1. Select the device.
2. Select the action to perform (on, off, level, color…).
3. If asked, select the device type: it can change how the command is sent.
4. If needed, enter a value or pick a color, then click *Send*.

### ZigBee command

With a zigpy coordinator (ZNP, EZSP/Bellows, deCONZ, BLZ), this panel sends a raw Zigbee frame to a device. It is meant for advanced users who know the Zigbee Cluster Library (ZCL): the plugin does not check or build anything, and sends the payload exactly as typed.

![Tools > Command, ZigBee command (zigpy)](Images/EN_WebUI-Tools-Command-zigpy.png)
*This picture may have changed since this documentation was written.*

All values are hexadecimal, without `0x`.

| Field | What to enter |
| ----- | ------------- |
| *(device)* | The target device. The list shows each device's name and short address (NwkId). |
| *GroupAddressFlag* | `False` to send to the device. `True` sends the frame as a group (multicast) request. |
| *AckMode* | `True` asks the device for an APS acknowledgement; `False` sends without it. |
| *ProfileId* | `0104` (Home Automation) for ZCL commands, `0000` for ZDO/ZDP requests. |
| *ClusterId* | The cluster, for example `0000` (Basic), `0006` (On/Off), `0008` (Level Control). |
| *SourceEp* | The coordinator's endpoint, usually `01` (`00` for ZDO/ZDP). |
| *TargetEp* | The device endpoint that holds the cluster (`00` for ZDO/ZDP). |
| *Sqn* | The sequence number of the request, for example `55`. Use the same value as the sequence number inside the payload. |
| *Data* | The payload: the complete ZCL frame, header included (see below). |

Click *Submit*. The WebUI only confirms that the command was sent; it does not show the device's answer. The plugin processes the answer like any other message from the device, so look at the plugin log to follow it.

#### Building the payload

The *Data* field is the complete ZCL frame, written as one string of hexadecimal bytes:

| Bytes | Content |
| ----- | ------- |
| 1 | Frame control: `00` for a general (profile-wide) command such as Read Attributes, `01` for a command specific to the cluster. Add `04` for a manufacturer-specific command (`04` or `05`). |
| 2 | Manufacturer code, **only** for a manufacturer-specific command. |
| 1 | Transaction sequence number, the same as *Sqn*. |
| 1 | Command identifier, for example `00` Read Attributes, `02` Write Attributes. |
| n | The command's fields. |

> **Endianness:** Zigbee sends every value longer than one byte in **little-endian** order, least significant byte first. You must reverse the bytes yourself in *Data*: attribute `0x0005` is typed `0500`, the manufacturer code `0x115F` is typed `5F11`, and a 16-bit value `0x012C` is typed `2C01`.
>
> This only applies to *Data*. The other fields (*ProfileId*, *ClusterId*, *Sqn*…) are typed the normal way, as in the picture: `0104`, `0000`.

The payload of the picture, `0055000500`, reads the *Model Identifier* of the device:

| Bytes | Meaning |
| ----- | ------- |
| `00` | Frame control: general command, from client to server |
| `55` | Transaction sequence number (same as *Sqn*) |
| `00` | Command Read Attributes |
| `0500` | Attribute `0x0005` (Model Identifier), little-endian |

More examples:

| Goal | ClusterId | Data |
| ---- | --------- | ---- |
| Read the Manufacturer Name and Model Identifier (attributes `0x0004` and `0x0005`) | `0000` | `00550004000500` |
| Switch on | `0006` | `015501` |
| Switch off | `0006` | `015500` |
| Toggle | `0006` | `015502` |

With a ZiGate coordinator this panel is replaced by **ZiGate command (raw)**, which sends a raw command to the ZiGate following the ZiGate protocol.

------------------------------------------------
## Reporting

The __Reporting__ page (*Tools > Reporting*) is only shown with a zigpy coordinator. It sets which attributes a device reports on its own, and how often.

![Tools > Reporting](Images/EN_WebUI-Tools-Reporting.png)
*This picture may have changed since this documentation was written.*

Select a device: its clusters and attributes are listed with their *Datatype*, *Timeout*, *min interval* and *max interval* (in seconds) and *Change* (the minimum change that triggers a report). The device sends a report when the value has changed by at least *Change*, but not more often than every *min interval*, and at least every *max interval* even if nothing changed.

* *Validate* saves your values for this device.
* *Trigger* sends the reporting configuration to the device now.
* *Reset* drops your values: the device goes back to the plugin's default configuration.

------------------------------------------------
## Bindings

The __Binding__ page (*Tools > Binding*) binds a cluster between two devices, so that the source device sends its commands or reports directly to the target, without going through the coordinator.

![WebUI-Tools-bindings.png](../Images/WebUI-Tools-bindings.png)
*This page may have changed since this documentation was written.*

Select the cluster, the source device (and endpoint) and the target device (and endpoint), then click *Binding* (or *Unbinding* to remove the binding). For example, to bind a temperature sensor to an actuator, the source is the sensor, the target is the actuator and the cluster is `0402` (Temperature Measurement).

Refer to the tutorial [Bind two devices](HowTo_Binding.md) for more information.

------------------------------------------------
## Debug

The __Debug__ page (*Tools > Debug*) holds the logging settings: which parts of the plugin log debug messages, for which devices, and where the logs go. Switch *Advanced settings* on to see the debug modules, tick the ones you need and click *Validate*. *Settings (default)* turns everything back to the defaults.

![WebUI-Tools-debug.png](../Images/WebUI-Tools-debug.png)
*This page may have changed since this documentation was written.*

Refer to [Debugging mode](Problem_Debuging-mode.md) for what each setting and module does, and which ones to enable for a given problem.

------------------------------------------------
## Error

The __Error(s)__ page (*Tools > Error(s)*) lists the errors recorded by the plugin. It is also where the *Error(s) detected* indicator of the menu bar (blinking red triangle) leads.

![Tools > Error(s)](Images/EN_WebUI-Tools-Errors.png)
*This page may have changed since this documentation was written.*

* *Log Error History (json)* displays the recorded errors, with their context; *Export* downloads them as a JSON file, for example to attach to an issue.
* *Clear Error History* empties the list.

Either button turns the red triangle off until a new error is recorded.

Refer to the tutorial [Deal with plugin errors](HowTo_Dealing-plugin-errors.md) for more information.


------------------------------------------------
Look at the other pages of the [plugin Web interface](Readme.md#4-the-webui).
