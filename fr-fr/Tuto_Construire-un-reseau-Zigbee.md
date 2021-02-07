# Comment construire et maintenir un bon réseau maillé ZigBee ?

## Avant-propos

Si vous utilisez des objets ZigBee, vous devez comprendre que le réseau maillé ZigBee est la pierre angulaire de votre domotique.
Ce réseau maillé permet aux objets ZigBee de communiquer entre eux et avec la passerelle ZigBee (la ZiGate dans notre cas). Bien que les objets construisent automatiquement le maillage, cette opération n'est pas instantanée. Il est donc nécessaire d'attendre que le réseau s'élabore avant de commencer à automatiser vos objets.
En automatisant trop précipitamment, vous risquez, notamment, d'être confronté à des pertes de objets.

Même si votre ZiGate supporte jusqu'à 40 objets connectés directement, un ou plusieurs routeurs contribueront à maintenir une bonne communication entre les objets et la ZiGate. Bien entendu, votre environnement, la distance entre la ZiGate et l'objet le plus éloigné, le nombre d'objets routeurs intégrés dans votre réseau va déterminer le nombre maximun d'objets que pourra contenir votre réseau ZigBee sous réserve d'avoir suffisamment d'objets routeur correctement répartis en distance avec la ZiGate mais également entre eux afin d'avoir un bon maillage.
Un routeur ZigBee est un objet alimenté sur le secteur, généralement des prises (plug) ou interrupteurs (wall switches). Par conséquent les objets ZigBee alimentés sur batterie ne permettent pas de répéter le signal ZigBee, ils sont désignés en tant que objets terminaux (end devices) à contrario des routeurs qui eux répètent le signal ZigBee.

La ZiGate supporte jusqu'à 40 objets en connexion directe. Vous pouvez étendre cette limitation en utilisant des objets avec la fonction routeur disposant de la fonction répéteur/routeur.
Les objets connectés alimentés sur batterie n'écoutent pas le réseau ZigBee et de ce fait ne peuvent exercer une fonction de routeur; on appelle aussi ces objets des objets terminaux.
Les objets terminaux ne communiquent qu'avec un parent qui peut être soit la ZiGate elle même ou bien un objet routeur. Les objets routeurs, quant à eux, communiquent avec la ZiGate et les objets terminaux.


## Comment fonctionnent les routeurs ZigBee ?

