# Les mises à jour et les branches

## Mettre à jour le plugin

Le plugin est régulièrement mis à jour que ce soit pour de la correction de bug ou l'ajout de nouvelle fonctionnalités.


### Procédure

* Ouvrir un terminal et aller jusqu'au répertoire du plugin ZiGate (généralement c'est '/home/pi/domoticz/plugins/Domoticz-Zigate')

* Lancer la commande `git pull`

Les informations de mise à jour sont affichées comme dans l'exemple  ci-dessous :

![Mise à jour](../Images/Git-Pull.png)

* Exécuter ensuite : `sudo chmod +x plugin.py`

* Redémarrer DomoticZ


### En cas d'erreurs


Il peut y avoir des fichiers dont les droits ont changés. Dans ce cas, faire les commandes suivantes :

```
  git reset –-hard
  git pull --force
 ```

## Les branches de mise à jour


Le plugin évolue en permanence suite à la correction de bug, l'amélioration du plugin ou l'ajout de nouveaux dispositifs. Afin d'éviter un maximum de bug, le code du plugin est disponible sous différentes canaux de mise à jour.

Les différentes branches sont :


#### stable

C'est la version la plus "solide". C'est la version par défaut.


#### stable-fix

La branche stable-fix est l'anti-chambre de la branche stable. En gros les bug-fix sont réalisées sur celle-ci avant d'être envoyer sur la branche stable. Il n'y a pas de gestion de version sur cette branche!


#### beta

La branche Béta est le canal de développement. __Ne passez pas sur la branche beta sans y avoir été invité.__

Si vous êtes sur la branche __Beta__ (suite à l'ajout d'un nouveau matériel par exemple), vous pouvez repasser sur la branche __Stable__ à la prochaine mise à jour du canal __Stable__.

### Connaître sa branche


* Ouvrir un terminal et aller jusqu'au répertoire du plugin ZiGate (généralement c'est '/home/pi/domoticz/plugins/Domoticz-Zigate')
* Lancer la commande `git status`


### Passer d'une branche à l'autre

Il est recommandé des faire une [sauvegarde](5_Sauvegardes.md) avant de faire des modifications afin de pouvoir revenir en arrière en cas de problèmes.

* Ouvrir un terminal et aller jusqu'au répertoire du plugin ZiGate (généralement c'est '/home/pi/domoticz/plugins/Domoticz-Zigate')

* Lancer la commande `git pull`

* Lancer la commande `git checkout stable` pour aller sur le canal stable
* Lancer la commande `git checkout stable-fix` pour aller sur le canal stable-fix
* Lancer la commande `git checkout beta` pour aller sur le canal beta
