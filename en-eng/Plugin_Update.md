# Plugin Update

"Update" can mean two different things — make sure you're following the right one:

* __Routine update__ — bug fixes and enhancements, staying on `stable9`. This is what this page covers.
* __Moving from `stable8` (or older) to `stable9`__ — a one-time, one-way switch to the Domoticz Extended Framework branch. This is *not* a routine update and has its own procedure: see [Upgrading from stable8 to stable9](HowTo_Upgrade-stable8-to-stable9.md) or [Upgrading from stable7 to stable9](HowTo_Upgrade-stable7-to-stable9.md).

Not sure which branch you are on? See [Know your branch](#know-your-branch).

Before updating, check that your Domoticz is recent enough: **Domoticz 2026.3 is the recommended version** (2025.1 is the minimum for `stable9`), see [Plugin installation](Plugin_Installation.md#requirements).

## Routine update

The plugin is regularly updated, for bug fixing or enhancement, without changing branch. Each release is tagged (`stable9-9.1.001`, `stable9-9.1.002`, ...) and described in `ReleaseNotes.md` in the plugin folder.

### From the WebUI (recommended)

The plugin can be updated from its own administration page. This is the recommended way: the update runs with the Python environment Domoticz uses, including a virtual environment (detected from `VIRTUAL_ENV`, as in the official Docker image, or from `PYTHONPATH`).

* Open the plugin Web Interface.
* Go to section [Admin > Plugin](WebUI_Admin.md#plugin).
* Click on the button **Start upgrade (can take several minutes)**.

  The plugin pulls the latest version of the branch you are on, then installs or upgrades the Python modules listed in `requirements.txt`. A box appears with the output of the update, as if you were running it from a terminal.

* When the update succeeds, the WebUI shows "You can restart the plugin now": click on the **Restart** button.

If the update fails, read the output in the box, then update manually.

### Manually

1. Go to the plugin folder (usually `/home/pi/domoticz/plugins/Domoticz-Zigbee`) and get the latest version:

   ```bash
   cd /home/pi/domoticz/plugins/Domoticz-Zigbee
   git pull
   ```

1. Update the Python modules **in the Python environment Domoticz uses**. With the virtual environment of [Using Python Virtual Environment](HowTo_PythonVirtualEnv.md):

   ```bash
   source /home/pi/Domoticz_Python_Environment/bin/activate
   python3 -m pip install -r requirements.txt --upgrade
   ```

   Don't use `sudo python3 -m pip install ...` on the system Python: it installs the modules where Domoticz may not look for them, and recent Debian / Raspberry Pi OS releases refuse it (`externally-managed-environment`).

1. Restart Domoticz:

   ```bash
   sudo systemctl restart domoticz
   ```

With Docker, run the same commands inside the container (the official image has a virtual environment already active):

```bash
docker exec -it domoticz bash -c "cd /opt/domoticz/userdata/plugins/Domoticz-Zigbee && git pull && python3 -m pip install -r requirements.txt --upgrade"
docker restart domoticz
```

### In case of error

If you have edited some of the files controlled by the plugin, `git pull` refuses to update. You can reset those files to the latest version with the following commands. Your configuration and data (`Conf/PluginConf-*.json`, `Data/`, `Reports/`, `Conf/Local-Devices/`) are not under git control and are kept.

```bash
git reset --hard
git pull --force
```

## Know your branch

From the plugin folder:

```bash
git status
```

The first line tells you the branch, for example `On branch stable9`. `git describe --tags` gives the closest release tag, for example `stable9-9.1.007`.

## Go back to a previous version

If a new release causes a problem, you can go back to a previous release of `stable9` while waiting for a fix. Take a [backup](Plugin_Backup.md) first.

```bash
cd /home/pi/domoticz/plugins/Domoticz-Zigbee
git fetch --tags
git checkout stable9-9.1.006
```

Then reinstall the Python modules of that version (see [Manually](#manually)) and restart Domoticz. Please report the problem on [GitHub](https://github.com/zigbeefordomoticz/Domoticz-Zigbee/issues).

To come back to the latest version:

```bash
git checkout stable9
git pull
```

Don't go back to a `stable8` (or older) tag: moving to `stable9` is one-way as soon as you have paired a device on `stable9` (see [Upgrading from stable8 to stable9](HowTo_Upgrade-stable8-to-stable9.md)).

## Plugin branches

The plugin is under constant development in order to bug fix and add new features as well as taking into account new devices. As Domoticz evolves, it is not possible to keep the plugin compatible with every older Domoticz release, so each major version has its own branch.

| Branch | Status | Versions | Requirements |
| :----- | :----- | :------- | :----------- |
| `stable9` | **Current production branch** | 9.1.xxx | Domoticz 2025.1 minimum, **2026.3 recommended**; Python 3.11+ |
| `stable8` | Out of support, locked | 8.1.xxx | Domoticz 2025.2+, Python 3.11+ |
| `stable7` | Out of support, locked | 7.1.xxx | Domoticz 2023.1+, Python 3.9+ |
| `stable6` and older | Out of support | | |

### stable9

This is the default branch, and the one every user should be on. It is built exclusively on the **Domoticz Extended Framework** (`DomoticzEx`), available since Domoticz 2025.1.

If you are still on `stable8` or older, move to `stable9` with the dedicated tool, not with `git checkout`: see [Upgrading from stable8 to stable9](HowTo_Upgrade-stable8-to-stable9.md) or [Upgrading from stable7 to stable9](HowTo_Upgrade-stable7-to-stable9.md).

### stable8 and older

These branches don't receive updates any more. `stable8` used the legacy Domoticz widget model.

### Development branches

The other branches of the repository are development branches. __Don't switch to them unless you are asked to__, for example to test a fix.
