# Using Python Virtual Environment with Domoticz and Zigbee 4 Domoticz Plugin

## Why ?

It looks like recent linux distribution will prevent using `sudo python3 -m pip` installation. This is mainly driven to prevent any risk of breaking the system by overwriting libraries that where part of tools writen in Python with the system.

To proper install the python libraries and applications required for the Z4D plugin, we need to create a virtual environment dedicated to __Domoticz__ and store all python modules/libraries required for the various python plugins.

This would prevent error messages like that one:

```log
error: externally-managed-environment

× This environment is externally managed
╰─> To install Python packages system-wide, try apt install
    python3-xyz, where xyz is the package you are trying to
    install.

    If you wish to install a non-Debian-packaged Python package,
    create a virtual environment using python3 -m venv path/to/venv.
    Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make
    sure you have python3-full installed.

    For more information visit http://rptl.io/venv

note: If you believe this is a mistake, please contact your Python installation or OS distribution provider. You can override this, at the risk of breaking your Python installation or OS, by passing --break-system-packages.
hint: See PEP 668 for the detailed specification.
```

## Create your python environment for Domoticz

### What is the python version running under Domoticz

Search for below the message in the Domoticz log:

`Status: PluginSystem: Started, Python version '3.10.11', 10 plugin definitions loaded.`

Conclusion: Domoticz is running python3.10 as thepython interpreter for all python plugins.

Check what is the default python3 interpreter version.

`python3 --version`

If you get : `Python 3.10.11` in response to the command, then you have the default python3 interpreter matching the Domoticz one. If you get a different answer like `Python 3.12.7` it means that Domoticz is running a lower python interpreter than the default on your system (which is not a problem), and therefore you must install the libraries for the right interpreter version, in this case 3.10 and not 3.12, in a separate Python environment for Domoticz. To do so, don't use python3 but python3.10 instead to specify the version you need to use.

### Create the python environment

assuming that you have a user __pi__ with the home directory __/home/pi__

We are suggesting to create the Domoticz Python Environment in the Domoticz home directory such as __/home/pi__

__note__ if you have to use a specific version use `python3.xx` instead of `python3`

1. setup venv

    assuming :

    - user: pi
    - user home directory: /home/pi
    - Setup the venv directory: /home/pi/Domoticz_Python_Environment
    - Domoticz is installed under: /home/pi/domoticz

    ```bash
    cd /home/pi
    mkdir Domoticz_Python_Environment
    python3 -m venv Domoticz_Python_Environment
    source Domoticz_Python_Environment/bin/activate
    pip install --upgrade pip
    ````

### Prior Stable8

We relied on PYTHONPATH to find the path to the python3 modules

1. Install Z4D required python modules

```bash
cd /home/pi/domoticz/plugins/Domoticz-Zigbee
python3 -m pip install -r requirements.txt --upgrade -t /home/pi/Domoticz_Python_Environment
```

1. Add the definition for the PYTHONPATH environment variable in the script which automaticaly start Domoticz.

 For more information you can have a look to [Domoticz Linux wiki page](https://wiki.domoticz.com/Linux) and especially in the section _Starting Domoticz automatically when the system boots_ .

If you are in __Option 1__ , you can simply edit the `/etc/init.d/domoticz.sh` file and add an extra line such as:

```export PYTHONPATH=/home/pi/Domoticz_Python_Environment:$PYTHONPATH```

### From Stable8

We rely on the standard VENV root via VIRTUAL_ENV

1. Install Z4D required python modules

if not yet done `source Domoticz_Python_Environment/bin/activate`, to use the venv.

```bash

cd /home/pi/domoticz/plugins/Domoticz-Zigbee
python3 -m pip install -r requirements.txt --upgrade 
```

Finaly we need to arrange the way to start Domoticz

1. using systemd: domoticz.service

    ```systemd
    [Unit]
          Description=domoticz_service
    [Service]
          #User=pi
          #Group=users
          ExecStart=/home/pi/domoticz/domoticz -www 8080 -sslwww 443
          Environment=VIRTUAL_ENV=/opt/domoticz/Domoticz_Python_Environment
          Environment=PATH=/opt/domoticz/Domoticz_Python_Environment/bin:/usr/bin:/bin
          #EnvironmentFile=/home/pi/domoticz.env
          WorkingDirectory=/home/pi/domoticz
          ExecStartPre=setcap 'cap_net_bind_service=+ep' /home/pi/domoticz/domoticz
          Restart=on-failure
          RestartSec=1m
          #StandardOutput=null
    [Install]
          WantedBy=multi-user.target
    ```

    In case you are using `EnvironmentFile=/home/pi/domoticz.env` just add the 2 following lines in the `/home/pi/domoticz.env`file

    ```bash
    VIRTUAL_ENV=/opt/domoticz/Domoticz_Python_Environment
    PATH=/opt/domoticz/Domoticz_Python_Environment/bin:/usr/bin:/bin
    ```

    Reload and start

    ```bash
    sudo systemctl daemon-reexec
    sudo systemctl daemon-reload
    sudo systemctl restart domoticz
    ```

1. using domoticz.sh

    Place the following line before `start-stop-daemon --chuid $USERNAME --start --quiet --pidfile $PIDFILE --exec $DAEMON --test > /dev/null || return 1` dans la fonction do_start()

    ```bash
    export VIRTUAL_ENV=/opt/domoticz/Domoticz_Python_Environment
    export PATH="$VIRTUAL_ENV/bin:$PATH"
    ```
