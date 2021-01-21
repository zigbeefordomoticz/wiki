# Paramétrage du plugin

Cette étape est la deuxième du procéssus d'instalaltion du plugin Zigate.

Vous devez donc avoir suivi et terminé l'[étape 1 Instalaltion](Installation.md)


##Le paramétrage

* Ouvrir __DomoticZ__ dans votre navigateur
* Aller dans le menu __Configuration__ puis __Matériel__

![Domoticz Hardware Menu for Plugin](https://raw.githubusercontent.com/pipiche38/Domoticz-Zigate-Wiki/master/Images/DzMenu.png)


| Id | Short Description | Full Description |
| -- | ----------------- | ---------------- |
| 1  | Nom               | Le nom donné à la Zigate. Si vous utiliser plusieurs Zigate, vous aurez besoin de plusieurs instances du matériel Zigate et le nom permettra de les identifiées.
| 2  | Type              | `Zigate plugin` à sélectionner dans la liste déroulante |
| 3  | Zigate Model      | Choisir entre les différents modèles de Zigate ( USB, DIN, PI, Wifi) |
| 4  | IP                | IP de la Zigate pour le modèle Wifi uniquement. Laisser 0.0.0.0 pour les autres modèles |
| 5  | Port              | Port de la Zigate pour le modèle Wifi uniquement (défaut 9999). Laisser 9999 pour les autres modèles |
| 6  | Serial Port       | Serial Port sur lequel est branché la Zigate |
| 7  | Initialize ZiGate (Erase Memory) `Erase PDM` | Will initialize ZiGate with the plugin parameters. This is a __MUST__ when using ZiGate the first time (or after an Erase EEPROMO). __ATTENTION:__ Will Erase all pairing information on the Zigate. In such case put it to True and restart the plugin |
| 8  | Port for Web Admin| Port number to reach the plugin Web Admin page (default 9440), you must change it of you run several instance of the plugin |
| 9  | Update            | You will activate the new values of this page, and it will restart the plugin |


* Aller en dessous du tableau de matériel installés et renseigner les informations suivantes :

   * __Type :__ Zigate Plugin
   * __Nom :__ Ce que vous voulez (Zigate par exemple)
   * __Délai d'inactivité :__ Désactivé
   * __Zigate model__ : indiquer ici votre modèle de Zigate
   * __IP :__ IP de la Zigate Wifi (laaisser 0.0.0.0 pour les autres modèles)
   * __Port :__Port de la Zigate Wifi
   

In domoticz navigate to Settings -> Hardware

Pick Zigate Plugin from the list, name it and set the wright USB port.

At the first boot you have to set “Erase Persistent Data” to True to build a new network.

Set Permit Join to value 255 to search for a unlimited time for new devices

Click Add and check the log. When the USB TTL is in Permit Join mode the blue and red LEDs are flickering. Now you can add devices the usual way. For example press and hold 3 secs the button at the Aqara sensor.

When you are done adding devices set the permit join value to something lower than 255. 


## E.	Tests des logiciels

Vous pouvez maintenant lancer Domotics en cliquant sur l’icône de Domoticz, ce qui conduit à ouvrir une fenêtre dans votre navigateur à l’adresse locale 127.0.0.1 (port 8080) :

127.0.0.1:8080

Dans Domoticz, Vous devez installer la passerelle Zigate en ajoutant un nouveau matériel (donnez un nom et sélectionnez dans la rubrique Type le plugin « Zigate plugin » en fin de liste). Si tout se passe bien, en allant dans le rubrique Configuration/logs, vous devriez avoir un log de ce type  :




Accéder également à l’interface du plugin de Pipiche en tapant dans votre navigateur:


127.0.0.1:9440

Cela permet d ‘accéder au dashboard suivant :


Pour ma part, j’utilise grandemment cet outil, notamment pour intégrer des nouveaux modules dans la Zigate (fonction Join à valider en activant la fonctionnalité « Accepter de nouveaux dispositifs » en haut à droite) et pour me rendre compte de l’état des échanges entre la Zigate et les dispositifs.
Puis je termine la mise en forme dans Domoticz (nom etc ...)
