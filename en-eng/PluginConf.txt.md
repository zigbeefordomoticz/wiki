# PluginConf

This file is used to customized some behaviour of the plugin at run time
If you are updating values in PluginConf, we strongly recommend you to make a copy of it in order to avoid any lost when doing an update of the plugin.

If you name the file PluginConf-xx.txt ( where xx is the HardwareId of the plugin zigate), the plugin will use that one instead of the generic PluginConf.txt .


`{
'allowStoreDiscoveryFrames':'0',
'logFORMAT':'0',
'logLQI':'0',
'allowRemoveZigateDevice':'0',
'allowForceCreationDomoDevice':'0',
'networkScan':'0',
'channel':'0'
}`

### Device Management
| Field                | Default | Description |Version |
| -----                | ------- | ----------- | ------ |
| allowStoreDiscoveryFrames | 0 | If set to '1' it will store the Frames during the discovery messages. DONT'T use it on operational system as the side effect is to push for a full discovery process and it doesn't take DeviceConf.txt in consideration | 4.0 |
| allowForceCreationDomoDevice | 0 | If set to '1' it will allow to create Domoticz widget even if there is one existing | 4.0 |
| forceConfigureReporting | 0 | If set to '1' it will force to re-set all configure reporting attributes | 4.0 |
| forceReadAttributes | 0 | If set to 1 it will force to reset all ReadAttributes |  4.0 |
| resetMotiondelay | 30 | Number of seconds before a reset of the Motion widget status | 4.1 |
| vibrationAqarasensitivity | 'medium' | Sensitivity of Vibration aqara device ('high', 'medium', 'low') | 4.1 |

### Zigate Configuration
| Field                | Default | Description | Version |
| -----                | ------- | ----------- | ------- |
| allowRemoveZigateDevice | 0 | if set to 1, when removing a device, it will also remove the pairing from Zigate | 4.0 |
| blueLedOff | 0 | If set to 1, the Zigate blue light will be disabled | 4.1 & Firm 3.0f |
| channel | 0 | Channel list for the ZigBee Radio | 4.0 |
| TXpower | 0 | This function allows control for transmission on a JN516x high-power module to be enabled or disabled. Values are 0 < 0x80 < 0xbf | 4.1 & Firm 3.0f |
| Ping | 1 | Enable or Disable a ping feature, which ensure that the Zigate connectivity is always on. In case of failure , retry to connect | 4.1 |
| Certification |  CE | Set Certification to CE or FCC | 4.1 & Firm 3.0f |

### Plugin Directories
| Field                | Default | Description | Version |
| -----                | ------- | ----------- | ------- |
| pluginData | pluginHome + './Data' | Absolute path to Data files ( DeviceList-xx.txt ... ) | 4.1 |
| pluginZData | pluginHome + './Zdatas/' | Absolute path to Zdatas files ( where Discovery report will be put) | 4.1 |
| pluginConfig | pluginHome + './Conf' | Absolution path where Config files ( DeviceConf.txt ) will be find | 4.1 |
| pluginWWW | pluginHome + '../../www/templates/' | Absolute path where Domoticz www/templates can be found | 4.1 |
| pluginReports| pluginWWW + 'zigate/reports/' | Absolute path where reports will be created | 4.1 |

### Groups Management
| Field                | Default | Description | Version |
| -----                | ------- | ----------- | ------- |
| enablegroupmanagement | 0 | '1' enable Group Management functionality | 4.1 & Firm 3.0f |

## Reports
| Field                | Default | Description | Version |
| -----                | ------- | ----------- | ------- |
| logLQI | 0 | Time when the report must be trigger. 0 means disabled | 4.0 |
| networkScan | 0 | Delay before doing a Scan for Interferences   | 4.0 |


