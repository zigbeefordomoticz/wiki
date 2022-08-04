# Tutoriel - Mettre une authentification sur l'interface web

## Introduction

Ce tutoriel explique comment mettre en place une authentification pour accéder à l'interface web du Plugin.
La méthode utilise [Nginx](https://www.nginx.com) et un certificat [Let's Encrypt](https://letsencrypt.org/). Elle sera expliquée sur Raspbian (Raspberry) mais elle peut-être appliquée sur d'autres distributions Linux.

**Il est recommandé d'utiliser un VPN ou une autre méthode sécurisée (VPS...) pour se connecter depuis l'extérieur au réseau local afin de ne pas exposer la page web sur internet.**

L'utilisation de [Fail2ban](http://www.fail2ban.org) (voir plus bas) limite les risques d'une attaque massive mais vous pouvez toujours avoir une vulnérabilité sur votre système.


## Prérequis

* Avoir un nom de domaine pour pouvoir générer et utiliser un certificat SSL. Un sous-domaine est nécessaire si le domaine principal est utilisé.

L'exemple sera pris pour un domaine nommé __dashboard__.

* Le port 80 devra être ouvert pendant le processus de génération du certificat.


## Méthode

La restriction d'accès sera implantée en utilisant une authentification par utilisateur/mot de passe.
Les utilisateurs/mot de passe seront créer à partir de __apache2-utils__ (un outil de création de fichier de mot de passe).

#### Installation des paquets nécessaire

* Ouvrir un terminal.
* Exécuter la commande : `sudo apt-get install nginx apache2-utils certbot python-certbot-nginx`


#### Création du certificat SSL pour Nginx

* S'assurer que le port 80 est ouvert.
* Suivre les [instructions du certbot](https://certbot.eff.org/lets-encrypt/debianbuster-nginx).


#### Choisir comment exécuter Certbot

##### Automatiquement

La commande va récupérer le certificat et Certbot va éditer la configuration Nginx automatiquement pour que l'accès HTTPS soit activé en une seule étape.

* Exécuter la commande : `sudo certbot --nginx`

##### Ou manuellement

Cette commande est réservée aux personnes souhaitant changer leur configuration Nginx à la main.

* Exécuter la commande : `sudo certbot certonly --nginx`


### Renouvellement du certificat

Le certificat est valide pour une période de 90 jours.

Lors de l'installation de Certbot sur le système, celui-ci paramètre une cron-job pour renouveler automatiquement le certificat avant qu'il n'expire. Il ne sera pas nécessaire d'exécuter le Certbot à nouveau.

* Tester le renouvellement automatique du certificat en exécutant la commande : `sudo certbot renew --dry-run` (l'ouverture du port 80 est nécessaire).


### Ajouter une restriction d'accès via une authentification HTTP basique

Il est possible d'utiliser le générateur en ligne ou l'outil du système.

* Créer un fichier de mot de passe pour un premier utilisateur.
* Exécuter l'utilitaire htpasswd avec la commande : `sudo htpasswd -c /etc/nginx/.htpasswd zigate`
* Indiquer le chemin du fichier
* Indiquer le nom d'utilisateur
* Indiquer le mot de passe

* Vérifier que la commande `cat /etc/nginx/.htpasswd` renvoie bien des informations (le mot de passe est haché).

```
$ cat /etc/nginx/.htpasswd
zigate:$apr1$/woC1jnP$KAh0SsVn5qeSMjTtn0E9Q0
```


### Créer un Reverse Proxy avec une authentification HTTP basique

Configuration de Nginx

* Exécuter la commande : `sudo nano /etc/nginx/sites-enabled/default`
* Ajouter ou remplacer :

```
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
            root   /home/pi/domoticz/plugins/Domoticz-Zigate/www;
            index  index.html index.htm;
        }

        location /rest-zigate {
            proxy_pass http://127.0.0.1:9440/rest-z4d;
        }
}
```

ATTENTION pour les utilisateurs d'une version du plugin supérieur à stable6.1.6 ou beta6.2.117 il faut remplacer

       ```
       location / {
            root   /home/pi/domoticz/plugins/Domoticz-Zigate/www;
            index  index.html index.htm;
        }
        ```     
par
        ```
        location /z4d {
            root   /home/pi/domoticz/plugins/Domoticz-Zigate/www;
            index  index.html index.htm;
         }
         ```
        
Dans le cas d'une configuration manuelle,

   * Modifier le nom du serveur (server_name)
   * Modifier le chemin complet vers le certificat ($domain)

   Ces informations sont pré-remplies avec la configuration automatique.

* Vérifier la configuration : `sudo nginx -t`
* Si ok, redémarrer Nginx : `sudo service nginx restart`

Le tableau de bord devrait être accessible https://dashboard.mydomain.com.

### Option 1 - Ajouter une protection avec fail2ban

Cette mesure permet de protéger votre système en vérifiant les erreurs d'authentification. Fail2ban peut bannir temporairement des IP agressives.

* Installer fail2ban : `sudo apt-get install fail2ban`
* Ajouter la configuration en ouvrant le fichier jail.local : `sudo nano /etc/fail2ban/jail.local`
* Coller :
```
[nginx-http-auth]

enabled  = true
filter   = nginx-http-auth
logpath  = /var/log/nginx/error.log
maxretry = 3
findtime = 900
bantime = 900
ignoreip = 127.0.0.1 192.168.1.0/24
```

* Redémarrer fail2ban : `sudo service fail2ban restart`
* Vérifier le fonctionnement : `sudo fail2ban-client status`

# OPTION 2 - Utiliser le certificat de DomoticZ

Il est possible d'utiliser le certificat de DomoticZ en exécutant (replacer <your domain>):

```
sudo mv ~/domoticz/server_cert.pem ~/domoticz/server_cert.pem.org
sudo cat /etc/letsencrypt/live/<your domain>/privkey.pem >> ~/domoticz/server_cert.pem
sudo cat /etc/letsencrypt/live/<your domain>/fullchain.pem >> ~/domoticz/server_cert.pem
sudo cp ~/domoticz/server_cert.pem ~/domoticz/letsencrypt_server_cert.pem
sudo service domoticz restart
```
Comme chaque mise à jour de DomoticZ écrase votre certificat, la dernière commande créer une sauvegarde de votre certificat qu'il est possible de restaurer si besoin.
