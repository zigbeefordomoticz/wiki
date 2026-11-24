# Plugin Update

"Update" can mean two different things — make sure you're following the right one:

* __Routine update__ — bug fixes and enhancements, staying on `stable9`. This is what this page covers.
* __Moving from `stable8` (or older) to `stable9`__ — a one-time, one-way switch to the Domoticz Extended Framework branch. This is *not* a routine update and has its own procedure: see [Upgrading from stable8 to stable9](HowTo_Upgrade-stable8-to-stable9.md) or [Upgrading from stable7 to stable9](HowTo_Upgrade-stable7-to-stable9.md).

Not sure which branch you are on? See [Know your branch](#know-your-branch).

Before updating, check that your Domoticz is recent enough: **Domoticz 2026.3 is the recommended version** (2025.1 is the minimum for `stable9`), see [Plugin installation](Plugin_Installation.md#requirements).

## Routine update

The plugin is regularly updated, for bug fixing or enhancement, without changing branch. Each release is tagged (`stable9-9.1.001`, `stable9-9.1.002`, ...) and described in `ReleaseNotes.md` in the plugin folder.

### From the WebUI (recommended)

The plugin can be updated from its own administration page. This is the recommended way: the update runs with the Python environment Domoticz uses, including a virtual environment: it is detected from `VIRTUAL_ENV`, from `PYTHONPATH`, or from the `python3` found in `PATH`, as in the official Docker image (see [Tools folder](Plugin_Tools-folder.md#plugin-auto-upgradesh)).

* Open the plugin Web Interface.
* Go to section [Admin > Plugin](WebUI_Admin.md#plugin).
* Click on the button **Upgrade** (**Start upgrade (can take several minutes)** before plugin 9.1.009).

  The plugin pulls the latest version of the branch you are on, then installs or upgrades the Python modules listed in `requirements.txt`. A box appears with the output of the update, as if you were running it from a terminal.

* When the update succeeds, the WebUI shows *Done. Restart the plugin to use the new version.*: click on **Restart now** (before plugin 9.1.009: "You can restart the plugin now", then the **Restart** button).

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

## Reduce the disk space used by the plugin

The folder `.git/objects/pack` of the plugin holds its git history: all the previous versions of the plugin files. It takes about 150 MB on a plain `git clone`, and more on an old installation. The plugin doesn't need it to run, but updates do: __don't delete these files__. If you already did, see [Make it much smaller, or repair it](#make-it-much-smaller-or-repair-it).

Don't do this while an update is running. If you installed the plugin with PyPluginStore, its folder is `plugins/Zigate`. With Docker, run the commands in the container (`docker exec -it domoticz bash`), in `/opt/domoticz/userdata/plugins/Domoticz-Zigbee`. Run the commands as the user who owns the plugin folder, or you may get a [`dubious ownership`](Problem_FAQ.md#e19-error-during-an-update--detected-dubious-ownership-in-repository-or-you-have-uncommitted-changes) error.

To see the size used:

```bash
cd /home/pi/domoticz/plugins/Domoticz-Zigbee
git count-objects -vH
```

`size-pack` is the history. `size-garbage` is what interrupted downloads left behind.

### Clean it

This removes the branches deleted on GitHub and the leftovers of interrupted downloads. It is enough on an installation that has grown over time; on a recent one it changes almost nothing. git needs free space for a second copy of the history while it works.

```bash
cd /home/pi/domoticz/plugins/Domoticz-Zigbee
git remote prune origin
git gc --prune=now
```

### Make it much smaller, or repair it

This replaces the history with a light one, of about 16 MB. Your configuration and data are not touched, but local branches and stashes are not carried over. It requires an Internet connection, about 35 MB of free space, and being on `stable9` (see [Know your branch](#know-your-branch)).

1. Update the plugin. `git status` must show no modified file. If you already deleted files of `.git/objects/pack`, skip this step.

   ```bash
   cd /home/pi/domoticz/plugins/Domoticz-Zigbee
   git pull
   git status
   ```

1. Get a light copy, __outside__ the `plugins` folder (Domoticz would see it as a second plugin), and use its `.git` folder:

   ```bash
   cd ~
   git clone -b stable9 --filter=blob:none https://github.com/zigbeefordomoticz/Domoticz-Zigbee.git z4d-new
   mv /home/pi/domoticz/plugins/Domoticz-Zigbee/.git ~/z4d-git-old && \
   mv ~/z4d-new/.git /home/pi/domoticz/plugins/Domoticz-Zigbee/.git
   ```

1. Check the result. `git status` must show no modified file; untracked files are not a problem.

   ```bash
   cd /home/pi/domoticz/plugins/Domoticz-Zigbee
   git status
   git pull
   ```

   After a repair, the plugin files may be older than the new history, and `git status` then shows modified files. Put them at the latest version with `git reset --hard`, which drops the changes you made to the plugin files, then [update the Python modules](#manually) and restart Domoticz.

1. When everything works, remove the two folders that are no longer needed:

   ```bash
   rm -rf ~/z4d-new ~/z4d-git-old
   ```

   Until then, you can undo: remove the new `.git` folder and move `~/z4d-git-old` back to `.git`.

### What not to do

* `git clone --depth 1` or `git fetch --depth=1`: the history comes back at the next update, and on an installation that is not up to date the next `git pull` can fail (`divergent branches`).
* `git reflog expire --expire=now --all`: it deletes your stashes, and doesn't free more space.
* `git gc --aggressive`: it used 1.5 GB of memory in our tests, too much for a small Raspberry Pi, for a limited gain.

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
