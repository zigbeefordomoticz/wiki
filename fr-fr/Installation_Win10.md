# Installation de Zigate et Domoticz sous Windows 10

Installer l’ensemble Domoticz et Zigate sous Windows 10 n’est pas réllement plug and play.

On on est très vite confronté à chercher des informations éparpillées sur le net, à lire des retours d’expérience dans de nombreux forums et tenter d’éviter les pièges sous Windows.

Après plusieurs tests et échecs, je vous fais part de mon expérience qui m’a permis en partie de comprendre et de solutionner les problèmes d’installation avec un peu de rigueur.

Un conseil : installer tous les logiciels en mode Administrateur ! (Clic droit dans Windows, éxécuter en tant qu’administrateur). Sinon, vous risquez d’installer partiellement un logiciel et ne pas vous en rendre compte sur le coup.

## 1	Installation de Domoticz

Le premier conseil est d’installer Domoticz (version stable par exemple) dans un répertoire autre que le classique Programmes (x86) par défaut. Sinon, il faudra jouer avec les droits utilisateurs. Si tel est le cas, pour modifier les droits, ouvrez l’explorateur Windows, faire clic-droit sur le disque C :, puis propriétés, onglet sécurité :

























Attention, Domoticz et Zigate ont besoin d’écrire des fichiers dans des sous répertoires et un droit d’accès manquant pourra faire apparaître dans l’onglet  « Configuration/log » de  Domoticz ce type de message :



Même en attribuant le maximum de droits autorisés (administrateur, utilisateur avec droits en écriture ...), il m’est arrivé d’obtenir ce message (peut être un oubli…).
Pour éviter tout problème, j’ai finalement choisi d’installer Domoticz directement à la racine sous C:\Domoticz et depuis aucun problème.


## 2.	Installation de la Zigate

Il est recommandé d’installer la Zigate selon les instructions disponibles sur le site officiel :

https://zigate.fr/documentation/tester-la-zigate-usb

Installer les pilotes (pour le convertisseur USB rouge, allez sur le site de siliconlabs et télécharger CP210x Universal Windows Driver )

