# Upgrading from stable8 to stable9

`stable9` is the current production branch of the plugin. `stable8` is out of support and locked: it receives no more updates, not even bug fixes. All development continues on `stable9`, which is built exclusively on the **Domoticz Extended Framework** (`DomoticzEx`), available since Domoticz 2025.1.

The switch is done with a single tool provided in the plugin itself: `Tools/plugin-switch-stable9.sh`. Do not switch branch manually with `git checkout stable9` — this script checks your Domoticz version, shows you the migration notice, and only proceeds once you've explicitly acknowledged it.

## Before you start — this is a one-way move

* The switch itself is **forward compatible**: it does not modify or recreate any of your existing devices. Everything you have paired under `stable8` keeps working exactly as before.
* But any device you pair **after** switching is created directly under the Extended Framework by `stable9`. Such new devices are **not** compatible with `stable8`'s legacy widget model.
* As soon as you pair one new device on `stable9`, going back to `stable8` stops being an option.

Only run the switch once you're ready to commit to `stable9`.

Still on `stable7`? Follow [Upgrading from stable7 to stable9](HowTo_Upgrade-stable7-to-stable9.md) instead: it goes straight to `stable9`.

## Step 0 — Check your Python and Domoticz versions first

Do this **before anything else**, before the backup and before the switch. `stable9` needs:

* **Python 3.11 or newer**, the Python that Domoticz runs with. On an older Python, `stable9` refuses to start (`Z4D requires Python 3.11, found 3.9`). The switch tool does **not** check the Python version.
* **Domoticz 2025.1 or newer** (2026.3 recommended).

`stable8` itself runs with Python 3.9 and Domoticz 2023.1, so a working `stable8` installation doesn't prove that your system is ready.

