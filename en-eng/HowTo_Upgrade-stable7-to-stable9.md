# Upgrading from stable7 to stable9

`stable7` is out of support and locked, and so is `stable8`. Go **directly from `stable7` to `stable9`**, the current production branch: there is no need to stop on `stable8`. Your devices, groups and settings are kept, and you don't have to pair your devices again.

Compared with [the move from stable8](HowTo_Upgrade-stable8-to-stable9.md), two things make this upgrade bigger:

* **The requirements are higher.** `stable9` needs **Python 3.11 or newer** and **Domoticz 2025.1 or newer** (2026.3 recommended). `stable7` ran with Python 3.9 and Domoticz 2023.1, so many `stable7` installations run on a distribution that is too old, such as Debian 11 *Bullseye* or Raspberry Pi OS *Bullseye* (Python 3.9), or older.
* **The Python virtual environment becomes mandatory.** Many `stable7` installations put the Python modules into the system Python (`sudo pip3 install ...`) or into a folder found through `PYTHONPATH`. With `stable9`, install them in a [Python virtual environment](HowTo_PythonVirtualEnv.md) (venv) used by Domoticz. Recent distributions refuse `sudo pip install` anyway (`externally-managed-environment`), and the modules of an old Python can't be reused by a newer one.

## Before you start — this is a one-way move

