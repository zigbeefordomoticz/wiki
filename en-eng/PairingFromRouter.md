# Pairing from a specific Router

## Introduction

You might want to force the pairing of a specific end device to a dedicated router instead of leaving the Controler to decided.
Despite the fact that the pairing will be done to a specific router, the system can then later decide to change the route and
you/we don't have any control to that.


## What to do

1. identify what router you want to use for the pairing process . You need to get its Short Network Address (Short Id). 
This is a 4 hex number, that you can find via the Device Management page


1. Make sure the Zigate is not in pairing mode, if yes, Stop it

1. For now we do not have any user interface yet, so you'll have to go via a Linux command

  We assume the command will be executed from the Domoticz server itself.
  
  ```
  wget --method=PUT --body-data='{"PermitToJoin": __120__,"Router": "__fd67__"}' --header='Content-Type:application/json' http://127.0.0.1:9440/rest-zigate/1/permit-to-join

  ```
  
  Where :
  * "PermitToJoin": 120,"Router": "fd67" is the only piece you need to update
  * 120 stands for 120 secondes
  * "fd67" is the ShortId of the router you have to identified
  
  __Attention__
  * Do note that there is no quotes for the PermitToJoin time duration
  
