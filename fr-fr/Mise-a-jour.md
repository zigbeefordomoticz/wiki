# Les mise à jour et les branches

## Mettre à jour le plugin

Le plugin est régulièrement mis à jour que ce soit pour de la correction de bug ou l'ajout de nouvelle fonctionnalités.

### Procédure

* Ouvrir un terminal et aller jusqu'au répertoire du pligin Zigate (génralement c'est '/home/pi/domoticz/plugins/Domoticz-Zigate')
* Lancer la commande `git pull`

Les informations de mise à jour sont affichées comme dans l'exemple  ci-dessous :

![Mise à jour](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Git-Pull.png)

* Exécuter ensuite : `sudo chmod +x plugin.py`
* Redémarer Domoticz



### En cas d'erreurs

Il peut y avoir des fichiers dont les droits ont changés. Dans ce cas, faire les commandes suviantes :
```
  git reset –-hard
  git pull --force
  ```
  
## Les branches de version

The plugin is under constant development in order to bug fix and add new features as well as taking into account new devices.

The code is available under different branches

## About release channels

In order to provide stability and also provide more recent development, Zigate plugin has the following channels

### stable

This is considered as a solid , reliable version.

### beta

We can open the beta channel to provide early version and to stabilize the version priori to be move to the stable channel

## How to switch from one channel to the other

`git pull`

`git checkout stable  // will move you to the stable channel`

`git checkout beta    // will move you to the beta channel`
