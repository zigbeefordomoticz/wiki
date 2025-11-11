# Installing Domoticz and the plugin on a DUSUN IoT system


## Disable default DUSUN services, conflicting with Domoticz and Zigbee4Domoticz

1. Disable the Wifi Access Point service

    ```bash
    systemctl disable hostapd
    ```

1. Disbale DUSUN Web server

    ```bash
    systemctl disable lighttpd
    ```

1. Disable the start of all DUSUN softwares

    ```bash
    systemctl disable rc-local
    mv /etc/rc.local /etc/rc.local-dusun-disabled
    ```

## Configure the host name

In this example, I wanted to change hostname 'DUSUN' into 'dusun-pipiche'

```bash
hostnamectl set-hostname dusun-pipiche
echo "127.0.0.1 dusun-pipiche" >> /etc/hosts
```

edit the file /etc/config/system with the command `vi /etc/config/system`and modify option hostname 'dusun-pipiche'

Then reboot the system with the command

```bash
reboot
```


## Installing Docker

1. Create the necessary folders

    ```bash
    mkdir /opt/domoticz
    cd /opt/domoticz
    mkdir userdata
    mkdir /opt/domoticz/Domoticz_Python_Environment
    ```

1. Create a docker compose file

    ```bash
    cat > docker-compose.yml
    version: "3.3"
    services:
      domoticz:
        image: domoticz/domoticz:stable
        container_name: domoticz
        restart: unless-stopped
        # Pass devices to container
        devices:
           - "/dev/serial/by-id/usb-1a86_USB_Serial-if00-port0:/dev/ttyUSB-zigbee"

        ports:
          - "8080:8080"
          - "9440:9440"

        volumes:
          - ./userdata:/opt/domoticz/userdata
          - ./Domoticz_Python_Environment:/opt/domoticz/Domoticz_Python_Environment

        logging:
          driver: "journald"

        environment:
          - TZ=Europe/Paris
          - PYTHONPATH=/opt/domoticz/Domoticz_Python_Environment:$PYTHONPATH
          #- LOG_PATH=/opt/domoticz/userdata/domoticz.log
    ```

1. Download the domoticz container

    ```bash
    docker pull domoticz/domoticz
    ```

1. Install the Zigbee for Domoticz plugin

    ```bash
    cd userdata
    mkdir plugins
    git clone https://github.com/zigbeefordomoticz/Domoticz-Zigbee.git
    ```

1. Put in place the customstart so, it will load all python3 modules for the Zigbee4Domoticz plugin

    ```bash
    cd /opt/domoticz/userdata
    ln -s /opt/domoticz/userdata/plugins/Domoticz-Zigbee/Tools/customstart.sh customstart.sh
    ```


## Start Domoticz

```bash
cd /opt/domoticz
docker-compose up -d
```
