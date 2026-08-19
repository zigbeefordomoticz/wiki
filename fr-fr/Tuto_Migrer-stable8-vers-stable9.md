# Migrer de stable8 vers stable9

La branche `stable8` est désormais fermée aux nouvelles fonctionnalités et ne reçoit plus que des correctifs critiques. Tous les nouveaux développements se poursuivent sur `stable9`, basée exclusivement sur le **Framework Étendu de Domoticz** (`DomoticzEx`), disponible depuis Domoticz 2025.1.

Le basculement se fait avec un outil unique fourni dans le plugin : `Tools/plugin-switch-stable9.sh`. Ne changez pas de branche manuellement avec `git checkout stable9` — ce script vérifie votre version de Domoticz, affiche l'avertissement de migration, et ne procède qu'une fois que vous l'avez explicitement accepté.

## Avant de commencer — ce basculement est à sens unique

* Le basculement lui-même est **rétrocompatible** : il ne modifie ni ne recrée aucun de vos périphériques existants. Tout ce que vous avez appairé sous `stable8` continue de fonctionner exactement comme avant.
* Mais tout périphérique que vous appairez **après** le basculement est créé directement sous le Framework Étendu par `stable9`. Ces nouveaux périphériques ne sont **pas** compatibles avec l'ancien modèle de widgets de `stable8`.
* Dès qu'un nouveau périphérique est appairé sur `stable9`, revenir à `stable8` cesse d'être possible.

Ne lancez le basculement que lorsque vous êtes prêt à vous engager définitivement sur `stable9`.

## Prérequis

* Domoticz **2025.1 ou supérieur**, avec le Framework Étendu disponible. `plugin-switch-stable9.sh` vérifie cela automatiquement en interrogeant l'API JSON de Domoticz — inutile de le vérifier vous-même. **Domoticz 2026.2 ou supérieur est vivement recommandé** pour la meilleure expérience avec le Framework Étendu — si vous êtes encore sur une version 2025.x, profitez-en pour mettre à jour Domoticz en même temps.
* Votre installation du plugin doit actuellement être sur `stable8`, sans modification locale non validée (`git status` propre). Validez ou mettez de côté (`git stash`) toute modification en attente au préalable.

## Étape 1 — Sauvegarder Domoticz et le plugin

Ce basculement étant à sens unique dès qu'un nouveau périphérique est appairé (voir ci-dessus), faites une sauvegarde complète **avant** de basculer, pas après :

* Arrêtez Domoticz.
* Sauvegardez la base de données Domoticz (`domoticz.db`) elle-même.
* Sauvegardez les fichiers critiques du plugin, **en même temps** que la base de données pour garder les deux cohérents entre eux — voir [Sauvegardes du Plugin](Plugin_Sauvegardes.md) pour la liste complète et la procédure :

  ```
  Conf/PluginConf-*.json
  Data/*
  Reports/*
  ```

* Redémarrez Domoticz une fois la sauvegarde terminée.

Ainsi, si quelque chose semble anormal juste après le basculement, vous pouvez restaurer à la fois la base de données et les fichiers du plugin et revenir exactement à votre point de départ — tant qu'aucun nouveau périphérique n'a été appairé sur `stable9`.

## Étape 2 — Lire l'avertissement de migration (aucune modification effectuée)

**Domoticz (et le plugin) doivent être démarrés** à ce stade — le script vérifie votre version en appelant l'API JSON de Domoticz, qui doit donc être accessible. Si vous avez arrêté Domoticz pour la sauvegarde de l'étape 1, redémarrez-le d'abord.

Depuis le répertoire du plugin (celui qui contient `Tools/`), lancez le script **sans argument** :

```bash
Tools/plugin-switch-stable9.sh
```

Cela va :

* Afficher l'avertissement de migration complet (en anglais et en français).
* Interroger Domoticz sur `127.0.0.1:8080` (valeur par défaut) pour confirmer que votre version prend en charge le Framework Étendu.
* Ne faire **aucune** modification sur git ni sur votre installation — c'est purement informatif.

Si Domoticz tourne sur une autre adresse/port, passez `--ip` et `--port` :

