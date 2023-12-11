# Install Zigbee for Domoticz plugin (under Docker on a RPi bare metal)

## Assumptions

The here after installation steps are based on the fact that Domoticz is installed and setup as documented [domoticz/domoticz - Docker](https://hub.docker.com/r/domoticz/domoticz)

When the Domoticz setup is correctly configured, and you have been able to access via a Web browser, you can install the plugin

## 1. Start domoticz

```bash
docker up -d
```

## 2. Install plugin & configuration

The idea is to install the plugin inside the container, to prevent having to install git under the bar metal system.

1. Open a sheel in the container

    ```bash
    docker exec -it domoticz /bin/bash
    ```

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

    1. stop the container

    ```bash
    docker down
    ```

    1. Identify the Serial line port

    ```bash
    ls -l /dev/serial/by-id/
    total 0
    lrwxrwxrwx 1 root root 13 Dec 11 22:19 usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0 -> ../../ttyUSB0
    ```

    In this exemple the Zigbee USB Dongle SonOff P is /dev/serial/by-id/usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0, that I'll add in the devices section of the docker-compose.yml file

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
            - "/dev/serial/by-id/usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0"
        ports:
            - "8080:8080"
        volumes:
            - ./config:/opt/domoticz/userdata
        environment:
            - TZ=Europe/Amsterdam
            #- LOG_PATH=/opt/domoticz/userdata/domoticz.log
    ```