Les routeurs ZigBee relaient les informations entre la ZiGate et l'objet destination en assurant la transmission (validation de réception).
Comme mentionné plus haut, un routeur est un objet connecté qui tire son alimentation du secteur (220v pour la France); attention, cependant avec les ampoules qui peuvent être également routeurs (voir la section [Astuces](#astuces-pour-créer-un-réseau-maillé-ZigBee) pour un bon réseau maillé ZigBee). Par exemple, les prises ZigBee qui agissent en routeur, en relai, vers les objets qui sont trop éloignés de la ZiGate permettent de fiabiliser l'émission et la réception du signal.
ZigBee et Z-Wave sont deux protocoles de communication sans fil très différents; ainsi avec le ZigBee, seuls les objets alimentés sur secteur ont une fonction routeur/répéteur vers les autres objets alors qu'avec le Z-Wave les objets se comportent tous en routeur vers tous les autres objets Z-Wave.

Des objets trop éloignés de la ZiGate ou gênés par des interférences génèrent des pertes de connexion liées à un signal ZigBee trop faible.

![](../Images/ZiGateDirectLink.png)

Quand un router/répéteur est positionné entre un objet terminal et la ZiGate, l'objet terminal communique avec le routeur/répéteur et celui-ci communique avec la ZiGate améliorant ainsi très significativement les performance et la fiabilité du signal.

![](../Images/ZiGateMeshNetwork.png)

Les routeurs ont la possibilité de communiquer, non seulement avec les objets terminaux mais également entre eux afin de constituer un puissant et stable réseau maillé ZigBee.

![](../Images/ZiGateMeshNwk_MultiRouteur.png)

Les objets alimentés sur batterie doivent toujours avoir un parent avec lequel communiquer : c'est soit la ZiGate, soit un objet routeur/répéteur. Lorsqu'un objet rejoint pour la première fois le réseau ZigBee, il choisira le parent qui offre la meilleure qualité de signal. Une fois le parent choisi, il reste attaché à ce parent jusqu'à ce qu'il n'y ait plus aucune communication possible : la relation entre le parent et l'objet est exclusive, même si un autre parent nouvellement introduit dans le réseau offre un meilleur signal. C'est seulement lorsque la communication entre l'objet et le parent est rompue sur une longue période que l'objet va sélectionner un nouveau parent. Cependant, si l'objet arrive à communiquer, même occasionnellement avec la ZiGate, il ne sélectionnera pas un nouveau parent.
Ceci est un remarque d'ordre générale mais il est possible que certain objets (les Xiaomi) ne recherchent pas de nouveau chemin si leur parent ne répond plus.

Comme nous l'avons vus, les objets ZigBee attendent que la communication soit complètement perdue avec leur parent pour en rechercher un nouveau. Vous pouvez, cependant, accélérer ce processus en arrêtant la ZiGate durant 20 minutes puis la redémarrer. Quand la ZiGate redémarre les objets routeurs et les objets terminaux établiront la communication entre eux en choisissant le chemin réseau optimum. Selon la complexité de votre configuration, comptez jusqu'à 24h pour que ce processus soit terminé.


## Astuces pour créer un réseau maillé ZigBee

Voici quelques procédures à suivre lors de la découverte des objets ZigBee pour constituer un réseau solide... La patience reste la clef du succès.

Bien que le maillage ZigBee établira le chemin optimal pour une communication stable dans le temps des objets avec la ZiGate, il y a quelques recommandations à suivre pour optimiser votre réseau et ainsi avoir les meilleurs résultats.

### Astuce 1 : Positionner votre ZiGate à un emplacement central dans votre logement.

Ceci permettra à votre ZiGate de rayonner sur tout le logement en limitant les interférences avec l'ensemble des objets (routeurs ou terminaux). Éviter les coins extrémité du logement, la cave, le garage ou les endroits avec beaucoup de grosses pièces métalliques (plaques, tuyaux, ...) qui vont générer des interférences.
Si votre routeur se situe à une extrémité de votre logement, essayer de positionner votre ZiGate sur un emplacement central au travers de câble Ethernet ou CPL.

### Astuce 2 : Appairer vos objets depuis leur emplacement final.

En ajoutant les objets à proximité de votre ZiGate (routeur principal), puis en le déplaçant à l'emplacement final conduit souvent à une perte du objet au sein du réseau. Il est donc recommandé de toujours appairer vos objets depuis leur emplacement final.

### Astuce 3 : Limiter les distances

Les distances maximales dépendent de l'environnement et de la puissance des objets. En général, on convient qu'au delà d'une distance de 6m à 12m, il est nécessaire de positionner un objet routeur entre la ZiGate et les objets terminaux ou autres routeurs.

### Astuce 4 : Appairer les routeurs en premiers

Afin de satisfaire les astuces 2 et 3, il est recommandé d'appairer les objets routeurs en premier en commençant si possible par le plus proche de la ZiGate et en terminant par le plus éloigné.
Une fois les objets routeurs installés vous pouvez terminer en connectant les objets terminaux alimentés sur batterie. Pour assurer un appairage correct de votre objet terminal, vous pouvez sélectionner le routeur le plus proche au moment de le lancer; la connexion sera facilitée et plus rapide.
**Note :**  Il est évidement possible de rajouter des routeurs par la suite. La procédure ci-dessus est pour avoir un réseau optimal dès le départ.

### Astuce 5 : Appairer les objets les uns après les autres.

Il est recommandé de stabiliser le réseau entre chaque appairage. Attendre la fin de l'appairage de l' objet pour tenter l'appairage du suivant. Voir les instructions d'appairage propres à votre matériel pour plus de détail.

### Astuce 6 : Mettre les ampoules sur un réseau spécifique

Éviter d'ajouter les ampoules dans votre réseau ZigBee en parallèle des autres objets; les ampoules vont vouloir se comporter comme des routeurs mais malheureusement, cette fonction n'est opérationnelle qu'avec d'autre ampoules. Vous avez toujours la possibilité de créer un second réseau ZigBee contenant uniquement les ampoules en déployant une seconde ZiGate; les ampoules ainsi concentrées sur ce second réseau éviteront d'agir comme des routeurs vis à vis des autres objets connectés.

### Astuce 7 : Écarter la ZiGate des routeurs Wifi ou box internet

Le ZigBee a été défini pour coexister avec le réseau WiFi car les deux réseaux implémentent le mode CCA (Clear Channel Assessment). Avant de transmettre un paquet, l'objet génère un CCA sur le canal pour déterminer si il est disponible. L'énergie détectée sur le canal est comparée avec la valeur du paramètre CCA; si la valeur détectée est supérieure à celle du paramètre alors le paquet n'est pas transmis. Cependant, il est recommandé de positionner votre ZiGate à plus de 3m de votre routeur WiFi. Plus d'information sur les [interférences entre Wifi et ZigBee](Info_ZigBee-et-Wifi.md).

### Astuce 8 : Tester des emplacements différents

Vous le savez maintenant, les matériaux composant votre logement peuvent drastiquement altérer le signal ZigBee avec pour conséquence des distances d'émission réduites. Les signaux peuvent traverser facilement une pièce sans interférences mais un simple mur peut, selon les matériaux utilisés, affaiblir fortement le signal. Changer les objets de lieu ou l'ajout d'objets routeur permet d’améliorer significativement la situation.

### Astuce 9 : Stabiliser le réseau

Quand tous vos objets sont appairés, arrêter votre ZiGate durant une vingtaine de minutes. Après ce délai, redémarrer votre ZiGate : le processus de découverte du maillage réseau sera relancer et le réseau choisira la meilleur route pour interconnecter les objets en 24h environ. Si vous ne souhaitez pas ou pouvez pas arrêter/redémarrer votre ZiGate vous pouvez attendre plusieurs jours (2-3j) pour que le réseau maillé établisse les meilleures routes entre votre ZiGate et les objets connectés.


### Sources

Cette page est issue de [How to Build a Solid ZigBee Mesh](https://docs.hubitat.com/index.php?title=How_to_Build_a_Solid_ZigBee_Mesh).

Mesh Network = Réseau maillé = topologie réseau décentralisée - [Voir Wikipedia Reseau maillé](https://fr.wikipedia.org/wiki/Topologie_mesh)
