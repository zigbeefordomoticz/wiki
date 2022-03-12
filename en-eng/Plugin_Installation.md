# Plugin ZiGate installation

In every installation methodes, the plugin requires Domoticz version 3.87xx or greater and Python version 3.5 or higher.
Make sure that you have __python3-dev package__ installed. More informations on [Domoticz Python page](https://www.domoticz.com/wiki/Using_Python_plugins).

In this first step, there are severals installation methodes depending on your Operating System :

* 1 - [Python Plugin Manager installation running on Linux](#1---python-plugin-manager-installation-running-on-linux)
* 2 - [Manual Installation running on Linux](#2---manual-installation-running-on-linux)
* 3 - [Installation running on Synology NAS](#3---installation-running-on-synology-nas)
* 4 - [Installation running on Docker](#4---installation-running-on-docker)
* 5 - [Installation running on Windows 10](#5---installation-running-on-windows-10)
* 6 - [PiZigate Installation on RPi3B+ running on Raspbian (Linux)](#6---pizigate-installation-on-rpi3b-running-on-raspbian-linux)
* 7 - [PiZigate Installation on RPi3B+ running on Fedora 29 (Linux)](#7---pizigate-installation-on-rpi3b-running-on-fedora-29-linux)
* 8 - [Installation running on OpenWRT](#8---installation-running-on-openwrt)

------------

## 1 - Python Plugin Manager installation running on Linux

* If you have [pp-manager](https://github.com/ycahome/pp-manager) installed on your system
* Just search for "Zigate Plugin" entry and add it.


------------

## 2 - Manual Installation running on Linux

* Go in your Domoticz directory using a command line and open the plugins directory.
* Usually you should be under <code>domoticz/plugins</code>
* Run: `git clone https://github.com/pipiche38/Domoticz-Zigate.git`
* It will create a folder 'Domoticz-Zigate'
* Make the plugin.py file executable `chmod +x Domoticz-Zigate/plugin.py`
* Restart Domoticz.


------------

## 3 - Installation running on Synology NAS

The purpose of this document is to help you in the installation of the Zigate plugin on a Synlology platform

### Pre-requisites

* First of all, please go through the  [Domoticz Python page](https://www.domoticz.com/wiki/Synology_installation_folder)
* The Domoticz for Synology package to be installed is the version 'with Python'. You can download it from Jahdal. At this moment it is v4.10717 with Python 3.5.1.
* Python Module from the Package manager must be installed. [Python Module](https://www.synology.com/en-uk/dsm/packages/PythonModule)
* The GitHub server Synology package must be installed . Install Git Server package via Diskstation. We don't need the 'Server' part of the GitHub Server package, just the 'git command', so no specific configurations are required.
* it is assumed that you have 'root'/'admin' right access with the use of 'sudo' command

Attention:
  * You need git-server package
  * Domoticz with python
  * USB drivers for zIgate can be found on [jadahl.com](http://www.jadahl.com/drivers_6.2/)

### Installation of the Plugin
Start a Putty session and login

Navigate to plugin folder domoticz:

cd /volume1/@appstore/domoticz/var/plugins

GIT clone Zigate plugin to new folder Zigate:

sudo git clone https://github.com/sasu-drooz/Domoticz-Zigate.git Zigate

Stop and start domoticz from package manager.

--------------------------------------------------------

In domoticz navigate to Settings -> Hardware

Pick Zigate Plugin from the list, name it and set the wright USB port.

At the first boot you have to set “Erase Persistent Data” to True to build a new network.

Set Permit Join to value 255 to search for a unlimited time for new devices

Click Add and check the log. When the USB TTL is in Permit Join mode the blue and red LEDs are flickering. Now you can add devices the usual way. For example press and hold 3 secs the button at the Aqara sensor.

When you are done adding devices set the permit join value to something lower than 255.

### Known issue

There is a known issue on Syno which makes Domoticz to crash when starting the plugin.
You need to disable the feature to check for plugin and firmware update availability.

You have to edit the file Domoticz-Zigate/Conf/PluginConf-xx.json
and add the following line

"internetAccess": 0,

the best is to add it in the middle of the file, so you don't break the all file syntax


------------

## 4 - Installation running on Docker

### 1. Docker Install

see [Get Docker](https://docs.docker.com/get-docker/)

### 2. Get Docker-Domoticz

Before run the domoticz's docker, you need to get it.
For this you have two choices :
* build your own docker-domoticz's image
* get an existing Domoticz's image from docker hub

#### A. Build Your own Docker-Domoticz

In a folder create a file named **dockerfile**, add this line in :
```
#name of container: docker-domoticz
#versison of container: 0.1.0
FROM debian:buster-slim
LABEL MAINTAINER your_name  "your_mail"

#add repository and update the container
#Installation of nesesary package/software for this containers...
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q build-essential\
                    netcat \
                    cmake  \
                    libsqlite3-dev curl libusb-dev \
                    zlib1g-dev libssl-dev git\
                    libudev-dev \
                    python3 \
                    python3-dev \
                    python \
                    python-dev \
                    python-libxml2 \
                    libxml2-dev \
                    python-pip \
                    python3-pip \
                    libxslt-dev \
                    lib32z1-dev \
                    liblua5.3 \
                    liblua5.3-dev \
                    libcereal-dev \
                    wget libssl-dev git libcurl4-gnutls-dev libcereal-dev uthash-dev\
                    && apt-get clean \
                    && rm -rf /tmp/* /var/tmp/*  \
                    && rm -rf /var/lib/apt/lists/*

# Rebuild cmake because stable version (3.0.2) incompatible with openssl
RUN wget -O- https://github.com/Kitware/CMake/releases/download/v3.17.0/cmake-3.17.0.tar.gz | tar xzv \
            && cd cmake-3.17.0 \
            && ./configure --prefix=/opt/cmake \
            && make \
            && make install \
            && cd ../

RUN wget -O- https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz | tar zxv \
            && cd boost_1_72_0 \
            && ./bootstrap.sh \
            && ./b2 install

RUN pip3 install caldav
RUN pip3 install broadlink
RUN pip3 install pycrypto
RUN pip3 install pyaes

#Compile Domoticz
RUN cd /opt && git clone -b development https://github.com/domoticz/domoticz.git domoticz && cd domoticz;git checkout external-libs;/opt/cmake/bin/cmake -J4 -DCMAKE_BUILD_TYPE=Release -DUSE_PYTHON=YES -DPython_ADDITIONAL_VERSIONS=3.5 . ;\
    make CMAKE_COMMAND=/opt/cmake/bin/cmake #&& make CMAKE_COMMAND=/opt/cmake/bin/cmake install

RUN mkdir -p /opt/domoticz/backup  /opt/scripts /opt/domoticz/db

VOLUME ["/opt/domoticz/scripts", "/opt/domoticz/backups",  "/opt/domoticz/db", "/opt/domoticz/plugins", " /opt/domoticz/www/images/floorplans", " /opt/domoticz/www/templates"]

# to allow access from outside of the container  to the container service
# at that ports need to allow access from firewall if need to access it outside of the server.
EXPOSE 8080 9440

# Use baseimage-docker's init system.
CMD ["/opt/domoticz/domoticz"]

```
Like in a normal install, you can add new packages with apt-get

for more information about dockerfile see [here](https://docs.docker.com/engine/reference/builder/)

Then you can build your docker's image localy with this command :
```
docker build -t docker-domoticz .
```

Now you can run your docker-domoticz's image

#### B. Get from docker Hub

Go on [docker hub](https://hub.docker.com/) and search for domoticz, when you find an image you want, run :
```
docker pull image-name
```

### 3. Run docker-domoticz's image

To lunch domoticz's image run :
```
docker run --privileged -d -p 8080:8080 -p 9440:9440 --name=Domoticz -v <Local path for your scripts>:/scripts -v <Local path for your plugins>:/opt/domoticz/plugins -v <Local path for your floorplans>:/opt/domoticz/www/images/floorplans -v /etc/localtime:/etc/localtime:ro -v <Local path for your domoticz.db>:/opt/domoticz/domoticz.db Your_Image_Name
```

If you have script, plugins ... put them in a directory and set the path before running this command
If you have a pluging who need to broadcast on your network (like xiaomi gateway) you need to add this :
```
--network host
```

### 4. Get docker log

to get full log from your docker, run :
```
docker logs Domoticz
```

### 5. Connect to your running docker

Run :
```
docker exec -it Domoticz bash
```

------------

## 5 - Installation running on Windows 10

[Refer to french page](../fr-fr/Plugin_Installation.md#5---installation-sous-windows-10)


------------

## 6 - PiZigate Installation on RPi3B+ running on Raspbian (Linux)

1. Make sure you have all the latest software and pyhon-dev is installed:

    ```bash
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install python3-dev
    ```

1. Test if wiringpi is installed:

    ```bash
    gpio -v
    gpio readall
    ```

1. If not, install it :

    ```bash
    sudo apt-get install wiringpi
    ```

1. Set the gpio pins for production mode in rc.local so that this will happen on every reboot:

    ```bash
    sudo nano /etc/rc.local
    gpio mode 0 out
    gpio mode 2 out
    gpio write 2 1
    gpio write 0 0
    gpio write 0 1
    ```

    Put these 5 lines just before the exit 0 line, save and exit

1. If you have a RPi3B+, shutdown bluetooth permanently by editing config.txt:

    ```bash
    sudo nano /boot/config.txt
    ```

    Put this on the end of the file:

    ```bash
    dtoverlay = pi3-disable-bt

    ```

    Save and exit.

1. Open the cmdline.txt:

    ```bash
    sudo nano /boot/cmdline.txt

    ```

    Delete the text console = serial0,115200
    Save and exit

1. Type the following commands (if pi is the username you are log in):

    ```bash
    sudo systemctl disable hciuart
    sudo usermod -ag gpio pi
    sudo shutdown

    ```

1. Power off the RPi, plug the Pizigate card in the gpio slot and power up.

1. Set the accessability of the serial adapter to 'No' using raspi-config option P6 (Interfacing options / serial):

    ```bash
    sudo raspi-config

    ```

1. Use at latest version (>4.10) of Domoticz. If you're still on stable version 4.9700, first update:

    ```bash
    cd /home/pi/domoticz
    ./updatebeta

    ```

1. Get the latest Zigate plugin and make the plugin.py executable:

    ```bash
    cd /home/pi/domoticz/plugins
    git clone https://github.com/sasu-drooz/Domoticz-Zigate.git
    chmod +x Domoticz-Zigate/plugin.py
    ```

1. If already installed, update to the newest version:

    ```bash
    cd /home/pi/domoticz/plugins/Domoticz-Zigate
    git pull
    sudo reboot
    ```

1. Startup the Pizigate:

    ```bash
    Tools/pi-zigate.sh run

    ```

1. Go to the hardware tab of Domoticz and Add the new hardware:
    Name: Zigate (or something similar)
    Type: Zigate plugin
    Click Add

    Next, click on Zigate in the hardware list to edit settings:
    Model: PI
    Serial Port: /dev/serial0
    Permit join time: 255 (=permanently)
    Erase Persistent Data: True (has to be done once on initialization)
    Click Update

    If everything went okay, the blue LED wil flash brightly and you can pair Zigbee devices by resetting them.

### FLASHING

If you ever have to enter flash mode to update the Pizigate firmware, first type:

```bash
0 gpio way out
2 gpio way out
gpio write 2 0
gpio write 0 0
gpio write 0 1
````

After flashing the firmware, a sudo reboot will reload defaults from rc.local


------------
## 7 - PiZigate Installation on RPi3B+ running on Fedora 29 (Linux)

Fedora is my developpement platform, and I was a bit frustrated when the PiZigate came and was only running on Raspbian.
Finally after few trials and changes, I have been able to get a Fedora 29 , Domoticz , PiZigate stack fully operationnal

### Fedora configuration

Platform: RPI3 B+

1. Enable UART

   * Edit file ` /boot/efi/config.txt`
     * Make sure that the following lines are uncommented
       * `enable_uart=1`
       * `dtoverlay = pi3-disable-bt`
       * reboot

   * Disable any Getty on /dev/ttyS1
     * `systemctl stop serial-getty@ttyS1.service1`
     * `systemctl disable serial-getty@ttyS1.service`

   * Check that there is no more process attached to /dev/ttyS1
     * `lsof /dev/ttyS1` or `ps -ef | grep ttyS1`

1. Check /dev/ttyS1 access rights

   * `ls -l /dev/ttyS1`

   * edit /etc/group and make sure that the user running domoticz belongs to the tty group
     * `sudo usermod -aG tty domoticz`

   * make sure that /dev/ttyS1 is read/write access
     * `sudo chmod 666 /dev/ttyS1`

1. Enable GPIO

   * Install libgpiod and python3 RPi.GPIO
     * sudo dnf install python3-RPi.GPIO libgpiod-utils

   * Kernel must run withthe iomem=relaxed option
     * Edit /etc/exlinux.conf and add iomem=relaxed in the append statement

     Here is an exemple of what you should have
     ```
     label Fedora (5.4.17-200.fc31.armv7hl) 31 (Thirty One)
	   kernel /vmlinuz-5.4.17-200.fc31.armv7hl
	   append ro root=UUID=2161061e-8612-4e18-a4e1-0e95aca6d2ff LANG=en_US.UTF-8 selinux=0 audit=0 rd.driver.blacklist=nouveau iomem=relaxed
	   fdtdir /dtb-5.4.17-200.fc31.armv7hl/
	   initrd /initramfs-5.4.17-200.fc31.armv7hl.img
     ```


   * You can use the pi-zigate-fedora.py tool provided under Tools/Fedora to switch the PiZigate
   to RUN or FLASH mode. For now you must be root when executing this module

     * `sudo python3 Tools/Fedora/pi-zigate-fedora.py run`

1. Sanity check

   * A tool is provided under Tools/Fedora to test the communication with the PiZigate. The tools is based on the PiZiGate_test tool provided with Zigate and is limited to the pure communication test.

   * recompile the tool `gcc -o PiZiGate_test-fedora PiZiGate_test-fedora.c`
   * excute it `./PiZiGate_test-fedora /dev/ttyS1`

   ```
   [domoticz@rasp Fedora]$ ./PiZiGate_test-fedora /dev/ttyS1
   Opening : /dev/ttyS1 ...
   + /dev/ttyS1 opened --> OK
   + Packet 01 02 10 10 02 10 02 10 10 03 sent --> OK
   + Packet received --> OK
   size : 37
   01 80 00 00 05 95 00 00 00 10 00 03
   01 80 10 00 05 8f 00 03 03 1a 00 03
   ```


 If you reach this step, you can start domoticz and configure the Zigate plugin on the PiZigate

## 8 - Installation Running on OpenWRT

OpenWRT provides a number of prebuilt python packages via opkg that must be installed instead of the normal dependencies:

```
opkg install kmod-usb-serial kmod-usb-serial-cp210x shadow-usermod python3 python3-pip python3-voluptuous python3-cryptodome python3-attrs python3-aiohttp python3-jsonschema domoticz
pip install aiosqlite crccheck pyusb pyserial-asyncio coloredlogs
```

The domoticz package provided by opkg has slightly different installation paths:

```
cd /etc/domoticz/plugins
git clone --recurse-submodules --depth 1 -b beta6 https://github.com/zigbeefordomoticz/Domoticz-Zigbee.git
chmod +x Domoticz-Zigbee/plugin.py
```

Domoticz is automatically configured to run under the 'domoticz' user and group, permissions must be granted to any resources it needs:

```
chown -R domoticz:domoticz /etc/domoticz/plugins/Domoticz-Zigbee
usermod -a -G dialout domoticz
```

Add a custom page to access Zigbee-for-domoticz from within the domoticz UI:

```
echo '<IFRAME SRC="http://10.0.0.1:9440/" height="800" width="100%"></IFRAME>' > /usr/share/domoticz/www/templates/Zigate2.html
```

Finally, restart domoticz to apply all changes:

```
service domoticz restart
```

You can verify that your Zigbee USB dongle was detected via:

```
lsusb
dmesg | grep ttyUSB
```
