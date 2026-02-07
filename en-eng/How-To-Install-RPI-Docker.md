# Install Zigbee for Domoticz plugin (under Docker on a RPi bare metal)

## 1. Assumptions & Prerequisites

The here after installation steps are based on Domoticz setup as documented [domoticz/domoticz - Docker](https://hub.docker.com/r/domoticz/domoticz)
We assumed here , that you you have access to Domoticz UI via a Web browser.

Docker and docker-compose installed.

User must be part of the docker group (so they don’t need sudo everywhere)

In the here documentation, the guide assumes the container name = domoticz

Nothing else to be done, as the provided customstart.sh will do the proper setup.

## 2. Docker domoticz optimization

Under the folder `/opt/domoticz`we recommand to have the following setup, slightly different from the recommended domoticz one. The benefit is to speedup the startup.

1. Configure the dockerfile

This help you to build a single docker image.

```bash
###############################################################################
# Dockerfile for Domoticz Zigbee4Domoticz Plugin
#
# Purpose:
#   This Dockerfile builds a custom Domoticz image with pre-installed Python
#   dependencies required by the Zigbee4Domoticz plugin. It is designed to work
#   with a persistent plugin folder mounted from the host, so plugin updates
#   survive container restarts and system reboots.
#
# Features:
#   - Based on the official domoticz/domoticz:latest image
#   - Sets timezone to Europe/Paris
#   - Installs essential system packages for plugin operation and management
#   - Pre-installs Python dependencies from the plugin's requirements.txt
#     to speed up first container start
#   - Ensures persistent plugin folder exists under /opt/domoticz/userdata/plugins
#   - Copies the plugin-auto-upgrade.sh script for optional first-start updates
#   - Keeps container image clean by removing temporary files after build
#
# Usage Notes:
#   - The actual plugin files should live in a Docker volume, typically mapped
#     from the host: ./userdata/plugins/Domoticz-Zigbee:/opt/domoticz/userdata/plugins/Domoticz-Zigbee
#   - Plugin auto-upgrades can be executed inside the container without rebuilding
#   - Rebuild the image only when Python dependencies change
#
# Volumes:
#   - /opt/domoticz/userdata/plugins/Domoticz-Zigbee  (plugin directory, persistent)
#   - ./userdata                                      (host directory mapped to userdata)
#
# Build Command:
#   docker build -t domoticz-custom:latest .
#
# Notes:
#   - pip notices about upgrades are suppressed by installing dependencies
#     during image build
#   - SSH known hosts are pre-populated to allow git access from the container
###############################################################################
# Base image
FROM domoticz/domoticz:latest

# Set timezone
ENV TZ=Europe/Paris

# Install required system packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        iputils-ping \
        vim \
        openssh-client \
        python3-venv \
        python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Ensure plugin folder exists in the userdata volume
RUN mkdir -p /opt/domoticz/userdata/plugins/Domoticz-Zigbee \
    && mkdir -p /root/.ssh \
    && ssh-keyscan github.com >> /root/.ssh/known_hosts

# Copy only requirements.txt and plugin-auto-upgrade script to install dependencies
# This will speed up first start
COPY userdata/plugins/Domoticz-Zigbee/requirements.txt /tmp/plugin-requirements.txt
COPY userdata/plugins/Domoticz-Zigbee/constraints.txt /tmp/constraints.txt
COPY userdata/plugins/Domoticz-Zigbee/Tools/plugin-auto-upgrade.sh /tmp/plugin-auto-upgrade.sh

# Check pip version and update
RUN pip3 install pip --upgrade

# Install Python dependencies during image build
RUN if [ -f /tmp/plugin-requirements.txt ]; then \
        pip3 install --no-cache-dir -r /tmp/plugin-requirements.txt; \
    fi

# Make the auto-upgrade script executable (optional, can be run inside container)
RUN chmod +x /tmp/plugin-auto-upgrade.sh

# Cleanup temporary files
RUN rm -f /tmp/plugin-requirements.txt
# Keep plugin-auto-upgrade.sh in /tmp for first-start usage if needed
```

1. Configure the docker-compose.yml

Defines how to run one or more containers together.

* It orchestrates services (containers), networks, volumes, and other runtime options.
* Can either pull an image from a registry, or build it using a Dockerfile.
* Handles relationships between services (e.g., depends_on, networks).
* Great for multi-container setups like Domoticz + Zigbee plugin + database.

```bash
services:
    domoticz:
    build:
        context: .
        dockerfile: dockerfile
    image: domoticz-custom:latest
    container_name: domoticz
    restart: unless-stopped

    # Pass devices to container
    devices:
        - "<physical serial port on host>:<serial port in container to be used by domoticz>"

    ports:
        - "<HOST domoticz port>:<CONTAINER domoticz port>"
        - "<HOST Z4D WebUI port>:<CONTAINER Z4D WebUI port>"

    volumes:
        # This is where customstart.sh will be as well as the domoticz Database, domoticz scripts as well as the plugins
        - /opt/domoticz/userdata:/opt/domoticz/userdata

    logging:
        driver: "journald"
```

## 2. Install plugin & configuration

1. clone the Z4D plugin

```bash
cd /opt/domoticz/userdata/plugins/
git clone https://github.com/zigbeefordomoticz/Domoticz-Zigbee.git
```

1. Identify the Serial line port of the Zigbee Dongle

```bash
ls -l /dev/serial/by-id/
total 0
lrwxrwxrwx 1 root root 13 Dec 11 22:19 usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0 -> ../../ttyUSB0
```

In this exemple the Zigbee USB Dongle SonOff P is /dev/serial/by-id/usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0.

1. Update docker-compose.yml file.

The syntax to be used is `<host port>:<container port>`

* __host port__ is `/dev/serial/by-id/usb-Silicon_Labs_Sonoff_Zigbee_3.0_USB_Dongle_Plus_0001-if00-port0`
* __container port__ is the port name you want to see inside the container, `/dev/ttyUSB0` ( you can choose what ever you want)

1. edit the file docker-compose.yml

* userdata must be mapped as a volume for plugins & DB persistence. Otherwise everything installed in /opt/domoticz/userdata inside the container will vanish after a rebuild.

```bash
vi /opt/domoticz/docker-compose.yml
```

* this should look similar to that one.

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

    logging:
        driver: "journald"

    environment:
        - TZ=Europe/Paris
        #- LOG_PATH=/opt/domoticz/userdata/domoticz.log
```

1. Domoticz custom script. IMPORTANT

When starting the Domoticz container, it will trigger automatically the `/opt/domoticz/userdata/customstart.sh`.
As part of the Zigbee. for Domoticz plugin we provide a custom version which fit for plugin. If you don't need anything special we do recommend to use it as such. The best is to do a symbolic link , so any update provided via the Z4D plugin update will be integrated immediatly

```bash
sudo ln -s /opt/domoticz/userdata/plugins/Domoticz-Zigbee/Tools/customstart.sh /opt/domoticz/userdata/customstart.sh
```

1. Build a Domoticz with Z4D plugin image

```bash
docker-compose build
````

From that, Domoticz is ready to start with the plugin

## 3. Start Domoticz with plugin

```bash
docker-compose up -d
```

## 4. Troubleshooting

* list running containers: `docker ps``
* get a bash inside the container: `docker exec -it domoticz /bin/bash`

* Inside the container, the python environment will be developped under /opt/venv

## 4. Sources and References

* [domoticz/domoticz - Docker](https://hub.docker.com/r/domoticz/domoticz)
* [Get Docker](https://docs.docker.com/get-docker/)
* [docker hub](https://hub.docker.com/)
