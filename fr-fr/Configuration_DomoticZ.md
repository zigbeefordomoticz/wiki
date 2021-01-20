In domoticz navigate to Settings -> Hardware

Pick Zigate Plugin from the list, name it and set the wright USB port.

At the first boot you have to set “Erase Persistent Data” to True to build a new network.

Set Permit Join to value 255 to search for a unlimited time for new devices

Click Add and check the log. When the USB TTL is in Permit Join mode the blue and red LEDs are flickering. Now you can add devices the usual way. For example press and hold 3 secs the button at the Aqara sensor.

When you are done adding devices set the permit join value to something lower than 255. 


## E.	Tests des logiciels

Vous pouvez maintenant lancer Domotics en cliquant sur l’icône de Domoticz, ce qui conduit à ouvrir une fenêtre dans votre navigateur à l’adresse locale 127.0.0.1 (port 8080) :

127.0.0.1:8080

Dans Domoticz, Vous devez installer la passerelle Zigate en ajoutant un nouveau matériel (donnez un nom et sélectionnez dans la rubrique Type le plugin « Zigate plugin » en fin de liste). Si tout se passe bien, en allant dans le rubrique Configuration/logs, vous devriez avoir un log de ce type  :




Accéder également à l’interface du plugin de Pipiche en tapant dans votre navigateur:


127.0.0.1:9440

Cela permet d ‘accéder au dashboard suivant :


Pour ma part, j’utilise grandemment cet outil, notamment pour intégrer des nouveaux modules dans la Zigate (fonction Join à valider en activant la fonctionnalité « Accepter de nouveaux dispositifs » en haut à droite) et pour me rendre compte de l’état des échanges entre la Zigate et les dispositifs.
Puis je termine la mise en forme dans Domoticz (nom etc ...)
