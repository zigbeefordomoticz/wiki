# The scripts of the Tools folder

The plugin ships a set of command-line scripts in its `Tools/` folder: to upgrade the plugin, back up and repair its data, check that it is running, or look into OTA firmware files. None of them is needed for day-to-day use; this page tells you what each one does and when it can help.

Unless stated otherwise, run them from the plugin folder (the one that contains `Tools/`), with the user that runs Domoticz:

```bash
cd domoticz/plugins/Domoticz-Zigbee
./Tools/<script> --help
```

Most Python scripts accept `--help`. With Docker, run them inside the container (for example `docker exec -it <container> bash`, then `cd /opt/domoticz/userdata/plugins/Domoticz-Zigbee`).

| Script | Purpose | More |
| ------ | ------- | ---- |
| [`plugin-auto-upgrade.sh`](#plugin-auto-upgradesh) | Update the plugin and its Python modules | |
| `plugin-auto-upgrade-v1.sh`, `plugin-auto-upgrade-v2.sh` | Called by `plugin-auto-upgrade.sh` | |
| [`cleaning-repository.sh`](#cleaning-repositorysh) | Reset the plugin code when `git pull` fails | |
| [`customstart.sh`](#customstartsh) | Docker: install the Python modules when a new container starts | [Installation](Plugin_Installation.md) |
| [`update_domoticz_docker_container.sh`](#update_domoticz_docker_containersh) | Docker: rebuild the image and update the plugin | [Docker on a Raspberry Pi](How-To-Install-RPI-Docker.md) |
| [`backup_z4d.sh`, `restore_z4d.sh`](#backup_z4dsh-and-restore_z4dsh) | Back up and restore the plugin data and the Domoticz database | [Backup and restore](Plugin_Backup.md) |
| [`replace_device.py`](#replace_devicepy) | Move the Domoticz history of a dead device to its replacement | [Replace a device](HowTo_Replace_Device.md) |
| [`repair_clustertype.py`](#repair_clustertypepy) | Repair devices whose widgets are no longer updated | |
| [`query_domoticz_hardware_configuration_record.py`](#query_domoticz_hardware_configuration_recordpy) | Display what the plugin stores in the Domoticz database | |
| [`printLOD.py`](#printlodpy) | Display a `DeviceList-<n>.txt` file in a readable way | |
| [`plugin-ping.py`](#plugin-pingpy) | Check that the plugin is alive (watchdog) | |
| [`generate_z4d_certificates.py`](#generate_z4d_certificatespy) | Create a self-signed certificate to serve the WebUI over https | |
| [`ikea-ota-download.py`](#ikea-ota-downloadpy) | Download every IKEA firmware | [Device firmware](HowTo_Update-device-firmware.md) |
| [`read_ota_headers.py`](#read_ota_headerspy) | Display the header of an OTA firmware file | |
| [`ota_validator.py`](#ota_validatorpy) | Check, block by block, a firmware transfer that failed | |
| [`hooks-pre-commit.sh`](#hooks-pre-commitsh) | Developers: run the tests before each commit | |
| [`pi-zigate.sh`, `PiZigate.service`, `Fedora/`, `JennicModuleProgrammer/`, `build-Jennic.sh`](#legacy-zigate-tools) | Legacy ZiGate tools | [PiZigate installation](Legacy_PiZigate-Installation.md) |

------------------------------------------------
## Installing and updating

### plugin-auto-upgrade.sh

Updates the plugin: `git pull` of the plugin folder, then installation of the Python modules listed in `requirements.txt` (`pip install -r requirements.txt --upgrade`). It is the script run by *Admin > Plugin > Upgrade* in the WebUI (see [Admin](WebUI_Admin.md)), and by `customstart.sh` in a new Docker container.

```bash
./Tools/plugin-auto-upgrade.sh
```

It looks for the Python virtual environment the plugin runs in, from the `VIRTUAL_ENV` and `PYTHONPATH` variables, and hands over to one of two scripts:

* `plugin-auto-upgrade-v2.sh` when `VIRTUAL_ENV` is set, or when `PYTHONPATH` points to a `lib/python3.x/site-packages` folder. Before running it, `plugin-auto-upgrade.sh` cleans the virtual environment: **everything in its root folder except `bin`, `lib`, `lib64`, `include` and `pyvenv.cfg` is deleted**, as well as the `__pycache__` folders and `.pyc` files. Don't keep anything of your own there.
* `plugin-auto-upgrade-v1.sh` in all other cases (`PYTHONPATH` points to the root of a virtual environment, or there is no virtual environment). Before installing, it uninstalls the modules listed in `constraints.txt`, so that they are installed again at the pinned version.

Both scripts also install `python3-venv` and `python3-pip` with the system package manager (`apt`; `v2` also handles `dnf` and `yum`) and upgrade `pip` if needed. When you are not `root`, they use `sudo`: the user must be able to run `sudo` without a password, or the script stops on the module installation.

You can run `plugin-auto-upgrade-v1.sh` or `plugin-auto-upgrade-v2.sh` directly, with the Python version as argument, for example `./Tools/plugin-auto-upgrade-v1.sh 3.12` to use `python3.12` (the default is `python3`). `plugin-auto-upgrade.sh` does not pass this argument on.

Both scripts call `Tools/check_python_and_branch.py`, which is not part of `stable9`: the message saying it can't be found can be ignored.

If the upgrade fails, follow [Plugin update](Plugin_Update.md) to update by hand.

### cleaning-repository.sh

When `git pull` refuses to update the plugin because files of the plugin were changed locally, this script puts the plugin code back to the state of the branch, then pulls:

```bash
./Tools/cleaning-repository.sh
```

You must type `YES` to go on. The script then:

1. deletes every folder of the plugin tracked by git, **except `Data`, `Conf` and `OTAFirmware`**: this includes `Logs`, `Reports` and `www`, with what you may have added in them;
2. runs `git reset --hard`, which drops every local change to the plugin files;
3. runs `git pull`, and shows the result.

Your devices (`Data/`), your settings and your own device configurations (`Conf/`, including `Conf/Local-Devices/`) and your firmware files (`OTAFirmware/`) are kept. Copy what you need from `Logs/` before running it. Stop the plugin first, and restart it afterwards.

### customstart.sh

For Docker only. The Domoticz image runs `/opt/domoticz/userdata/customstart.sh` each time the container starts. The plugin's version does its work on the first start of a new container only (it creates `/opt/domoticz/FIRSTRUN` to remember it): it installs `ping`, `vim` and `ssh`, then runs `plugin-auto-upgrade.sh` to install the Python modules of the plugin.

See [Installation](Plugin_Installation.md) and [Docker on a Raspberry Pi](How-To-Install-RPI-Docker.md) for how to put it in place.

### update_domoticz_docker_container.sh

For Docker only: rebuilds the Domoticz image, restarts the container and checks for plugin updates. See [Docker on a Raspberry Pi](How-To-Install-RPI-Docker.md); run it with `--help` for the options, and `--dry-run` to see what it would do.

------------------------------------------------
## Backing up and repairing the plugin data

### backup_z4d.sh and restore_z4d.sh

Save the plugin data and the Domoticz database into a dated archive, and restore it. See [Backup and restore](Plugin_Backup.md).

### replace_device.py

Moves the widgets, and so the Domoticz history, of a dead device to the device that replaces it. See [Replace a device while keeping its Domoticz history](HowTo_Replace_Device.md).

### repair_clustertype.py

For devices whose Domoticz widgets still exist but are no longer updated by the plugin, after the device announced itself again (plugin issue [#1987](https://github.com/zigbeefordomoticz/Domoticz-Zigbee/issues/1987)). The plugin keeps, for each endpoint of a device, the list of its widgets (`ClusterType`); an old bug could empty this list, and the plugin then no longer knows which widget to update. The bug is fixed, but devices damaged before the fix keep the empty list.

The script rebuilds the missing entries from the widgets found in the Domoticz database: it reads the endpoint and the widget type from the widget name. It only adds missing entries, and never changes or removes an existing one.

You need the path of `domoticz.db`, the *Hardware ID* of the plugin (the *Idx* in *Setup > Hardware* of Domoticz) and the plugin's `Data/DeviceList-<Hardware ID>.txt` file. First run it without `--apply`: it lists the changes it would make and writes nothing.

```bash
python3 Tools/repair_clustertype.py --db /path/to/domoticz.db --hwid 3 \
    --devicelist Data/DeviceList-3.txt
```

If the changes look right, **stop Domoticz**, run the same command with `--apply`, then start Domoticz again:

```bash
python3 Tools/repair_clustertype.py --db /path/to/domoticz.db --hwid 3 \
    --devicelist Data/DeviceList-3.txt --apply
```

A copy of the file is saved first, as `DeviceList-3.txt.bak-<date>`.

> Domoticz must be stopped, not only the plugin restarted. The plugin writes its device list to `DeviceList-<n>.txt` when it stops: if it is running when you apply the repair, restarting it overwrites the repaired file with the damaged list it has in memory.

### query_domoticz_hardware_configuration_record.py

Displays what the plugin stores in the Domoticz database, in the *Configuration* field of its *Hardware* entry. It only reads the database. Useful to check what Domoticz holds, or when asked for it in an issue.

```bash
python3 Tools/query_domoticz_hardware_configuration_record.py --db /path/to/domoticz.db --id 3 --decode-b64
```

* `--id`: the *Hardware ID* of the plugin.
* `--decode-b64`: decodes the entries the plugin stores encoded in Base64.
* `--entry`: displays a single entry, with a dotted path, for example `--entry ListOfDevices.b64-devicelist`.

### printLOD.py

Displays a `Data/DeviceList-<n>.txt` file one device at a time, one attribute per line, which is easier to read than the raw file. It asks for the file name:

```bash
python3 Tools/printLOD.py
Enter the DeviceList.txt filename:
Data/DeviceList-3.txt
```

------------------------------------------------
## Monitoring and access

### plugin-ping.py

Checks that the plugin is alive, by calling the `plugin-ping` command of its [REST API](Technical/REST-API.md) at regular intervals. As long as the plugin answers, it keeps running; when the plugin doesn't answer within one second, it stops with an error exit code. Use it in a watchdog script, which restarts Domoticz or sends you an alert when it ends.

```bash
python3 Tools/plugin-ping.py --ip 127.0.0.1 --port 9440 --check_period 300
```

* `--ip` and `--port`: where the plugin WebUI listens (default `127.0.0.1` and `9440`).
* `--check_period`: seconds between two checks (default `300`).
* `--silent`: print nothing.

It needs the Python module `requests`, and only works over http: it fails if the WebUI is served over https.

### generate_z4d_certificates.py

Creates a self-signed certificate and its key, so that the plugin serves the WebUI over https. Run it from the plugin folder: it creates `certs/server.crt` and `certs/server.key`, which is where the plugin looks for them by default (settings `SSLCertificate` and `SSLPrivateKey`, see [Settings](WebUI_Settings.md#plugin-environment-settings)). It needs the `openssl` command.

```bash
python3 Tools/generate_z4d_certificates.py
```

Restart the plugin: the WebUI is then at `https://<Domoticz server address>:9440/z4d/`. As the certificate is self-signed, your browser warns you the first time.

The certificate is valid for 365 days. The script doesn't replace existing files: to renew it, delete both files, run it again and restart the plugin. To use a certificate of your own instead, set `SSLCertificate` and `SSLPrivateKey` to its files.

------------------------------------------------
## Device firmware (OTA)

### ikea-ota-download.py

Downloads every firmware published by IKEA into the current folder. See [IKEA: downloading the whole catalogue](HowTo_Update-device-firmware.md#ikea-downloading-the-whole-catalogue).

### read_ota_headers.py

Displays the header of a Zigbee OTA firmware file: manufacturer code (and name, when known), image type, image version, sizes, header string, optional fields and the start of the file. Use it to check which device and which version a firmware file is for, before putting it in `OTAFirmware/` (see [Device firmware](HowTo_Update-device-firmware.md)).

```bash
python3 Tools/read_ota_headers.py OTAFirmware/IKEA-TRADFRI/<file>.ota
```

### ota_validator.py

For investigating a firmware transfer that fails. It compares the blocks actually sent to the device with the original firmware file, and reports gaps between blocks, blocks whose content differs, and whether the rebuilt image matches the file. The blocks come from:

* a Wireshark capture of the transfer, exported as JSON (`--wireshark-json`), and/or
* the trace the plugin writes when the `EnableOTATracing` setting is on: `ota_blocks_<device>_<image type>.log` in the plugin `Logs/` folder (`--trace-log`).

```bash
python3 Tools/ota_validator.py --trace-log Logs/ota_blocks_<device>_<image type>.log \
    --source OTAFirmware/<folder>/<file>.ota
```

Run it with `--help` for the options (filtering by device, first block only, rebuilding the image into a file with `--output`…).

------------------------------------------------
## Development

### hooks-pre-commit.sh

A git hook for people who change the plugin code: it runs the test suite (`pytest tests/`) before each commit, and cancels the commit if a test fails. Install it once from the plugin folder:

```bash
ln -s ../../Tools/hooks-pre-commit.sh .git/hooks/pre-commit
```

------------------------------------------------
## Legacy ZiGate tools

These tools are for ZiGate coordinators, which are no longer supported, and are not maintained:

* `pi-zigate.sh` (`run` or `flash`) and `PiZigate.service`: switch a PiZiGate between run and flash mode, at boot with the service. `Fedora/` holds the same for Fedora. See [PiZigate installation](Legacy_PiZigate-Installation.md).
* `JennicModuleProgrammer/` and `build-Jennic.sh`: the source of NXP's flash programmer for the JN5168 chip of the ZiGate, and the script that builds it. For the firmware update itself, see [Upgrading the ZiGate firmware](HowTo_Update-ZiGate-firmware.md).

------------------------------------------------
Back to the [wiki index](Readme.md).
