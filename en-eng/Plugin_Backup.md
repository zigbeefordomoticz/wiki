# Backup and restore

What to back up so that you can restore the plugin and your Zigbee network without pairing everything again, and how to reinstall the plugin while keeping its data.

## Where the plugin keeps its data

The plugin data is in two places:

1. **In the plugin folder** (`domoticz/plugins/Domoticz-Zigbee`):
   * `Data/DeviceList-<hardware id>.txt`: the device database (everything the plugin knows about each device);
   * `Data/GroupsList-<hardware id>.json`: the groups;
   * `Data/Coordinator-<hardware id>.backup`: the backup of the coordinator network (zigpy coordinators, see below);
   * `Conf/PluginConf-<hardware id>.json`: the plugin settings;
   * `Reports/`: the topology and interference reports (optional).

   `<hardware id>` is the Domoticz hardware ID of the plugin, on two digits.

1. **In the Domoticz database** (`domoticz.db`): since plugin 9.1, the plugin also stores its settings, its device database, its groups and the coordinator backup in Domoticz, with the plugin hardware (settings `useDomoticzDb` and `storeDomoticzDb`, on by default).

Each copy is time-stamped, and at start-up the plugin loads the most recent one. So:

* **Back up `domoticz.db` and the plugin folder at the same time**, so that both copies match, and the Domoticz widgets match the plugin devices.
* A copy of `domoticz.db` alone already holds the plugin data: it can bring the plugin back even if the plugin files are lost.
* The data stored in Domoticz belongs to the plugin hardware: if you delete the plugin hardware in Domoticz, that copy is lost.

## Coordinator backup

With a zigpy coordinator (Texas Instruments, Silicon Labs, ConBee/RaspBee…), the plugin regularly saves the coordinator network (network keys, PAN ID, channel, devices) when the `autoBackup` setting is on (default). The backup goes to `Data/Coordinator-<hardware id>.backup` (older versions are kept) and to the Domoticz database.

When the plugin starts with a blank coordinator of the same family, for example after replacing a broken dongle, it restores this backup when the `autoRestore` setting is on (default): the devices don't need to be paired again.

See [Backup a zigpy coordinator](HowTo_Backup-zigpy-coordinators.md).

## Backup with the plugin scripts

The plugin comes with two scripts, in its `Tools` folder:

* `backup_z4d.sh` creates a dated `tar.gz` archive with a consistent copy of `domoticz.db` (made with `sqlite3` when available) and the plugin key files (`Data/DeviceList-*.txt`, `Data/Coordinator-*.backup`, the zigpy database `Data/zigpy_persistent_*.db` if any, `Conf/PluginConf-*.json`). In plugin 9.1.007 it doesn't pick up the groups file `Data/GroupsList-*.json` (it looks for `.txt`): the groups are still saved in the copy of `domoticz.db`, or use `--full-plugin-copy`;
* `restore_z4d.sh` restores such an archive.

```bash
cd /home/pi/domoticz/plugins/Domoticz-Zigbee
./Tools/backup_z4d.sh --domoticz-db /home/pi/domoticz/domoticz.db \
                      --plugin-target-path /home/pi/domoticz/plugins/Domoticz-Zigbee \
                      --dest /home/pi/backups/domoticz
```

Options of `backup_z4d.sh`:

| Option | Use |
| ------ | --- |
| `--domoticz-db PATH` | The Domoticz database. |
| `--plugin-target-path PATH` | The plugin folder. |
| `--dest DIR` | Where to write the archives (default `~/backups/domoticz`). |
| `--full-plugin-copy` | Copy the whole plugin folder instead of the key files only. |
| `--stop-service` | Stop Domoticz during the backup, for a guaranteed consistent copy. |
| `--retention DAYS` | Delete the archives older than DAYS days (default 14). |
| `--dry-run` | Show what would be done, without doing it. |

Without `--domoticz-db` and `--plugin-target-path`, the script looks in the usual locations.

To restore:

```bash
./Tools/restore_z4d.sh --archive /home/pi/backups/domoticz/<archive>.tar.gz \
                       --plugin-target-path /home/pi/domoticz/plugins/Domoticz-Zigbee \
                       --domoticz-db-target /home/pi/domoticz/domoticz.db --stop-service
```

Run `./Tools/backup_z4d.sh --help` and `./Tools/restore_z4d.sh --help` for all the options. You can run the backup every night with `cron`. The other scripts of the plugin are described in [The scripts of the Tools folder](Plugin_Tools-folder.md).

With Docker, the paths are usually `/opt/domoticz/userdata/domoticz.db` and `/opt/domoticz/userdata/plugins/Domoticz-Zigbee`.

## Manual backup

Stop Domoticz, then copy together:

* `domoticz.db` (or use the Domoticz backup: *Setup > Settings > Backup*);
* the plugin `Data` folder and `Conf/PluginConf-*.json`;
* if you want, the `Reports` folder.

## Reinstall the plugin and keep its data

The paths below assume the plugin is in `/home/pi/domoticz/plugins/Domoticz-Zigbee`; adapt them to your installation.

1. Stop Domoticz.
1. Keep a copy of the plugin folder:

   ```bash
   cp -r /home/pi/domoticz/plugins/Domoticz-Zigbee /home/pi/Domoticz-Zigbee.old
   ```

1. Install the plugin again (see [Plugin installation](Plugin_Installation.md)).
1. Copy the plugin data and settings into the new installation:

   ```bash
   cp /home/pi/Domoticz-Zigbee.old/Data/* /home/pi/domoticz/plugins/Domoticz-Zigbee/Data/
   cp /home/pi/Domoticz-Zigbee.old/Conf/PluginConf-*.json /home/pi/domoticz/plugins/Domoticz-Zigbee/Conf/
   cp /home/pi/Domoticz-Zigbee.old/Reports/* /home/pi/domoticz/plugins/Domoticz-Zigbee/Reports/   # optional
   ```

1. Start Domoticz. Keep the same plugin hardware in Domoticz: its data in the Domoticz database is kept too.
