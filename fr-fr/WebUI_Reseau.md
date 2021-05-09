# L'interface Web - La section Réseau

Pour accéder à l'interface d'administration du plugin, voir l'étape 3 [Configuration du plugin](Plugin_Configuration.md).

La section __Réseau__ comporte les pages :

* [Topologie](#topologie)
* [Niveau d'interférences](#niveau-dinterf%C3%A9rences)


------------------------------------------------
## Topologie

Voici la page __Topologie__ de l'interface Web du plugin :

![Topologie réseau](Images/FR_WebUI-Reseau-Topologie.png)
*Cette page est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet de visualiser le réseau ZigBee.

Elle permet :

* De visualiser et gérer les différents rapports d'analyse du réseau
* De lancer une analyse du réseau basée sur le LQI (puissance du signal détecté)
  * A noter que le filtrage des paquets implémenté dans la ZiGate s'appuie sur la LQI. Un coût supérieur à 5 implique une perte potentielle de paquets

| LQI interval | Cost |
| ---------| -----|
| >= 51 | 1 |
| 46 - 50 | 2 |
| 41 - 45 | 3 |
| 39 - 40 | 4 |
| 36 - 38 | 5 |

**Attention :** Le temps de sortie d'un rapport de topologie est très dépendant de la taille du réseau ZigBee à analyser; plus le nombre de routeurs est important et plus le temps d'analyse sera long.

**A Noter :** Le rapport est également diffusé (format texte) dans les logs de DomoticZ.

### Description d'un rapport de topologie réseau

Le rapport de topologie réseau est constitué de deux graphiques présentant le maillage et le réseau.

#### Le graphique du maillage

L'illustration de votre maillage montre tous les liens entre les objets et ZiGate.
En déplaçant votre souris sur un lien un pop-up vous indique les composants participant à ce lien ainsi que la qualité de la liaison (LQI) : échelle de 0 (très mauvaise) à 255 (la meilleure).

Un bouton (Chart context menu) en haut à droite du graphique permet de l'afficher en plein écran, de l'imprimer ou de l'exporter sous différent formats.

#### Le graphique du réseau

L'illustration de votre maillage montre l'architecture du réseau ZigBee (les connexions entre les différents objets).
Vous pouvez visualiser sur quel routeur est accroché votre objet terminal.

Un bouton (Chart context menu) en haut à droite du graphique permet de l'afficher en plein écran, de l'imprimer ou de l'exporter sous différent formats.

##### L'affichage sans Sibling

Le Sibling correspond aux objets frères qui peuvent communiquer entre eux sans passer par un parent.

Par défaut, le plugin affiche les liens directs entre les objets mais n'affiche pas les liens Sibling.

Un exemple de topologie Sans Sibling : on voit que les routeurs (les noeuds) n'ont pas d'inter-comnunication entre eux.

![Topologie réseau sans sibling](Images/FR_WebUI-Reseau-Topologie-sans-sibling.png)

*Cette image est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

##### L'affichage avec Sibling

Il est possible dans [Réglages > Réglages de l'interface Web](WebUI_Reglages.md#r%C3%A9glages-de-linterface-web) d'activer l'option **displaySibling** pour afficher les liens de même niveau sur les graphiques de topologie réseau.

Le même exemple de topologie Avec Sibling : on voit que les routeurs (les noeuds) ont un lien d'inter-comnunication entre eux.

![Topologie réseau avec sibling](Images/FR_WebUI-Reseau-Topologie-avec-sibling.png)

*Cette image est susceptible d'avoir évolué depuis l'écriture de cette documentation.*


#### La liste des objets liés à la ZiGate

Vous retrouvez sous cet item un tableau fournissant des informations relatives aux objets liées à la ZiGate et remontées dans les widgets DomoticZ.

![Network_Topology](Images/FR_WebUI-Reseau-ListDispositifs.png)


------------------------------------------------
## Niveau d'interférences

Voici la page __Niveau d'interférences__ de l'interface Web du plugin :

![Niveau d'interférences](Images/FR_WebUI-Reseau-Interferences.png)
*Cette image est susceptible d'avoir évolué depuis l'écriture de cette documentation.*

### Utilisation

Cette page permet de visualiser les niveaux d'interférences par canal du réseau ZigBee.

Elle permet :

* De visualiser et gérer les différents rapports d'interférence du réseau.
* De lancer une analyse des interférences par canal
* De lancer une analyse complète des niveaux d'interférence par canal

### Description d'un rapport de niveau d'interférence

Voir les [explications](Info_ZigBee-et-Wifi.md) sur les interférences entre le Wifi et le ZigBee

Le niveaux d'interférence est calculé avec la communication entre la ZiGate et un routeur.
Si vous ne disposez pas de routeur, vous ne pouvez pas faire d'analyse du niveau d'interférence.

Les graphiques montrent pour chaque canal ZigBee (de 11 à 26) et pour chaque routeur, le niveau d'interférence lors de la communication avec la ZiGate: échelle de 0 (aucune détérioration du signal) à 255 (message inaudible).

![Niveau d'interférences-1](Images/FR_WebUI-Reseau-Interferences-1.png)

Sur le graphique circulaire, les faibles interférences sont proches du centre.

![Niveau d'interférences-2](Images/FR_WebUI-Reseau-Interferences-2.png)

Sources:
* https://www.nxp.com/docs/en/user-guide/JN-UG-3101.pdf ( page 367 - Section 8.2.3.41 ZPS_tsAplZdpMgmtNwkUpdateNotify)
* https://en.wikipedia.org/wiki/Received_signal_strength_indication ( RSSI - Received Signal Strength Indication)


------------------------------------------------
Voir les autres pages de l'[interface Web du plugin](Home.md#linterface-web-du-plugin).
