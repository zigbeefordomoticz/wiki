# Utilisation de l'environnement virtuel Python avec Domoticz et le plugin Zigbee 4 Domoticz

## Pourquoi ?

Il semble que des distributions Linux récentes peuvent empêcher l'utilisation de `sudo python3 -m pip` pour l'installation de code python. Cela vise principalement à éviter tout risque de panne du système en écrasant les bibliothèques faisant partie des outils écrits en Python avec le système.

Pour installer correctement les bibliothèques et applications Python requises pour le plugin Z4D, nous devons créer un environnement virtuel dédié à __Domoticz__ et y stocker tous les modules/bibliothèques Python requis pour les différents plugins Python.


Cela évitera des messages d’erreur comme celui-ci :

```log
error: externally-managed-environment

× This environment is externally managed
╰─> To install Python packages system-wide, try apt install
    python3-xyz, where xyz is the package you are trying to
    install.

    If you wish to install a non-Debian-packaged Python package,
    create a virtual environment using python3 -m venv path/to/venv.
    Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make
    sure you have python3-full installed.

    For more information visit http://rptl.io/venv

note: If you believe this is a mistake, please contact your Python installation or OS distribution provider. You can override this, at the risk of breaking your Python installation or OS, by passing --break-system-packages.
hint: See PEP 668 for the detailed specification.
```

## Création de l'environnement Python pour Domoticz

### Quelle est la version Python exécutée sous Domoticz

Recherchez le message ci-dessous dans le journal Domoticz.

`Status: PluginSystem: Started, Python version '3.10.11', 10 plugin definitions loaded.`

Conclusion : Domoticz exécute python3.10 comme interpréteur Python pour tous les plugins Python.

Vérifiez quelle est la version par défaut de l'interpréteur Python3

`python3 --version`

Si vous obtenez : `Python 3.10.11` en réponse à la commande, alors l'interpréteur python3 par défaut correspondant à celui de Domoticz. Si vous obtenez une réponse différente, comme `Python 3.12.7`, cela signifie que Domoticz exécute un interpréteur python inférieur à celui par défaut sur votre système (ce qui n'est pas un problème). Vous devez donc installer les bibliothèques pour la bonne version d'interpréteur, dans ce cas 3.10 et non 3.12, dans un environnement Python séparé pour Domoticz. Pour ce faire, n'utilisez pas python3 mais python3.10 à la place pour spécifier la version que vous devez utiliser.

### Création de l'environnement Python

Nous suggérons de créer l'environnement Python Domoticz dans un répertoire personnel de Domoticz tel que __/home/domoticz__ :

```bash
cd /home/domoticz
mkdir Domoticz_Python_Environment
```

```bash
cd /home/domoticz/plugins/Domoticz-Zigbee
````

```bash
python3 -m pip install -r requirements.txt --upgrade -t /home/domoticz/Domoticz_Python_Environment
```

ou si vous devez utiliser une version spécifique:

```bash
python3.10 -m pip install -r requirements.txt --upgrade -t /home/domoticz/Domoticz_Python_Environment
```

### Démarrer Domoticz avec l'environnement Python

Ajoutez la définition de la variable d'environnement PYTHONPATH dans le script qui démarre automatiquement Domoticz. Pour plus d'informations consultez la page [Domoticz Linux wiki](https://wiki.domoticz.com/Linux) et notamment la section _Starting Domoticz automatically when the system boots_ .

Si vous utilisez l' __Option 1__ , éditez le script  `/etc/init.d/domoticz.sh` et ajoutez la ligne suivante:

```export PYTHONPATH=/home/domoticz/Domoticz_Python_Environment:$PYTHONPATH```

Si vous utilisez l' __Option 2__ , éditez le fichier domoticz.service et ajoutez le paramètre __EnvironmentFile__  avec le nom d'un fichier de configuration tel que décrit dans le wiki. Ajouter votre définition de PYTHONPATH dans ce fichier de configuration.

Suite aux modifications de domoticz.service le script vous devrez peut-être exécuter la commande `systemctl daemon-reload`.
