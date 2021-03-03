# How to get Netamo Legrand firmware for my device

## Introduction

The purpose is to document a way to retreive the Netamo-Legrand firmware for your devices. It is based on the assumption that you own a Netamo-Legrand Gateway (Hub)

I would lik to acknowldge here the work done by @bsheepdiy in contribution of the this [post](
https://github.com/dresden-elektronik/deconz-rest-plugin/issues/883#issuecomment-593098964)

## Pre-requisites

* You own a Netatmo-Legrand Gateway
* You need to setup a system able to play the role of Access Point and DHCP server 


## Overview

This is based on a RPI3B+ which provides 2 network interfaces ( wired rj45 and wifi ), so the wired RJ45 will be used to get access to Internet and the WiFi interface will be used for the Access Point.

1. Setup
   1. Linux system
   1. DHCP Server on your system (dhcpd or dnsmasq )
   1. Access Point ( hostapd )
   1. router ( iptables and ip_forward ) , route the Wireless traffic to the Ethernet traffic

1. Usage
   1. use tcpdump on the wired network interface ( `tcpdump -vvAls0 | grep 'GET'` )
   1. Get you Netamo-Legrand Gateway connected through the Access Point ( you will have get your smartphone paired on the Accesspoint and then configure the Gateway with this network)

1. Capturing Firmware path

   Through the `tcpdump`command you'll capture GET request which will be done by the Netamo-Legrand gateway to pull firmware from the Cloud.
The full URL will be like:

    * `http://fw.netatmo.net/getfirmware/000474230eec/1584836191/zwG-s1Xxva2b0Ujdb_u-ky_m-oHCozEx3gOHWoULEqM/NLD-6.fw`
    
    Where 
    * `http://fw.netatmo.net/getfirmware/`is the base URL to access firmware on netatmo cloud
    * `000474230eec`is the mac address of your Gateway (visible on the Home + App)
    * `123836123/zwG-s1Xxva2b0Uklm_f-ey_o-oHCozEx3gOHWoULEqM/`is something changing over the time. It is valid for a period of time.
    * `NLD-6.fw` Fimrware for Remote Switch
    
    From that, you can retreive any firmware you want by using the same URL and changing the last part 
    
    * NLC -> Cable outlet
    * NLD -> Remote Switch
    * NLF -> Dimer w/o neutral
    * NLM -> Micromodule
    * NLP -> Hub Plug / Mobile Plug / Connected Plug
    * NLT -> telecommande
    * NLV -> Shutter
   
## References

* https://danielmiessler.com/study/tcpdump/
* https://www.shellvoide.com/wifi/setup-wireless-access-point-hostapd-dnsmasq-linux/
* https://doc.ubuntu-fr.org/hostapd (in French )
   
