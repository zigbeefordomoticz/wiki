# Les mises à jour et les branches

## Mettre à jour le Plugin

Le Plugin est régulièrement mis à jour que ce soit pour de la correction de bug ou l'ajout de nouvelle fonctionnalités.

### Procédure

__ATTENTION:__ si vous n'êtes pas encore en Version 7, merci de suivre cette procédure de  mise à jour vers la [version 7](Plugin_Version-7.md)

La version 6.3 a ajouter la possibilité de lancer une mise à jour depuis le WebUI.

#### Mise à jour via le WebUI

* Ouvrir l'interface web du plugin

* Aller dans la section [Admin > Plugin](WebUI_Admin.md#plugin).

* Cliquer sur le bouton **Mettre à jour le plugin**

Un encadré va apparaître en dessus avec le résultat de la mise à jour comme si vous la lanciez depuis votre terminal.

* Une fois la mise à jour terminée, cliquer sur le bouton **Redémarrer le plugin**.


#### Mise à jour via le terminal (Mise à jour manuelle)

* Ouvrir un terminal et aller jusqu'au répertoire du Plugin ZigBeeForDomoticZ (généralement c'est '/home/pi/domoticz/plugins/Domoticz-Zigbee')

* Lancer les commandes (si besoin en ajoutant sudo):

```bash
  git pull
  sudo python3 -m pip install -r requirements.txt --upgrade
 ```

* Redémarrer DomoticZ


### En cas d'erreurs

Il peut y avoir des fichiers dont les droits ont changés. Dans ce cas, faire les commandes suivantes :

```bash
  git reset --hard
  git pull --force
 ```

## Les branches de mise à jour

Le Plugin évolue en permanence suite à la correction de bug, l'amélioration du Plugin ou l'ajout de nouveaux objets. Afin d'éviter un maximum de bug, le code du Plugin est disponible sous différents canaux de mise à jour.

Au fur et à mesure des évolutions de DomoticZ, le Plugin se doit d'évoluer et, malheureusement, il n'est pas possible de conserver une compatibilité du Plugin avec toutes les versions antérieurs de DomoticZ. C'est pourquoi à partir de la version 5 (mai 2021), une branche __stable5__ est crée pour conserver la branche __stable__ compatible avec les anciennes versions.

Les différentes branches sont :

#### stable7 (créée en avril 2023)

C'est la version qui sépare la gestion des objets certifiés des fichiers de fonctionnement du plugin.

| Info  | Compatibilité  |
| :------------: |:---------------:|
| Coordinateurs | ZiGate V1 et V2<br>ELElabs<br>ZZH<br>Sonoff<br>TI CCXXXX |
| Compatibilité minimale | DomoticZ 2023.1 / Python 3.8 > Debian Bullseye|
| Compatibilité maximale | Dernière version de DomoticZ |

__Note :__ Le passage à la stable7 nécessite une procédure particulière : voir la page [Migration vers version 7](../en-eng/Release_7.1.md).


#### dev (créée en avril 2023)

La branche dev est le canal de développement. __Ne passez pas sur la branche dev sans y avoir été invité.__

Si vous êtes sur la branche __dev__ (suite à un développement), vous pouvez repasser sur la branche __stable7__ à la prochaine mise à jour du canal __stable7__.

| Info  | Compatibilité  |
| :------------: |:---------------:|
| Coordinateurs | idem stable7 |
| Compatibilité minimale | DomoticZ 2023.1 |
| Compatibilité maximale | Dernière version de DomoticZ |

#### stable6 (créée en avril 2022)

C'est la version qui a ouvert le plugin aux coordinateurs TI CCXXXX, Sonoff, Elelabs, ZNP.

| Info  | Compatibilité  |
| :------------: |:---------------:|
| Coordinateurs | ZiGate V1 et V2<br>ELElabs<br>ZZH<br>Sonoff<br>TI CCXXXX |
| Compatibilité minimale | DomoticZ 2021.1 |
| Compatibilité maximale | Dernière version de DomoticZ |

__Note :__ Le passage à la stable6 nécessite une procédure particulière : voir la page [Migration vers version 6](Mise-a-jour_6.1.md).

#### stable5 (créée en mai 2021)

C'est la version qui a ajouté la compatibilité avec la ZiGate+ (V2).

| Info  | Compatibilité  |
| :------------: |:---------------:|
| Modèles de ZiGate | V1 et V2 |
| Compatibilité minimale | DomoticZ 2020.1 |
| Compatibilité maximale | DomoticZ 2022.1 |

Cette version ne recevra plus de mise à jour.

__Note :__ Le passage à la stable5 nécessite un redémarrage de DomoticZ et de renseigner des nouveaux paramètres dans le [Paramétrage du plugin](Plugin_Parametrage.md) sinon, vous aurez une erreur de communication au lancement du Plugin.

#### stable

C'était la version par défaut jusqu'au moment de la sortie de la ZiGate V2.
Sa compatibilité s'arrête avec DomoticZ 2020.2.

| Info  | Compatibilité  |
| :------------: |:---------------:|
| Modèles de ZiGate | V1 |
| Compatibilité minimale | DomoticZ 4.XXX |
| Compatibilité maximale | DomoticZ 2020.2 |

Cette version ne recevra plus de mise à jour.

#### dev

La branche dev est le canal de développement. __Ne passez pas sur la branche dev sans y avoir été invité.__

Si vous êtes sur la branche dev (suite à l'ajout d'un nouveau matériel par exemple), vous pouvez repasser sur la branche __stableX__ à la prochaine mise à jour du canal __stableX__.

| Info  | Compatibilité  |
| :------------: |:---------------:|
| Modèles de ZiGate | V1 et V2 |
| Compatibilité minimale | DomoticZ 2020.1 |
| Compatibilité maximale | Dernière version de DomoticZ |

Cette version ne recevra plus de mise à jour.

### Connaître sa branche

* Ouvrir un terminal et aller jusqu'au répertoire du Plugin ZigBeeForDomoticZ (généralement c'est '/home/pi/domoticz/plugins/Domoticz-Zigate')
* Lancer la commande `git status`

### Passer d'une branche à l'autre

Il est recommandé des faire une [sauvegarde](Plugin_Sauvegardes.md) avant de faire des modifications afin de pouvoir revenir en arrière en cas de problèmes.

* Ouvrir un terminal et aller jusqu'au répertoire du Plugin ZigBeeForDomoticZ (généralement c'est '/home/pi/domoticz/plugins/Domoticz-Zigate')

* Lancer la commande `git pull`

* Lancer la commande `git checkout stable7` pour aller sur le canal stable7
* Lancer la commande `git checkout dev` pour aller sur le canal de développement

__Attention aux compatibilités avec DomoticZ lors du changement de branche.__

[Poursuivre sur la mise à jour du Plugin](Readme.md#mises-%C3%A0-jour-du-plugin)

### Revenir à une version précédente

En cas de gros soucis avec une nouvelle version, il est possible de revenir en arrière en utilisant la commande `git checkout beta-5.2.XXX` en remplaçant __beta__ et __5.2.XXX__ par les valeurs souhaitées.
