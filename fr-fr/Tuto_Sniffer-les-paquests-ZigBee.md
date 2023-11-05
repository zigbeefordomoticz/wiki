# Tutoriel - Sniffer les paquets ZigBee

Ce tutoriel explique comment sniffer des paquets ZigBee.

## Sous Windows avec Wireshark

### Matériel utilisé
* Un ZigBee CC2531 Sniffer Module
* Un CC debugger Texas Instrument
* Un câble adaptateur qui vous permettront de flasher la clé pour la passer permettre l'utilisation du sniffing via le logiciel ZBOSS

Un exemple pour un kit complet sur [Amazon](https://www.amazon.fr/Debugger-Adaptateur-CC2531-ZigBee-Complet/dp/B07VH5Q54R/ref=sr_1_4?__mk_fr_FR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=XVNEYFTCQ2QF&keywords=CC+debugger&qid=1699016512&s=electronics&sprefix=cc+debugger%2Celectronics%2C83&sr=1-4) *(lien valable au 05/11/2023)*.


### 1 - Flasher la clé pour la mettre en mode sniffing ZBOSS
* Aller sur le site [ZBoss](https://dsr-iot.com/downloads/tools#upper-header).
* Téléchargez ZBOSS Sniffer Package rev. 2.0 (il vous faudra juste donner votre adresse mail).
NB : le package contient à la fois le FirmeWare à uploader sur la clé ZigBee pour lui permettre de sniffer et à la fois la console GUI qui permet d'interfacer Wireshark ensuite.
* Aller sur le site [Texas Instrument](https://www.ti.com/tool/FLASH-PROGRAMMER#downloads) pour télécharger la version V1 (attention pas la v2) du programme Smart RF FLashProgrammer.
* En utilisant [les instructions suivantes](https://www.zigbee2mqtt.io/guide/adapters/flashing/flashing_the_cc2531.html), flashez la clé en utilisant le fichier .hex présent dans l'archive ZBOSS récupérée précédemment.
Le firmware .hex se trouve dans le répertoire **2020_11_02_zboss_sniffer_windows_ubuntu_64bit\zb_sniffer_bin\zb_sniffer_target\CC2531 USB dongle**.
Une fois flashée (2 à 3 secondes) votre clé est prête à être utilisée.


### 2 - Configurer l'interface ZBOSS
ZBOSS est un outil permettant d'interfacer votre clé USB avec Wireshark en présentant à Wireshark une nouvelle interface d'écoute liée à votre clé.

* Lancez la console ZBOSS (zboss_sniffer.exe) présente dans l'archive ZBOSS récupérée précédemment au niveau du répertoire **2020_11_02_zboss_sniffer_windows_ubuntu_64bit\zb_sniffer_bin\zb_sniffer_host\gui**
* Renseignez le chemin d'accès à l'executable Wireshark (que vous aurez préalablement installé)
* Sélectionnez "Zigbee Page 0" dans "Select Page"
* Dans le WebUI du plugin, récupérer le canal ZigBee de fonctionnement du coordinateur (menu Outils / Outils / Infos du coordinateur / Channel) Channel 15 dans l'exemple.
* Positionnez dans channel le canal sur lequel votre coordinateur travail. 


### 3 - Lancer Wireshark via ZBOSS
* Dans l'interface ZBOSS, cliquez sur **Start**. 

Wireshark se lance et les paquets commencent à être capturés mais ils ne sont à ce stade pas encore décodés (on voit dans la partie data qu'il n'est pas possible de "comprendre" le paquet et son contenu).


### 4 - Fournir à Wireshark sa clé de réseau ZigBee pour lui permettre de décoder les trames
* Dans le WebUI du plugin, récupérer la "Network key" (menu Outils / Outils / Infos du coordinateur / Network Key)
* Dans Wireshark, allez dans Éditer / Préférence / Protocols / ZigBee.
* Sélectionnez **AES 128 Encryption 32 bits** et cliquez sur **Éditer**.
* Cliquez sur le petit bouton **+** et collez la "Network Key" puis **Validez** .

Vous pouvez maintenant voir dans Wireshark vos trames correctement décodées.


Un exemple d'image : 
![WikiUI-FR](Images/FR_WikiUI.png)
