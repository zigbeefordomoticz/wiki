# Use a Python virtual environment for Domoticz

## Why

The plugin needs Python modules (zigpy and its radio libraries…) that are not part of your Linux distribution. Recent distributions (Debian 12, Raspberry Pi OS Bookworm and later) refuse `sudo pip install` into the system Python:

```log
error: externally-managed-environment

× This environment is externally managed
╰─> To install Python packages system-wide, try apt install
    python3-xyz, where xyz is the package you are trying to
    install.
    ...
```

The clean way is a Python **virtual environment** (venv) dedicated to Domoticz, in which you install the modules of the plugin (and of your other Python plugins), and which Domoticz uses when it starts.

**With the official Domoticz Docker image, there is nothing to do:** the image already runs Domoticz with a virtual environment (`/opt/venv`), and the plugin installs its modules there. See [Installation with Docker](How-To-Install-RPI-Docker.md).

## 1. Find the Python version of Domoticz

The plugin needs **Python 3.11 or newer**. The virtual environment must be built with **the same Python version** (major and minor) as the one Domoticz embeds. Look for this line in the Domoticz log, at start-up:

`Status: PluginSystem: Started, Python version '3.13.5', 10 plugin definitions loaded.`

Here Domoticz uses Python 3.13. Then check the default Python of your system:

```bash
python3 --version
```

If it gives the same minor version (here `3.13.x`), use `python3` below. Otherwise use the matching interpreter explicitly, for example `python3.13`.

> **Several plugin instances and Python 3.11:** running several instances of the plugin (several coordinators) with Domoticz 2026.x and Python 3.11 doesn't work because of a Python 3.11 problem ([domoticz/domoticz#6763](https://github.com/domoticz/domoticz/issues/6763)). If you build a new installation, prefer Python 3.12 or newer.

## 2. Install the prerequisites

```bash
sudo apt install python3-venv python3-dev
```

(or `python3-full`). With a specific version, install the matching packages, for example `python3.13-venv python3.13-dev`.

## 3. Create the virtual environment

In the examples below, Domoticz runs as the user `pi`, is installed in `/home/pi/domoticz`, and the virtual environment is `/home/pi/Domoticz_Python_Environment`. Adapt them to your installation.

```bash
cd /home/pi
python3 -m venv Domoticz_Python_Environment
source Domoticz_Python_Environment/bin/activate
pip install --upgrade pip
```

## 4. Install the plugin modules

With the virtual environment activated:

```bash
source /home/pi/Domoticz_Python_Environment/bin/activate
cd /home/pi/domoticz/plugins/Domoticz-Zigbee
python3 -m pip install -r requirements.txt --upgrade
```

Later, the plugin upgrade from the WebUI (*Admin > Plugin*) detects the virtual environment Domoticz runs with (`VIRTUAL_ENV`) and updates the modules there. See [Plugin update](Plugin_Update.md).

## 5. Start Domoticz with the virtual environment

Domoticz uses the virtual environment when it is started with the `VIRTUAL_ENV` and `PATH` environment variables pointing to it.

### With systemd (`domoticz.service`)

Add the two `Environment=` lines to the `[Service]` section:

```ini
[Unit]
Description=domoticz_service

[Service]
ExecStart=/home/pi/domoticz/domoticz -www 8080 -sslwww 443
Environment=VIRTUAL_ENV=/home/pi/Domoticz_Python_Environment
Environment=PATH=/home/pi/Domoticz_Python_Environment/bin:/usr/bin:/bin
WorkingDirectory=/home/pi/domoticz
ExecStartPre=setcap 'cap_net_bind_service=+ep' /home/pi/domoticz/domoticz
Restart=on-failure
RestartSec=1m

[Install]
WantedBy=multi-user.target
```

If the service uses an `EnvironmentFile=` (for example `/home/pi/domoticz.env`), add the two variables to that file instead:

```bash
VIRTUAL_ENV=/home/pi/Domoticz_Python_Environment
PATH=/home/pi/Domoticz_Python_Environment/bin:/usr/bin:/bin
```

Then reload and restart:

```bash
sudo systemctl daemon-reload
sudo systemctl restart domoticz
```

### With the `domoticz.sh` init script

In the `do_start()` function, before the line `start-stop-daemon --chuid $USERNAME --start --quiet --pidfile $PIDFILE --exec $DAEMON --test > /dev/null || return 1`, add:

```bash
export VIRTUAL_ENV=/home/pi/Domoticz_Python_Environment
export PATH="$VIRTUAL_ENV/bin:$PATH"
```

## 6. Check

At start-up, the plugin writes `VIRTUAL_ENV is set to: /home/pi/Domoticz_Python_Environment` in the Domoticz log. If it writes `VIRTUAL_ENV is not set`, Domoticz was not started with the virtual environment.

The official Docker image is the exception: it enables `/opt/venv` through `PATH` only, so the log says `VIRTUAL_ENV is not set` although the virtual environment is used.

## Older setups with PYTHONPATH

Before `stable8`, the modules were installed with `pip install -t <folder>` and found through a `PYTHONPATH` variable set in the Domoticz start script. This still works, but it is not the recommended setup any more. To move to a virtual environment:

1. Create the virtual environment and install the modules (steps 3 and 4).
1. In the Domoticz start script, remove the `PYTHONPATH` line and set `VIRTUAL_ENV` and `PATH` instead (step 5).
1. Restart Domoticz.

Coming from `stable7`: [Upgrading from stable7 to stable9](HowTo_Upgrade-stable7-to-stable9.md) covers this move together with the branch switch.
