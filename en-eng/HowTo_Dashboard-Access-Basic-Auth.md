<a href="Home.md"><img align="left" width="80" height="80" src="../Images/logo_Z4D.png" alt="Logo"></a>

# Protection Plugin Web Admin via Basic Authentication

</br>

## Introduction

The aim of this page is to allow you to acces to the plugin admin page through a basic authentication page.
This method uses nginx and a let's encrypt certificate on rpi with Raspbian but the nginx configuration works on other systems.

**Prefer to use a VPN to your local network or other methods (VPS...) that avoid exposing a web page.**

Adding fail2ban (see below) limits the risk of authentication flood attack but you can still have a vulnerability on your system.

## Prerequisite

First of all, you'll need a domain name to generate and use your ssl certificate. A sub domain is necessary if you're using your main domain. I'll use dashboard.

The port 80 need to be open during the certificate generation process.
We'll add a restrict access by implementing a username/password authentication. Usernames and passwords are taken from a file created and populated by a password file creation tool, in our case, apache2-utils.

You'll need the following tools:

```shell
sudo apt-get install nginx apache2-utils certbot python-certbot-nginx
```

## SSL Certificate for nginx

Be sure that the port 80 is opened.

By following the certbot [instructions](https://certbot.eff.org/lets-encrypt/debianbuster-nginx):

### Choose how you'd like to run Certbot

* Either get and install your certificates...
    Run this command to get a certificate and have Certbot edit your Nginx configuration automatically to serve it, turning on HTTPS access in a single step.

    ```shell
    sudo certbot --nginx
    ```

* Or, just get a certificate.
    If you're feeling more conservative and would like to make the changes to your Nginx configuration by hand, run this command.

    ```shell
    sudo certbot certonly --nginx
    ```

### Renew certificate

The certificate is valid for 90 days.

The Certbot packages on your system come with a cron job or systemd timer that will renew your certificates automatically before they expire. You will not need to run Certbot again, unless you change your configuration. You can test automatic renewal for your certificates by running this command:

```shell
sudo certbot renew --dry-run
```

If, like me, you always close the port 80, you'll have to run the renew command manualy after opening it.

## Add a Restricting Access with HTTP Basic Authentication

You can use online generator or the local tool.

Create a password file and a first user. Run the htpasswd utility with the -c flag (to create a new file), the file pathname as the first argument, and the username as the second argument:

```shell
sudo htpasswd -c /etc/nginx/.htpasswd zigbeefordomoticz
```

Press Enter and type the password for zigbeefordomoticz at the prompts.

You can confirm that the file contains paired usernames and encrypted passwords:

```shell
$ cat /etc/nginx/.htpasswd
zigbeefordomoticz:$apr1$/woC1jnP$KAh0SsVn5qeSMjTtn0E9Q0
```

## Reverse Proxy with HTTP Basic Authentication

Now, we need to configure nginx.

```shell
sudo nano /etc/nginx/sites-enabled/default
```

Add or replace:

```script
server {
        listen 443 ssl;
        listen [::]:443 ssl;

        auth_basic "Restricted website";
        auth_basic_user_file /etc/nginx/.htpasswd;

        server_name dashboard.mydomain.com;
        #change to match your address

        #SSL-settings and generic server options here
        ssl_certificate           /etc/letsencrypt/live/$domain/fullchain.pem;
        ssl_certificate_key       /etc/letsencrypt/live/$domain/privkey.pem;

        ssl on;
        ssl_session_cache  builtin:1000  shared:SSL:10m;
        ssl_protocols  TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers HIGH:!aNULL:!eNULL:!EXPORT:!CAMELLIA:!DES:!MD5:!PSK:!RC4;
        ssl_prefer_server_ciphers on;

        location / {
            root   /home/pi/domoticz/plugins/Domoticz-Zigbee/www;
            index  index.html index.htm;
        }

        location /rest-zigbee {
            proxy_pass http://127.0.0.1:9440/rest-zigbee;
        }
}
```

You'll have to fill the server name (server_name) and complete the path name for the certificates ($domain) if you choose the manual option with certbot, otherwise, it's already filled.

When finished, check your configuration:

```shell
sudo nginx -t
```

and if it's ok, restart nginx:

```shell
sudo service nginx restart
```

Your dashboard is now accessible: <https://dashboard.mydomain.com/>

## OPTION 1 - Add jail with fail2ban

This measure can help to protect your system by checking repeatedly fail on authenticate.
Fail2ban can issue a temporary bans on the offending IP address.
Install fail2ban:

```shell
sudo apt-get install fail2ban
```

Add the jail configuration by opening the jail file:

```shell
sudo nano /etc/fail2ban/jail.local
```

and paste:

```config
[nginx-http-auth]

enabled  = true
filter   = nginx-http-auth
logpath  = /var/log/nginx/error.log
maxretry = 3
findtime = 900
bantime = 900
ignoreip = 127.0.0.1 192.168.1.0/24
```

and restart fail2ban

```shell
sudo service fail2ban restart
```

You can check what is going on:

```shell
sudo fail2ban-client status
```

## OPTION 2 - Use the certificate with DomoticZ

You can use the certificate with DomoticZ by running (replace \<your domain>):

```shell
sudo mv ~/domoticz/server_cert.pem ~/domoticz/server_cert.pem.org
sudo cat /etc/letsencrypt/live/<your domain>/privkey.pem >> ~/domoticz/server_cert.pem
sudo cat /etc/letsencrypt/live/<your domain>/fullchain.pem >> ~/domoticz/server_cert.pem
sudo cp ~/domoticz/server_cert.pem ~/domoticz/letsencrypt_server_cert.pem
sudo service domoticz restart
```

As every update of DomoticZ overwrites your certificate, the last command backups your new certificate so that you may may restore it if needed.
