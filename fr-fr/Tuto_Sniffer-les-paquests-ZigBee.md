# Tutoriel - Sniffer les paquets ZigBee

Ce tutoriel explique comment sniffer des paquets ZigBee.

## Sous Windows avec WireShark

### Matériel utilisé
Zigbee CC2531 Sniffer Module + un CC debugger Texas Instrument et un câble adaptateur qui vous permettront de flasher la clé pour la passer permettre l'utilisation du sniffing via le logiciel ZBOSS
Exemple pour un kit complet : https://www.amazon.fr/Debugger-Adaptateur-CC2531-ZigBee-Complet/dp/B07VH5Q54R/ref=sr_1_4?__mk_fr_FR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=XVNEYFTCQ2QF&keywords=CC+debugger&qid=1699016512&s=electronics&sprefix=cc+debugger%2Celectronics%2C83&sr=1-4

### 1 - Flasher la clé pour la mettre en mode sniffing ZBOSS
- Aller sur le site ZBoss (https://dsr-iot.com/downloads/tools#upper-header)
- téléchargez ZBOSS Sniffer Package rev. 2.0 (il vous faudra juste donner votre adresse mail).
NB : le package contient à la fois le FirmeWare à uploader sur la clé Zigbee pour lui permettre de sniffer et à la fois la console GUI qui permet d'interfacer WireShark ensuite
- Aller sur le site Texas Instrument (https://www.ti.com/tool/FLASH-PROGRAMMER#downloads) pour télécharger la version V1 (attention pas la v2) du programme Smart RF FLashProgrammer
- En utilisant les instructions positionnées sur https://www.zigbee2mqtt.io/guide/adapters/flashing/flashing_the_cc2531.html , flashez la clé en utilisant le fichier .hex présent dans l'archive ZBOSS récupérée précédement.
Le firmeware .hex se trouve dans le répertoire "2020_11_02_zboss_sniffer_windows_ubuntu_64bit\zb_sniffer_bin\zb_sniffer_target\CC2531 USB dongle".
Une fois flashée (2 à 3 secondes) votre clée est prête à être utilisée

### 2 - Configurer l'interface ZBOSS
ZBOSS est un outil permettant d'interfacer votre clé USB avec WireShark en présentant à WireShark une nouvelle interface d'écoute liée à votre clé 
- Lancez la console ZBOSS (zboss_sniffer.exe) présente dans l'archive ZBOSS récupérée précédement au niveau du répertoire "2020_11_02_zboss_sniffer_windows_ubuntu_64bit\zb_sniffer_bin\zb_sniffer_host\gui"
- Renseignez le chemin d'accès à l'executable WireShark (que vous aurez préalablement installé)
- sélectionnez "ZIgbee Page 0" dans "Select Page"
- positionnez dans channel le canal sur lequel votre coordinateur travail (à récupérer dans la WebUi Zigbee au niveau de Outils=>Outils=>Infos du coordinateur=>Channel" (dans mon cas = channel 15)

### 3 - lancer WireShark via ZBOSS
Dans l'interface ZBOSS, cliquez sur Start: Wireshark se lance et les paquets commencent à être capturés mais ils ne sont à ce stade pas encore décodés (on voit dans la partie data qu'il n'est pas possible de "comprendre" le paquet et son contenu)

### 4 - fournir à WireShark sa clé de réseau Zigbee pour lui permettre de décoder les trames
- dans WIreShark, allez dans Editer=>Préférence=>Protocols=>Zigbee 
- Sélectionnez "AES 128 Encryption 32 bits" et cliquez sur "Editer"
- cliquez sur le petit bouton + et collez la clé que vous récupérez dans la WebUi Zigbee au niveau de Outils=>Outils=>Infos du coordinateur=>Network Key" puis validez 
Vous pouvez maintenant voir dans WireShark vos trames correctement décodées :
!
