# Revenir à python3.8 par défaut sur RaspberryOS 11 (bullseye)

Domoticz a des soucis avec python3.9 sur raspberry pi, or c’est désormais la version par défaut de python avec RaspberryOS. Nous allons donc voir comment revenir à la version précédente de python pour permettre à domoticz de fonctionner correctement.

On parle ici de changer de version de python pour un serveur domotique. Je pars donc du principe qu’il s’agit d’un serveur sans écran, clavier ou souris et que vous savez vous connecter dessus à distance (pour ma part en SSH) et utiliser un terminal. Avec une interface graphique vous pourrez aussi suivre ces instructions mais je ne parle que de lignes de commande, vous devrez donc tout taper dans un terminal vous aussi.

Pour mettre tout à plat, on va commencer par mettre à jour le système :

```
sudo apt update
sudo apt upgrade
sudo apt dist-upgrade
```

Si une de ces commandes renvoie des erreurs, n’allez pas plus loin et aidez-vous d’un ami ou un moteur de recherche pour corriger le problème avant de continuer.

Ensuite, nous allons identifier les packages de python en version 3.9 installés sur le système :

```shellsession
$ dpkg -l | grep python3.9
ii libpython3.9:armhf 3.9.2-1+rpi1 armhf Shared Python runtime library (version 3.9)
ii libpython3.9-dev:armhf 3.9.2-1+rpi1 armhf Header files and a static library for Python (v3.9)
ii libpython3.9-minimal:armhf 3.9.2-1+rpi1 armhf Minimal subset of the Python language (version 3.9)
ii libpython3.9-stdlib:armhf 3.9.2-1+rpi1 armhf Interactive high-level object-oriented language (standard library, version 3.9)
ii python3.9 3.9.2-1+rpi1 armhf Interactive high-level object-oriented language (version 3.9)
ii python3.9-dev 3.9.2-1+rpi1 armhf Header files and a static library for Python (v3.9)
ii python3.9-minimal 3.9.2-1+rpi1 armhf Minimal subset of the Python language (version 3.9)
```

Sur ce système relativement propre, on retrouve les packages python standards et les packages « -dev » nécessaires au système de plugins de domoticz.

Regardons maintenant ce qui est installé concernant python3.8. Il est possible que quelques packages soit installés soit historiquement, soit en raison de dépendances d’autres packages.

```shellsession
$ dpkg -l | grep python3.8
ii libpython3.8:armhf 3.8.7-1 armhf Shared Python runtime library (version 3.8)
ii libpython3.8-minimal:armhf 3.8.7-1 armhf Minimal subset of the Python language (version 3.8)
ii libpython3.8-stdlib:armhf 3.8.7-1 armhf Interactive high-level object-oriented language (standard library, version 3.8)
```

Nous allons donc devoir installer le complément. Adaptez la liste des packages à installer en fonction des 2 listes disponibles sur votre machine. Dans mon exemple, je vais donc installer les packages suivants : libpython3.8-dev, python3.8, python3.8-dev et python3.8-minimal. Je peux même finasser et ne demander l’installation que de python3.8-dev puisque il dépend des 3 autres packages, apt les installera tous.

```shellsession
$ sudo apt install python3.8-dev
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
libpython3.8-dev python3.8 python3.8-minimal
Suggested packages:
python3.8-venv python3.8-doc binfmt-support
The following NEW packages will be installed:
libpython3.8-dev python3.8 python3.8-dev python3.8-minimal
0 upgraded, 4 newly installed, 0 to remove and 0 not upgraded.
Need to get 5.422 kB of archives.
After this operation, 19,1 MB of additional disk space will be used.
Do you want to continue? [Y/n]
Get:1 http://mirrors.ircam.fr/pub/raspbian/raspbian bullseye/main armhf python3.8-minimal armhf 3.8.7-1 [1.557 kB]
Get:2 http://mirrors.ircam.fr/pub/raspbian/raspbian bullseye/main armhf libpython3.8-dev armhf 3.8.7-1 [2.927 kB]
Get:3 http://mirrors.ircam.fr/pub/raspbian/raspbian bullseye/main armhf python3.8 armhf 3.8.7-1 [427 kB]
Get:4 http://mirrors.ircam.fr/pub/raspbian/raspbian bullseye/main armhf python3.8-dev armhf 3.8.7-1 [511 kB]
Fetched 5.422 kB in 1s (5.099 kB/s)
Selecting previously unselected package python3.8-minimal.
(Reading database ... 69731 files and directories currently installed.)
Preparing to unpack .../python3.8-minimal_3.8.7-1_armhf.deb ...
Unpacking python3.8-minimal (3.8.7-1) ...
Selecting previously unselected package libpython3.8-dev:armhf.
Preparing to unpack .../libpython3.8-dev_3.8.7-1_armhf.deb ...
Unpacking libpython3.8-dev:armhf (3.8.7-1) ...
Selecting previously unselected package python3.8.
Preparing to unpack .../python3.8_3.8.7-1_armhf.deb ...
Unpacking python3.8 (3.8.7-1) ...
Selecting previously unselected package python3.8-dev.
Preparing to unpack .../python3.8-dev_3.8.7-1_armhf.deb ...
Unpacking python3.8-dev (3.8.7-1) ...
Setting up libpython3.8-dev:armhf (3.8.7-1) ...
Setting up python3.8-minimal (3.8.7-1) ...
Setting up python3.8 (3.8.7-1) ...
Setting up python3.8-dev (3.8.7-1) ...
Processing triggers for desktop-file-utils (0.26-1) ...
Processing triggers for man-db (2.9.4-2) ...
Processing triggers for mailcap (3.69) ...
$
```

