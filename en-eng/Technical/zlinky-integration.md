# Zlinky TIC Integration

## Overview

Purpose is to describe the integration of the ZLinky_TIC module in the plugin and Domoticz





|Commande TIC|CLUSTER|Attribut|Droit|Comment|data type|size max|unit|designation|valeur par defaut|
|------------|-------|--------|-----|--------------|---------|-------|----|-----------|------------|				
|ADC0|0x0702|0x0308|RO||String|12 car|-|	Serial Number|NULL|
|![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) BASE|0x0702|0x0000|RP||Uint32|9 car|Wh| Index Base|0|
|OPTARIF			|0xFF66|	0x0000|		RO||String|4 car|-| Option tarifaire|BASE|	
|ISOUSC			|0x0B01	|0x000D		|RO		||Uint16|2 car|A| Intensité souscrite|0|
|![#c5f015](https://via.placeholder.com/15/c5f015/000000?text=+) HCHC			|0x0702	|0x0102		|RO			||Uint32|9 car|Wh|Index HCHC|0|
|![#c5f015](https://via.placeholder.com/15/c5f015/000000?text=+) HCHP			|0x0702	|0x0100		|RO			||Uint32|9 car|Wh|Index HCHP|0|
|![#c56615](https://via.placeholder.com/15/c56615/000000?text=+) EJPHN			|0x0702	|0x0100		|RO			||Uint32|9 car|Wh|Index EJPHN|0|
|![#c56615](https://via.placeholder.com/15/c56615/000000?text=+) EJPHPM			|0x0702	|0x0102		|RO			||Uint32|9 car|Wh|Index EJPHPM|0|
|![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) BBRHCJB			|0x0702	|0x0100		|RO			||Uint32|9 car|Wh|Index BBRHCJB|0|
|![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) BBRHPJB			|0x0702	|0x0102		|RO			||Uint32|9 car|Wh|Index BBRHPJB|0|
|![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) BBRHCJW			|0x0702	|0x0104		|RO			||Uint32|9 car|Wh|Index BBRHCJW|0|
|![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) BBRHPJW			|0x0702	|0x0106		|RO			||Uint32|9 car|Wh|Index BBRHPJW|0|
|![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) BBRHCJR			|0x0702	|0x0108		|RO			||Uint32|9 car|Wh|Index BBRHCJR|0|
|![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) BBRHPJR			|0x0702	|0x010A		|RO			||Uint32|9 car|Wh|Index BBRHPJR|0|
|IINST			|0x0B04	|0x0508		|RP			||Uint16|3 car|A|Courant efficace|0xFFFF|
|IINST1			|0x0B04	|0x0508		|RP			||Uint16|3 car|A|Courant efficace phase 1|0xFFFF|
|IINST2			|0x0B04	|0x0908		|RP			||Uint16|3 car|A|Courant efficace phase 2|0xFFFF|
|IINST3			|0x0B04	|0x0A08		|RP			||Uint16|3 car|A|Courant efficace phase 3|0xFFFF|
|IMAX			|0x0B04	|0x050A		|RO			||Uint16|3 car|A|Intensité maximale|0xFFFF|
|IMAX1			|0x0B04	|0x050A		|RO			||Uint16|3 car|A|Intensité maximale phase 1|0xFFFF|
|IMAX2			|0x0B04	|0x090A		|RO			||Uint16|3 car|A|Intensité maximale phase 2|0xFFFF|
|IMAX3			|0x0B04	|0x0A0A		|RO			||Uint16|3 car|A|Intensité maximale phase 3|0xFFFF|
|PMAX			|0x0B04	|0x050D		|RO			||Uint16|5 car|W|Puissance maximale triphasée atteinte|0x8000|
|PAPP			|0x0B04	|0x050F		|RP			||Uint16|5 car|VA|Puissance apparente|0xFFFF|
|PTEC			|0x0702	|0x0020		|RO	||String|4 car|-|Periode tarifaire en cours|NULL|
|			|0xFF66	|0x0100		|RW		|Change the periodic Linky acquisition time based on 7 sec cycle. ex : value=1 → send every 7 sec. Value= 5 → send every 35 sec	etc|Uint16|-|-|-|0xA|								
|![#1589F0](https://via.placeholder.com/15/1589F0/000000?text=+) DEMAIN			|0xFF66	|0x0001		|RP||String|4 car|-|Couleur du lendemain|NULL|
|HHPHC			|0xFF66	|0x0002		|RO||Uint8|1 car|-|Horaire Heure Pleines Heures Creuses|0|
|PPOT 			|0xFF66	|0x0003		|RO||Uint8|2 car|-| Présence des potentiels|0|
|![#c56615](https://via.placeholder.com/15/c56615/000000?text=+) PEJP			|0xFF66	|0x0004		|RP||Uint8|2 car|Min|Préavis début EJP(30min)|0|
|ADPS			|0xFF66	|0x0005		|RP||Uint16|3 car|A|Avertissement de Dépassement De Puissance Souscrite|0|
|ADIR1			|0xFF66	|0x0006		|RP||Uint16|3 car|A|Avertissement de Dépassement D'intensité phase 1|0|
|ADIR2			|0xFF66	|0x0007		|RP||Uint16|3 car|A|Avertissement de Dépassement D'intensité phase 2|0|
|ADIR3			|0xFF66	|0x0008		|RP||Uint16|3 car|A|Avertissement de Dépassement D'intensité phase 3|0|
