# Tutoriel - Remplacer ou ré-initialiser la ZiGate

Ce tutoriel explique comment remplacer ou ré-initialiser sa ZiGate.

## Avant propos

**Quand appliquer ce Tutoriel ?**

* Pour remplacer une ZiGate par une nouvelle (cause de crash par exemple)*.
* Pour passer d'une version V1 à une version V2.
* Pour réinitialiser compétemment une ZiGate (cause de bug par exemple)*.
* Pour passer d'un firmware classique au firmware OptiPDM (à partir de la version 3.1e)

\* Demander conseils sur les forums et attendre les avis des développeurs.

**Quand __NE PAS__ appliquer ce Tutoriel ?**

* Pour faire une simple mise à jour du firmware de la ZiGate.

### Qu'est-ce qui va ce passer pour les appairages

A la fin de cette procédure, il faudra ré-appairer TOUS les objets avec la ZiGate. [Voir les conseils d'appairage](Tuto_Appairage-objet.md#conseils-dappairage)

### Qu'est-ce qui va ce passer pour les dispositifs existants dans DomoticZ

En suivant cette procédure, qui ne touche ni à DomoticZ, ni au plugin, les dispositifs seront retrouvé automatiquement lorsque les objets seront ré-appairer. Il n'y pas de perte de paramétrage dans le plugin, ni de perte d'historique dans DomoticZ.

**Note :** le plugin reconnaissant les objets appairés, la fenêtre de l'assistant d'appairage n'affiche pas les objets ré-appairés (seulement les nouveaux). Le ré-appairage est visible dans les logs de DomoticZ.


## Procédure

1. Être à jour sur la branche Béta du plugin.

2. Être de préférence sur une version 2021.1 ou supérieure de DomoticZ.

Cela apporte des améliorations pour le fonctionnement du plugin.

3. Redémarrer complètement (Serveur, Domoticz, Plugin, ZiGate).

S'assurer que tout fonctionne normalement.

4. Arrêter le plugin via la page **Matériels** de DomoticZ.

5. Faire une Sauvegarde de la base de DomoticZ.

6. [Sauvegarder le plugin](Plugin_Sauvegardes.md) :

A minima les dossiers **Conf/** et **Data/**, sinon prendre tout le dossier du plugin.

7. [Sauvegarder la ZiGate](https://zigate.fr/documentation/sauvegardez-et-restaurez-votre-zigate).

__Note :__ cette sauvegarde ne peut être utilisée pour revenir en arrière que jusqu'au point 11. A partir du moment où un reset est réalisé sur objet pour le ré-appairer, la sauvegarde ne permettra pas de revenir à l'état sauvegardé.

__Rappel :__ il n'est pas possible de faire une sauvegarde sur une ZiGate et faire une restauration sur une autre ZiGate (raison de sécurité).


8. [Flasher la ZiGate](https://zigate.fr/documentation/mise-a-jour-de-la-zigate) avec le firmware souhaité.

Faire un **Erase EEPROM**. Attention : ceci va ré-initialiser  totalement la ZiGate !!

9. Rebrancher la ZiGate et s'assurer que le port USB n'a pas changé.

10. Relancer le plugin en activant le **Erase PDM** ( Initialize ZiGate (Erase Memory) ) dans le [Paramétrage du plugin](Plugin_Parametrage.md)

11. Vérifier que le plugin se lance correctement.

Attendre d'avoir accès au Web UI.

En cas d'erreurs, et pour revenir à l'état initial, il faudra restaurer la sauvegarde de la ZiGate et la sauvegarde du plugin (puisqu'un ErasePDM a été fait).

12. Vérifier que le **ErasePDM** est bien désactivé dans le [Paramétrage du plugin](Plugin_Parametrage.md)

13. Ré-appairer TOUS les objets avec la ZiGate. [Voir les conseils d'appairage](Tuto_Appairage-objet.md#conseils-dappairage)
