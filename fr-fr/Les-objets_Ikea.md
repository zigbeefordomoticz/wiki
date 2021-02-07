# Les objets de la marque Ikea

Certains objets de la marque Ikea ont besoin d'une configuration particulière pour fonctionner avec le plugin. Ils seront listés dans cette page.

** Cette page n'est pas une liste des objets compatibles.**

La liste des objets compatibles est sur le site [https://zigbee.blakadder.com/zigate.html](https://zigbee.blakadder.com/zigate.html).


## Sommaire

Les objets nécessitant une configuration particulière :

* [Les ampoules connectées](#les-ampoules-connectéees)
* [Les prises connectées](#les-prises-connectees)
* [Les capteurs de mouvement](#les-capteurs-de-mouvement)
* [La télécommande 5 boutons](#la-telecommande-5-outons)


**Attention :** Dans le cas où les appairages en mode classique décrits ci dessous ne fonctionnent pas, ces objets utilisant le groupe 0x0000, il est possible que vous soyez amenés à l'activer préalablement à l'appairage. Pour cela se rapporter à la section [Reglages > Réglage de la Zigate](WebUI_Reglages.md#r%C3%A9glages-de-la-zigate)

### Les ampoules connectées

Allumer/Eteindre six fois de suite votre ampoule (hors télécommande Ikea); l'ampoule envoie alors une annonce à la ZiGate qui répondra en demandant plus d'informations comme le modèle avant de l'inclure ensuite dans DomoticZ. Dans le cas où le modèle n'est pas connu dans le fichier DeviceConf.txt, le processus prendra un peu plus de temps mais s'effectuera complètement dès que la ZiGate disposera des informations nécessaires.

Dès l'appairage, de 1 à 3 dispositifs sont présentés à DomoticZ

| Type                         | Fonction                                      |
| ---------------------------- | --------------------------------------------- |
| Switch                       | Permet l'allumage/extinction de l'ampoule     |
| Level Control (LvlControl)   | Controle le niveau de luminosité de l'ampoule |
| Color Control (ColorControl) | Controle la coulour d'éclairage               |

### Les prises connectées

Après avoir mis la ZiGate en mode appairage voir le tutoriel [Appairer un dispositif](Tuto_Appairage-objet.md), l'appairage, sans télécommande Ikea, s'effectue en activant 6 fois dans les 5 secondes sur le bouton d'appairage accessible avec un extracteur de carte SIM placé sous la prise.

**Attention :** La manipulation en soit n'est pas compliquée mais hasardeuse, il est donc fort probable qu'il faille redoubler de tentatives.....

**A Noter :** La prise Ikea ne présente que l'objet Switch On/Off; elle ne permet pas de suivre la consommation électrique. En revanche, comme tout objet alimenté sur le secteur, elle offre la fonction de routeur.

L'appairage avec télécommande Ikea s'effectue en plaçant la télécommande à moins de 5 cm de la prise, appuyer plus d'une dizaine de seconde sur le bouton d’appairage que vous trouverez en face arrière intérieure de la télécommande.

L'appairage avec le capteur de mouvement suit le même processus. Ouvrir la face arrière du capteur de mouvement, appuyer durant plus de 10s sur le bouton d'appairage à moins de 5cm de la prise.

### Les capteurs de mouvement

Les capteurs de mouvement peuvent être appairés en unitaire. Pour cela, mettre la ZiGate en mode appairage puis activer 4 fois dans les 5 secondes, le bouton d'appairage du capteur.

**Attention :** La manipulation en soit n'est pas compliquée mais hasardeuse, il est donc fort probable qu'il faille redoubler de tentatives.....


### La télécommande 5 boutons

La télécommande 5 bouton ne peut commander qu'un seul groupe.
Pour pouvoir appairer et utiliser la télécommande avec la ZiGate, il sera nécessaire d'avoir une ampoule Ikea au moment de l’installation.

#### Méthode pour appairer la télécommande

* Appairer une ampoule Ikea ou avoir une ampoule déjà appairée. *Elle doit être fonctionnelle.*
* Appairer la télécommande : appuyer 4 fois sur le bouton appairage de la télécommande pour lancer le Reset. *L'appairage réussi créera un dispositif et un widget sélecteur 5 boutons dans DomoticZ.* __Ceux-ci ne fonctionneront pas pour le moment.__

* Lier la télécommande avec l'ampoule Ikea : faire un appui long sur le bouton d'appairage de la télécommande (8 à 10 secondes) et mettre l'ampoule à 5 cm de la télécommande. *L'ampoule va varier de luminosité puis fera un flash (voir la documentation Ikea).*

A ce niveau, le réglage d'intensité de la télécommande fonctionne mais pas les boutons de variation de couleur (pour le moment ...)

* Aller dans la section [Admin > Groupes](WebUI_Admin.md#groupe).
* Lancer une analyse sélective sur l'ampoule Ikea utilisée précédemment afin d'identifier le groupe utilisé par l'ampoule et la télécommande *Le groupe créé par le lien sera récupérer.*
* Ajouter la ZiGate dans le groupe crée par le lien.

Maintenant, toutes les évènements de la télécommandes seront visibles sur le Widget dans DomoticZ.


#### Utiliser la télécommande pour d'autres choses que des ampoules Ikea

* Procéder à l'appairage de la télécommande en suivant la méthode précédamment décrite.
* Supprimer ensuite l'ampoule utilisée dans le groupe créé lors de l'apparaige de la telecommande avac l'ampoule : *Une fois l'opération terminée, seules la ZiGate et la télécommande doivent rester dans ce groupe.*

__Une ampoule Ikea est obligatoire pour appairer la télécommande avec la ZiGate.__ Cela oblige l'achat d'une ampoule en plus de la télécommande, mais ceci est la seule méthode trouvée pour pouvoir réutiliser la télécommande.
