# Replace or migrate the coordinator

How to replace the coordinator: a broken dongle replaced by the same model, a move to another model of the same family, or a migration to another family (for example from a ZiGate or a ConBee to a Texas Instruments or Silicon Labs coordinator).

## What is kept, what may be lost

* **The Domoticz widgets and their history are always kept.** The plugin knows the devices by their IEEE address: a device that joins the new network is recognised, and its existing widgets are used again.
* **The pairings** (the Zigbee network) are kept only if the network of the old coordinator can be restored onto the new one, from a coordinator backup. Otherwise every device must be paired again (reset it and pair it, see [Add a new device](HowTo_Pairing-device.md)).

## Before you start

1. Make a full backup: see [Backup and restore](Plugin_Backup.md).
1. With a zigpy coordinator, make sure a recent coordinator backup exists: `Data/Coordinator-<hardware id>.backup` in the plugin folder, written by the plugin when `autoBackup` is on (default) and when the plugin stops. See [Back up a zigpy coordinator](HowTo_Backup-zigpy-coordinators.md). Stopping the plugin cleanly just before the change gives the most recent one.
1. Stop the plugin (or Domoticz) and unplug the old coordinator. **Don't use the old and the new coordinator at the same time** with the same network: they would compete for the same network.

## Case 1: same family (zigpy coordinator)

For example a Sonoff ZBDongle-P replaced by another Texas Instruments coordinator, or a Silicon Labs dongle by another Silicon Labs one.

1. Plug the new coordinator. It must be **blank** (no network yet): a new coordinator, or one reset to factory settings.
1. If needed, update the plugin hardware in Domoticz: *Serial Port*, *Coordinator connection type* (see [Plugin settings](Plugin_Settings.md)). Leave *Coordinator Model* and *Initialize Coordinator* (*False*) unchanged.
1. **Silicon Labs only:** enable `OverWriteCoordinatorIEEEOnlyOnce` in the WebUI *Settings* (*Zigpy CIE specific configuration*, advanced, shown with Silicon Labs coordinators) before starting with the new dongle. The coordinator IEEE address of the backup is written into the new dongle; this can only be done once per dongle.
1. Start the plugin. With `autoRestore` on (default), the plugin finds a blank coordinator, restores the most recent backup onto it, and starts the same network: same PAN ID, channel and network key, same coordinator address. The devices keep working; battery devices reconnect when they next wake up.

Check the Domoticz log for the restore, then check in *Management > Device Management* that the devices report.

## Case 2: another family

For example from a ConBee to a Texas Instruments or Silicon Labs coordinator, or from Texas Instruments to Silicon Labs.

zigpy backups are not tied to a coordinator family, so the network can usually be restored onto a coordinator of another zigpy family:

1. Plug the new, blank coordinator.
1. In the plugin hardware, change *Coordinator Model* to the new family, and the *Serial Port* / connection type (see [Plugin settings](Plugin_Settings.md)). Leave *Initialize Coordinator* to *False*.
1. To a Silicon Labs coordinator: enable `OverWriteCoordinatorIEEEOnlyOnce` first, as in case 1.
1. Start the plugin: as in case 1, `autoRestore` restores the most recent backup onto the blank coordinator.

You can also restore the backup by hand with zigpy-cli before starting the plugin (see [Back up a zigpy coordinator](HowTo_Backup-zigpy-coordinators.md)).

If the network can't be restored (no backup, or a failure), form a new network (case 3).

## Case 3: from a ZiGate, or starting a new network

A ZiGate network can't be restored onto a zigpy coordinator: the devices must be paired again. The same applies whenever you want a new network.

1. Plug the new coordinator and change *Coordinator Model*, *Coordinator connection type* and *Serial Port* in the plugin hardware.
1. **Turn `autoRestore` off** in the WebUI *Settings* (*Zigpy CIE specific configuration*, advanced) if a backup of another zigpy network exists: otherwise the plugin would restore it instead of forming a new network.
1. Set *Initialize Coordinator* to *True* and click *Update*. The plugin forms a new network, then sets *Initialize Coordinator* back to *False* and restarts by itself (check it in the hardware list; set it back yourself if needed).
1. Pair the devices again, routers first: reset each device and pair it (see [Add a new device](HowTo_Pairing-device.md)). Their widgets and history are kept.
1. Turn `autoRestore` back on.

Note: *Devices that joined*, on the *Admin > Provisionning* tab (the pairing assistant before plugin 9.1.009), doesn't show devices that the plugin already knew. Follow the re-pairing in the Domoticz log.

## See also

* [Compatible coordinators](Coordinators.md)
* [Back up a zigpy coordinator](HowTo_Backup-zigpy-coordinators.md)
* [Replace a device while keeping its Domoticz history](HowTo_Replace_Device.md)
