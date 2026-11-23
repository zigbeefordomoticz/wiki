# Reverse proxy with Caddy: reach Domoticz and the plugin WebUI from the Internet, with a login

## Overview

The plugin WebUI (port `9440` by default) has **no login of its own**. Whoever can reach that port can use the WebUI and its REST API: change the plugin settings, send commands to your Zigbee devices, download the logs.

So the WebUI port must never be opened on your Internet box. To use it from outside your home:

* **prefer a VPN** to your local network; nothing is exposed;
* otherwise, put a reverse proxy in front of it that asks for a user name and password, and make the WebUI reachable **only through that proxy**. This page does it with [Caddy](https://caddyserver.com/docs/), which also gets and renews the HTTPS certificate for you.

Once done:

* `https://domoticz.example.com/` opens Domoticz;
* `https://domoticz.example.com/z4d/` opens the plugin WebUI;
* both ask for the user name and password you set in Caddy.

## Assumptions

* Caddy runs on the same machine as Domoticz. If it does not, see the note at the end of step 1.
* Domoticz listens on port `8080`, the plugin WebUI on `9440`. Replace them with your values.
* You own a domain name, or a dynamic DNS name, here `domoticz.example.com`.
* You can forward ports `80` and `443` of your Internet box to the Caddy machine, and nothing else.

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
curl -s -o /dev/null -w '%{http_code}\n' --connect-timeout 5 http://<Domoticz address>:9440/z4d/
```

must print `000` (no connection). Any other code means the proxy can be bypassed from your network.

> If Caddy runs on another machine, set the *Plugin WebUI port* to the LAN address of the Domoticz machine (for example `192.168.1.10:9440`). Then block port `9440` on the Domoticz machine for every address except the Caddy machine, for example with `ufw` or `nftables`.

## 2- Install Caddy

Follow the [Caddy installation guide](https://caddyserver.com/docs/install#debian-ubuntu-raspbian) for your system. Prefer Caddy's own package repository: the Caddy packaged by a distribution is often several versions behind, and Caddy is the program facing the Internet.

Check the version:

```shell
caddy version
```

This page uses the `basic_auth` directive, which needs Caddy 2.8 or later. With an older Caddy (2.7.6 for example), write `basicauth` instead, or better, upgrade. From 2.8 on, `basicauth` still works but logs a deprecation warning.

## 3- DNS and Internet box

* Create an `A` (or `CNAME`) record `domoticz.example.com` pointing to your public IP address, or use your dynamic DNS name.
* On your Internet box, forward ports `80` and `443` to the Caddy machine. Caddy uses port `80` to get the Let's Encrypt certificate, and serves everything on `443`.
* Do **not** forward `8080` or `9440`.

## 4- Choose the password

Caddy stores a hash of the password, never the password itself:

```shell
caddy hash-password
```

Type the password twice. Caddy prints a hash: copy it for the next step, exactly as printed. Recent versions print it as is (`$2a$14$…`), older ones base64-encoded (`JDJh…`): use what your own Caddy printed.

**Never use a hash copied from an example**, on this page or anywhere else. A published hash can be attacked offline, as fast as the attacker's computer allows. If you ever did, run `caddy hash-password` again, put the new hash in your Caddyfile, and reload Caddy.

## 5- Write the Caddyfile

Edit `/etc/caddy/Caddyfile` (replace its content, or add this block if Caddy already serves other sites).

> To keep one file per site, put the block in its own file, for example `/etc/caddy/Caddyfile.d/domoticz.caddyfile`, and add this line to `/etc/caddy/Caddyfile`:
>
> ```
> import Caddyfile.d/*.caddyfile
> ```

```
domoticz.example.com {
	encode gzip

	# One login for everything served under this name: Domoticz and the plugin WebUI
	basic_auth {
		zigbee <hash from step 4>
	}

	# Zigbee for Domoticz: the WebUI, its REST API and the log downloads
	@z4d path /z4d /z4d/* /rest-z4d/* /download/*
	handle @z4d {
		reverse_proxy 127.0.0.1:9440
	}

	# Everything else is Domoticz
	handle {
		reverse_proxy 127.0.0.1:8080
	}

	log {
		output file /var/log/caddy/domoticz.log
	}
}
```

`zigbee` is the user name: choose your own. You can add more `user hash` lines, one per person.

**Keep `basic_auth` without a path after it.** In Caddy, a path without `*` matches only that exact path: `basic_auth / { … }` protects the home page and nothing else, and leaves `/z4d/`, `/rest-z4d/` and all of Domoticz open.

Check the configuration, then reload Caddy:

```shell
caddy validate --config /etc/caddy/Caddyfile
sudo systemctl reload caddy
```

Always validate the main `/etc/caddy/Caddyfile`: it also checks the files it imports, as Caddy will load them. If `caddy validate` fails:

| Message | Cause | Fix |
| --- | --- | --- |
| `decoding config: invalid character '…' looking for beginning of value` | The file given to `--config` is not named `Caddyfile`, so Caddy read it as JSON | Validate `/etc/caddy/Caddyfile`, or add `--adapter caddyfile` |
| `unrecognized directive: basic_auth` | Caddy is older than 2.8 | Write `basicauth`, or upgrade Caddy (step 2) |

### Domoticz keeps its own login

Requests reach Domoticz from Caddy, so from `127.0.0.1`. Check that Domoticz still asks for its own user name and password when you open it through Caddy. If it does not, look in the Domoticz settings for the list of networks that may connect without a user name and password (*Local Networks*, or *Trusted Networks* depending on the version): an entry covering `127.0.0.1` lets every request coming through Caddy in without a Domoticz login.

### Domoticz mobile apps

Some Domoticz mobile apps cannot send a Caddy user name and password. If you need one of them, move the `basic_auth` block inside `handle @z4d { … }`: the plugin WebUI keeps the Caddy login, and Domoticz relies on its own login only.

## 6- Check the login

Run these from any computer that can reach `domoticz.example.com`. Use the user name you put in the Caddyfile instead of `zigbee`.

* Without a user name and password, the WebUI and its REST API are refused:

  ```shell
  curl -s -o /dev/null -w '%{http_code}\n' https://domoticz.example.com/z4d/
  curl -s -o /dev/null -w '%{http_code}\n' https://domoticz.example.com/rest-z4d/1/plugin
  ```

  Both must print `401`.

* With the user name and the right password, the REST API answers:

  ```shell
  curl -s -o /dev/null -w '%{http_code}\n' -u zigbee https://domoticz.example.com/rest-z4d/1/plugin
  ```

  `curl` asks for the password, then must print `200`.

* Run the same command with a wrong password, and with any password you used before: it must print `401`.

* Domoticz:

  ```shell
  curl -s -o /dev/null -w '%{http_code}\n' https://domoticz.example.com/
  ```

  prints `401` with the Caddyfile of step 5. With the mobile-app variant (login on the WebUI only), it prints `200`, and the page is the Domoticz login.

Then, from a device that is **not** on your home network (a phone on mobile data, for example):

* `https://domoticz.example.com/z4d/` asks for the user name and password, then opens the WebUI;
* in the WebUI, *Tools* > *Data*, the *Plugin log* item downloads the log file (the item is there when the plugin writes its own log file, `enablePluginLogging`).

Run the checks of step 1 and of this step again after every change to the Caddyfile, to the *Plugin WebUI port*, or to the port forwarding on your Internet box.

## 7- Domoticz custom menu

The *Zigbee* entry the plugin adds to the Domoticz custom menu points to `http://<address>:9440/z4d/`. It does not work through Caddy, nor when the *Plugin WebUI port* is `127.0.0.1:9440`.

Create your own entry instead: a file in the `www/templates/` folder of Domoticz, for example `www/templates/Zigbee-Remote.html`:

```html
<iframe id="Zigbee-Remote" style="width:100%;height:800px;overflow:scroll;"></iframe>
<script>
document.getElementById('Zigbee-Remote').src = "/z4d/";
</script>
```

Opened through Caddy, Domoticz and the WebUI share the same address, so `/z4d/` is enough and the login is not asked twice.

## References

* [Caddy documentation](https://caddyserver.com/docs/)
* [Caddy `basic_auth` directive](https://caddyserver.com/docs/caddyfile/directives/basic_auth)
* [Caddy request matchers](https://caddyserver.com/docs/caddyfile/matchers) (exact and prefix paths)
* [Plugin configuration](Plugin_Configuration.md) (*Plugin WebUI port*)
