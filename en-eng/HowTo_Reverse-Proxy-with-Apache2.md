# Reverse proxy with Apache 2: reach Domoticz and the plugin WebUI over HTTPS, with a login

## Overview

The plugin WebUI (port `9440` by default) has **no login of its own**. Whoever can reach that port can use the WebUI and its REST API: change the plugin settings, send commands to your Zigbee devices, download the logs.

So the WebUI port must never be opened on your Internet box. To use it from outside your home:

* **prefer a VPN** to your local network; nothing is exposed;
* otherwise, put a reverse proxy in front of it that asks for a user name and password, and make the WebUI reachable **only through that proxy**. This page does it with Apache 2 on Debian / Ubuntu / Raspberry Pi OS. [Reverse proxy with Caddy](HowTo_Reverse-Proxy-with-Caddy.md) does the same with less configuration, and gets the certificate for you.

Once done:

* `https://domoticz.example.com:9443/` opens Domoticz, protected by the Domoticz login;
* `https://domoticz.example.com:9443/z4d/` opens the plugin WebUI, protected by an Apache login (the browser asks for a user name and password).

## Assumptions

* Apache, Domoticz and the plugin run on the same machine, here `192.168.1.10`.
* Domoticz listens on port `8080`, the plugin WebUI on `9440`. Apache serves HTTPS on port `9443`. Replace them with your values.
* You have a domain name, or a dynamic DNS name, here `domoticz.example.com`.

## 1- Restrict the WebUI to the local machine

In Domoticz, *Setup* > *Hardware*, select the Zigbee for Domoticz hardware and set *Plugin WebUI port* to:

```
127.0.0.1:9440
```

Then press *Update*. The plugin restarts, and the WebUI now only answers on the Domoticz machine itself.

Check it. On the Domoticz machine, the WebUI must listen on `127.0.0.1` only:

```shell
ss -ltn | grep 9440
```

```
LISTEN 0      5          127.0.0.1:9440       0.0.0.0:*
```

`0.0.0.0:9440` or `*:9440` means the parameter was not taken: check it and restart the plugin.

From another computer on your network, the WebUI must not answer:

```shell
curl -s -o /dev/null -w '%{http_code}\n' --connect-timeout 5 http://192.168.1.10:9440/z4d/
```

must print `000` (no connection). Any other code means the proxy can be bypassed from your network.

## 2- Domoticz keeps its own login

Requests reach Domoticz from Apache, so from `127.0.0.1`. In the Domoticz settings, the list of networks that may connect without a user name and password (*Local Networks*, or *Trusted Networks* depending on the version) must **not** cover `127.0.0.1` (for example `127.0.0.*`). Otherwise every request coming through Apache gets into Domoticz without a login.

## 3- Certificate

This page uses a self-signed certificate: no port `80` to open, but every browser and phone that connects must be told to trust it (import the `.crt` file, or accept the warning).

> If you can open port `80`, a Let's Encrypt certificate is trusted everywhere and renewed automatically: `sudo apt install certbot python3-certbot-apache`, then `sudo certbot --apache -d domoticz.example.com`. Skip the rest of this step and use the paths certbot prints in step 5.

Create an OpenSSL configuration for the certificate:

```shell
sudo nano /etc/ssl/domoticz.cnf
```

```
[ req ]
distinguished_name = req_distinguished_name
prompt             = no

[ req_distinguished_name ]
CN = domoticz.example.com

[ v3_req ]
basicConstraints = CA:FALSE
keyUsage         = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName   = @alt_names

[ alt_names ]
DNS.1 = domoticz.example.com
IP.1  = 192.168.1.10
```

Generate the key and the certificate, valid one year:

```shell
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/domoticz.example.com.key \
  -out /etc/ssl/certs/domoticz.example.com.crt \
  -config /etc/ssl/domoticz.cnf \
  -extensions v3_req
```

The private key stays in `/etc/ssl/private/`, readable by root only.

## 4- Install and prepare Apache

```shell
sudo apt-get install apache2 apache2-utils
sudo a2enmod ssl headers proxy proxy_http proxy_wstunnel
sudo a2dissite 000-default.conf default-ssl.conf
```

Make Apache listen on `9443` only. Replace the content of `/etc/apache2/ports.conf` with:

```
<IfModule ssl_module>
	Listen 9443
</IfModule>

<IfModule mod_gnutls.c>
	Listen 9443
</IfModule>
```

Create the user for the plugin WebUI login. `-B` stores the password as a bcrypt hash; `-c` creates the file, leave it out to add more users later:

```shell
sudo htpasswd -B -c /etc/apache2/.htpasswd zigbee
```

`zigbee` is the user name: choose your own.

## 5- Configure the site

Create `/etc/apache2/sites-available/domoticz.conf`:

