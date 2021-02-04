# Les objets de la marque Ikea

Certains dispositifs de la marque Ikea ont besoin d'une configuration particulière pour fonctionner avec le plugin. Ils seront listés dans cette page.

** Cette page n'est pas une liste des dispositifs compatibles.**

La liste des dispositifs compatibles est sur le site [https://zigbee.blakadder.com/zigate.html](https://zigbee.blakadder.com/zigate.html)


## Sommaire

Les dispositifs nécessitant une configuration particulière :

* [Les ampoules connectées](#les-ampoules-connectéees)
* [Les prises connectées](#les-prises-connectees)
* [Les capteurs de mouvement](#les-capteurs-de-mouvement)
* [La télécommande 5 boutons](#la-telecommande-5-outons)


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

Après avoir mis la ZiGate en mode appairage voir le tutoriel [Appairer un dispositif](Tuto_Appairage-dispositif.md), l'appairage, sans télécommande Ikea, s'effectue en activant 6 fois dans les 5 secondes sur le bouton d'appairage accessible avec un extracteur de carte SIM placé sous la prise.

**Attention :** La manipulation en soit n'est pas compliquée mais hasardeuse, il est donc fort probable qu'il faille redoubler de tentatives.....

L'appairage avec télécommande Ikea s'effectue en plaçant la télécommande à moins de 5 cm de la prise, appuyer plus d'une dizaine de seconde sur le bouton d’appairage que vous trouverez en face arrière intérieure de la télécommande.

L'appairage avec le capteur de mouvement suit le même processus. Ouvrir la face arrière du capteur de mouvement, appuyer durant plus de 10s sur le bouton d'appairage à moins de 5cm de la prise.

### Les capteurs de mouvement

Les capteurs de mouvement peuvent être appairés en unitaire. Pour cela, mettre la ZiGate en mode appairage puis activer 4 fois dans les 5 secondes, le bouton d'appairage du capteur.

**Attention :** La manipulation en soit n'est pas compliquée mais hasardeuse, il est donc fort probable qu'il faille redoubler de tentatives.....


### La télécommande 5 boutons


!!! La télécommande ne commande qu'un groupe!!!

Appairer une ampoule Ikea avec la ZiGate > Ampoule fonctionnel
Appairer la télécommande avec la ZiGate (bouton appairage appuyer 4 fois pour faire un reset) > création d'un widget sélecteur 5 boutons qui ne fonctionne pas pour le moment.

Liéer la remote avec une ampoule > utiliser le bouton d'appairage de la remote avec un appui long (8 à 10 secondes) . Avoir l'ampoule à 5 cm de la remote. L'ampoule va varié de luminosité pour faire un flash (voir documentation Ikea)

a ce niveau le réglage d'intensité fonctionne mais pas les boutons de variation de couleur.

Aller dans le plugin et faire un scan device de l'ampoule qui vient d'être lié. pour récupérer le groupe créer par le lien. Ajouter ensuite la Zigate.
Les actions sont enfin visible dans le widget de la remote dans DomoticZ.

Ajouter la ZiGate (pour recevoir les évènements de la télécommande) et le télécommande de le groupe.

Supprimer l'ampoule du groupe. Le groupe n'aura que la ZiGate et la télécommande.

* Create group 00 !!!
* Appairer tous les dispositifs séparément dans la ZiGate
* Appairer la télécommande avec chaque ampoule qui fera partie du groupe
* Lancer un scan de groupe
  * Aller dans la section [Admin > Groupe](WebUI_Admin.md#groupe)
  * Lancer une __Analyse complète__
Le groupe sera créer et visible dans [Management > Gestion des groupes](WebUI_Management.md#gestion-des-groupes).

In order to use an IKEA/Tradfri:
1. Pair/Commission each single object to the Zigate (including the remote controller)
1. Pair the Remote Control with each Bulb you want to be part of such group
1. Request a Scan from Admin -> Group and select the Bulb you have paired the remote with
1. The group created will be then visible under the Group Management

##### Récupérer les évènements du groupe

* Ajouter la ZiGate au groupe
* Ajouter la Tradfri 5 buttons au groupe

???

![cxvc](https://user-images.githubusercontent.com/4406440/54182600-3ec50200-44a2-11e9-8be7-c2e6b15b4deb.png)

From that stage, you can eventually add Zigate to this group. It will make each remote controller event seen in Zigate.

Additionaly, you can also enable the Left/Right commands of the Tradfri 5 buttons remote controller.

For that you need to edit the Group and add the  Tradfri 5 buttons to that group
