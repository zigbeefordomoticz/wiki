# Using PiZigate on a Fedora 29 distribution


Fedora is my developpement platform, and I was a bit frustrated when the PiZigate came and was only running on Raspbian.
Finally after few trials and changes, I have been able to get a Fedoar 29 , Domoticz , PiZigate stack fully oiperationnal


## Fedora configuration

Platform: RPI3 B+

1. Enable UART 

   * Edit file ` /boot/efi/config.txt`
     * Make sure that the following lines are uncommented
       * `enable_uart=1`
       * `dtoverlay = pi3-disable-bt`
       
     * `systemctl stop system-getty@ttyS1.service`
     * `systemctl disable system-getty@ttyS1.service`

1. Check /dev/ttyS1 access rights

   * `ls -l /dev/ttyS1`
   
   * edit /etc/group and make sure that the user running domoticz belongs to the tty group
     * `sudo usermod -aG tty domoticz`
     
   * make sure that /dev/ttyS1 is read/write access for group
     * `sudo chmod +g /dev/ttyS1
     
1. Enable GPIO 

   * Install libgpiod and python3 RPi.GPIO
     * sudo dnf install python3-RPi.GPIO libgpiod-utils
     
   * You can use the pi-zigate-fedora.py tool provided under Tools/Fedora to switch the PiZigate 
   to RUN or FLASH mode. For now you must be root when executing this module
   
     * `sudo python3 Tools/Fedora/pi-zigate-fedora.py run`
     
     
   


