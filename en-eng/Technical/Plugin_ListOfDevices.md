# Plugin database (ListOfDevices)

The plugin keeps everything it knows about the devices (collected during pairing, then updated while running) in an internal structure, `ListOfDevices`. It is saved regularly, not in real time:

* in the file `DeviceList-<hardware id>.txt` of the plugin `Data` folder (`<hardware id>` is the Domoticz hardware ID of the plugin), and, when the `expJsonDatabase` setting is on, in a `DeviceList-<hardware id>.json` copy;
* in the Domoticz database, when the `useDomoticzDb` and `storeDomoticzDb` settings are on (the default). At start-up the plugin reads the most recent of the two.

To look at the database, use the WebUI: *Tools > Tools*, **Plugin Raw Devices** (see [Use the plugin tools](../HowTo_Using-tools.md)).

The fields are described in [Structure of ListOfDevices](Structure-of-ListOfDevices.md).
