# Cette page contient les anciennes informations présentent dans la page Installation du plugin.

__Les informations contenues dans cette page sont dépassées.  Se reporter à la page [Installation du plugin](../Plugin_Installation.md)__


------------

## 5 - Installation sous Windows 10

Rédaction par [@Pipiche38](https://github.com/pipiche38)

__Cette procédure n'est pas encore mise à jour pour être compatible avec la version 6 du plugin.__

Cette méthode est uniquement valable pour les systèmes Windows 10.

### 5.1 - Avant-propos

La majeure partie du développement du plugin est réalisée sous Linux (Raspbian, Fedora) en s'appuyant sur du code Python pour permettre l'exécution sur plateforme Windows.

Néanmoins, installer l’ensemble DomoticZ et ZiGate sous Windows 10 n’est pas réellement plug and play.

On est très vite confronté à chercher des informations éparpillées sur le net, à lire des retours d’expérience dans de nombreux forums et tenter d’éviter les pièges sous Windows.

Après plusieurs tests et échecs, je vous fais part de mon expérience qui m’a permis en partie de comprendre et de solutionner les problèmes d’installation avec un peu de rigueur.

Un conseil : installer tous les logiciels en mode Administrateur ! (Clic droit dans Windows, exécuter en tant qu’administrateur). Sinon, vous risquez d’installer partiellement un logiciel et ne pas vous en rendre compte sur le coup.

### 5.2 - Procédure

#### 5.2.A - Installation de DomoticZ

Le premier conseil est d’installer DomoticZ (version stable par exemple) dans un répertoire autre que le classique Programmes (x86) par défaut. Sinon, il faudra jouer avec les droits utilisateurs. Si tel est le cas, pour modifier les droits, ouvrez l’explorateur Windows, faire clic-droit sur le disque C :, puis propriétés, onglet sécurité :

![Win10 Installation](../Images/Win10Pic1png.png)

Attention, DomoticZ et ZiGate ont besoin d’écrire des fichiers dans des sous répertoires et un droit d’accès manquant pourra faire apparaître dans l’onglet  « Configuration/log » de  DomoticZ ce type de message :

![Win10 Installation](../Images/Win10Pic2.png)

Même en attribuant le maximum de droits autorisés (administrateur, utilisateur avec droits en écriture ...), il m’est arrivé d’obtenir ce message (peut être un oubli…).
Pour éviter tout problème, j’ai finalement choisi d’installer DomoticZ directement à la racine sous C:\Domoticz et depuis aucun problème.

#### 5.2.B - Installation de la ZiGate

Il est recommandé d’installer la ZiGate selon les instructions disponibles sur le site officiel : <https://zigate.fr/documentation/tester-la-zigate-usb>

Installer les pilotes (pour le convertisseur USB rouge, allez sur le site de siliconlabs et télécharger CP210x Universal Windows Driver )

Tester l’application TestGUI (vous pouvez télécharger le fichier zip en allant dans la rubrique code sur le site <https://github.com/fairecasoimeme/ZiGate> puis le dézipper dans un répertoire dédié).
Vous pouvez également utiliser un client Git pour Windows (voir 3.2 ci après)

L’application se situe dans un sous répertoire Tools et se nomme ZGWUI.exe

Vérifier que la ZiGate est correctement installée et fonctionnelle en effectuant les tests mentionnés sur le site de ZiGate

#### 5.2.C - Logiciels additionnels

Pour la suite, deux logiciels sont nécessaires et utiles pour réaliser une installation propre sous Windows.

##### 5.2.C.1 - Python

Installer une version de Python prenant en charge DomoticZ comme indiqué dans le Wiki: [Using Python plugins in DomoticZ](https://www.domoticz.com/wiki/Using_Python_plugins#Installing_Python_for_Windows)

Installer une version 32 bits pour Windows à partir du site Python.org (par exemple, 3.5.2 et 32 bits) : <https://www.python.org/downloads/windows>

Si la version est compatible avec DomoticZ, un message de statut dans l’onglet « Configuration/Log » de DomoticZ l’indiquera au démarrage:

![Win10 Installation](../Images/Win10Pic3.png)

Autrement, un message du type Python Failed apparaîtra

Pour avoir testé plusieurs versions avec échec et succès, j’ai finalement opté pour conserver la version 3.5.2 (mentionnée dans le wiki DomoticZ)  qui a fonctionné correctement et j’ai supprimé toutes les autres .

Il est possible cependant d’installer et de conserver plusieurs versions de python sur son ordinateur. Pour connaître la version active en cours, cliquer sur l’icône Démarrer Windows, puis entrer CMD dans la barre de recherche afin de lancer l’invite de commande (clic droit, exécuter en tant qu’administrateur). Enfin taper : `python --version`

Gérer plusieurs version python avec py sous Windows n’est pas forcément simple mais des explications sont disponibles à la fin du Wiki consacré à Python et DomoticZ [Using Python plugins in DomoticZ](https://www.domoticz.com/wiki/Using_Python_plugins#Installing_Python_for_Windows)

Il est fort possible que la librairie libpython utile à DomoticZ ne soit pas installée (vérifiez si un fichier du type libpython3.x existe dans le sous répertoire « libs » de python). S’il n’existe pas, effectuez la même opération avec la commande :  `py -m pip install libpython3.5`
Cela donne donc : C:\Program Files (x86)\Python35-32>py -m pip install libpython3.5

En fonction de la version x de Python installée, vous devez installer libpython3.x
Attendre que l’installation du package soit terminé (vous devez être connecté à Internet)

##### 5.2.C.2 - Git pour Windows

De nombreux packages de plugin sont disponibles sur GitHub pour DomoticZ. C’est le cas notamment pour la ZiGate.

Sous Windows, le plus simple pour gérer ce type de packages est de télécharger et d’installer  un client de téléchargement « git » en allant sur le site officiel : <https://gitforwindows.org/>

#### 5.2.D. - Installation du plugin ZiGate

La dernière étape consiste à installer le plugin de Pipiche pour gérer la ZiGate dans DomoticZ.

Cependant, le répertoire ou sont installés les plugins n’existe pas lors de l’installation de DomoticZ. Il faut donc le créer manuellement.

Pour cela, ouvrez l’explorateur Windows et allez dans le répertoire où est installé DomoticZ (pour mon cas,  C:\DomoticZ)
Clic droit sur DomoticZ, puis Nouveau Dossier que vous nommerez plugins
En exécutant une invite de commande CMD en mode administrateur, positionnez vous dans le répertoire plugins puis taper la ligne d’instruction : `git clone https://github.com/pipiche38/Domoticz-Zigate.git`

L’arborescence de la ZiGate est installée :

![Win10 Installation](../Images/Win10Pic4.png)

Le plugin ZigBee for DomoticZ doit apparaître dans la liste des matériels.
Passer à l'[étape 2 Paramétrage du plugin](Plugin_Parametrage.md).

### 5.3 - Un PC Windows comme box domotique

Avec l’apparition des mini PC fanless sous Windows 10 pour une centaine d’euros, il est tentant de se constituer sa box à l’aide du logiciel DomoticZ et de la clé ZiGate USB avec protocole ZigBee .

Mais en cas de coupure de courant, une box domotique doit être en état de repartir. DomoticZ étant dans le groupe de démarrage, l’application se relance automatiquement.

Malheureusement, l’invite de Windows 10, en vous demandant d’introduire votre mot de passe, interrompt ce processus de lancement automatique.

Pour éviter ce désagrément (surtout lorsqu’on est absent du domicile), il est possible d’éviter d’entrer le mot de passe du compte courant à l’invite de Windows (l’inconvénient est un PC accessible à tous, à vous de choisir).

Pour cela, taper `netplwiz` dans l’invite de commande Windows et exécuter la commande

------------



------------
## 3 - Installation sur NAS Synology

Cette méthode est uniquement valable pour les systèmes NAS Synology.

__Note :__ Jahdal a arrêté son développement en 2020. La dernière version disponible est DomoticZ Béta 2020.2 for DSM 6.2.


### 3.A - Prérequis


* Avant tout, Python doit être installé (voir [Domoticz Python page](https://www.domoticz.com/wiki/Synology_installation_folder)).
* Le paquet DomoticZ pour Synology à installer est la version 'avec Python'. Vous pouvez la télécharger depuis Jahdal. Au moment de l'écriture de ces lignes, c'est la version v2020.1 avec Python 3.5.1.
* Le Module Python du Package manager doit être installé (voir [Python Module](https://www.synology.com/en-uk/dsm/packages/PythonModule))
* Le paquet GitHub server pour Synology doit être installé.
* Installer le paquet Git Server via Diskstation. La partie Serveur du paquet Git Server n'est pas nécessaire, juste le 'git command' (pas de configurations spécifiques).
* Vous devez avoir les accès root/admin avec la commande 'sudo'.
* Si besoin, les drivers pour la ZiGate sont disponibles sur le site [jadahl.com](http://www.jadahl.com/drivers_6.2/).


### 3.B - Procédure

* Démarrer une session __Putty__
* Se loguer

* Aller jusqu'au dossier __plugins__ de DomoticZ : `cd /volume1/@appstore/domoticz/var/plugins`
* Faire un clone du Git du plugin ZiGate dans un nouveau dossier : `sudo git clone https://github.com/sasu-drooz/Domoticz-Zigate.git Zigate`
* Arrêter et redémarrer DomoticZ depuis le gestionnaire de paquet.

Le plugin ZiGate doit apparaître dans la liste des matériels.
Passer à l'[étape 2 Paramétrage du plugin](Plugin_Parametrage.md).


------------
## 4 - Installation sur Docker

Cette méthode est uniquement valable pour les systèmes Docker.

### 4.1 - Prérequis

* Docker doit être installé (voir [Get Docker](https://docs.docker.com/get-docker/))


### 4.2 - Procédure

#### 4.2.A - Récupérer Docker-DomoticZ

Avant de pouvoir exécuter le Docker DomoticZ, il faut le récupérer. Il y a deux possibilités :
* Créer votre propre image Docker DomoticZ
* Récupérer une image existante depuis le dépôt Docker


##### 4.2.A.1 - Créer votre propre image Docker DomoticZ

* Dans un dossier, créer un fichier **dockerfile** avec le contenu suivant :
```
#name of container: docker-domoticz
#versison of container: 0.1.0
FROM debian:buster-slim
LABEL MAINTAINER your_name  "your_mail"

#add repository and update the container
#Installation of nesesary package/software for this containers...
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q build-essential\
                    netcat \
                    cmake  \
                    libsqlite3-dev curl libusb-dev \
                    zlib1g-dev libssl-dev git\
                    libudev-dev \
                    python3 \
                    python3-dev \
                    python \
                    python-dev \
                    python-libxml2 \
                    libxml2-dev \
                    python-pip \
                    python3-pip \
                    libxslt-dev \
                    lib32z1-dev \
                    liblua5.3 \
                    liblua5.3-dev \
                    libcereal-dev \
                    wget libssl-dev git libcurl4-gnutls-dev libcereal-dev uthash-dev\
                    && apt-get clean \
                    && rm -rf /tmp/* /var/tmp/*  \
                    && rm -rf /var/lib/apt/lists/*

# Rebuild cmake because stable version (3.0.2) incompatible with openssl
RUN wget -O- https://github.com/Kitware/CMake/releases/download/v3.17.0/cmake-3.17.0.tar.gz | tar xzv \
            && cd cmake-3.17.0 \
            && ./configure --prefix=/opt/cmake \
            && make \
            && make install \
            && cd ../

RUN wget -O- https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz | tar zxv \
            && cd boost_1_72_0 \
            && ./bootstrap.sh \
            && ./b2 install

RUN pip3 install caldav
RUN pip3 install broadlink
RUN pip3 install pycrypto
RUN pip3 install pyaes

#Compile Domoticz
RUN cd /opt && git clone -b development https://github.com/domoticz/domoticz.git domoticz && cd domoticz;git checkout external-libs;/opt/cmake/bin/cmake -J4 -DCMAKE_BUILD_TYPE=Release -DUSE_PYTHON=YES -DPython_ADDITIONAL_VERSIONS=3.5 . ;\
    make CMAKE_COMMAND=/opt/cmake/bin/cmake #&& make CMAKE_COMMAND=/opt/cmake/bin/cmake install

RUN mkdir -p /opt/domoticz/backup  /opt/scripts /opt/domoticz/db

VOLUME ["/opt/domoticz/scripts", "/opt/domoticz/backups",  "/opt/domoticz/db", "/opt/domoticz/plugins", " /opt/domoticz/www/images/floorplans", " /opt/domoticz/www/templates"]

# to allow access from outside of the container  to the container service
# at that ports need to allow access from firewall if need to access it outside of the server.
EXPOSE 8080 9440

# Use baseimage-docker's init system.
CMD ["/opt/domoticz/domoticz"]

```
Comme pour installation normale, vous pouvez ajouter des nouveaux paquets avec apt-get. Plus d''informations voir [Fichier Docker](https://docs.docker.com/engine/reference/builder/)


* Ensuite, créer votre image Docker localement avec la commande : `docker build -t docker-domoticz .`


##### 4.2.A.2 - Récupérer une image existante depuis le dépôt Docker

* Aller sur [docker hub](https://hub.docker.com/)
* Rechercher DomoticZ
* Lancer la commande `docker pull image-name` en remplaçant __image-name__ par l'image trouvée



#### 4.2.B - Exécuter l'image Docker DomoticZ

Si vous avez des scripts, plugins ... mettez les dans un répertoire et définissez le chemin avant de lancer la commande.

* Exécuter la commande : `docker run --privileged -d -p 8080:8080 -p 9440:9440 --name=Domoticz -v <Local path for your scripts>:/scripts -v <Local path for your plugins>:/opt/domoticz/plugins -v <Local path for your floorplans>:/opt/domoticz/www/images/floorplans -v /etc/localtime:/etc/localtime:ro -v <Local path for your domoticz.db>:/opt/domoticz/domoticz.db Your_Image_Name`

Si vous avez des plugins qui ont besoin d'un accès réseau (comme la ZiGate Wifi), il faut ajouter `--network host` à la commande au-dessus.



#### 4.2.C - Récupérer les logs Docker


Pour récupérer les logs complets depuis Docker, exécuter : `docker logs Domoticz`


#### 4.2.D - Connexion au Docker actif

* Exécuter la commande `docker exec -it Domoticz bash`


Le plugin ZiGate doit apparaître dans la liste des matériels.
Passer à l'[étape 2 Paramétrage du plugin](Plugin_Parametrage.md).


### 3.C - Erreurs connues

Il y a des erreurs connues dans Synology qui font planter DomoticZ au lancement du plugin ZiGate.
Il faut désactiver le plugin ZiGate et vérifier s'il y a une mise à jour du plugin ou du firmware.

Éditer le fichier __Domoticz-Zigate/Conf/PluginConf-xx.json__

Et ajouter la ligne (de préférence au milieu du fichier afin de ne pas perturber la syntaxe globale) : `"internetAccess": 0,`


Ou aller dans la section [Réglages > Liste des services](#liste-des-services) et désactiver la fonction __internet access__.
