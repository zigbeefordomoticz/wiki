# Reverse proxy with nginx: reach Domoticz and the plugin WebUI over HTTPS, with a login

## Overview

The plugin WebUI (port `9440` by default) has **no login of its own**. Whoever can reach that port can use the WebUI and its REST API: change the plugin settings, send commands to your Zigbee devices, download the logs.

So the WebUI port must never be opened on your Internet box. To use it from outside your home:

* **prefer a VPN** to your local network; nothing is exposed;
* otherwise, put a reverse proxy in front of it that asks for a user name and password, and make the WebUI reachable **only through that proxy**. This page does it with nginx and a Let's Encrypt certificate on Debian / Ubuntu / Raspberry Pi OS. [Reverse proxy with Caddy](HowTo_Reverse-Proxy-with-Caddy.md) does the same with less configuration, and [Reverse proxy with Apache 2](HowTo_Reverse-Proxy-with-Apache2.md) with Apache.

Once done:

* `https://domoticz.example.com/` opens Domoticz;
* `https://domoticz.example.com/z4d/` opens the plugin WebUI;
* both are behind an nginx login (the browser asks for a user name and password), and Domoticz keeps its own login as well.

## Assumptions

* nginx, Domoticz and the plugin run on the same machine, here `192.168.1.10`.
* Domoticz listens on port `8080`, the plugin WebUI on `9440`. Replace them with your values.
* You have a domain name, or a dynamic DNS name, here `domoticz.example.com`, that points to your Internet box.
* Port `80` can be forwarded to the machine while the certificate is created and renewed.

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

Requests reach Domoticz from nginx, so from `127.0.0.1`. In the Domoticz settings, the list of networks that may connect without a user name and password (*Local Networks*, or *Trusted Networks* depending on the version) must **not** cover `127.0.0.1` (for example `127.0.0.*`). Otherwise every request coming through nginx gets into Domoticz without a Domoticz login.

## 3- Install nginx and get the certificate

```shell
sudo apt-get install nginx apache2-utils certbot python3-certbot-nginx
nginx -v
```

`apache2-utils` only provides `htpasswd`, used in step 4; it does not install Apache.

Forward port `80` of your Internet box to `192.168.1.10:80`, then get the certificate:

```shell
sudo certbot certonly --nginx -d domoticz.example.com
```

`certbot` prints where it saved the certificate, normally `/etc/letsencrypt/live/domoticz.example.com/`. The certificate is valid 90 days, and the `certbot` package renews it automatically, through port `80`. Check that renewal works:

```shell
sudo certbot renew --dry-run
```

If you close port `80` again, the automatic renewal fails: open it and run `sudo certbot renew` before the certificate expires.

## 4- Create the login

Create the password file and a first user. `-B` stores the password as a bcrypt hash; `-c` creates the file, leave it out to add more users later:

```shell
sudo htpasswd -B -c /etc/nginx/.htpasswd zigbee
```

`zigbee` is the user name: choose your own. Give nginx read access to the file, and nobody else:

```shell
sudo chown root:www-data /etc/nginx/.htpasswd
sudo chmod 640 /etc/nginx/.htpasswd
```

## 5- Configure the site

Create `/etc/nginx/sites-available/domoticz`:

```nginx
# WebSocket upgrade for Domoticz (its live updates go through /json)
map $http_upgrade $connection_upgrade {
    default upgrade;
    ''      close;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name domoticz.example.com;

    ssl_certificate     /etc/letsencrypt/live/domoticz.example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/domoticz.example.com/privkey.pem;
    ssl_protocols       TLSv1.2 TLSv1.3;

    add_header Strict-Transport-Security "max-age=31536000" always;

    # One login for everything served under this name: Domoticz and the plugin WebUI
    auth_basic           "Zigbee for Domoticz";
    auth_basic_user_file /etc/nginx/.htpasswd;

    proxy_http_version 1.1;

    # Zigbee for Domoticz: the WebUI, its REST API and the log downloads
    location ~ ^/(z4d|rest-z4d|download)(/|$) {
        proxy_pass http://127.0.0.1:9440;
    }

    # Everything else is Domoticz
    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host       $host;
        proxy_set_header Upgrade    $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
    }
}
```

**Keep `auth_basic` at the `server` level.** There it applies to every `location`, so no path is left without a login. The WebUI is `/z4d/`, but it reads and changes everything through `/rest-z4d/`, and downloads the logs through `/download/`: a login on `/z4d/` alone leaves the REST API open to anyone.

