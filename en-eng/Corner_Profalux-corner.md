# Purpose is to document all findings around Profalux Zigbee blind/shutter

## Profalux behaviour

When the Shutter leave the network, it searches for an open network


* If an open network is found :
  1. Shutter do a 2nd Up/Down. Up/Down is to inform that shutter found an Open Network and is in. The first Up/down is down when receiving R + UP.
  1. All shutter will do an Up/Down
  1. The Remote Led has a Green blink every second to indicate "network search"
  1. When the remote joins the network and get paired with the shutter, the shutter will do a 3rd Up/Down
  1. The Remote Led will stop blinking ( fast Green then stop)

* If no network found :
  1. The shutter will create it's own network and will notfiy by a double Up/Down
  1. Open the new created Network
  1. Get the remote to join

* If the Remote doesn't find its associated shutter (factory) :
  1. Led blink Red
  1. Shutter will reset after 3 minutes ( one Up/Down )
  1. Do a 5 time R on the remote to get it reset
  1. Hold until the Led stop blinking
  1. Press stop to look for a network (the one of the reseted shutter)

   
   
## Pairing Process

The pairing process is well documented on [Zigate.fr]( https://zigate.fr/2018/02/03/association-des-volets-profalux-a-la-zigate/ )

* Reset of Shutter and Remote command

   1. Check that Coordinator is not in pairing mode.
   1. 5 times on R (back side of remote)
   
   Remote will flash RED then GREEN
   
   1. In the next minute press STOP ( and it will close the network , stop the pairing process )
   
   You can check that the remote command the shutter. In case not, please consult the Profalux documentation
   
* Pairing of Shutter
   1. Switch Coordinator to pairing mode ( Permit to Join, or use the Provisionning function from Web Admin)
      ___Any Shutter part of the network will do an Up/Down___
      
   1. Press once on R (back side of remote)
      ___The remote Led should blink Once. (if the remote doesn't blink the request as not been taken)___
      
   1. Press UP
   
   1. The shutter should go up-down
      ___The Shutter and the Remote will go out of the Zigbee network, and search for an open (pairing) network.___
      
   1. ___All Shutter and the one you want to add are doing an Up/Down, which confirm the correct pairing___
   
   1. When the remote Led do not flash anymore press STOP
      ___This will close the network and complete the pairing of a new Shutter___
      

## Findings

* Manufacturer Code: 0x1110
* ProfileID: 0x0104
* DeviceID: 0x0200 ( Shutter )
* DeviceID: 0x0201 ( remote 

Profalux do not use attribut 0x0005 __Model Name__ of Basic cluster.
Attribut 0x0010 of Basic Cluster should provide Type of device ( 'bso', volet' )


When you don't have any controler, one of the shutter act as a controler

Interestingly, you can move the network from one Channel to an other one via the ZOE Admin menu

## VR

* Remote Control

```
ProfileID 0104
ZDeviceID 0201
Application Version 0000
Cluster IN Count: 03
Cluster In 1: 0000 (Basic)
Cluster In 2: 0003 (Identify)
Cluster In 3: 0015 (Commissioning)
Cluster OUT Count: 08
Cluster Out 1: 0003 (Identify)
Cluster Out 2: 0004 (Groups)
Cluster Out 3: 0005 (Scenes)
Cluster Out 4: 0006 (On/Off)
Cluster Out 5: 0008 (Level Control)
Cluster Out 6: 0100 (Shade Configuration)
Cluster Out 7: fc20
Cluster Out 8: fc21

```

## BSO


## Store


## Steering and other findings

* The Profalux shutter can be steer with cluster ONOFF (0x0006) or cluster LevelControl (0x0008). It is __adviced__ to use __only__ the LevelControl even for a full Open or Close.

* Configure Reporting can be set on Cluster LevelControl (0x0008) attribute (0x0000)

* The remote is very basic and it is not adviced to try doing anything with it. During the pairing process, the Shutter and the Remote will announced themselve, just drop the remote, but keep it paired on Coordinator as both VR and Remote must be part of the same network.

* Never try to bind the remote with the Coordinator

* If you have a ZOE central remote, you can create groups, and those groupes are created in the range of 0x8000 - 0x8... ) Otherwise , Profalux informed me that depending on the Firmware version of Zoe, they must be pgraded before been paired with a non-Profalux controler. 
For that the best is to contact Profalux for getting the upgrade.



## References:

* [Notices de références Profalux]( https://www.profalux-pro.com/telecommande/moteur-radio-profalux-zigbee-2/)
* [Notice de dépanage](https://www.profalux-pro.com/notice/mon-volet-roulant-ne-fonctionne-plus-ndep005-2/)

* [Profalux Notice for blind after 2016](http://www.profalux-pro.com/download/1.%20Notices,%20Plans,%20Technique/1.%20Volets%20roulants/3.%20Moteurs%20Commandes%20et%20Accessoires/1.%20Moteur/Moteur%20Profalux%20Zigbee/Notice%20SAV%20moteur%20et%20telecommande%20Profalux%20Zigbee.%20A%20partir%20de%20Juillet%202016-NSAV029.pdf)


