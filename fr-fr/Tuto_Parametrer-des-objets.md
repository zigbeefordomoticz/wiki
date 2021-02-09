# Tutoriel - Paramétrer des objets

Ce tutoriel explique comment paramétrer spécifiquement certains objets.

## Avant propos

Le plugin dispose de paramètres permettant de personnaliser le fonctionnement des objets ou le fonctionnement du plugin.
Par défaut, un objet certifié est initialisé avec les paramètres par défaut. Il est ensuite possible de personnaliser ces paramètres.

## Méthode

* Aller dans la section [Management > Gestion des objets](WebUI_Management.md#gestion-des-objets).
* Filtrer si nécessaire pour trouver l'objet souhaité.
* Renseigner le champ __Paramètres__.

Il est possible d'éditer le champ paramètres en ajoutant, supprimant ou en mettant à jour les attributs.

Il est important de suivre le formalisme suivant :  { 'parametre1': valeur, 'parametre2': valeur .... }


## Liste des paramètres

| Nom du paramètre | Description | Valeur / Unité | Objet concerné |
| ---------------- | ----------- | -------------- | -------------- |
| Calibration    | Permet de définir une valeur de calibration | °C | Tuya eTRV, Eurotronics SPZB0001 |
| Alarm1         | Configuration de Alarm1 avec les informations Durée, Volume et Mélodie | | Tuya Siren TS0601 |
| Alarm2         | Configuration de Alarm2 avec les informations Durée, Volume et Mélodie | | Tuya Siren TS0601 |
| Alarm3         | Configuration de Alarm3 avec les informations Durée, Volume et Mélodie | | Tuya Siren TS0601 |
| Alarm4         | Configuration de Alarm4 avec les informations Durée, Volume et Mélodie | | Tuya Siren TS0601 |
| Alarm5         | Configuration de Alarm5 avec les informations Durée, Volume et Mélodie | | Tuya Siren TS0601 |
| Duration       | Valable seulement  Applicable only inside the Alarm definition, it will configure the duration of alarm in | Seconde | Tuya Siren TS0601 |
| Volume         | Applicable only inside the Alarm definition, it will configure the Volume of alarm | 0=Fort, 1=Moyen, 2=Faible | Tuya Siren TS0601 |
| Melody         | Applicable only inside the Alarm definition, it will configure the Melody | de 1 à 15  | Tuya Siren TS0601 |
| HumidityMinAlarm    | Niveau minimum d'humidité pour déclenchement alarme | % | Tuya Siren TS0601 |
| HumidityMaxAlarm    | Niveau maximum d'humidité pour déclenchement alarme | % | Tuya Siren TS0601 |
| TemperatureMinAlarm | Température minimale pour déclenchement alarme | °C | Tuya Siren TS0601 |
| TemperatureMaxAlarm | Température maximale pour déclenchement alarme | °C | Tuya Siren TS0601 |
| PowerOnAfterOffOn   | Si l'objet est compatible, il se mettra dans l'état défini après une coupure d'alimentation | 0=restera à Off, 1=passera à On, 255=se remettra dans l'état précédent | Ikea, ENki, BlitzWolf plug, Legrand, Philips (une maj des firmware peut être nécessaire) |
| fadingOff     | Durée de transition pour l'extinction . Augmentera de 20% puis s'éteindra | Seconde | Toutes les Led variables |
| moveToHueSatu    | Durée de transition pour changer la température de saturation | Dixième de seconde (10=1s) | Toutes les Led variables |
| moveToColourTemp | Durée de transition pour changer la température de couleur | Dixième de seconde (10=1s) | Toutes les Led variables |
| moveToColourRGB  | Durée de transition pour changer la couleur | Dixième de seconde (10=1s) | Toutes les Led variables |
| moveToLevel      | Durée de transition pour faire varier l'intensité lumineuse | Dixième de seconde (10=1s) | Toutes les Led variables |

*Cette page est issue d'une traduction : il est possible que le tableau ci-dessus ne soit pas à jour. Se référer à la [page originale](../en-eng/device-parameters.md) en anglais.*
