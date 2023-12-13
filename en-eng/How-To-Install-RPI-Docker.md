# Install Zigbee for Domoticz plugin (under Docker on a RPi bare metal)

## 1. Assumptions

The here after installation steps are based on Domoticz setup as documented [domoticz/domoticz - Docker](https://hub.docker.com/r/domoticz/domoticz)
We assumed here , that you you have access to Domoticz UI via a Web browser.

## 2. Install plugin & configuration

1. Start domoticz if not yet started

    ```bash
    docker up -d
    ```

When the container is started, and you have Domoticz access via a browser, we can start the installation procedure.
The idea is to install the plugin inside the container, to prevent having to install git under the bar metal system.

1. Open a sheel in the container `docker exec -it domoticz /bin/bash`

1. clone the Z4D plugin

    ```bash
    cd /opt/domoticz/userdata/plugins/
    git clone https://github.com/zigbeefordomoticz/Domoticz-Zigbee.git
    ```

1. Edit the Domoticz custom script, so the python modules are correctly installed and up to date

    ```bash
    vi /opt/domoticz/userdata/customstart.sh
    ```

    ```bash
    #!/bin/bash

    if [ -f /opt/domoticz/FIRSTRUN ]; then
        true
    else
        echo 'creating FIRSTRUN file so script can check on next run'
        touch /opt/domoticz/FIRSTRUN

        echo 'updating packages'
        apt-get -qq update

        echo 'installing iputils-ping'
        apt-get -y install iputils-ping

        echo 'installing vim editor'
        apt-get -y install vim-ping

        if [ -f /opt/domoticz/userdata/plugins/Domoticz-Zigbee/requirements.txt ]; then
        echo 'Install the necessary python3 modules for Zigbee for Domoticz plugin'
                python3 -m pip install -r /opt/domoticz/userdata/plugins/Domoticz-Zigbee/requirements.txt --upgrade
        fi
        cd /opt/domoticz || return
    fi
    ```

1. Provide the Zigbee dongle port to the container.

    1. stop the container `docker down`

    1. Identify the Serial line port

    ```bash
    ls -l /dev/serial/by-id/
    total 0
    lrwxrwxrwx 1 root root 13 Dec 11 22:19 usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0 -> ../../ttyUSB0
    ```

    In this exemple the Zigbee USB Dongle SonOff P is /dev/serial/by-id/usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0, that I'll add in the devices section of the docker-compose.yml file.

    The syntax to be used is `<host port>:<container port>`

    * __host port__ is `/dev/serial/by-id/usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0``
    * __container port__ is the port name you want to see inside the container, `/dev/ttyUSB0` ( you can choose what ever you want)

    1. edit the file docker-compose.yml

    ```bash
    vi /opt/domoticz/docker-compose.yml
    ```

    this should look similar to that one.

    ```bash
    version: '3.3'

    services:
    domoticz:
        image: domoticz/domoticz:stable
        container_name: domoticz
        restart: unless-stopped
        # Pass devices to container
        devices:
            - "/dev/serial/by-id/usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0:/dev/ttyUSB0"
        ports:
            - "8080:8080"
        volumes:
            - ./config:/opt/domoticz/userdata
        environment:
            - TZ=Europe/Amsterdam
            #- LOG_PATH=/opt/domoticz/userdata/domoticz.log
    ```

## 3. Sources and References

* [domoticz/domoticz - Docker](https://hub.docker.com/r/domoticz/domoticz)
* [Get Docker](https://docs.docker.com/get-docker/)
* [docker hub](https://hub.docker.com/)
