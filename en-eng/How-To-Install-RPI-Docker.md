# Install Zigbee for Domoticz plugin (under Docker on a RPi bare metal)

## 1. Assumptions & Prerequisites

The here after installation steps are based on Domoticz setup as documented [domoticz/domoticz - Docker](https://hub.docker.com/r/domoticz/domoticz)
We assumed here , that you you have access to Domoticz UI via a Web browser.

Docker and docker-compose installed.

User must be part of the docker group (so they don’t need sudo everywhere)

In the here documentation, the guide assumes the container name = domoticz

It is highly recommended to setup a python venv

1. create folder to host the python virtual environment

```bash
mkdir /opt/domoticz/Domoticz_Python_Environment
```

Nothing else to be done, as the provided customstart.sh will do the proper setup.

## 2. Install plugin & configuration

1. Start domoticz if not yet started

    ```bash
    docker-compose up -d
    ```

When the container is started, and you have Domoticz access via a browser, we can start the installation procedure.
The idea is to install the plugin inside the container, to prevent having to install git under the bar metal system.

1. Open a shell in the container `docker exec -it domoticz /bin/bash`

1. clone the Z4D plugin

    ```bash
    cd /opt/domoticz/userdata/plugins/
    git clone https://github.com/zigbeefordomoticz/Domoticz-Zigbee.git
    ```

1. Provide the Zigbee dongle port to the container.

    1. stop the container `docker-compose down`

    1. Identify the Serial line port

    ```bash
    ls -l /dev/serial/by-id/
    total 0
    lrwxrwxrwx 1 root root 13 Dec 11 22:19 usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0 -> ../../ttyUSB0
    ```

    In this exemple the Zigbee USB Dongle SonOff P is /dev/serial/by-id/usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0, that I'll add in the devices section of the docker-compose.yml file.

    The syntax to be used is `<host port>:<container port>`

    * __host port__ is `/dev/serial/by-id/usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0`
    * __container port__ is the port name you want to see inside the container, `/dev/ttyUSB0` ( you can choose what ever you want)

    1. edit the file docker-compose.yml

    userdata must be mapped as a volume for plugins & DB persistence.
    Otherwise everything installed in /opt/domoticz/userdata inside the container will vanish after a rebuild.

    ```bash
    vi /opt/domoticz/docker-compose.yml
    ```

    this should look similar to that one.

    ```bash
    services:
      domoticz:
        image: domoticz/domoticz:stable
        container_name: domoticz
        restart: unless-stopped
        # Pass devices to container
        devices:
           - "/dev/serial/by-id/usb-ITEAD_SONOFF_Zigbee_3.0_USB_Dongle_Plus_V2_20220715103321-if00:/dev/ttyUSB-zigbee"

        ports:
          - "8080:8080"
          - "9440:9440"

        volumes:
          # This is where customstart.sh will be as well as the domoticz Database, domoticz scripts as well as the plugins
          - /opt/domoticz/userdata:/opt/domoticz/userdata
          # This is where the Python3 environment will be installed
          - /opt/domoticz/Domoticz_Python_Environment:/opt/domoticz/Domoticz_Python_Environment

        logging:
          driver: "journald"

        environment:
          - TZ=Europe/Paris
          # PYTHONPATH is use to set Domoticz to use a dedicated python environment instead of the system wide.
          - PYTHONPATH=/opt/domoticz/Domoticz_Python_Environment:$PYTHONPATH. # For below stable8
          #- PYTHONPATH=/home/pi/Domoticz_Python_Environment/lib/python3.11/site-packages/  # for stable8 and above
          #- LOG_PATH=/opt/domoticz/userdata/domoticz.log

    ```

1. Domoticz custom script.

    When starting the Domoticz container, it will trigger automatically the `/opt/domoticz/userdata/customstart.sh`.
    As part of the Zigbee. for Domoticz plugin we provide a custom version which fit for plugin. If you don't need anything special we do recommend to use it as such. The best is to do a symbolic link , so any update provided via the Z4D plugin update will be integrated immediatly

    ```bash
    sudo ln -s /opt/domoticz/userdata/plugins/Domoticz-Zigbee/Tools/customstart.sh /opt/domoticz/userdata/customstart.sh
    ```

## 3. Start Domoticz with plugin

```bash
docker-compose up -d
```

This will start the docker container, which then will trigger the customstart.sh which is going to set the Python environment.
Depending of the system and performance of it, it could take a while. Just have a look to the system log to monitor the progress.

## 4. Sources and References

* [domoticz/domoticz - Docker](https://hub.docker.com/r/domoticz/domoticz)
* [Get Docker](https://docs.docker.com/get-docker/)
* [docker hub](https://hub.docker.com/)