```bash
Tools/plugin-switch-stable9.sh --ip 192.168.1.10 --port 8080
```

Si vous utilisez Domoticz sous Docker et que vous lancez le script depuis l'**hôte** Docker (et non via `docker compose exec`), `127.0.0.1` sur l'hôte n'atteint Domoticz que si ce port est publié vers l'hôte. Dans ce cas :

* lancez le script à l'intérieur du conteneur, en suivant le même principe que `Tools/update_domoticz_docker_container.sh`, par exemple :

  ```bash
  docker compose exec <container> bash -c "cd <repertoire_plugin> && Tools/plugin-switch-stable9.sh"
  ```

* ou passez `--ip`/`--port` correspondant à l'adresse publiée sur l'hôte.

Si le script ne parvient pas du tout à joindre Domoticz, il vous demandera de confirmer la version manuellement via **Setup > About** dans Domoticz plutôt que de supposer que tout va bien.

## Étape 3 — Effectuer le basculement

**Domoticz (et le plugin) doivent toujours être démarrés** — le script revérifie votre version de Domoticz de la même façon qu'à l'étape 2. Laissez-les démarrés ensuite également : la mise à jour via le WebUI de l'étape 4 est une action du plugin, donc impossible si Domoticz et le plugin ne sont pas actifs.

Une fois l'avertissement lu et prêt à poursuivre, relancez le script avec `--i-understand` :

```bash
Tools/plugin-switch-stable9.sh --i-understand
```

C'est le seul indicateur qui déclenche réellement le basculement — il doit être tapé explicitement, en ligne de commande, par une personne ayant lu l'avertissement. Le script va alors :

1. Revérifier la version de Domoticz (arrêt si elle est antérieure à 2025.1).
2. Vérifier qu'il n'y a aucune modification locale non validée.
3. Lancer `git fetch origin` puis récupérer les dernières modifications de la branche courante.
4. Basculer sur `stable9` et récupérer ses dernières modifications.

En cas de succès, vous verrez :

```
Successfully switched to stable9 branch
```

accompagné du même rappel sur le caractère définitif du basculement que dans l'avertissement ci-dessus.

## Étape 4 — Mettre à jour les modules Python et redémarrer

`plugin-switch-stable9.sh` ne fait que basculer la branche git — il n'installe/ne met **pas** à jour les dépendances Python. `stable9` peut nécessiter des versions de modules plus récentes que `stable8`. Avant de redémarrer, utilisez donc l'action de mise à jour propre au plugin pour aligner l'environnement Python :

* Ouvrez l'interface web du plugin.
* Allez dans la section [Admin > Plugin](WebUI_Admin.md#plugin).
* Cliquez sur **Mettre à jour le plugin**. Cela installe/met à jour tout ce qui est listé dans `requirements.txt` pour le code `stable9` désormais actif (voir [Mise à jour via le WebUI](Plugin_Mise-a-jour.md#mise-à-jour-via-le-webui)), en utilisant l'environnement Python que le plugin est lui-même configuré pour utiliser — y compris un venv, si vous en utilisez un.
* Une fois terminé, cliquez sur **Redémarrer le plugin**.

Privilégiez l'action du WebUI plutôt qu'un `pip install` lancé vous-même depuis un terminal : un `pip install` manuel cible le `python3` résolu par votre shell, qui n'est pas forcément le même interpréteur/venv que celui réellement utilisé par Domoticz pour exécuter le plugin.

## En cas de problème

* **« You have uncommitted changes »** : validez ou mettez de côté vos modifications (`git stash -u`), puis relancez le script.
* **« Domoticz version requirement not met »** : mettez d'abord Domoticz à jour vers la version 2025.1 ou supérieure — sinon le plugin ne démarrera pas sous `stable9`.
* **La vérification de version n'arrive pas à joindre Domoticz** : passez `--ip`/`--port`, ou confirmez votre version manuellement via **Setup > About**, puis relancez avec `--i-understand` une fois certain.

## Voir aussi

* [Mettre à jour le Plugin](Plugin_Mise-a-jour.md) — procédure générale de mise à jour du plugin
* [Installation du Plugin](Plugin_Installation.md) — prérequis Domoticz/Python
