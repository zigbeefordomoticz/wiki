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
     
     
## Use Case: Monitoring the health of your devices

By setting enableAPSFailureReporting to 1 (which is default), you will give the pluging the capability to inform Domoticz in case of Device not reachable and the result will be to have a Red flag on the corresponding Domoticz widget

In some settings, Bulbs are also behind a physical switch, which allow to switch off the main powered. In such case, Zigate and the plugin can get this information and flag it to Domoticz

In order to make that into practice, you'll have to enable a polling mecanishm where the plugin will ping each of the device on a reguar basis.

Here after is the parameter to set to 1 in the corresponding PluginConf file of your environment.

```
'enableReadAttributes':'1',
```



  
