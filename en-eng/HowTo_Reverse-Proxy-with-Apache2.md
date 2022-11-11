# Reverse proxy domoticz and zigbee webui with apache2 on ubuntu

## Prerequisite
- domain name (no-ip for ex) : ben33880.no-ip.com
- apache2 installed, we will use it as reverse proxy, listen 9443 port, local ip : 192.168.1.99
- domoticz running on 192.168.1.99 no certificat needed, default port 8080
- zigbee webui running on 192.168.1.99, default port 9440
- openssl

Apache, domoticz are on the same server with IP 192.168.1.99

Attention: You must remove 127.0.0.* from domoticz parameters (no auth), if not you will access to domoticz without authentication. 

So we will have 2 urls :

- https://ben33880.no-ip.com:9443 => for domoticz UI => protect by domoticz login page
- https://ben33880.no-ip.com:9443/z4d/ => for zigbee web UI => protect by basic auth prompt in the browser

## SSL Certificate for apache2
I use self signed certificate, no lets encrypt => you can have certificate for 2 years.

But u will have to import this certificate in windows, linux, mac, android, ios (not tested) ....

### create configuration file for domoticz certificate :

  ```
    sudo cp /etc/ssl/openssl.cnf /etc/ssl/domoticz.cnf
    sudo nano /etc/ssl/domoticz.cnf
  ```

### modify :
```
 [ v3_req ]

# Extensions to add to a certificate request

basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment

by 

[ v3_req ]

# Extensions to add to a certificate request

basicConstraints = CA:TRUE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = ben33880.no-ip.com
IP.1 = 192.168.1.99
```

### generate certificate : 

  ```
    sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ben33880.no-ip.com.key -out /etc/ssl/certs/ben33880.no-ip.com.crt -config /etc/ssl/domoticz.cnf -extensions 'v3_req'
  ```


## Configure apache2
### install apache2 
```
sudo apt-get install apache2 apache2-utils
```

### install mod :
``` 
sudo a2enmod ssl
sudo a2enmod headers
sudo a2enmod lbmethod_byrequests
sudo a2enmod proxy_balancer
sudo a2enmod proxy_http
sudo a2enmod proxy
sudo a2enmod proxy_wstunnel
```

### disable defaults site :
```
sudo a2dissite 000-default.conf
sudo a2dissite default-ssl.conf
```

### listen only 9443 port :
```
sudo nano /etc/apache2/ports.conf
```

* modifiy ports.conf with :
``` 
<IfModule ssl_module>
        Listen 9443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 9443
</IfModule
```

### create user for basic authentication on zigbee web ui
```
sudo htpasswd -c /etc/apache2/.htpasswd USER_TO_CHANGE
```
  
### configure virtual host

```
sudo cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/domoticz.conf
sudo mv /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf.old
sudo mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.old
sudo nano /etc/apache2/sites-available/domoticz.conf
```
change

```<VirtualHost _default_:443>``` by ```<VirtualHost _default_:9443>```
  
change certificate path :
```
/etc/ssl/certs/ssl-cert-snakeoil.pem by /etc/ssl/certs/ben33880.no-ip.com.crt
/etc/ssl/private/ssl-cert-snakeoil.key by /etc/ssl/certs/ben33880.no-ip.com.key
```
add reverse proxy :
```
Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
ServerName ben33880.no-ip.com
ProxyPreserveHost On
ProxyPass /z4d/  http://127.0.0.1:9440/z4d/
ProxyPassReverse /z4d/ http://127.0.0.1:9440/z4d/
ProxyPass /rest-z4d/  http://127.0.0.1:9440/rest-z4d/
ProxyPassReverse /rest-z4d/ http://127.0.0.1:9440/rest-z4d/
ProxyPass /json ws://127.0.0.1:8080/json
ProxyPass / http://127.0.0.1:8080/
ProxyPassReverse / http://127.0.0.1:8080/
<Proxy "*/z4d*">
        Order deny,allow
        Allow from all
        Authtype Basic
        Authname "Password Required"
        AuthUserFile /etc/apache2/.htpasswd
        Require valid-user
</Proxy>
```

### apply configuration
``` 
sudo a2ensite domoticz.conf
sudo systemctl reload apache2
sudo systemctl restart apache2
```