```
<VirtualHost *:9443>
	ServerName domoticz.example.com

	SSLEngine on
	SSLCertificateFile    /etc/ssl/certs/domoticz.example.com.crt
	SSLCertificateKeyFile /etc/ssl/private/domoticz.example.com.key

	Header always set Strict-Transport-Security "max-age=31536000"

	ProxyRequests Off
	ProxyPreserveHost On

	# Zigbee for Domoticz: the WebUI, its REST API and the log downloads
	ProxyPass        /z4d/      http://127.0.0.1:9440/z4d/
	ProxyPassReverse /z4d/      http://127.0.0.1:9440/z4d/
	ProxyPass        /rest-z4d/ http://127.0.0.1:9440/rest-z4d/
	ProxyPassReverse /rest-z4d/ http://127.0.0.1:9440/rest-z4d/
	ProxyPass        /download/ http://127.0.0.1:9440/download/
	ProxyPassReverse /download/ http://127.0.0.1:9440/download/

	# Login on every path of the plugin
	<LocationMatch "^/(z4d|rest-z4d|download)(/|$)">
		AuthType Basic
		AuthName "Zigbee for Domoticz"
		AuthUserFile /etc/apache2/.htpasswd
		Require valid-user
	</LocationMatch>

	# Everything else is Domoticz, with its own login
	ProxyPass        /json ws://127.0.0.1:8080/json
	ProxyPass        /     http://127.0.0.1:8080/
	ProxyPassReverse /     http://127.0.0.1:8080/

	ErrorLog  ${APACHE_LOG_DIR}/domoticz-error.log
	CustomLog ${APACHE_LOG_DIR}/domoticz-access.log combined
</VirtualHost>
```

The `/z4d/`, `/rest-z4d/` and `/download/` lines must come before the `/` ones: Apache uses the first `ProxyPass` that matches.

**Protect the three paths.** The WebUI is `/z4d/`, but it reads and changes everything through `/rest-z4d/`, and downloads the logs through `/download/`. A login on `/z4d/` alone leaves the REST API open to anyone.

Check the configuration, then enable the site:

```shell
sudo apache2ctl configtest
sudo a2ensite domoticz.conf
sudo systemctl reload apache2
```

`apache2ctl configtest` must print `Syntax OK`.

## 6- Internet box

Forward port `9443` of your Internet box to `192.168.1.10:9443`. Do **not** forward `8080` or `9440`.

## 7- Check the login

Run these from any computer that can reach `domoticz.example.com:9443`. As the certificate is self-signed, give `curl` a copy of `domoticz.example.com.crt` with `--cacert`. Use the user name you created instead of `zigbee`.

* Without a user name and password, the WebUI, its REST API and the downloads are refused:

  ```shell
  curl -s -o /dev/null -w '%{http_code}\n' --cacert domoticz.example.com.crt https://domoticz.example.com:9443/z4d/
  curl -s -o /dev/null -w '%{http_code}\n' --cacert domoticz.example.com.crt https://domoticz.example.com:9443/rest-z4d/1/plugin
  curl -s -o /dev/null -w '%{http_code}\n' --cacert domoticz.example.com.crt https://domoticz.example.com:9443/download/
  ```

  All three must print `401`.

* With the user name and the right password, the REST API answers:

  ```shell
  curl -s -o /dev/null -w '%{http_code}\n' --cacert domoticz.example.com.crt -u zigbee https://domoticz.example.com:9443/rest-z4d/1/plugin
  ```

  `curl` asks for the password, then must print `200`.

* Run the same command with a wrong password, and with any password you used before: it must print `401`.

* Domoticz answers with its own login page (`200`), not with an Apache login:

  ```shell
  curl -s -o /dev/null -w '%{http_code}\n' --cacert domoticz.example.com.crt https://domoticz.example.com:9443/
  ```

  Then open `https://domoticz.example.com:9443/` in a browser: Domoticz must ask for its user name and password (step 2).

Then, from a device that is **not** on your home network (a phone on mobile data, for example):

* `https://domoticz.example.com:9443/z4d/` asks for the user name and password, then opens the WebUI;
* in the WebUI, *Tools* > *Data*, the *Plugin log* item downloads the log file (the item is there when the plugin writes its own log file, `enablePluginLogging`).

Run the checks of step 1 and of this step again after every change to the Apache configuration, to the *Plugin WebUI port*, or to the port forwarding on your Internet box.

## 8- Domoticz custom menu

The *Zigbee* entry the plugin adds to the Domoticz custom menu points to `http://<address>:9440/z4d/`. It does not work through Apache, nor when the *Plugin WebUI port* is `127.0.0.1:9440`.

Create your own entry instead: a file in the `www/templates/` folder of Domoticz, for example `www/templates/Zigbee-Remote.html`:

```html
<iframe id="Zigbee-Remote" style="width:100%;height:800px;overflow:scroll;"></iframe>
<script>
document.getElementById('Zigbee-Remote').src = "/z4d/";
</script>
```

Opened through Apache, Domoticz and the WebUI share the same address, so `/z4d/` is enough.

## References

* [Apache mod_proxy](https://httpd.apache.org/docs/2.4/mod/mod_proxy.html)
* [Apache authentication and authorization](https://httpd.apache.org/docs/2.4/howto/auth.html)
* [Reverse proxy with Caddy](HowTo_Reverse-Proxy-with-Caddy.md)
* [Plugin configuration](Plugin_Configuration.md) (*Plugin WebUI port*)
