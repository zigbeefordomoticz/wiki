# Les objets de la marque Livolo

Certains objets de la marque Livolo ont besoin d'une configuration particulière pour fonctionner avec le plugin. Ils seront listés dans cette page.

** Cette page n'est pas une liste des objets compatibles.**

La liste des objets compatibles est sur le site [https://zigbee.blakadder.com/zigate.html](https://zigbee.blakadder.com/zigate.html).


## Avertissement

Livolo semble __ne pas suivre__ les standard ZigBee. Il en résulte :
* la stabilité peut-être un problème : l'interrupteur se déconnecte de temps en temps et il n'est pas évident de le faire revenir. Une fois, il a été nécessaire de faire une Erase PDM pour refaire un appairage complet (avec tous les autres dispositifs)
* l'extensibilité (la capacité d'avoir beaucoup d'objets) peut-être un problème et __peut impacter négativement les autres objets__.  


## Prérequis

* L'interrupteur Livolo (simple ou double) __peut seulement être appairer sur le canal 26__. Une méthode est décrite plus bas pour mettre l'interrupteur sur le canal 11.
* Firmware 3.1b de la ZiGate
* Version du plugin 4.6 ou supérieure
* __Obligation de laisser la ZiGate en mode appairage en permanence.__


## L'appairage

* Mettre la ZiGate sur le canal 26 (voir le tutoriel [Changer le canal ZigBee](Tuto_Changer-le-canal-ZigBee.md))
* Mettre la ZiGate en mode appairage (voir le tutoriel [Ajouter un nouveau dispositif](Tuto_Appairage-objet.md))
* Lancer le processus d'appairage sur l'interrupteur en appuyant sur un bouton pendant 6 secondes. Un bip se fera entendre.

Après un moment, l'interrupteur devrait être appairer et deux Widgets seront créer dans DomoticZ.

**Information :**

Que l'interrupteur soit à simple ou à double commande, il sera identifier comme un __TI0001__. C'est la raison pour laquelle le plugin ne peut pas identifier le type de l'interrupteur. Même si vous avez un interrupteur simple, 2 Widgets seront crées. Il est possible de supprimer le Widget qui ne sera pas utilisé.

## Forcer le canal 11

Il est possible de basculer un dispositif Livolo appairé sur le canal 11 (et seulement le 11).

L'interrupteur doit être appairé sur le canal 26.

* Mettre la ZiGate sur le canal 11 (voir le tutoriel [Changer le canal ZigBee](Tuto_Changer-le-canal-ZigBee.md))

Après un moment, le dispositif Livolo devrait basculer automatiquement sur le canal 11.

Malheureusement, __en cas de pane de courant__, il faudra supprimer les Widgets dans DomoticZ et refaire le processus d'appairage sur le canal 26.


## Fonction On/OFF

La fonction On/Off est basée sur le cluster 0x0008 (Level Control) plutôt que le 0x0006 (Switch). C'est comme ça, merci Livolo !
Il utilise donc les deux paramètres :
* Niveau auquel vous souhaiter aller. Utiliser pour la commande On/OFF
* La période de transition qui exprime le temps pour changer du niveau actuel au niveau souhaité. Ceci est utilisé pour la sélection du coté (droite ou gauche)

| Commande | Niveau |
| ------- | ----- |
| On      | 0x6C (108) |
| Off     | 0x01 (1) |

| Sélection du coté | Transition |
| -------------- | ---------- |
| Gauche         | 0x0001 (1) |
| Droite         | 0x0002 (2) |

Par exemple, pour allumer le coté droit, il faudra faire Level 0x6C avec Transition 0x0002.


## Avancé

Il peut arriver que l'interrupteur sorte du réseau et n'arrive pas à revenir dans le réseau. Généralement, un branchement Off/On ou un simple reset (appui de 6 secondes sur le bouton de droite) résous le problème. Si ce n'est pas le cas, essayer d'activer le paramètre expérimental __rebindLivolo__.

@Kiwic16 a trouvé une façon pour que l'interrupteur reste appairer avec la ZiGate. Plus d'informations sur son site : http://kiwihc16.free.fr/Livolo.html


## Références

* https://github.com/fairecasoimeme/ZiGate/issues/148
* https://github.com/KiwiHC16/Abeille/issues/570
* http://kiwihc16.free.fr/Livolo.html
