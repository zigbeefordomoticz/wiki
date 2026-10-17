# Install the plugin with Docker

This page installs Domoticz and the plugin with Docker, for example on a Raspberry Pi. It builds a custom Domoticz image, based on the official [domoticz/domoticz](https://hub.docker.com/r/domoticz/domoticz) `stable` image, with the Python modules of the plugin already installed, so the container starts quickly.

The plugin, the Domoticz database and the scripts live in a host folder mapped into the container, so they survive container rebuilds and restarts.

## 1. Prerequisites

* Docker with the Compose plugin (`docker compose`), see [Get Docker](https://docs.docker.com/get-docker/).
* Your user in the `docker` group, so you don't need `sudo` for every command.
* The container is named `domoticz` and everything lives under `/opt/domoticz` on the host; adapt if you use other names.

## 2. Get the plugin

The image build needs the plugin, so clone it first, into the `userdata/plugins` folder that will be mapped into the container:

```bash
mkdir -p /opt/domoticz/userdata/plugins
cd /opt/domoticz/userdata/plugins
git clone https://github.com/zigbeefordomoticz/Domoticz-Zigbee.git
```

## 3. The Dockerfile and the compose file

The plugin ships both files in its `Docker` folder. Copy them to `/opt/domoticz`:

```bash
cd /opt/domoticz
cp userdata/plugins/Domoticz-Zigbee/Docker/dockerfile .
cp userdata/plugins/Domoticz-Zigbee/Docker/docker-compose.yml .
```

The **dockerfile** builds the custom image: it starts from `domoticz/domoticz:stable`, sets the time zone (`TZ=Europe/Paris`, change it if needed), installs a few tools (`ping`, `vim`, `ssh` for `git pull`), and installs the Python modules listed in the plugin `requirements.txt` into the Domoticz virtual environment of the image (`/opt/venv`). Use the file of the plugin as is; you only need to rebuild the image when the plugin's Python requirements change.

The **docker-compose.yml** runs the container. Adapt it to your installation; it should look like this:

```yaml
services:
  domoticz:
    build:
      context: .
      dockerfile: dockerfile
    image: domoticz/domoticz:stable-custom
    container_name: domoticz
    restart: unless-stopped

    # Pass devices to container
    devices:
       - "/dev/serial/by-id/usb-ITEAD_SONOFF_Zigbee_3.0_USB_Dongle_Plus_V2_20220715103321-if00:/dev/ttyUSB-zigbee"

    ports:
      - "8080:8080"
      - "9440:9440"

    volumes:
      - ./userdata:/opt/domoticz/userdata

    logging:
      driver: "journald"
```

* `devices`: maps the coordinator into the container, as `<path on the host>:<path in the container>` (see step 4). Not needed for a network coordinator.
* `ports`: `8080` is the Domoticz web interface, `9440` the plugin WebUI. Add `443:443` if you use Domoticz over https, and one port per additional plugin instance.
* `volumes`: `./userdata` (that is `/opt/domoticz/userdata`) holds the Domoticz database, scripts and plugins. Without it, everything would be lost when the container is rebuilt.

## 4. Find the serial port of the coordinator

```bash
ls -l /dev/serial/by-id/
lrwxrwxrwx 1 root root 13 Dec 11 22:19 usb-ITEAD_SONOFF_Zigbee_3.0_USB_Dongle_Plus_V2_20220715103321-if00 -> ../../ttyUSB0
```

Use this `/dev/serial/by-id/…` path, which doesn't change after a reboot, on the host side of `devices`. The container side is a name of your choice, for example `/dev/ttyUSB-zigbee`: this is the *Serial Port* you will give to the plugin.

## 5. Use the plugin start script

When the container starts, the Domoticz image runs `/opt/domoticz/userdata/customstart.sh` if it exists. The plugin provides one, which, the first time a new container starts, reinstalls the tools and the plugin Python modules (through `Tools/plugin-auto-upgrade.sh`). Link it, so that plugin updates bring its updates too:

```bash
ln -s /opt/domoticz/userdata/plugins/Domoticz-Zigbee/Tools/customstart.sh /opt/domoticz/userdata/customstart.sh
```

## 6. Build and start

```bash
cd /opt/domoticz
docker compose build
docker compose up -d
```

Domoticz is then available at `http://<host>:8080`.

## 7. Add the plugin in Domoticz

Follow [Plugin settings](Plugin_Settings.md). For a USB coordinator, the *Serial Port* is the container path chosen in step 4 (`/dev/ttyUSB-zigbee` in the example). Then open the WebUI at `http://<host>:9440/z4d/`.

## Updating

* **The plugin**: from the WebUI, *Admin > Plugin* (see [Plugin update](Plugin_Update.md)), or with `git pull` in the plugin folder. The modules are installed in the container: when the container is recreated, `customstart.sh` installs them again.
* **Domoticz, or the plugin's Python requirements**: rebuild the image and recreate the container:

  ```bash
  cd /opt/domoticz
  docker compose build --pull
  docker compose up -d
  ```

* The plugin also provides `Tools/update_domoticz_docker_container.sh`, which rebuilds the image (`--rebuild`), restarts the container and checks for plugin updates. Its defaults (image `domoticz-custom:latest`, plugin folder `/opt/domoticz/plugins/Domoticz-Zigbee`) differ from this page: use `--image` and `--plugin-dir` to match your setup, and `--dry-run` to see what it would do. Run it with `--help` for all the options.

## Troubleshooting

* List the running containers: `docker ps`
* Open a shell inside the container: `docker exec -it domoticz /bin/bash`
* See the container log: `docker logs domoticz` (or `journalctl` with the `journald` logging driver)
* Inside the container, the Python modules are in the virtual environment `/opt/venv` (see [Python virtual environment](HowTo_PythonVirtualEnv.md)).

## References

* [domoticz/domoticz on Docker Hub](https://hub.docker.com/r/domoticz/domoticz)
* [Get Docker](https://docs.docker.com/get-docker/)
* [Backup and restore](Plugin_Backup.md), for the Docker paths of the database and the plugin
