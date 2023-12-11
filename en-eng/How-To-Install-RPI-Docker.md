# Install Zigbee for Domoticz plugin (under Docker on a RPi bare metal)

## Assumptions

The here after installation steps are based on the fact that Domoticz is installed and setup as documented [domoticz/domoticz - Docker](https://hub.docker.com/r/domoticz/domoticz)

When the Domoticz setup is correctly configured, and you have been able to access via a Web browser, you can install the plugin

## 1. Start domoticz

`docker up -d``

## 2. Install plugin & configuration

    1. Open a sheel in the container
    
    `docker exec -it domoticz /bin/bash`
    
    1. clone the Z4D plugin
    
    ```bash
    cd /opt/domoticz/userdata/plugins/
    git clone https://github.com/zigbeefordomoticz/Domoticz-Zigbee.git
    ````
    
    1. Edit the Domoticz custom script, so the python modules are correctly installed and up to date
    
    `vi /opt/domoticz/userdata/customstart.sh`
    
    ```bash
    #!/bin/bash
    
    if [ -f /opt/domoticz/FIRSTRUN ]; then
     true
    else
     echo 'creating FIRSTRUN file so script can check on next run'
     touch /opt/domoticz/FIRSTRUN
    
     echo 'updating packages'
     apt-get -qq update
    
     echo 'installing iputils-ping'
     apt-get -y install iputils-ping
    
     echo 'installing vim editor'
     apt-get -y install vim-ping
    
     if [ -f /opt/domoticz/userdata/plugins/Domoticz-Zigbee/requirements.txt ]; then
      echo 'Install the necessary python3 modules for Zigbee for Domoticz plugin'
             python3 -m pip install -r /opt/domoticz/userdata/plugins/Domoticz-Zigbee/requirements.txt --upgrade
     fi
     cd /opt/domoticz || return
    fi
    ```
