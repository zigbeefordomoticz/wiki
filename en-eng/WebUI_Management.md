# The Web interface - Management section

Please refer to STEP 3 [Plugin Configuration](Plugin_Configuration.md) to get access to the Web interface administration.

The __Management__ menu contains the pages:

* [Device Management](#device-management)
* [Group Management](#group-management)


------------------------------------------------
## Device Management

The __Device Management__ page (*Management > Device Management*) lists all the devices paired with the plugin. From it you rename a device, set its parameters, enable or disable it, and open its details.

> **Plugin 9.1.009 and later.** This section describes the Device Management page available since plugin 9.1.009. In older versions, the page is a wide table with a *Del.* (trash) column, an *Optimized* icon to copy the device data, names typed in the table and saved with *Validate*, and a parameter window where the parameters are typed as one text.

![Device Management](Images/EN_WebUI-Management-Device.png)

*This picture may have changed since this documentation was written.*

### The list

| Column | Content |
|--------|---------|
| Friendly Name | The name you gave the device (the model, in italics, when it has none). Below it, its Domoticz widget, or the number of widgets and the first one, or *No Domoticz widget*. Click the name to rename the device (see below). |
| Model | The model name reported by the device, and below it *Optimized* (in green) when the plugin has a certified configuration for this model, or *Not optimized* (in orange) when it hasn't (see [Dealing with a non-optimized device](Problem_Dealing-with-none-optimized-device.md)). |
| Address | The network address (short id, NwkId), which can change when the device rejoins, and below it the IEEE, the unique and permanent address of the device. |
| Power | *Mains*, or the battery level (in red at 15 % and below), and the role of the device in the mesh: *Router* or *End device*. |
| LQI | The last link quality seen from this device (0 to 255), with a bar: green from 100, orange from 40, red below. When the coordinator reports it, the RSSI is shown below. |
| Health | *Live*, *Not seen recently*, *Not reachable*, *Timed out*, *Disabled*, *Unknown*. A device whose pairing is not complete shows a warning below: *Pairing failed*, *Not in Domoticz*, or *Status:* followed by the pairing state of the plugin. |
| Parameters | The number of parameters set for the device (*None* when there is none). An orange dot means the last saved parameters wait for the device's next heartbeat. Click it to open the parameter panel (see below). |

Above the list:

* **Quick filters**, with the number of devices in each: *All*, *Needs attention* (not reachable, timed out, not seen recently, battery at 15 % or below, or pairing not complete), *Not optimized*, *Disabled*, *Routers*, *End devices*.
* **Search**: type part of a name, model, short id, IEEE or widget name.

Click a column header to sort the list. The page remembers your sort order and page size.

### Rename a device

The friendly name is used by the WebUI to show the device, in the network pages for example, instead of its four-digit short id.

![Rename a device](Images/EN_WebUI-Management-Device-Rename.png)

1. Click the name of the device: it becomes an input field.
1. Type the new name.
1. Press `Enter`, or click ✓. Only this device is saved, at once.

`Esc`, ✕ or a click elsewhere cancels the change.

### Parameters

The *Parameters* button of a row (or the *Parameters* button of the [device details](#device-details)) opens a side panel:

![Device parameters, Fields](Images/EN_WebUI-Management-Device-Parameters.png)

* **Device enabled**: switch it off to disable the device. The plugin then ignores its messages, skips it at heartbeat and sends it no command; *Health* shows *Disabled*. Switch it on again to enable the device.
* **Device parameters**: the device's own parameters. *What can I set?* opens [Device parameters](HowTo_Device-parameters.md), the list of the parameters and their values. Two views of the same parameters:
  * **Fields**: one field per parameter. A value is a number, a text, `true` / `false`, or JSON such as `{"01": 600}`; an invalid value is outlined in red. ✕ removes a parameter. To add one, type its name under *Add a parameter*, click *Add*, then fill its value.
  * **JSON**: all the parameters as one JSON object, checked as you type (*Valid JSON · n parameter(s)*). Use double quotes: `{"PowerPollingFreq": 120}`.

  ![Device parameters, JSON](Images/EN_WebUI-Management-Device-Parameters-JSON.png)

  The `Disabled` parameter is not accepted in either view: use the *Device enabled* switch.
* **Save parameters** saves the switch and the parameters of this device only. The panel closes once the plugin has accepted them. They are sent to the device at its next heartbeat: until then, the *Parameters* button shows an orange dot. *Cancel*, ✕ or `Esc` closes the panel without saving.

If the parameters stored by the plugin can't be read, the panel opens on the *JSON* view with the stored text, so you can fix it.

### Device details

Click anywhere else on a row (or press `Enter` on a selected row) to open the details of the device:

![Device details](Images/EN_WebUI-Management-Device-Details.png)

* **From the device configuration**: the description and the comment of the device configuration, and a *Blakadder* line: a link to the device page on [zigbee.blakadder.com](https://zigbee.blakadder.com) or, when there is none yet, a *Please create the device info* link to add it.
* **The device**: name, network id (short id), IEEE, model, manufacturer (code and name), Profile ID and Device ID with their meaning, health.
* **Signal**: the last readings of the signal strength (RSSI, in dBm) when the coordinator reports it, else of the link quality (LQI), with the latest, lowest and highest values.
* **Domoticz widgets**: the widgets created for this device.
* **Node descriptor**: what the device announced about itself, decoded: logical type (coordinator, router, end device), frequency band, MAC capability (full- or reduced-function device, mains or battery powered, receiver on when idle…), manufacturer code, buffer and transfer sizes, server mask, stack compliance revision.

The buttons at the bottom:

* **Remove device**: removes the device from the plugin, after confirmation. It is only available for a device whose pairing failed, that is not in Domoticz, or that has no widget. To remove a working device, see [Remove a device](HowTo_Remove-device.md).
* **Copy device info**: copies the discovery data of the device (what the plugin learned during pairing) to the clipboard, ready to paste into a request for support or for the optimization of the device (see [Dealing with a non-optimized device](Problem_Dealing-with-none-optimized-device.md)).
* **Parameters**: opens the [parameter panel](#parameters).
* **Close**.

------------------------------------------------
## Group Management

The __Group Management__ page (*Management > Group Management*) is where you create and edit the Zigbee groups. Groups must be enabled first with the `enablegroupmanagement` setting (see [Group management settings](WebUI_Settings.md#group-management-settings)).

![Group Management](Images/EN_WebUI-Management-Group.png)

*This picture may have changed since this documentation was written.*

### Columns

| Column | Content |
|--------|---------|
| Group id | The group address, 4 hexadecimal digits. |
| Group name | The name of the group, given to the group's Domoticz widget when it is created. Required. |
| Devices selected in the group | The device endpoints (widgets) that belong to the group. Pick them from the list. |
| Coordinator (in the group) | Tick it to make the coordinator a member of the group too, so that it receives the commands sent to the group (for example by a remote bound to that group) and the plugin can update the widgets. |
| *(trash icon)* | Delete the group. |

*Add a new Group* adds an empty row; a group needs at least one device, or the coordinator. Click *Validate* to save your changes. When the changes need a plugin restart, the WebUI says so and the *Restart needed* indicator blinks in the menu bar until you restart the plugin.

Refer to the section [How to manage groups](HowTo_Group-management.md) for more information.

------------------------------------------------
Look at the other pages of the [plugin Web interface](Readme.md#plugins-web-interface).
