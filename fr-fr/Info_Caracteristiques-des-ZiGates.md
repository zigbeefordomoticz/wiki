<a href="Home.md"><img align="left" width="80" height="80" src="../Images/zigbee4domoticz-logo.png" alt="Logo"></a>

# Info - Les caractéristiques des coordinateurs

Les coordinateurs peuvent avoir des différences. Plutôt que d'éditer toutes les pages du wiki pour rajouter les infos pour les nouveaux modèles, toutes les informations de ce type sont regroupées dans cette page.

## Nombre d'objet limité

Le nombre d'objets géré par un coordinateur est limité :

* ZiGate Modèle **V1** avec **firmware standard** : 40 objets en tout.
* ZiGate Modèle **V1** avec **firmware OptiPDM** : 70 objets en tout avec 20 objets maximum en direct sur la ZiGate, le reste en passant par les routeurs.

* ZiGate Modèle **V2** : 200 objets avec 20 maximum en direct sur la ZiGate, le reste en passant par les routeurs.


Dans tous les cas, **DomoticZ limite le nombre de dispositifs par plugin à 255**.

Pour info, un objet capteur de température Xiaomi / Aqara occupe 5 dispositifs : Température, Hygrométrie, Pression, Température + Hygrométrie et Température + Hygrométrie + Pression. Il est possible à tout instant de supprimer les dispositifs (DomoticZ) non utilisés et ainsi gagner en nombre. [Voir le paragraphe Gestion des Dispositifs](Tuto_Appairage-objet.md#gestion-des-dispositifs).

[Comment mettre à jour le firmware de sa ZiGate](Tuto_Maj-firmware-zigate.md)

## Nombre de groupe limité

Le nombre de groupes auxquels un coordinateur peut appartenir est limité :

* ZiGate Modèle V1 : 5 Groupes
* ZiGate Modèle V2 : 15 Groupes

Le nombre de groupes auxquels un objet peut appartenir est limité :

Généralement, un objet peut appartenir à 5 groupes différents. Pour rappel, c'est l'objet qui sait dans quel groupe il appartient. Le nombre exact va dépendre de chaque objet.
