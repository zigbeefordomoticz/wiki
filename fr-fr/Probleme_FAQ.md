# FAQ - Réponses aux questions fréquentes

* [Q1. Où obtenir de l'aide ?](#q1-o%C3%B9-obtenir-de-laide-)
* [Q2. Où trouver les logs ?](#q2-o%C3%B9-trouver-les-logs-)
* [Q3. Comment faire du débogage ?](#q3-comment-faire-du-d%C3%A9bogage-)
* [Q4. Où trouver la liste des coordinateurs et des objets supportés ?](#q4-o%C3%B9-trouver-la-liste-des-coordinateurs-et-des-objets-support%C3%A9s-)
* [Q5. Où trouver les firmwares des coordinateurs ?](#q5-o%C3%B9-trouver-les-firmwares-des-coordinateurs-)
* [Q6. Est il possible d'utiliser plusieurs coordinateurs dans un seul DomoticZ ?](#q6-est-il-possible-dutiliser-plusieurs-coordinateurs-dans-un-seul-domoticz-)
* [Q7. Est il possible de fixer le numéro du port USB ?](#q7-est-il-possible-de-fixer-le-num%C3%A9ro-du-port-usb-)
* [Q8. Mon objet n'est pas mis à jour dans DomoticZ quand je l'actionne manuellement](#q8-mon-objet-nest-pas-mis-%C3%A0-jour-dans-domoticz-quand-je-lactionne-manuellement)


## Débogage

* [T1. Mon coordinateur ne fonctionne pas](#t1-mon-coordinateur-ne-fonctionne-pas)
* [T2. Mon objet ne s'appaire pas](#t2-mon-objet-ne-sappaire-pas)
* [T3. Mon objet ne fonctionne pas comme prévu](#t3-mon-objet-ne-fonctionne-pas-comme-pr%C3%A9vu)


## Erreurs

* [E1. Erreur : No transport, write directive to XXX.XXX.XXX.XXX:8080' ignored](#e1-erreur--no-transport-write-directive-to-xxxxxxxxxxxx8080-ignored)
* [E2. Erreur : Decode8000](#e2-erreur--decode8000)
* [E3. Erreur : Error: (Zigate) Communication error when transmiting a previous command to XXXX ieee XXXXXXXXXXXXXXXX](#e3-erreur--error-zigate-communication-error-when-transmiting-a-previous-command-to-xxxx-ieee-xxxxxxxxxxxxxxxx)
* [E4. Erreur : Error: (FindModule) Domoticz/DomoticzEx modules not found in interpreter](#e4-erreur--e4-erreur--error-findmodule-domoticzdomoticzex-modules-not-found-in-interpreter)
* [E5. Missing module Error ](#e5-missing-module-error)
* [E5. Erreur : Error: (FindModule) Domoticz/DomoticzEx modules not found in interpreter](#e4-erreur--e4-erreur--error-findmodule-domoticzdomoticzex-modules-not-found-in-interpreter)


------------
------------
## Q1. Où obtenir de l'aide ?

La première source d'aide est le wiki :

* [Wiki français](https://zigbeefordomoticz.github.io/wiki/fr-fr)
* [Wiki anglais](https://zigbeefordomoticz.github.io/wiki/en-eng)
* [Wiki allemand](https://zigbeefordomoticz.github.io/wiki/nl-dut) ( _Malheureusement, il n'est plus à jour. Merci de nous contacter si vous êtes prêt à contribuer dans l'amélioration de ce wiki_)

Vous pouvez également obtenir de l'aide et poser des questions : :

* Le [forum français](https://easydomoticz.com/forum/viewforum.php?f=28)
* Le [forum anglais](https://www.domoticz.com/forum/viewforum.php?f=68)
* [Keybase groupe français](https://keybase.io/team/zigate)
* [Keybase groupe anglais](https://keybase.io/team/zigateforum)


------------
## Q2. Où trouver les logs ?

Depuis la Stable6, les logs sont enregistés dans le fichier : `domoticz/plugins/Domoticz-Zigbee/Logs/PluginZigbee-XX.log`

Le dossier __Domoticz-Zigbee__ peut s'appeler __Domoticz-Zigate__ si vous aviez installer le plugin ZiGate avant avril 2022.


------------
## Q3. Comment faire du débogage ?

Merci de consulter la page [Aide au débogage](Probleme_Aide-Debogage.md)


------------
## Q4. Où trouver la liste des coordinateurs et des objets supportés ?

Merci de consulter le site [https://zigbee.blakadder.com/z4d.html](https://zigbee.blakadder.com/z4d.html)


------------
## Q5. Où trouver les firmwares des coordinateurs ?

* Pour __Texas Instrument__, nous recommandons l'utilisation des firmwares Z-Stack firmware de @Koenkk disponibles [ici](https://github.com/Koenkk/Z-Stack-firmware/tree/master/coordinator). Nous ne recommandons pas l'utilisation de la branche _develop_. Merci de rester sur la branche _master_.
* Pour __ZiGate__, Les firmwares sont disponibles [ici pour la Zigate V1](https://github.com/fairecasoimeme/ZiGate/releases) et [ici pour la ZiGate+ V2](https://github.com/fairecasoimeme/ZiGateV2/releases)
* Pour __EZNP (Silicon Labs)__, nous recommandons de suivre les [recommendations zigpy](https://github.com/zigpy/zigpy/wiki/Coordinator-Firmware-Updates)


------------
## Q6. Est il possible d'utiliser plusieurs coordinateurs dans un seul DomoticZ ?

* Si vous utilisez des coordinateurs ZiGates, vous pouvez faire fonctionner plusieurs instances du plugin en parallèle.
* Si vous utilisez d'autres coordinateurs (TI CCxxxx, Silicon Labs), il ne peut y avoir qu'une seule instance du plugin utilisant la couche ZigPy.

Il peut y avoir deux instances ZiGate et une instance Zigpy : cela fonctionne.


------------
## Q7. Est il possible de fixer le numéro du port USB ?

Quelques fois, au redémarrage du système, le port USB (_dev/ttyUSB0_ par exemple) peut changer de numéro ce qui provoque une erreur de communication avec le coordinateur. C'est plus un souci au niveau de l'OS, mais il y a des solutions :

* [Persistent USB Devices en français](https://easydomoticz.com/mon-premier-peripherique-z-wave-2/)
* [Assign fixed device name to USB port](https://www.domoticz.com/wiki/Assign_fixed_device_name_to_USB_port)
* [Persistent USB Devices](https://www.domoticz.com/wiki/PersistentUSBDevices)


------------
## Q8. Mon objet n'est pas mis à jour dans DomoticZ quand je l'actionne manuellement

Par exemple : Si vous éteignez une ampoule Ikea (avec l'interrupteur physique) puis que vous la rallumez, l'état de l'ampoule n'est pas mis à jour dans DomoticZ. Ou une télécommande qui ne met pas non plus à jour son état actuel vers DomoticZ.

Si vous rencontrez des problèmes comme l'exemple ci-dessus, il est fort probable que le rapport automatique ne soit pas configuré correctement à partir de l'objet. Veuillez suivre les étapes ci-dessous pour résoudre ce problème :

1. Aller sur la page Réglages du WebUI
1. Activer les réglages avancés
1. Activer le paramètre __AllowRebindingClusters__.
1. Éteignez l'ampoule Ikea avec l'interrupteur physique, attendez 10 secondes, puis rallumez-la. Le processus d'appairage va commencer de lui-même, les problèmes d'état devraient maintenant être résolus.


------------
## T1. Mon coordinateur ne fonctionne pas

Vous avez les messages suivant dans le fichier de [log file](#q2.-ou-trouver-les-logs-) :

```log
2022-02-25 00:19:41,006 INFO    : [       MainThread] Zigate plugin beta6-6.0.114 started
2022-02-25 00:19:41,384 INFO    : [       MainThread] Plugin Database: DeviceList-2.txt
2022-02-25 00:19:41,466 INFO    : [       MainThread] DeviceConf loaded - 23 confs loaded
2022-02-25 00:19:43,858 INFO    : [       MainThread] DeviceConf loaded - 329 confs loaded
2022-02-25 00:19:43,875 INFO    : [       MainThread] load ListOfDevice
2022-02-25 00:19:43,955 INFO    : [       MainThread] Transport mode: ZigpyZNP
2022-02-25 00:20:45,074 ERROR   : [       MainThread] [ 61] I have hard time to get Coordinator Version. Mostlikly there is a communication issue
2022-02-25 00:20:45,084 ERROR   : [       MainThread] [   ] Stop the plugin and check the Coordinator connectivity.
```

Cela indique un souci de communication entre le plugin et le coordinateur. Vous devez vérifier les éléments suivants dans la configuration du plugin dans DomoticZ :

* Si c'est la première fois que vous utilisez le coordinateur (aucun objets appairés pour le moment), vous devez l'initialiser.  Définir le __Initialize Coordinateur: True__ dans le menu Matériel DomoticZ lors du démarrage du plugin. Une fois que le premier démarrage est correct, désactivez ce paramètre pour éviter d'effacer tous les périphériques appariés au prochain redémarrage.
* Assurez-vous que le port série est le bon.
* Assurez-vous que le modèle de coordinateur correspond à votre dongle.
* Assurez-vous qu'aucun autre processus n'est en cours d'exécution sur le port USB.
* Si le coordinateur est connecté sur un Raspberry Pi, assurez-vous d'utiliser un port USB2 (et non l'USB3 du PI4).
* Si le coordinateur est branché sur un hub USB, essayez de la brancher directement sur un port USB de votre serveur.


Si cela ne fonctionne toujours pas, vous pouvez essayer de tester le coordinateur en faisant une [analyse de topologie en temps reel](HowTo_Have-a-real-time-topology.md). Ce test se fera sans DomoticZ ni le plugin. Il ne fonctionne qu'avec TI CCxxx.


------------
## T2. Mon objet ne s'appaire pas

* Si le coordinateur est branché directement sur un port USB du serveur, essayez de le déporter en utilisant une rallonge USB (ne pas utiliser de Hub USB). Ceci permettra de l'éloigner des interférences, et en particulier celles des disques SSD, puces wifi, etc...

Merci de consulter la page [Problèmes d'appairage](Probleme_Appairage.md)


------------
## T3. Mon objet ne fonctionne pas comme prévu

Merci de consulter la page [Problèmes d'appairage](Probleme_Appairage.md)


------------
## E1. Erreur : `No transport, write directive to XXX.XXX.XXX.XXX:8080' ignored`

De temps en temps, il y a le message d'erreur suivant. Est-ce un gros problème ?

```log
Apr 02 13:30:23 pi domoticz[1328]: 2022-04-02 13:30:23.327  Error: ZigBee: No transport, write directive to 'XXX.XXX.XXX.XXX:8080' ignored.
```

Cette erreur provient de DomoticZ et est liée au fait que vous aviez la page WebUI ouverte depuis un moment et lorsque vous essayez d'actualiser cette page, DomoticZ a détecté qu'il n'y avait plus de communication.
Ne pas s'inquiéter de ce message.


------------
## E2. Erreur : `Decode8000`

Si vous voyez des journaux d'erreurs comme ici après, il s'agit très probablement d'un problème avec le matériel ZiGate.

```log
2022-02-22 18:03:11.851 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 22 Status: [ZigBee Error Code Unknown code : 80]
2022-02-22 18:06:23.656 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 4d Status: [ZigBee Error Code Unknown code : 80]
2022-02-22 18:06:30.282 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 51 Status: [ZigBee Error Code Unknown code : 80]
2022-02-22 18:06:30.499 Error: ZiGate: Decode8000 - PacketType: 0030 TypeSqn: 02 sqn_app: 00 sqn_aps: 52 Status: [ZigBee Error Code Unknown code : 80]
```

* Assurez vous de ne pas utiliser le vieux module USB-TTL __bleu__ (il faut utiliser le rouge).
* Essayez d'éteindre le ZiGate en arrêtant le plugin, de débrancher la ZiGate pendant 1 minute, de rebrancher et  redémarrez le plugin.

cc: [Une issue est ouverte](https://github.com/fairecasoimeme/ZiGate/issues/394)


------------
## E3. Erreur : `Error: (Zigate) Communication error when transmiting a previous command to XXXX ieee XXXXXXXXXXXXXXXX`

Voici ci-dessous un exemple d'erreurs trouvées dans le fichier de logs :

```log
Apr 24 11:47:47 pi3 domoticz[23926]: 2019-04-24 11:47:47.697  Error: (Zigate) Communication error when transmiting a previous command to 9d58 ieee 90fd9ffffe31f150
Apr 24 11:47:47 pi3 domoticz[23926]: 2019-04-24 11:47:47.697  Error: (Zigate) Decode8702 - SQN: bc AddrMode: 02 DestAddr: 9d58 SrcEP: 01 DestEP: 01 Status: d4 - Unicast frame does not have a route available but it is buffered for automatic resend
```

Cela indique que l'objet ```90fd9ffffe31f150``` n'est pas joignable ou que la ZiGate a un problème de communication avec lui.


------------
## E4. Erreur : `[E4. Erreur : Error: (FindModule) Domoticz/DomoticzEx modules not found in interpreter`

```log
2022-04-09 07:27:25.699 Error: (FindModule) Domoticz/DomoticzEx modules not found in interpreter.
```

Cette erreur apparaît lors de l'arrêt du plugin. Ne pas en tenir compte.


------------
## E5. Erreur : `Missing module error`

### Vérifier que le plugin est correctement installé :

* Aller dans le répertoire du plugin _Domoticz-Zigbee_ ou _Domoticz-Zigate_
* Lancer la commande

``` bash
ls -l external/dnspython/

```

Si la réponse est :
```
total 0
```

Il faut lancer les commandes
``` bash
git config --add submodule.recurse true
git submodule update --init --recursive
```

### Vérifier que les dépendances sont bien installées

* Lancer la commande depuis le répertoire du plugin
``` bash
sudo pip3 install -r requirements.txt
```

ATTENTION:
Sur les Windows, il faut lancer les commandes _pip3 install_ en mode administrateur etce, dès la première fois.
Si cela n'a pas été fait la première fois, il faut désinstaller les modules existants.

------------
## E6. Erreur : `Error: <Nom du plugin> : You need to setup the URL Base to access the Domoticz JSON/API`

Cette erreur apparaît lorsque _API base url_ n'est pas (ou pas bien) paramétrée dans DomoticZ. Se reporter à l'[étape 2 Paramétrage du plugin](Plugin_Parametrage.md) pour plus d'infos.
