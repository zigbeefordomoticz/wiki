## Zigate Plugin Web Interface


### Introduction
Starting beta-4.3 there is a Web User Interface available. This will allow User to 
1. edit all Plugin settings (previously managed under the file PluginConf.txt), 
1. visualize the Network Topology and Mesh level
1. edit the Equipment managed by Zigate and give a name to each physical device
1. Administrate the plugin and Zigate, by allowing Setting Zigate in Pairing mode

### Preamble
Due to a problem in Domoticz Python Framework, the current version of the Web User Interface is only accessible through the loopback interface. This means that you must access the Web via the ip 127.0.0.1.


### Enable the Web User Interface 

edit the file ```Conf/PluginConf-xx.json``` please do not that the extension of the file is _.json_

Add the following line in the middle of the file

```
"enableWebServer": 1,
```

Then restart the plugin


### Access the Web User Interface

If you have a stable Domoticz version or a Beta Domoticz version below 4.10900 you have to  you need first to open a ssh tunnel, then you can access the Web User Interface by accessing the following URL ```http://127.0.0.1:9440```


### Tunnel ssh

There are several ways to open an ssh tunnel between your client (where you run your browser) and the server.

your Server IP address: domoticz.server.local
your Server User login: pi

1. Client is a unix/linux based system ( MacOs included )

   * Open a terminal
   * type the command:
   
     ```
     ssh -L9440:127.0.0.1:9440 pi@domoticz.server.local
     ```
     
1. Client is a Windows based system

   1. PowerSheel Client OpenSSH is available
   
      * Open a Command window
      * type the following command
      
           ```
           ssh -L9440:127.0.0.1:9440 pi@domoticz.server.local
           ```
   

   1. You have 'Putty' or you have to download Putty
   
      * Download and open PuTTY
      * Open the Putty Configuration client, and fill in the field ‘Host Name (or IP address)‘ with the IP or host name of your remote server. In the Connection type section you should select SSH which will set the port automatically to 22.
      * Once this is done, open the Tunnels section in the menu Connection -> SSH. In this section we are going to configure the port forwarding. Assume we want to access the Zigate Web UI  which runs on the port 9440. We need to tell Putty to listen on a Source port (=local), and to forward it to the Destination (=remote).
      * For this example we will configure putty to forward port 9440 to the remote port 127.0.0.1:9440.
      * If everything is correctly configured click Open. This will open a SSH connection with your remote server and at the same time the configured port forwarding. 
      

