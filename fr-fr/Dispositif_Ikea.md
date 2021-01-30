# Les dispositifs de la marque Ikea

Certains dispositifs de la marque Ikea ont besoin d'une configuration particulière pour fonctionner avec le plugin. Ils seront listés dans cette page.

** Cette page n'est pas une liste des dispositifs compatibles.** 

La liste des dispositifs compatibles est sur le site [https://zigbee.blakadder.com/zigate.html](https://zigbee.blakadder.com/zigate.html)


## Sommaire

Les dispositifs nécessitant une configuration particulière :

* [Les ampoules connectées](#les-ampoules-connectéees)
* [Les prises connectées](#les-prises-connectees)
* [Les capteurs de mouvement](#les-capteurs-de-mouvement)


**Attention :** Dans le cas où les appairages en mode classique décrits ci dessous ne fonctionnent pas, ces dispositifs utilisant le groupe 0x0000, il est possible que vous soyez amené à l'activer préalablement à l'appairage. Pour cela se rapporter à la section [Reglages > Réglage de la Zigate](WebUI_Reglages.md#r%C3%A9glages-de-la-zigate)

### Les ampoules connectées

Allumer/Eteindre six fois de suite votre ampoule (hors télécommande Ikea); l'ampoule envoie alors une annonce à la Zigate qui répondra en demandant plus d'informations comme le modèle avant de l'inclure ensuite dans DomoticZ. Dans le cas où le modèle n'est pas connu dans le fichier DeviceConf.txt, le processus prendra un peu plus de temps mais s'effectuera complètement dès que la Zigate disposera des informations nécessaires. 

Dès l'appairage, de 1 à 3 dispositifs sont présentés à DomoticZ

| Type | Fonction |
| ---- | -------- |
| Switch | Permet l'allumage/extinction de l'ampoule |
| Level Control (LvlControl) | Controle le niveau de luminosité de l'ampoule |
| Color Control (ColorControl) | Controle la coulour d'éclairage |

### Les prises connectées

Après avoir mis la Zigate en mode appairage voir le tutoriel [Appairer un dispositif](Tuto_Appairage-dispositif.md), l'appairage, sans télécommande Ikea, s'effectue en activant 6 fois dans les 5 secondes sur le bouton d'appairage accessible avec un extracteur de carte SIM placé sous la prise.

**Attention :** La manipulation en soit n'est pas compliquée mais hasardeuse, il est donc fort probable qu'il faille redoubler de tentatives.....

L'appairage avec télécommande Ikea s'effectue en plaçant la télécommande à moins de 5 cm de la prise, appuyer plus d'une dizaine de seconde sur le bouton d’appairage que vous trouverez en face arrière intérieure de la télécommande.

L'appairage avec le capteur de mouvement suit le même processus. Ouvrir la face arrière du capteur de mouvement, appuyer durant plus de 10s sur le bouton d'appairage à moins de 5cm de la prise.

### Les capteurs de mouvement

Les capteurs de mouvement peuvent être appairés en unitaire. Pour cela, mettre la Zigate en mode appairage puis activer 4 fois dans les 5 secondes, le bouton d'appairage du capteur.

**Attention :** La manipulation en soit n'est pas compliquee mais hasardeuse, il est donc fort probable qu'il faille redoubler de tentatives.....

