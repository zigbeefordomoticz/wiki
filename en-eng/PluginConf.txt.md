# PluginConf

This file is used to customized some behaviour of the plugin at run time
If you are updating values in PluginConf, we strongly recommend you to make a copy of it in order to avoid any lost when doing an update of the plugin.

If you name the file PluginConf-xx.json ( where xx is the HardwareId of the plugin zigate), the plugin will use that one instead of the generic PluginConf.txt .

ATTENTION: Starting Version 4.5 the Configuration File Name is : PluginConf-xx.json and not '.txt'. The .txt' one is not more used and can be removed

```
{
'channel':'11,15,16,21,22',
'Certification':'CE',
'Ping':'1',
'self.eraseZigatePDM':'0',
'vibrationAqarasensitivity':'medium',
'resetMotiondelay':'30',
'enableReadAttributes':'0',
'enablegroupmanagement':'0',
'allowReBindingClusters':'0',
'resetConfigureReporting':'0',
'resetReadAttributes':'0',
'allowRemoveZigateDevice':'0',
'allowStoreDiscoveryFrames':'0',
'logLQI':'0',
'logFORMAT':'0'
}
```

### Device Management
| Field                | Default | Description |Version |
| -----                | ------- | ----------- | ------ |
| allowStoreDiscoveryFrames | 0 | If set to '1' it will store the Frames during the discovery messages. DONT'T use it on operational system as the side effect is to push for a full discovery process and it doesn't take DeviceConf.txt in consideration | 4.0 |
| allowForceCreationDomoDevice | 0 | If set to '1' it will allow to create Domoticz widget even if there is one existing | 4.0 |
| allowReBindingClusters | 1 | By default we allow to rebind clusters of a particular device when receving Device Annoucement.| 4.1 |
| resetConfigureReporting | 0 | If set to '1' it will force to re-set all configure reporting attributes | 4.0 |
| resetReadAttributes | 0 | If set to 1 it will force to reset all ReadAttributes |  4.0 |
| enableReadAttributes | 0 | If set to 1, the plugin will poll information from each of the main powered devices. It might be needed for some devices which doesn't all to set Configure Automatic reporting |
| resetMotiondelay | 30 | Number of seconds before a reset of the Motion widget status | 4.1 |
| vibrationAqarasensitivity | 'medium' | Sensitivity of Vibration aqara device ('high', 'medium', 'low') | 4.1 |


### Zigate Configuration
| Field                | Default | Description | Version |
| -----                | ------- | ----------- | ------- |
| allowRemoveZigateDevice | 0 | if set to 1, when removing a device, it will also remove the pairing from Zigate | 4.0 |
| blueLedOff | 0 | If set to 1, the Zigate blue light will be disabled | 4.1 & Firm 3.0f |
| TXpower | 0 (no attenuation) | This function allows control for transmission on a JN516x high-power module to be enabled or disabled. Values are 0,1,2,3 (indicate the level of attenuation )| 4.1 & Firm 3.0f |
| channel | 0 | Channel list for the ZigBee Radio. WARNING: if you want to change the channel, you need to re-pair all of the devices as you will switch to a new communication channel | 4.0 |
| eraseZigatePDM | 0 | You must set this flag to 1 , if you want to Erase Zigate Permanent Data Memory. This flag will automatically be reset to 0 after a plugin restart, or after an Erase Zigate action. |
| extendedPANID | 0 | If the pre-set value is zero, the Co-ordinator will use its own IEEE/MAC address as the EPID. Otherwise specifiy the 16 hex digits of the specific network. WARNING: If you want to change the Extended PANID, you need to go through an Erase PDM to take it into account | 4.2 |
| Ping | 1 | Enable or Disable a ping feature, which ensure that the Zigate connectivity is always on. In case of failure , retry to connect | 4.1 |
| Certification |  CE (0x01) | Set Certification to CE(0x01) or FCC (0x02) . European devices are based on CE certification, Xiaomi devices are on FCC. In case you have FCC and CE devices, we recommend to use CE| 4.1 & Firm 3.0f |
| enableAPSFailureLoging | 0 | If enable , Log the APS Failure messages | 4.2 |
| enableAPSFailureReporting | 1 | In case of APS Failure messages, Log the failure and TimedOut the device in Domoticz | 4.2 |

### Over-The-Air Upgrade
| Field                | Default | Description | Version |
| -----                | ------- | ----------- | ------- |
| allowOTA             |   0     | If set to 1 it allow OTA firmware upgrade | beta |
| waitingOTA           | 3600    | Delay in sec to start the OTA firmware process | beta |

### Plugin Directories
| Field                | Default | Description | Version |
| -----                | ------- | ----------- | ------- |
| pluginData | pluginHome + './Data' | Absolute path to Data files ( DeviceList-xx.txt ... ) | 4.1 |
| pluginZData | pluginHome + './Zdatas/' | Absolute path to Zdatas files ( where Discovery report will be put) | 4.1 |
| pluginConfig | pluginHome + './Conf' | Absolution path where Config files ( DeviceConf.txt ) will be find | 4.1 |
| pluginWWW | pluginHome + '../../www/templates/' | Absolute path where Domoticz www/templates can be found | 4.1 |
| pluginReports| pluginWWW + 'zigate/reports/' | Absolute path where reports will be created | 4.1 |
| numDeviceListVersion | 12 | Number of versions of DeviceList we will keep. | 4.2.1 |

### Groups Management
| Field                | Default | Description | Version |
| -----                | ------- | ----------- | ------- |
| enablegroupmanagement | 0 | '1' enable Group Management functionality | 4.1 & Firm 3.0f |

## Reports
| Field                | Default | Description | Version |
| -----                | ------- | ----------- | ------- |
| logLQI | 0 | Time when the report must be trigger. 0 means disabled | 4.0 |
| networkScan | 0 | Delay before doing a Scan for Interferences   | 4.0 |

## Verbose

Those parameters will enable/disabe more verbose informations in the Log

| Field                | Default | Description | Version |
| -----                | ------- | ----------- | ------- |
| debugInput           | 0       | Enable debug-logs for all incoming messages | 4.4 |
| debugCluster         | 0       | Enable debug-logs for all cluster incoming messages | 4.4     |
| debugOutput          | 0       | Enable debug-logs for all outcoming messages | 4.4,  
| debugMatchId         | ffff    | applicable for debugInputs,Outputs,Cluster will print debug-logs only for device matching this ShortAddress (4 Hexa) or the IEEE ( 16 Hexa ) | 4.4 |
| debugPairing         | 0       | Enable debug-logs for Pairing process | 4.4     |
| debugNetworkMap      | 0       | Enable debug-logs for Network Mapping feature | 4.4     |
| debugNetworkEnergy   | 0       | Enable debug-logs for Network Energy feature| 4.4     |
| debugGroups          | 0       | Enable debug- logs for Group Management feature | 4.4     |
| debugWebServer       | 0       | Enable debug-logs for Web Admin interface | 4.4 |
