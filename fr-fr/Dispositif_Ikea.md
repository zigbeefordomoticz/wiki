# Les dispositifs de la marque IKEA

Voir la liste des [dispositifs compatibles](../en-eng/Compatible-Devices.md)

Ces dispositifs connus sous l'appélation TRADFRI, on y retrouve des ampoules (TRADFRI bulb), des prises commandées (TRADFRI control outlet), 

## L'appairage des dispositifs

### Les Ampoules connectées

Allumer/Eteindre six fois de suite votre ampoule (
Just turn off/on 6 times your bulb (not with ikea remote, shut off then on power). Your bulb will send a device announce to your zigate, then your zigate will ask some information to your bulb to know wich model it is and add it to Domoticz. If your model is not in DeviceConf.txt it should take a little longer but it will be automatically add as soon as the zigate will have information need foor this.

Bulb Device

You should find between 1 and 3 new devices in your Domoticz Device list :

simple switch, to turn on or off your bulb
Level Control (LvlControl), to set brigthness level of your bulb
Color Control (ColorControl), to set color of your bulb

### Les prises connectées

### 

## Les Firmware des dispositifs

| Modele - Produit                | Image type  | Version(s) FW | Nom du fichier                                           |
| ------------------------------- | ----------- | ------------- | -------------------------------------------------------- |
| TRADFRI bulb E27 WS clear 950lm | 0x2202      | 2.3.050       | 159695-2.1-TRADFRI-bulb-ws-1000lm-2.3.050.ota.ota.signed |
