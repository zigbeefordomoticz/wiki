# 1. Docker Install

see [Get Docker](https://docs.docker.com/get-docker/)

# 2. Get Docker-Domoticz

Before run the domoticz's docker, you need to get it.
For this you have two choices :
* build your own docker-domoticz's image
* get an existing Domoticz's image from docker hub

## A. Build Your own Docker-Domoticz

In a folder create a file named **dockerfile**, add this line in :
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
Like in a normal install, you can add new packages with apt-get

for more information about dockerfile see [here](https://docs.docker.com/engine/reference/builder/)

Then you can build your docker's image localy with this command :
```
docker build -t docker-domoticz .
```

Now you can run your docker-domoticz's image

## B. Get from docker Hub

Go on [docker hub](https://hub.docker.com/) and search for domoticz, when you find an image you want, run :
```
docker pull image-name
```

# 3. Run docker-domoticz's image

To lunch domoticz's image run :
```
docker run --privileged -d -p 8080:8080 -p 9440:9440 --name=Domoticz -v <Local path for your scripts>:/scripts -v <Local path for your plugins>:/opt/domoticz/plugins -v <Local path for your floorplans>:/opt/domoticz/www/images/floorplans -v /etc/localtime:/etc/localtime:ro -v <Local path for your domoticz.db>:/opt/domoticz/domoticz.db Your_Image_Name
```

If you have script, plugins ... put them in a directory and set the path before running this command
If you have a pluging who need to broadcast on your network (like xiaomi gateway) you need to add this :
```
--network host
```

# 4. Get docker log

to get full log from your docker, run :
```
docker logs Domoticz
```

# 5. Connect to your running docker

Run :
```
docker exec -it Domoticz bash
```
