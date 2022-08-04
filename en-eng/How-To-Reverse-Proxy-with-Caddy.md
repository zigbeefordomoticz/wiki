# How to access domoticz and the plugin Web Admin from Internet and get protected

## Overview

The purpose is to use [Caddy](https://caddyserver.com/docs/) and setup a reverse proxy to allow access to Domoticz and the plugin Web Admin
The Domoticz interface will be accessible via `domoticz.my-domain.com` while the plugin WebAdmin will be via `domoticz.my-domain.com/zigate`
## Assumpion

You have a domain name where you can register 2 names ( CNAME or A record) to point one to domoticz and one to plugin webadmin

## 1- Install Caddy

There are plenty of how-to , but I would recommend the [Caddy Documentation](https://caddyserver.com/docs/install#debian-ubuntu-raspbian)

## 2- DNS setup

You'll need to setup 2 records ( CNAME or A ).

For exemple:

if your domain name is my-domain.com

* domoticz.my-domain.com


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
            header_up X-Real-IP 127.0.0.1
            header_up X-Forwarded-Port 9440
            header_up X-Forwarded-Proto http
        }

        domoticz.my-domain.com:443 {
            encode gzip
            basicauth / {
                support JDJhJDE0JFpWUEU0b1FlV0RiUDJrb24ybGp6cy43NGszWnFSY0FOUXZTcmk5ZzE1MWhDQnplUnFLdmNH
            }
            handle /z4d* {
                reverse_proxy 127.0.0.1:9440 {
                    import reverseproxyheaders
                }
            }
            handle /rest-z4d* {
                reverse_proxy 127.0.0.1:9440 {
                    import reverseproxyheaders
                }
            }

            handle /*/Custom* {
                reverse_proxy 10.0.0.22:8080
            }
            handle /* {
                reverse_proxy 10.0.0.22:8080
            }

            log {
                output file /var/log/caddy/domoticz.log
            }

       }	
     ```
	
## 4- Firwall setup
	
   make sure that
	* port 80 is open (it will be used by Caddy at startup to configure a Let's Encrypt certificate)
	* port 443 is open (it will be used to get access to your domoticz and web admin pages)

## 5- Domoticz Custom Menu
	
   Finally you need to create a specific Custom Menu if you want to access the WebUI plugin via the Domoticz Custom menu as the default one "Zigbee" won't work when reaching through the reverse-proxy

   We have to create a file under `domoticz/www/template` on the Domoticz environement with the following content. Of course you need to update `domoticz.my-domain.com`by your specific domain name
	
   ```
   cat > "Zigbee(from External)".html
   <iframe id="Zigbee"style="width:100%;height:800px;overflow:scroll;">
   </iframe>

   <script>
   document.getElementById('Zigbee').src = "https://domoticz.my-domain.com/z4d/";
   </script>
   ```
	
	
	
## References & Links
	
   * [Caddy documentation](https://caddyserver.com/docs/)
   * [Caddy basic Authentication](https://caddyserver.com/docs/caddyfile/directives/basicauth)

