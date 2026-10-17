# Back up a zigpy coordinator

A backup of the coordinator holds the Zigbee network itself: PAN ID, extended PAN ID, channel, network key, the coordinator IEEE and the list of devices. With it, a coordinator can be replaced by a new one of the same family without pairing the devices again (see [Replace or migrate the coordinator](HowTo_Replace-coordinator.md)).

This applies to the zigpy coordinators: Texas Instruments (zigpy-znp), Silicon Labs (bellows), ConBee/RaspBee (zigpy-deconz) and Bouffalo Lab (zigpy-blz).

## The plugin backs up the coordinator automatically

You normally have nothing to do. When the `autoBackup` setting is on (default, WebUI *Settings*, *Zigpy CIE specific configuration*), the plugin saves the coordinator network:

* at most once a day, during its night-time jobs;
* when the plugin stops (except when the connection to the coordinator was lost).

Each backup is written to `Data/Coordinator-<hardware id>.backup` in the plugin folder (the previous versions are kept, as many as `numDeviceListVersion`, 12 by default) and to the Domoticz database. Back up both with the rest of the plugin data: see [Backup and restore](Plugin_Backup.md).

With a Texas Instruments coordinator, the `BackupFullDevices` setting also stores the full device information in the backup.

### Automatic restore

When the plugin starts with a **blank** coordinator of the same family (for example after replacing a broken dongle) and the `autoRestore` setting is on (default), it restores the most recent backup (from the file or from the Domoticz database) onto the new coordinator instead of forming a new network. The devices keep working without being paired again.

With a Silicon Labs coordinator, the coordinator IEEE address of the backup can only be written once into a new dongle: enable `OverWriteCoordinatorIEEEOnlyOnce` (Silicon Labs only, plugin restart) before starting with the new dongle.

## Manual backup and restore with zigpy-cli

You can also back up or restore a coordinator by hand with `zigpy`, the zigpy command-line tool installed with the plugin. zigpy-cli supports Texas Instruments (`znp`), Silicon Labs (`ezsp`) and ConBee/RaspBee (`deconz`) coordinators; for Bouffalo Lab coordinators, rely on the plugin backups.

1. **Stop the plugin** (or Domoticz): only one program can use the coordinator.
1. Activate the Python virtual environment of Domoticz (see [Python virtual environment](HowTo_PythonVirtualEnv.md)); with Docker, open a shell in the container.
1. Run the command for your coordinator, replacing `/dev/ttyUSB0` with its serial port (or `socket://<ip>:<port>` for a network coordinator).

Back up:

```bash
zigpy radio znp /dev/ttyUSB0 backup coordinator-backup.json
zigpy radio ezsp /dev/ttyUSB0 backup coordinator-backup.json
zigpy radio deconz /dev/ttyUSB0 backup coordinator-backup.json
```

Restore onto a coordinator of the same family:

```bash
zigpy radio znp /dev/ttyUSB0 restore coordinator-backup.json
```

Notes:

* Add `--baudrate 115200` (or the speed of your coordinator) after `radio` if needed, for example `zigpy radio --baudrate 115200 ezsp /dev/ttyAMA0 backup coordinator-backup.json`.
* Silicon Labs: to be able to write the coordinator IEEE into a new dongle, make the backup with `--i-understand-i-can-update-eui64-only-once-and-i-still-want-to-do-it`. This can only be done once per dongle.
* The plugin backup file `Data/Coordinator-<hardware id>.backup` is in zigpy's format and can be restored the same way.

## References

* [zigpy-cli](https://github.com/zigpy/zigpy-cli)
* [Backup and restore](Plugin_Backup.md)