1. **The Python version Domoticz runs with.** Look for these lines in the Domoticz log at start-up:

   `Status: PluginSystem: Started, Python version '3.9.2', 10 plugin definitions loaded.`

   `Status: Zigbee: Z4D requires python3.11 or above and you are running 3.9`

   The first one comes from Domoticz, the second one from the `stable8` plugin (`Zigbee` is the name of your plugin hardware). The version of `python3` in a terminal is not always the one Domoticz uses: rely on the log. See [Find the Python version of Domoticz](HowTo_PythonVirtualEnv.md#1-find-the-python-version-of-domoticz).

1. **The Domoticz version**, in *Setup > About*.

Then:

| Your system | What to do |
| :---------- | :--------- |
| Python **3.11 or newer** and Domoticz **2025.1 or newer** | Go on with the [prerequisites](#prerequisites) and [Step 1](#step-1--back-up-domoticz-and-the-plugin-first). |
| Python **3.11 or newer**, Domoticz **older than 2025.1** | Upgrade Domoticz first (2026.3 recommended), then check the Python version in the log again. |
| Python **3.10 or older** (Debian 11 *Bullseye* or older, Raspberry Pi OS Bullseye or older, Ubuntu 22.04 or older) | **Don't switch.** Your system is too old for `stable9`: move to a new system as described in [Path B of the stable7 page](HowTo_Upgrade-stable7-to-stable9.md#path-b--move-to-a-new-system). It applies to `stable8` in the same way. |
| **Docker** (official `domoticz/domoticz` image) | The image comes with a recent Python. Update the image to Domoticz 2025.1 or newer first. |

These distributions don't provide Python 3.11, and recent official Domoticz builds no longer run on them (they need OpenSSL 3). Building your own Python or Domoticz on an old distribution is not supported by the plugin team.

## Prerequisites

* Python **3.11 or newer** and Domoticz **2025.1 or newer**, with the Extended Framework available, as checked in [Step 0](#step-0--check-your-python-and-domoticz-versions-first). `plugin-switch-stable9.sh` checks the Domoticz version again through the Domoticz JSON API, and refuses to switch if it is too old. **Domoticz 2026.3 is the recommended version** for the best experience with the Extended Framework.
* Your plugin checkout must currently be on `stable8`, with no uncommitted local changes (`git status` clean). Commit or stash anything pending first.

## Step 1 — Back up Domoticz and the plugin first

Because this move is one-way as soon as you pair a new device (see above), take a full backup **before** switching, not after:

* Stop Domoticz.
* Back up the Domoticz database (`domoticz.db`) itself.
* Back up the plugin's critical files, **at the same time** as the database so the two stay consistent — see [Plugin Backup](Plugin_Backup.md) for the full list and procedure:

  ```
  Conf/PluginConf-*.json
  Data/*
  Reports/*
  ```

* Restart Domoticz once the backup is done.

This way, if anything looks wrong right after the switch, you can restore both the database and the plugin files and be back exactly where you started — as long as you haven't paired a new device yet on `stable9`.

## Step 2 — Read the migration notice (no changes made)

**Domoticz (and the plugin) must be up and running** at this point — the script checks your version by calling Domoticz's own JSON API, so it needs to be reachable. If you stopped Domoticz for the backup in Step 1, restart it first.

From your plugin directory (the one containing `Tools/`), run the script with **no arguments**:

```bash
Tools/plugin-switch-stable9.sh
```

This:

* Displays the full migration notice (English and French).
* Queries Domoticz at `127.0.0.1:8080` (the default) to confirm your version supports the Extended Framework.
* Makes **no** change to git or to your installation — it's purely informational.

If Domoticz runs on a different host/port, pass `--ip` and `--port`:

```bash
Tools/plugin-switch-stable9.sh --ip 192.168.1.10 --port 8080
```

If you run Domoticz in Docker and invoke the script from the Docker **host** (not via `docker compose exec`), `127.0.0.1` on the host only reaches Domoticz if that port is published to the host. Either:

* run the script inside the container, matching the pattern used by `Tools/update_domoticz_docker_container.sh`, e.g.:

  ```bash
  docker compose exec <container> bash -c "cd <plugin_dir> && Tools/plugin-switch-stable9.sh"
  ```

* or pass `--ip`/`--port` matching the host-published address.

If the script cannot reach Domoticz at all, it falls back to asking you to confirm the version manually via **Setup > About** in Domoticz rather than assuming success.

## Step 3 — Perform the switch

**Domoticz (and the plugin) must still be up and running** — the script re-checks your Domoticz version the same way it did in Step 2. Keep it running afterward too: Step 4's WebUI upgrade is a plugin action, so it isn't possible unless Domoticz and the plugin are up.

Once you've read the notice and are ready to proceed, re-run the script with `--i-understand`:

```bash
Tools/plugin-switch-stable9.sh --i-understand
```

This is the only flag that actually triggers the switch — it's meant to be typed explicitly, on the command line, by a person who read the notice. The script then:

1. Re-checks the Domoticz version (aborts if it's older than 2025.1).
2. Verifies there are no uncommitted local changes.
3. Runs `git fetch origin` and pulls the latest changes on your current branch.
4. Checks out `stable9` and pulls its latest changes.

On success you'll see:

```
Successfully switched to stable9 branch
```

along with the same one-way reminder from the notice above.

## Step 4 — Update the Python modules and restart

`plugin-switch-stable9.sh` only switches the git branch — it does **not** install/upgrade Python dependencies. `stable9` can require newer module versions than `stable8`, so before restarting, use the plugin's own upgrade action to bring the Python environment in line:

* Open the plugin Web Interface.
* Go to [Admin > Plugin](WebUI_Admin.md#plugin).
* Click **Start upgrade** (**Upgrade** from plugin 9.1.009). This installs/upgrades everything listed in `requirements.txt` for the `stable9` code now checked out (see [Plugin Update](Plugin_Update.md#from-the-webui-recommended)), using whichever Python environment the plugin itself is configured to run under — including a venv, if you use one.
* Once it completes, click **Restart** (**Restart now** from plugin 9.1.009).

Use the WebUI action rather than running `pip install` yourself from a terminal: a manual `pip install` targets whatever `python3` resolves to in your shell, which may not be the same interpreter/venv Domoticz actually runs the plugin with.

## If something goes wrong

* **"You have uncommitted changes"**: commit or stash them (`git stash -u`), then re-run the script.
* **"Domoticz version requirement not met"**: upgrade Domoticz to 2025.1 or newer first — the plugin will fail to start on `stable9` otherwise.
* **`Z4D requires Python 3.11, found 3.9`** after the restart: Domoticz runs with a Python that is too old for `stable9` (see [Step 0](#step-0--check-your-python-and-domoticz-versions-first)). You can't fix it with the plugin: move to a new system as in [Path B of the stable7 page](HowTo_Upgrade-stable7-to-stable9.md#path-b--move-to-a-new-system), or go back to `stable8`: `git checkout stable8`, then restore the backup of Step 1.
* **Version check can't connect to Domoticz**: pass `--ip`/`--port`, or confirm your version manually via **Setup > About**, then re-run with `--i-understand` once you're sure.

## See also

* [Plugin Update](Plugin_Update.md) — general plugin update process
* [Plugin Installation](Plugin_Installation.md) — Domoticz/Python version requirements