* The switch is **forward compatible**: it doesn't modify or recreate your existing devices. Everything paired under `stable7` keeps working.
* Any device you pair **after** the switch is created under the Domoticz Extended Framework by `stable9`, and can't be used by `stable7`. As soon as you pair one new device on `stable9`, going back to `stable7` stops being an option.
* **ZiGate users:** ZiGate coordinators are no longer supported by the plugin. Read [ZiGate (legacy)](Coordinators.md#zigate-legacy) before you upgrade.

## Step 0 — Which path is yours?

Check two versions:

1. **The Python version Domoticz runs with.** Look for this line in the Domoticz log at start-up:

   `Status: PluginSystem: Started, Python version '3.9.2', 10 plugin definitions loaded.`

1. **The Domoticz version**, in *Setup > About*.

Then:

| Your system | Path |
| :---------- | :--- |
| Domoticz runs with **Python 3.11 or newer** (Debian 12 *Bookworm*, Debian 13 *Trixie*, Raspberry Pi OS Bookworm/Trixie, Ubuntu 24.04…) | [Path A — upgrade in place](#path-a--upgrade-in-place). If Domoticz is older than 2025.1, you upgrade it in step A.2. |
| Domoticz runs with **Python 3.10 or older** (Debian 11 *Bullseye* or older, Raspberry Pi OS Bullseye or older, Ubuntu 22.04 or older) | [Path B — move to a new system](#path-b--move-to-a-new-system). |
| **Docker** (official `domoticz/domoticz` image) | [Path C — Docker](#path-c--docker). |

Path B is needed because these distributions don't provide Python 3.11, and recent official Domoticz builds no longer run on them (they need OpenSSL 3). Building your own Python or Domoticz on an old distribution is not supported by the plugin team.

------------

## Path A — upgrade in place

The examples use the paths of [Plugin installation](Plugin_Installation.md): Domoticz in `/home/pi/domoticz`, the plugin in `/home/pi/domoticz/plugins/Domoticz-Zigbee`, the virtual environment in `/home/pi/Domoticz_Python_Environment`. Adapt them to your installation.

### A.1 — Back up Domoticz and the plugin

`stable7` doesn't have the backup scripts, so make a manual backup. Stop Domoticz, then copy, **at the same time**:

* the Domoticz database, `domoticz.db`;
* the plugin files:

  ```
  Data/*
  Conf/PluginConf-*.json
  Conf/Local-Devices/*      (only if you added your own device files)
  Reports/*                 (optional)
  ```

For example:

```bash
sudo systemctl stop domoticz
mkdir -p /home/pi/backup-stable7
cp /home/pi/domoticz/domoticz.db /home/pi/backup-stable7/
cp -r /home/pi/domoticz/plugins/Domoticz-Zigbee /home/pi/backup-stable7/
sudo systemctl start domoticz
```

If anything goes wrong before you pair a new device, restoring both brings you back exactly where you started. See [Backup and restore](Plugin_Backup.md).

### A.2 — Upgrade Domoticz if needed

If *Setup > About* shows a version older than 2025.1, upgrade Domoticz now (2026.3 is recommended), and do it right before the plugin switch. Check again in the Domoticz log that Python is still 3.11 or newer.

### A.3 — Check how Domoticz finds the Python modules

With Domoticz running, look at the environment it was started with:

```bash
sudo cat /proc/$(pidof domoticz)/environ | tr '\0' '\n' | grep -E '^(VIRTUAL_ENV|PYTHONPATH|PATH)='
```

* `VIRTUAL_ENV=...` is listed: Domoticz already uses a virtual environment. Note its path and go to [A.4](#a4--switch-the-plugin-code-to-stable9).
* `PYTHONPATH=...` is listed, or neither of them: the modules are in a `PYTHONPATH` folder or in the system Python. You **set up a virtual environment** in [A.5](#a5--install-the-python-modules-in-a-virtual-environment) and [A.6](#a6--start-domoticz-with-the-virtual-environment).

The start configuration of Domoticz is in `systemctl cat domoticz` (systemd service), or in `/etc/init.d/domoticz.sh` (old init script).

### A.4 — Switch the plugin code to stable9

The switch tool, `Tools/plugin-switch-stable9.sh`, is in `stable8` and not in `stable7`. Check out `stable8` only to get it, and run it right away. Domoticz must be running: the tool checks your Domoticz version through the Domoticz API.

```bash
cd /home/pi/domoticz/plugins/Domoticz-Zigbee
git status                       # must show no modified file
git fetch origin
git checkout stable8
Tools/plugin-switch-stable9.sh   # shows the migration notice and checks the Domoticz version; changes nothing
```

Read the notice. When you are ready:

```bash
Tools/plugin-switch-stable9.sh --i-understand
```

It ends with `Successfully switched to stable9 branch`. Check with `git status`: the first line must be `On branch stable9`. The options of the tool (`--ip`, `--port`) and its errors are described in [Upgrading from stable8 to stable9](HowTo_Upgrade-stable8-to-stable9.md#step-2--read-the-migration-notice-no-changes-made).

Don't restart Domoticz yet: the Python modules of `stable9` are not installed.

### A.5 — Install the Python modules in a virtual environment

If Domoticz already uses a virtual environment, just activate it and install the modules (last block below).

Otherwise create one, **with the Python version Domoticz uses** (the version from step 0; use `python3.11`, `python3.13`… instead of `python3` if your default `python3` is another version):

```bash
sudo apt install python3-venv python3-dev
cd /home/pi
python3 -m venv Domoticz_Python_Environment
source Domoticz_Python_Environment/bin/activate
pip install --upgrade pip
```

Then install the modules of `stable9` in the virtual environment:

```bash
source /home/pi/Domoticz_Python_Environment/bin/activate
cd /home/pi/domoticz/plugins/Domoticz-Zigbee
python3 -m pip install -r requirements.txt --upgrade
```

Run these commands as the user Domoticz runs as (here `pi`), not with `sudo`.

Install the modules of your other Python plugins in the same virtual environment as well: once Domoticz starts with it, they are looked up there.

### A.6 — Start Domoticz with the virtual environment

If Domoticz already used a virtual environment, skip to [A.7](#a7--restart-and-check).

Otherwise, add `VIRTUAL_ENV` and `PATH` to the Domoticz start configuration, and **remove any `PYTHONPATH` line** you had for the plugin. With systemd:

```ini
[Service]
Environment=VIRTUAL_ENV=/home/pi/Domoticz_Python_Environment
Environment=PATH=/home/pi/Domoticz_Python_Environment/bin:/usr/bin:/bin
```

The full service file, the `EnvironmentFile=` variant and the `domoticz.sh` init script are in [Start Domoticz with the virtual environment](HowTo_PythonVirtualEnv.md#5-start-domoticz-with-the-virtual-environment).

### A.7 — Restart and check

```bash
sudo systemctl daemon-reload
sudo systemctl restart domoticz
```

Restart Domoticz itself, not only the plugin. Then check the Domoticz log:

* `VIRTUAL_ENV is set to: /home/pi/Domoticz_Python_Environment`: Domoticz uses the virtual environment. If you see `VIRTUAL_ENV is not set`, step A.6 didn't apply: check the service file and run `daemon-reload` again.
* `Z4D starts with ... and using DomoticzEx !`: the plugin runs `stable9`.
* No `Z4D requires Python 3.11` error, and no `ModuleNotFoundError`.

Your devices come back as before. From now on, update the plugin from the WebUI ([Admin > Plugin](WebUI_Admin.md#plugin)): it detects the virtual environment and updates the modules there (see [Plugin update](Plugin_Update.md)).

### A.8 — Clean up the old installation (optional)

Once everything works, the modules installed for `stable7` are no longer used:

* a `PYTHONPATH` folder: you can delete it;
* modules installed in the system Python with `sudo pip3 install`: remove at least the plugin ones, so that an old zigpy can never be loaded instead of the one in the virtual environment:

  ```bash
  sudo python3 -m pip uninstall zigpy zigpy-znp zigpy-deconz zigpy-blz bellows zigpy-cli z4d-certified-devices
  ```

  On Debian 12 and newer, add `--break-system-packages`. Don't remove modules your other software may need.

------------

## Path B — move to a new system

Your distribution is too old for `stable9`. Install a supported one: Raspberry Pi OS or Debian 12 *Bookworm* or 13 *Trixie*, or Ubuntu 24.04. A **fresh install** is recommended over an in-place distribution upgrade, which is outside the scope of this page. Use a new SD card or disk if you can: the old system stays intact, and you can go back to it if needed.

### B.1 — Back up the old system

On the old system, stop Domoticz, then copy off the machine:

* `domoticz.db`;
* the plugin files `Data/*`, `Conf/PluginConf-*.json`, `Conf/Local-Devices/*` (if you added your own device files) and `Reports/*` (optional);
* your Domoticz start configuration (`/etc/systemd/system/domoticz.service` or `/etc/init.d/domoticz.sh`), your scripts, and the backups of your other plugins.

Note the serial port of the coordinator in Domoticz (*Setup > Hardware*, plugin hardware, *Serial Port*).

The Zigbee network itself is stored in the coordinator: plug the same coordinator into the new system and the devices stay paired.

### B.2 — Install Domoticz on the new system

Install Domoticz 2026.3 (recommended) following the [Domoticz documentation](https://www.domoticz.com/wiki/Linux). Start it once, then stop it, and replace its `domoticz.db` with the one from your backup. Domoticz updates the database to its new version at the next start.

### B.3 — Install the plugin with a virtual environment

Don't start Domoticz yet. Follow [Manual installation on Linux](Plugin_Installation.md#1---manual-installation-on-linux): clone the `stable9` branch, create the virtual environment, install the modules in it, and make Domoticz start with it (`VIRTUAL_ENV` and `PATH`). On the new system, the virtual environment is the only supported setup: don't install the modules with `sudo pip`, and don't use `PYTHONPATH`.

There is no branch switch to do: you start directly on `stable9`.

### B.4 — Restore the plugin data

Copy the plugin files from your backup into the new plugin folder, **before** the first start of Domoticz:

```bash
cd /home/pi/domoticz/plugins/Domoticz-Zigbee
cp /path/to/backup/Data/* Data/
cp /path/to/backup/Conf/PluginConf-*.json Conf/
cp -r /path/to/backup/Conf/Local-Devices/* Conf/Local-Devices/   # if you had some
cp /path/to/backup/Reports/* Reports/                             # optional
sudo chown -R pi:pi .
```

Keep the same plugin hardware in Domoticz (it comes with `domoticz.db`): its hardware ID is in the names of the files above.

### B.5 — Start and check

Plug in the coordinator and start Domoticz. If the serial port name changed on the new system, fix it in *Setup > Hardware* (prefer the `/dev/serial/by-id/...` path, which doesn't change between reboots).

Check the Domoticz log as in [A.7](#a7--restart-and-check): `VIRTUAL_ENV is set to: ...`, then `Z4D starts with ... and using DomoticzEx !`.

------------

## Path C — Docker

The official `domoticz/domoticz` image already runs Domoticz with a recent Python in a virtual environment (`/opt/venv`): there is no venv to set up.

1. Back up the folder mapped to `/opt/domoticz/userdata` (it holds `domoticz.db` and `plugins/Domoticz-Zigbee`), with the container stopped.
1. Update the image to Domoticz 2025.1 or newer (2026.3 recommended) and recreate the container.
1. Switch the plugin code, from a shell in the container (Domoticz must be running):

   ```bash
   docker exec -it domoticz bash
   cd /opt/domoticz/userdata/plugins/Domoticz-Zigbee
   git fetch origin
   git checkout stable8
   Tools/plugin-switch-stable9.sh
   Tools/plugin-switch-stable9.sh --i-understand
   python3 -m pip install -r requirements.txt --upgrade
   exit
   ```

1. Restart the container: `docker restart domoticz`.

If you use `customstart.sh`, copy the `stable9` version again, as it may have changed: `cp userdata/plugins/Domoticz-Zigbee/Tools/customstart.sh userdata/customstart.sh`. See [Installation on Docker](Plugin_Installation.md#2---installation-on-docker).

------------

## If something goes wrong

* **`git checkout stable8` refuses** (`Your local changes ... would be overwritten`): put your changes aside with `git stash -u`, or reset them as in [Plugin update](Plugin_Update.md#in-case-of-error). Your data (`Data/`, `Conf/PluginConf-*.json`, `Conf/Local-Devices/`) is not under git control and is kept.
* **`Z4D requires Python 3.11, found 3.9`**: Domoticz still runs with the old Python. Your system needs [Path B](#path-b--move-to-a-new-system).
* **`ModuleNotFoundError`** at start-up, or `VIRTUAL_ENV is not set`: Domoticz doesn't use the virtual environment where you installed the modules. Check [A.6](#a6--start-domoticz-with-the-virtual-environment), and that the venv was created with the same Python version as Domoticz.
* **`error: externally-managed-environment`** when installing the modules: you ran `pip` outside the virtual environment. Activate it first (`source .../bin/activate`).
* **Errors of the switch tool** (Domoticz version, connection to Domoticz): see [Upgrading from stable8 to stable9](HowTo_Upgrade-stable8-to-stable9.md#if-something-goes-wrong).
* **You want to go back to `stable7`** (only if you haven't paired a new device on `stable9`): stop Domoticz, restore the backup of step A.1 or B.1, including the Domoticz start configuration, then start Domoticz. On Path B, simply go back to the old SD card or disk.

## See also

* [Upgrading from stable8 to stable9](HowTo_Upgrade-stable8-to-stable9.md)
* [Use a Python virtual environment for Domoticz](HowTo_PythonVirtualEnv.md)
* [Plugin installation](Plugin_Installation.md) — requirements of `stable9`
* [Backup and restore](Plugin_Backup.md)
* [Plugin update](Plugin_Update.md) — routine updates once you are on `stable9`
