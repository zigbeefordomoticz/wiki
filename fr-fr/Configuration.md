# Configuration du plugin


Cette étape est la troisième étape du procsssus d'installation du plugin Zigate.

Vous devez donc avoir suivi et terminé l'[étape 1 Installation](Installation.md) et l'[étape 2 Paramétrage](Parametrage.md)

## Accéder à l'interface d'aministration

L'interface d'administration vous donne acceder aux éléments suivants :
- Un tableau de bord synthétique
- La gestion des dispositifs et des groupes
- La visualisation de la topologie et la qualité du reseau ZigBee
- Un jeu de commandes permettant d'administrer la ZiGate, le plugin et les dispositifs
- La configuration du plugin
- Un jeu d'outils permettant le debug, la gestion des erreurs et l'interaction directe avec les dispositifs.

Vous pouvez accéder à l'interface web d'administration en allant à la page http://IP-serveur-domoticz:numéro-de-port-défini-dans-paramétrage.

Si votre DomoticZ est sur un serveur en local et que vous avez laisser le port par défaut, l'adresse de l'interface web est http://127.0.0.1:9440

**ATTENTION :** Pour des raisons de sécurité, **ne pas présenter le port 9440 sur votre réseau externe** sous peine d'ouvrir à tous la gestion de votre domotique.

Ce tableau de bord vous propose un apercu rapide, en un coup d'oeil, du fonctionnement de votre environnement ZiGate/ZigBee.
Chaque section de ce table de bord est commentée pour permettre une lecture simple des informations remontés.
En haut de page, vous avez acces aux differents onglets decrits ci dessus. Vous trouvez egalement un switch (haut/droite) permettant de basculer la ZiGate et le plugin en mode appairage (dans le cas où la ZiGate est dejà en mode appairage, le swictch est automatiquement activé).

Sur le bas de la page, bandeau vert, vous disposez des informations suivantes (de gauche vers droite) :
- Date et heure de démarrage du plugin
- La bande passante 
- Le MaxLoad (c'est quoi ?)
- L'état du plugin (Busy, Ready, etc..)
- La version du plugin
- La version du firmware de le ZiGate

![Zigate Web Admin Interface](../Images/Dashboard.png)

