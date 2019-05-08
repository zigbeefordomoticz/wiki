# APS Failure messages

Starting with plugin version 4.3, the plugin is capable to handle the APS Failure messages provided by Zigate during normale operation.


## How to Enable

There are 2 parameters which are involved in the APS Failure management

```
'enableAPSFailureLoging':'1',
'enableAPSFailureReporting':'1',
```

* enableAPSFailureLoging

  * Default: disable (0)
  * Behaviour: this will simply report in the log any APS communication messages. No action taken by the plugin.


* enableAPSFailureReporting

  * Default: enable (1)
  * Behaviour: Everytime the plugin receives from Zigate an APS communication message, 
  it will associate this to a communication problem with the concerned device. The resuting actions
  will be to 
     * set the Domoticz widget TimedOut to 1.
     * report as an Error in the Log.
  
