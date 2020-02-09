# Using PiZigate on a Fedora 29 distribution


Fedora is my developpement platform, and I was a bit frustrated when the PiZigate came and was only running on Raspbian.
Finally after few trials and changes, I have been able to get a Fedora 29 , Domoticz , PiZigate stack fully operationnal

## Fedora configuration

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
     
   


