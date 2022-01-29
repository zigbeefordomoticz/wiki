<a href="Home.md"><img align="left" width="80" height="80" src="../Images/logo_Z4D.png" alt="Logo"></a>

# Info - Les caractéristiques des coordinateurs

</br>

Les coordinateurs peuvent avoir des différences. Plutôt que d'éditer toutes les pages du wiki pour rajouter les infos pour les nouveaux modèles, toutes les informations de ce type sont regroupées dans ce tableau :  

|                 Coordinateurs                | Firmwares |   Puces  | Objets en tout | Objets en direct | Groupes |
|:--------------------------------------------:|:---------:|:--------:|:--------------:|:----------------:|:-------:|
|        [ZiGate V1](https://zigate.fr)        |   Legacy  |          |       40       |         ?        |    5    |
|        [ZiGate V1](https://zigate.fr)        |  OptiPDM  |          |       70       |        20        |    5    |
|        [ZiGate V2](https://zigate.fr)        |           |          |       200      |        20        |    15   |
| [ZZH RF Stick](https://shop.electrolama.com) |           | CC2652R1 |        ?       |         ?        |    ?    |



## Nombre d'objets limité

Le nombre d'objets gérés par un coordinateur est limité. Il y a un nombre total d'objets (Objets en tout) mais aussi un nombre maximal d'objets en direct sur le coordinateur (Objets en direct). Le reste des objets devra passer par des routeurs.

Dans tous les cas, **DomoticZ limite le nombre de dispositifs par plugin à 255**.

__Info :__ Un objet capteur de température Xiaomi / Aqara occupe 5 dispositifs : Température, Hygrométrie, Pression, Température + Hygrométrie et Température + Hygrométrie + Pression. Il est possible à tout instant de supprimer les dispositifs (DomoticZ) non utilisés et ainsi gagner en nombre. [Voir le paragraphe Gestion des Dispositifs](Tuto_Appairage-objet.md#gestion-des-dispositifs).

## Nombre de groupes limité

Le nombre de groupes auxquels un coordinateur peut appartenir est limité.

__Info :__ Le nombre de groupes auxquels un objet peut appartenir est limité. Généralement, un objet peut appartenir à 5 groupes différents. Pour rappel, c'est l'objet qui sait dans quel groupe il appartient. Le nombre exact va dépendre de chaque objet.
