# Les dispositifs de la marque IKEA

Voir la liste des [dispositifs compatibles](https://zigbee.blakadder.com/zigate.html)

Ces dispositifs sont connus sous l'appélation TRADFRI, on y retrouve des ampoules (TRADFRI bulb), des prises commandées (TRADFRI control outlet), des capteurs de mouvements (Tradfri Motion Sensor).

**Attention :** Ces dispositifs utilisent le groupe 0000 par défaut, il est donc nécessaire de l'activer preallablement à l'appairage. Pour cela se rapporter à la section [Reglages](mettre lien)

## L'appairage des dispositifs

### Les Ampoules connectées

Allumer/Eteindre six fois de suite votre ampoule (hors telecommande Ikea); L'ampoule envoie alors une annonce à la zigate qui repondra en demandant plus d'informations comme le modele avant de l'inclure ensuite dans Domoticz. Dans le cas où le modèle n'est pas connu dans le fichier DeviceConf.txt, le processus prendra un peu plus de temps mais s'effectuera completement dès que la Zigate disposera des informations nécessaires. 

Dès l'appairage, de 1 à 3 dispositifs sont présentés à Domoticz

| Type | Fonction |
| ---- | -------- |
| Switch | Permet l'allumage/extinction de l'ampoule |
| Level Control (LvlControl) | Controle le niveau de luminosité de l'ampoule |
| Color Control (ColorControl) | Controle la coulour d'éclairage |

### Les prises connectées

Après avoir mis la zigate en mode appairage voir section [Appairage](mettre lien), l'appairage, sans telecommande ikea, s'effectue en activant 6 fois dans les 5 secondes sur le bouton d'appairage accessible avec un extracteur de carte SIM placé sous la prise.

**Attention :** La manipulation en soit n'est pas compliquee mais hasardeuse, il est donc fort probable qu'il faille redoubler de tentatives.....

L'appairage avec telecommande ikea s'effectue en plaçant la telecommande à moins de 5 cm de la prise, appuyer plus d'une dizaine de seconde sur le bouton d'apparaige que vous trouverez en face arriere interieure de la telecommande.

L'appairage avec le capteur de mouvement suit le même processus. Ouvrir la face arriere du capteur de mouvement, appuyer durant plus de 10s sur le bouton d'appairage à moins de 5cm de la prise.

### Les capteurs de mouvement

Les capteurs de mouvement peuvent etre appairés en unitaire. Pour cela, mettre la Zigate en mode appairage puis activer 6 fois dans les 5 secondes, le bouton d'apparaige du capteur.

**Attention :** La manipulation en soit n'est pas compliquee mais hasardeuse, il est donc fort probable qu'il faille redoubler de tentatives.....

## Les Firmware des dispositifs

| Modele - Produit                | Image type  | Version(s) FW | Nom du fichier                                           |
| ------------------------------- | ----------- | ------------- | -------------------------------------------------------- |
| TRADFRI bulb E27 WS clear 950lm | 0x2202      | 2.3.050       | 159695-2.1-TRADFRI-bulb-ws-1000lm-2.3.050.ota.ota.signed |