Voilà, python3.8 est installé mais c’est toujours python3.9 qui est utilisé par défaut.

```shellsession
$ python --version
Python 3.9.2
$ python3 --version
Python 3.9.2
```

La solution passe par l’outil update-alternatives, nous allons l’utiliser définir une politique pour les commandes python et python3 qui utiliseront désormais python3.8.

```shellsession
$ sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1
update-alternatives: using /usr/bin/python3.9 to provide /usr/bin/python (python) in auto mode
$ sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 10
update-alternatives: using /usr/bin/python3.8 to provide /usr/bin/python (python) in auto mode
$ sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
update-alternatives: using /usr/bin/python3.9 to provide /usr/bin/python3 (python3) in auto mode
$ sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 10
update-alternatives: using /usr/bin/python3.8 to provide /usr/bin/python3 (python3) in auto mode
$
```

J’ai mis une priorité de 10 à python3.8 et 1 à python3.9, ainsi le choix en mode automatique passe sur l’option à la priorité la plus haute. Il est toujours possible ensuite de changer la priorité (en repassant les commandes précédentes en changeant juste le dernier paramètre) ou séléctionner manuellement l’option de votre choix via l’option –config :

```shellsession
$ sudo update-alternatives --config python
There are 2 choices for the alternative python (providing /usr/bin/python).

Selection Path Priority Status
------------------------------------------------------------
* 0 /usr/bin/python3.8 10 auto mode
1 /usr/bin/python3.8 10 manual mode
2 /usr/bin/python3.9 1 manual mode

Press <enter> to keep the current choice[*], or type selection number:
$
```

On peut aussi vérifier que le changement de version par défaut est bien passé :

```shellsession
$ python --version
Python 3.8.7
$ python3 --version
Python 3.8.7
```

Pour finir, il faut retirer les packages -dev liés à python 3.9, sinon domoticz continue d’essayer de démarrer le système de plugins avec python 3.9 sans considérer la configuration système par défaut. Il y a peut-être une solution plus propre que de désinstaller ces packages, si vous la trouvez n’hésitez pas à me le faire savoir dans les commentaires par exemple.

```shellsession
$ sudo apt remove libpython3.9-dev
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages were automatically installed and are no longer required:
javascript-common libjs-jquery libjs-sphinxdoc libjs-underscore python3-distutils python3-lib2to3
Use 'sudo apt autoremove' to remove them.
The following packages will be REMOVED:
libpython3-dev libpython3.9-dev python3-dev python3.9-dev
0 upgraded, 0 newly installed, 4 to remove and 0 not upgraded.
After this operation, 14,7 MB disk space will be freed.
Do you want to continue? [Y/n]
(Reading database ... 69924 files and directories currently installed.)
Removing python3-dev (3.9.2-3) ...
Removing libpython3-dev:armhf (3.9.2-3) ...
Removing python3.9-dev (3.9.2-1+rpi1) ...
Removing libpython3.9-dev:armhf (3.9.2-1+rpi1) ...
Processing triggers for man-db (2.9.4-2) ...
$
```

Il ne reste plus qu’à relancer domoticz Merci de m’avoir lu, j’espère que cet article vous aura été utile !