`proxy_pass` has no path after the port, so nginx passes the request path to the plugin as it is.

Enable the site, check the configuration, then reload nginx:

```shell
sudo ln -s /etc/nginx/sites-available/domoticz /etc/nginx/sites-enabled/domoticz
sudo nginx -t
sudo systemctl reload nginx
```

`nginx -t` must end with `test is successful`.

### Domoticz mobile apps

Some Domoticz mobile apps cannot send an nginx user name and password. If you need one of them, move the two `auth_basic` lines from the `server` level into the `location ~ ^/(z4d|rest-z4d|download)(/|$)` block: the plugin WebUI keeps the nginx login, and Domoticz relies on its own login only.

## 6- Internet box

Forward port `443` of your Internet box to `192.168.1.10:443`, and port `80` only as long as `certbot` needs it (step 3). Do **not** forward `8080` or `9440`.

## 7- Check the login

Run these from any computer that can reach `domoticz.example.com`. Use the user name you created instead of `zigbee`.

* Without a user name and password, the WebUI, its REST API and the downloads are refused:

  ```shell
  curl -s -o /dev/null -w '%{http_code}\n' https://domoticz.example.com/z4d/
  curl -s -o /dev/null -w '%{http_code}\n' https://domoticz.example.com/rest-z4d/1/plugin
  curl -s -o /dev/null -w '%{http_code}\n' https://domoticz.example.com/download/
  ```

  All three must print `401`.

* With the user name and the right password, the REST API answers:

  ```shell
  curl -s -o /dev/null -w '%{http_code}\n' -u zigbee https://domoticz.example.com/rest-z4d/1/plugin
  ```

  `curl` asks for the password, then must print `200`. `500` with the right password means the system cannot check bcrypt hashes: create the user again without `-B` (step 4).

* Run the same command with a wrong password, and with any password you used before: it must print `401`.

* Domoticz:

  ```shell
  curl -s -o /dev/null -w '%{http_code}\n' https://domoticz.example.com/
  ```

  prints `401` with the configuration of step 5. With the mobile-app variant (login on the WebUI only), it prints `200`, and the page is the Domoticz login.

Then, from a device that is **not** on your home network (a phone on mobile data, for example):

* `https://domoticz.example.com/z4d/` asks for the user name and password, then opens the WebUI;
* in the WebUI, *Tools* > *Data*, the *Plugin log* item downloads the log file (the item is there when the plugin writes its own log file, `enablePluginLogging`).

Run the checks of step 1 and of this step again after every change to the nginx configuration, to the *Plugin WebUI port*, or to the port forwarding on your Internet box.

## 8- Domoticz custom menu

The *Zigbee* entry the plugin adds to the Domoticz custom menu points to `http://<address>:9440/z4d/`. It does not work through nginx, nor when the *Plugin WebUI port* is `127.0.0.1:9440`.

Create your own entry instead: a file in the `www/templates/` folder of Domoticz, for example `www/templates/Zigbee-Remote.html`:

```html
<iframe id="Zigbee-Remote" style="width:100%;height:800px;overflow:scroll;"></iframe>
<script>
document.getElementById('Zigbee-Remote').src = "/z4d/";
</script>
```

Opened through nginx, Domoticz and the WebUI share the same address, so `/z4d/` is enough.

## Option: ban repeated login failures with fail2ban

fail2ban reads the nginx error log and bans, for a while, an address that keeps failing the login.

```shell
sudo apt-get install fail2ban
sudo nano /etc/fail2ban/jail.local
```

```ini
[nginx-http-auth]
enabled  = true
backend  = auto
logpath  = /var/log/nginx/error.log
maxretry = 3
findtime = 15m
bantime  = 1h
ignoreip = 127.0.0.1/8 ::1 192.168.1.0/24
```

`ignoreip` keeps your own network from being banned: use your network's range.

```shell
sudo systemctl restart fail2ban
sudo fail2ban-client status nginx-http-auth
```

## References

* [nginx `ngx_http_auth_basic_module`](https://nginx.org/en/docs/http/ngx_http_auth_basic_module.html)
* [nginx `ngx_http_proxy_module`](https://nginx.org/en/docs/http/ngx_http_proxy_module.html)
* [Certbot](https://certbot.eff.org/)
* [Reverse proxy with Caddy](HowTo_Reverse-Proxy-with-Caddy.md)
* [Reverse proxy with Apache 2](HowTo_Reverse-Proxy-with-Apache2.md)
* [Plugin configuration](Plugin_Configuration.md) (*Plugin WebUI port*)