Tester l’application TestGUI (vous pouvez télécharger le fichier zip en allant dans la rubrique code sur le site https://github.com/fairecasoimeme/ZiGate puis le dézipper dans un répertoire dédié).
Vous pouvez également utiliser un client Git pour Windows (voir 3.2 ci après)

L’application se situe dans un sous répertoire Tools et se nomme ZGWUI.exe

Vérifier que la Zigate est correctement installée et fonctionnelle en effectuant les tests mentionnés sur le site de Zigate

## 3.	 Logiciels additionnels

Pour la suite, deux logiciels sont nécessaires et utiles pour réaliser une installation propre sous windows:

### 3.1	Python

Installer une version de Python prenant en charge Domoticz comme indiqué dans le Wiki:
https://www.domoticz.com/wiki/Using_Pyt ... or_Windows

Installer une version 32 bits pour Windows à partir du site Python.org (par exemple, 3.5.2 et 32 bits) :
https://www.python.org/downloads/windows/

Si la version est compatible avec Domoticz, un message de status dans l’onglet « Configuration/Log » de Domoticz  l’indiquera au démarrage:



Autrement, un message du type Python Failed apparaitra

Pour avoir testé plusieurs versions avec échec et succès, j’ai finalement opté pour conserver la version 3.5.2 (mentionnée dans le wiki Domoticz)  qui a fonctionné correctement et j’ai supprimé toutes les autres .
 
Il est possible cependant d’installer et de conserver plusieurs versions de python sur son ordinateur. Pour connaître la version active en cours, cliquer sur l’icône Démarrer Windows, puis entrer CMD dans la barre de recherche afin de lancer l’invite de commande (clic droit, éxécuter en tant qu’administrateur). Enfin taper : python --version

Gérer plusieurs version python avec py sous windows n’est pas forcément simple mais des explications sont disponibles à la fin du Wiki consacré à Python et Domoticz :
https://www.domoticz.com/wiki/Using_Pyt ... or_Windows

Lors de l’installation de Python, des librairies sont manquantes côté Python comme le package ZIGATE pour Python.

Lancer une invite de commande en tant qu'administrateur et se placer dans le répertoire de python en tapant : cd \Program Files (x86)\Python35-32>

Exécuter la commande (sans les guillemets) : "py -m pip install zigate"
Cela donne donc : C:\Program Files (x86)\Python35-32>py -m pip install zigate

Attendre que l’installation du package soit terminé (vous devez être connecté à Internet)

Il est fort possible que la librairie libpython utile à Domoticz ne soit pas installée (vérifiez si un fichier du type libpython3.x existe dans le sous répertoire « libs » de python). S’il n’existe pas, effectuez la même opération avec la commande (sans les guillemets) :
 "py -m pip install libpython3.5"
Cela donne donc : C:\Program Files (x86)\Python35-32>py -m pip install libpython3.5

En fonction de la version x de Python installée, vous devez installer libpython3.x
Attendre que l’installation du package soit terminé (vous devez être connecté à Internet)
### 3.2	Git pour Windows

De nombreux packages de plugin sont disponibles sur GitHub pour Domoticz. C’est le cas notamment pour la Zigate.

Sous windows, le plus simple pour gérer ce type de packages est de télécharger et d’installer  un client de téléchargement « git » en allant sur le site officiel :

https://gitforwindows.org/

## 4.	Installation du plugin ZIGATE

La dernière étape consiste à installer le plugin de Pipiche pour gérer la Zigate dans Domoticz.

Cependant, le répertoire ou sont installés les plugins n’existe pas lors de l’installation de Domoticz. Il faut donc le créer manuellement.

Pour cela, ouvrez l’explorateur Windows et allez dans le répertoire ou est installé Domoticz (pour mon cas,  C:\Domoticz)
Clic droit sur Domoticz, puis Nouveau Dossier que vous nommerez plugins
En éxécutant une invite de commande CMD en mode administrateur, positionnez vous dans le répertoire plugins puis taper la ligne d’instruction :

git clone https://github.com/pipiche38/Domoticz-Zigate.git

L’arborescence de la Zigate est installée :

	
## 5.	Tests des logiciels

Vous pouvez maintenant lancer Domotics en cliquant sur l’icône de Domoticz, ce qui conduit à ouvrir une fenêtre dans votre navigateur à l’adresse locale 127.0.0.1 (port 8080) :

127.0.0.1:8080

Dans Domoticz, Vous devez installer la passerelle Zigate en ajoutant un nouveau matériel (donnez un nom et sélectionnez dans la rubrique Type le plugin « Zigate plugin » en fin de liste). Si tout se passe bien, en allant dans le rubrique Configuration/logs, vous devriez avoir un log de ce type  :




Accéder également à l’interface du plugin de Pipiche en tapant dans votre navigateur:


127.0.0.1:9440

Cela permet d ‘accéder au dashboard suivant :


Pour ma part, j’utilise grandemment cet outil, notamment pour intégrer des nouveaux modules dans la Zigate (fonction Join à valider en activant la fonctionnalité « Accepter de nouveaux dispositifs » en haut à droite) et pour me rendre compte de l’état des échanges entre la Zigate et les dispositifs.
Puis je termine la mise en forme dans Domoticz (nom etc ...)


## 6	Un PC Windows comme box domotique

Avec l’apparition des mini PC fanless sous windows 10 pour une centaine d’euros, il est tentant de se constituer sa box à l’aide du logiciel Domoticz et de la clé Zigate USB avec protocole Zigbee .

Mais en cas de coupure de courant, une box domotique doit être en état de repartir. Domoticz étant dans le groupe de démarrage, l’application se relance automatiquement.

Malheureusement, l’invite de Windows 10 vous demande d’introduire votre mot de passe et interrompre ce processus.

Pour éviter ce désagrément (surtout lorsqu’on est absent du domicile), il est possible d’éviter d’entrer le mot de passe du compte courant à l’invite de Windows (l’inconvénient est un PC accessible à tous, à vous de choisir).

Pour cela, taper « netplwiz » dans l’invite de commande Windows et éxécuter la commande




















Décocher la case à cocher « Les utilisateurs doivent entrer un nom d’utilisateur et un mot de passe pour utiliser cet ordinateur » et redémarrer l’ordinateur.

Celui-ci ne devrait plus vous demander le mot de passe sur la page de démarrage.

Dans certaines versions de Windows 10,  vous pouvez également demander à modifier le mot de passe en laissant le champ vide dans nouveau mot de passe.























Si la case à cocher n’est pas visible, alors il s’agit probablement d’une version très récente de Windows 10. Des tutos sont disponibles sur la toîle pour la faire apparaître en manipulant le registre de Windows (winlogon pour les plus avertis).


