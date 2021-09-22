# Cette page contient les anciennes informations présentent dans la page Installation du plugin.

__Les informations contenues dans cette page sont dépassées.  Se reporter à la page [Installation du plugin](../Plugin_Installation.md)__



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
