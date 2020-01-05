# Purpose is to document all findings around Profalux Zigbee blind/shutter


## Pairing Process

The pairing process is well documented on [Zigate.fr]( https://zigate.fr/2018/02/03/association-des-volets-profalux-a-la-zigate/ )

1. Reset of Shutter and Remote command

   1. Check that Zigate is not in pairing mode.
   1. 5 times on R (back side of remote)
   
   Remote will flash RED then GREEN
   
   1. In the next minute press STOP
   
   You can check that the remote command the shutter. In case not, please consult the Profalux documentation
   
1. Pairing of Shutter
   1. Switch Zigate to pairing mode ( Permit to Join, or use the Provisionning function from Web Admin)
   1. Press once on R (back side of remote)
   1. Press UP
   
   The shutter should go up-down
   
   1. When the remote Led do not flash anymore press STOP
   
## Findings

* Manufacturer Code: 0x1110
* ProfileID: 0x0104
* DeviceID: 0x0200 ( Shutter )
* DeviceID: 0x0201 ( remote 

Unfortunatly Profalux do not provide any Model Name ( cluster 0x0000, attribute 0x0005)
You an find Location in  basic cluster attribute 0x0010 (which can be set by ZOE for instance, or via a write attribute)

When using ZOE ( main remote command), it acts as a Zigbee controler with ShortID: 0x0000

Interestingly, you can move the network from one Channel to an other one via the ZOE Admin menu


## Steering and other findings

The Profalux shutter can be steer with cluster ONOFF (0x0006) or cluster LevelControl (0x0008). It is adviced to use only the LevelControl even for a full Open or Close.

Configure Reporting can be set on Cluster LevelControl (0x0008) attribute (0x0000)


For now, I'm getting the remote paired also with Zigate as a dimer switch, but didn't find any way to make a use of it. In case you bind the remote with Zigate, then the remote doesn't command the shutter anymore, but all messages are send to Zigate with message 0x8085

If you have a ZOE central remote, you can create groups, and those groupes are created in the range of 0x8000 - 0x8... )



## References:

* [Notice de dépanage](https://www.profalux-pro.com/notice/mon-volet-roulant-ne-fonctionne-plus-ndep005-2/)

* [Profalux Notice for blind after 2016](http://www.profalux-pro.com/download/1.%20Notices,%20Plans,%20Technique/1.%20Volets%20roulants/3.%20Moteurs%20Commandes%20et%20Accessoires/1.%20Moteur/Moteur%20Profalux%20Zigbee/Notice%20SAV%20moteur%20et%20telecommande%20Profalux%20Zigbee.%20A%20partir%20de%20Juillet%202016-NSAV029.pdf)


