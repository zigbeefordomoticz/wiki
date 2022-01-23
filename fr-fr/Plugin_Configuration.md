<a href="#"><img align="left" width="80" height="80" src="../Images/logo_Z4D.png" alt="Logo"></a>

# Configuration du plugin

</br>


Cette étape est la troisième étape du processus d'installation du plugin ZigBeeForDomoticZ.

Vous devez donc avoir suivi et terminé l'[étape 1 Installation](Plugin_Installation.md) et l'[étape 2 Paramétrage](Plugin_Parametrage.md)

## Accéder à l'interface d'administration

L'interface d'administration vous donne accès aux éléments suivants :
- Un tableau de bord synthétique
- La gestion des objets et des groupes
- La visualisation de la topologie et la qualité du réseau ZigBee
- Un jeu de commandes permettant d'administrer le coordinateur, le plugin et les objets
- La configuration du plugin
- Un jeu d'outils permettant le debug, la gestion des erreurs et l'interaction directe avec les objets.

Vous pouvez accéder à l'interface web d'administration en allant à la page http://IP-serveur-domoticz:numéro-de-port-défini-dans-paramétrage.

Si votre DomoticZ est sur un serveur en local et que vous avez laisser le port par défaut, l'adresse de l'interface web est http://127.0.0.1:9440

**ATTENTION :** Pour des raisons de sécurité, **ne pas présenter le port 9440 sur votre réseau externe** sous peine d'ouvrir à tous la gestion de votre domotique.

Ce tableau de bord vous propose un aperçu rapide, en un coup d’œil, du fonctionnement de votre environnement ZigBee.
Chaque section de ce table de bord est commentée pour permettre une lecture simple des informations remontés.
En haut de page, vous avez accès aux différents onglets décrits ci dessus. Vous trouvez également un switch (haut/droite) permettant de basculer le coordinateur en mode appairage (dans le cas où le coordinateur est déjà en mode appairage, le swictch est automatiquement activé).

Sur le bandeau en bas de la page, vous disposez des informations suivantes (de gauche vers droite) :
- Date et heure de démarrage du plugin.
- Le nombre de messages envoyés/reçus par seconde par le coordinateur.
- Le MaxLoad (indication du nombre de messages en attente d'envoi par le coordinateur).
  - Une valeur de MaxLoad supérieure à 5 peut être indicative d'un engorgement et donc d'un dysfonctionnement.
  - Une fréquence trop élevée d'interrogation des objets peut être la cause d'un MaxLoad élevé (>5).
- L'état du plugin (Busy, Ready, etc..).
- La version du plugin.
- La version du firmware du coordinateur.

![Plugin Web Admin Interface](../Images/Dashboard.png)

## Présentation de l'interface d'administration
[L'interface web du plugin](Home.md#linterface-web-du-plugin)
