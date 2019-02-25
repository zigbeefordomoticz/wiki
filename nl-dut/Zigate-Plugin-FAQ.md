# Veelgestelde vragen over de Zigate plugin

##Hoe zorg je ervoor dat de host altijd de dezelfde USB poort gebruikt?
Dit wordt meer in het OS geregeld, hier zijn een paar tips:
* https://www.domoticz.com/wiki/Assign_fixed_device_name_to_USB_port
* https://www.domoticz.com/wiki/PersistentUSBDevices

## Hoe koppel je een nieuw apparaat?
1. Make sure you authorized new hardware in Domoticz
Zorg ervoor dat de nieuwe hardware is toegestaan in Domoticz (zie Domoticz settings)
2. Zet in de plugin “Permit Join” op 120 seconden.
3. Start de plugin, dit doe je door nogmaals op aanpassen te klikken. Of via de CLI door heel Domoticz te herstarten -> sudo service domoticz restart
4. Activeer het pairing proces, bijvoorbeeld bij Ikea lampen dien je de lamp kort te resetten door deze snel 6 keer achter elkaar aan/uit te zetten.

