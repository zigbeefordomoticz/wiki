# ZigBeeForDomoticZ plugin installation

In every installation methods, the plugin requires DomoticZ version 2021.1 or greater and Python version 3.8 or higher.
Make sure that you have __python3-dev package__ installed. More informations on [DomoticZ Python page](https://www.domoticz.com/wiki/Using_Python_plugins).

In this first step, there are severals installation methods depending on your Operating System :

* 1 - [Manual Installation running on Linux](#1---manual-installation-running-on-linux)
* 2 - [Python Plugin Manager installation running on Linux](#2---python-plugin-manager-installation-running-on-linux)
* 3 - [Installation running on Synology NAS](#3---installation-running-on-synology-nas)
* 4 - [Installation running on Docker](#4---installation-running-on-docker)
* 5 - [Installation running on Windows 10](#5---installation-running-on-windows-10)
* 6 - [PiZigate Installation on RPi3B+ running on Raspbian (Linux)](#6---pizigate-installation-on-rpi3b-running-on-raspbian-linux)
* 7 - [PiZigate Installation on RPi3B+ running on Fedora 29 (Linux)](#7---pizigate-installation-on-rpi3b-running-on-fedora-29-linux)
* 8 - [Installation running on OpenWRT](#8---installation-running-on-openwrt)

------------

## 1 - Manual Installation running on Linux

This method is only valid for Linux : Raspberry, Debian, Ubuntu, etc. It will be necessary to modify the command lines according to your system..

__Important :__ This installation method is not valid for an installation of the PiZigate (check the [PiZigate installations process](Plugin_Installation.md)).

### 1.A - Prerequisite

* DomoticZ version above 2021.1 (voir [Wiki DomoticZ](https://www.domoticz.com/wiki))
* Python version above 3.8 (voir [DomoticZ Python](https://www.domoticz.com/wiki/Using_Python_plugins))
* Git packet installed

### 1.B - Procedure

Open the terminal

1. Go in your DomoticZ directory and inside the __plugins__ folder. The command is usually :

``` bash
cd domoticz/plugins/
```

2. Run the command :

``` bash
git clone https://github.com/zigbeefordomoticz/Domoticz-Zigbee.git
```

The folder __Domoticz-Zigbee__ will be created in the plugins folder.

3. Go to the __Domoticz-Zigbee__ folder. The command is usually :

``` bash
cd Domoticz-Zigbee/
```

4. Install the needed Python packet with the command :

``` bash
sudo pip3 install -r requirements.txt
```

__Note :__ With Debian 12 Bookworm, you have to add __--break-system-packages__ at the end of the previous command line. Be careful to take the two dash at the beginning.

5. Execute the command by adapting __pi:pi__ if necessary to the __user:group__ used. Be careful to take the point at the end.

``` bash
sudo chown -R pi:pi .
```

6. Run the command :

``` bash
git config --add submodule.recurse true
```

7. Install the missing Python libraries with the command :

``` bash
git submodule update --init --recursive
```

8. Make the __plugin.py__ file executable with the command :

``` bash
sudo chmod +x plugin.py
```

9. Restart DomoticZ. The command is usually :

``` bash
sudo service domoticz.sh restart
```

The ZigBee for DomoticZ plugin should appear in the hardware list (at the very bottom of the __Type__ listbox).
Move on to [step 2 Plugin settings](Plugin_Settings.md).

------------

## 2 - Python Plugin Manager installation running on Linux

__This procedure is not yet updated to be compatible with version 6 of the plugin.__

* If you have [pp-manager](https://github.com/ycahome/pp-manager) installed on your system
* Just search for "Zigbee for domoticz Plugin" entry and add it.

------------

## 3 - Installation running on Synology NAS

__This procedure is not yet updated to be compatible with version 6 of the plugin.__

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
* USB drivers for ZiGate can be found on [jadahl.com](http://www.jadahl.com/drivers_6.2/)

### Installation of the Plugin

Start a Putty session and login

Navigate to plugin folder domoticz:

cd /volume1/@appstore/domoticz/var/plugins

GIT clone Zigbee for Domoticz plugin to new folder Zigbee:

sudo git clone <https://github.com/zigbeefordomoticz/Domoticz-Zigbee> Zigbee

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

You have to edit the file Domoticz-ZigbeeConf/PluginConf-xx.json
and add the following line

"internetAccess": 0,

the best is to add it in the middle of the file, so you don't break the all file syntax

------------

## 4 - Installation running on Docker

__This procedure is not yet updated to be compatible with version 6 of the plugin.__

### 1. Docker Install

[How to install Zigbee4Domoticz on a docker based setup](../en-en/How-To-Install-RPI-Docker.md)

## 5 - Installation running on Windows 10

__This procedure is not yet updated to be compatible with version 6 of the plugin.__

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

    if it doesn't work you can download the wiringpi package from [here](https://project-downloads.drogon.net/wiringpi-latest.deb)

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

1. If you have a RPi3B+, shutdown Bluetooth permanently by editing config.txt:

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
    git clone https://github.com/zigbeefordomoticz/Domoticz-Zigbee
    chmod +x Domoticz-Zigbee/plugin.py
    ```

1. If already installed, update to the newest version:

    ```bash
    cd /home/pi/domoticz/plugins/Domoticz-Zigbee
    git pull
    sudo reboot
    ```

1. Startup the Pizigate:

    ```bash
    Tools/pi-zigate.sh run

    ```

1. Go to the hardware tab of Domoticz and Add the new hardware:
    Name: Zigbee (or something similar)
    Type: Zigbee for domoticz plugin
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
```

After flashing the firmware, a sudo reboot will reload defaults from rc.local

------------

## 7 - PiZigate Installation on RPi3B+ running on Fedora 29 (Linux)

Fedora is my development platform, and I was a bit frustrated when the PiZigate came and was only running on Raspbian.
Finally after few trials and changes, I have been able to get a Fedora 29 , Domoticz , PiZigate stack fully operational

### Fedora configuration

Platform: RPI3 B+

1. Enable UART

   * Edit file `/boot/efi/config.txt`
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

 1. OpenWRT provides a number of prebuilt python packages via opkg that must be installed instead of the normal dependencies :

 ```
 opkg install kmod-usb-serial kmod-usb-serial-cp210x shadow-usermod python3 python3-pip python3-voluptuous python3-cryptodome python3-attrs python3-aiohttp python3-jsonschema domoticz curl
 pip install aiosqlite crccheck pyusb pyserial-asyncio coloredlogs
 ```

 2. The domoticz package provided by opkg has slightly different installation paths:

 ```
 cd /etc/domoticz/plugins
 git clone --recurse-submodules --depth 1 -b beta6 https://github.com/zigbeefordomoticz/Domoticz-Zigbee.git
 chmod +x Domoticz-Zigbee/plugin.py
 ```

 3. Domoticz is automatically configured to run under the 'domoticz' user and group, permissions must be granted to any resources it needs:

 ```
 chown -R domoticz:domoticz /etc/domoticz/plugins/Domoticz-Zigbee
 usermod -a -G dialout domoticz
 ```

 4. Finally, restart domoticz to apply all changes:

 ```
 service domoticz restart
 ```

 5. You can verify that your Zigbee USB dongle was detected via:

 ```
 lsusb
 dmesg | grep ttyUSB
 ```
