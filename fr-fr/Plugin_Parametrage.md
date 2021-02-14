# Paramétrage du plugin

Cette étape est la deuxième du processus d'installation du plugin ZiGate.

Vous devez donc avoir suivi et terminé l'[étape 1 Installation du plugin](Plugin_Installation.md)



## Le paramétrage

* Ouvrir __DomoticZ__ dans votre navigateur
* Aller dans le menu __Configuration__ puis __Matériel__

![Domoticz Hardware Menu for Plugin](../Images/DzMenu.png)

*Cette page est susceptible d'avoir évolué depuis l'écriture de cette documentation.*



| Id | Short Description    | Full Description |
| -- | -------------------- | ---------------- |
| 1  | Nom                  | Le nom donné à la ZiGate. Si vous utiliser plusieurs ZiGate, vous aurez besoin de plusieurs instances du matériel ZiGate et le nom permettra de les identifier. |
| 2  | Type                 | `ZiGate plugin` à sélectionner dans la liste déroulante |
| 3  | ZiGate Model         | Choisir entre les différents modèles de ZiGate (USB, DIN, PI, Wifi) |
| 4  | IP                   | IP de la ZiGate pour le modèle Wifi uniquement. Laisser 0.0.0.0 pour les autres modèles |
| 5  | Port                 | Port de la ZiGate pour le modèle Wifi uniquement (défaut 9999). Laisser 9999 pour les autres modèles |
| 6  | Port série           | Port usb sur lequel est branché la ZiGate |
| 7  | Initialize ZiGate (Erase Memory) `Erase PDM` | Pour initialiser la ZiGate avec les paramètres du plugin. A __activer obligatoirement__ lors de la configuration initiale (ou après un Erase EEPROM). __ATTENTION:__ L'activation va effacer toutes des informations d'appairage de la ZiGate. Pour activer, passer à True et redémarrer le plugin |
| 8  | Port for Web Admin| Port pour accéder à l'administration web du plugin (défaut 9440). A modifier en cas d'utilisation de plusieurs instances du plugin. |
| 9  | Verbors and Debuging | Sélection du niveau du log du plugin (Aucun par défaut) |


* Coché __Activé__ pour activer le plugin.
* Renseigner un __Nom__ : il est conseillé de ne pas mettre d'espace ou de caractère spécial dans le nom du plugin. Ce nom peut être utiliser dans une URL et un espace ou des caractères spéciaux peuvent générer des problèmes.
* Sélectionner __ZiGate plugin__ dans la liste type.
* Sélectionner votre modèle de ZiGate.
* Renseigner les informations d'__IP__ et de __Port__ ou de __Port série__ en fonction de votre modèle de ZiGate.
* laisser les autres paramètres par défaut pour le moment.
* Cliquer sur __Ajouter__.

La ligne correspondante à votre plugin ZiGate (avec le nom défini) est normalement apparue dans la liste des matériels. Cliquer dessus.

* Mettre __Initialize ZiGate (Erase Memory)__ à __False__.
* Décoché __Activé__ pour désactiver le plugin.
* Cliquer sur __Modifier__ (ne pas cliquer sur Ajouter car cela dupliquera le plugin).
* Recliquer sur la ligne du plugin ZiGate.
* Recocher __Activé__ pour réactiver le plugin.
* Cliquer sur __Modifier__ pour relancer le plugin.

Vérifier les logs que le plugin ZiGate s'initialise correctement.


## Les widgets du plugin

A l'installation, le plugin créé 2 widgets dans l'onglet __Mesures__ de DomoticZ.

![Administration Widgets](../Images/Widgets_Admin.png)

### Widget Statut

Le widget s'appelle 'Zigate Status XX' avec XX correspondant au numéro de matériel du plugin ZiGate. Il indiquera l'état du plugin. Le Log du widget permettra d'avoir l'historique des états du plugins.

Les différents états possibles sont :

| État | Couleur | Description |
| ---- | ------- | ----------- |
| Off | Rouge | Le plugin s'éteint ou il y a un problème de communication |
| Démarrage | Gris | Le plugin démarre |
| Prêt | Vert | Le plugin est en fonctionnement normal |
| Appairage | Ambre | Le plugin est en mode appairage |
| Saturation | Ambre | Le plugin sature : il peut y avoir des délais de transmissions rallongés |


### Widget Texte

Liste non-exhaustive des notifications :

* Succès d'appairage
* Échec d'appairage
* Exclusion d'un objet
* Rapport de topologie réseau disponible
* Rapport d'interférences réseau disponible
* Problème réseau
* Canal ZigBee

Un exemple de l'historique des notifications (en anglais)

![Notification Widgets](../Images/Widget_Notifications.png)


Si tout semble fonctionner normalement, passer à l'[étape 3 Configuration du plugin](Plugin_Configuration.md)
