# Installation procedure of Pizigate on Domoticz running on RPi3B+
( from Pierre Gielen )

1. Make sure you have all the latest software and pyhon-dev is installed: 
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python3-dev
```

1. Test if wiringpi is installed: 

```
gpio -v
gpio readall
```

1. If not, install it : 

```
sudo apt-get install wiringpi
```

1. Set the gpio pins for production mode in rc.local so that this will happen on every reboot: 

```
sudo nano /etc/rc.local
gpio mode 0 out
gpio mode 2 out
gpio write 2 1 
gpio write 0 0
gpio write 0 1
```

Put these 5 lines just before the exit 0 line, save and exit

1. If you have a RPi3B+, shutdown bluetooth permanently by editing config.txt: 

```
sudo nano /boot/config.txt
```

Put this on the end of the file: 

```
dtoverlay = pi3-disable-bt

```

Save and exit. 

1. Open the cmdline.txt: 

```
sudo nano /boot/cmdline.txt

```

Delete the text console = serial0,115200
Save and exit

1. Type the following commands: 

```
sudo systemctl disable hciuart
sudo usermod -ag gpio ft
sudo shutdown

```

1. Power off the RPi, plug the Pizigate card in the gpio slot and power up. 

1. Set the accessability of the serial adapter to 'No' using raspi-config option P6 (Interfacing options / serial):

```
sudo raspi-config

```

1. Use at latest version (>4.10) of Domoticz. If you're still on stable version 4.9700, first update:

```
cd /home/pi/domoticz
./updatebeta

```

1. Get the latest Zigate plugin and make the plugin.py executable: 

```
cd /home/pi/domoticz/plugins
git clone https://github.com/sasu-drooz/Domoticz-Zigate.git
chmod +x Domoticz-Zigate/plugin.py
```

1. If already installed, update to the newest version:

```
cd /home/pi/domoticz/plugins/Domoticz-Zigate
git pull
sudo reboot
```

1. Startup the Pizigate: 

```
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



## FLASHING

If you ever have to enter flash mode to update the Pizigate firmware, first type: 
```
0 gpio way out
2 gpio way out
gpio write 2 0 
gpio write 0 0
gpio write 0 1
````
After flashing the firmware, a sudo reboot will reload defaults from rc.local



 
