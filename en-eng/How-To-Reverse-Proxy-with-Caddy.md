# How to access domoticz and the plugin Web Admin from Internet and get protected

## Overview

The purpose is to use [Caddy](https://caddyserver.com/docs/) and setup a reverse proxy to allow access to Domoticz and the plugin Web Admin

## Assumpion

You have a domain name where you can register 2 names ( CNAME or A record) to point one to domoticz and one to plugin webadmin

## 1- Install Caddy

There are plenty of how-to , but I would recommend the [Caddy Documentation](https://caddyserver.com/docs/install#debian-ubuntu-raspbian)

## 2- DNS setup

You'll need to setup 2 records ( CNAME or A ).

For exemple:

if your domain name is my-domain.com

* domoticz.my-domain.com
* zigbee-admin.my-domain.com

## 3- Caddy setup

   We assumed, if in your configuration this is somehow different, please replace by your values
   
   domoticz is accessible on port 8080 and nothing else. The SSL support will be provided by Caddy
   the zigbee4domoticz web admin is accessible on port 9440.

1. go to the '/etc/caddy' folder and check if you have a folder 'Caddyfile.d' or 'conf.d'. If that is the case skip 2. and go directly to 3.
2. edit the file Caddyfile and the line
   ```
   import Caddyfile.d/*.caddyfile
   ```
   
   create a folder `Caddyfile.d`
   ```
   mkdir Caddyfile.
   ```

3. If you want to secure the access to the Web Admin page

   ```
   % caddy hash-password
   Enter password:
   Confirm password:
   JDJhJDE0JEdHY0Y5ZW1nTnlMU0RzNFNIOFNObnVobXN3SVBHUkdCam1JWWV2c2hXcFZSd3AwZ2JWOHdl
   ```
   you will have to copy paste the <hash password> into the next step
  
5. create the Caddy file for the 2 records

   ```
   (reverseproxyheaders) {
    header_up X-Real-IP {remote}
    header_down Strict-Transport-Security max-age=31536000
   }

	
   domoticz.my-domain.net:443 {
   	# Reverse Plugin Zigbee for Domoticz
    	reverse_proxy /zigate*   127.0.0.1:9440
    	reverse_proxy /rest-z4d* 127.0.0.1:9440

    	# Reverse Domoticz
    	reverse_proxy 127.0.0.1:8080

    	log {
        	output file /var/log/caddy/domoticz.log
    	}
    }
     ```
	
## 4- Firwall setup
	
   make sure that
	* port 80 is open (it will be used by Caddy at startup to configure a Let's Encrypt certificate)
	* port 443 is open (it will be used to get access to your domoticz and web admin pages)

## References & Links
	
   * [Caddy documentation](https://caddyserver.com/docs/)
   * [Caddy basic Authentication](https://caddyserver.com/docs/caddyfile/directives/basicauth)

