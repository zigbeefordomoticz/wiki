# WebUI : Settings

The __Settings__ menu of the WebUI lets you view and change the plugin settings.

## How the page works

* The settings are grouped by theme, in the sections below.
* By default, only the main settings are shown. Enable the **Advanced settings** switch to see all of them (the *Advanced parameters* tables below).
* Change the values, then click **Validate** to save them. **Settings (default)** puts all settings back to their default value.
* Some settings only take effect after a restart. After **Validate**, a pop-up tells you what is needed:
  * **Plugin Reload**: restart the plugin (**Admin > Plugin > Restart**). The WebUI header also shows that a restart is pending.
  * **Coordinator Reset**: the coordinator must be reset (for example after a channel change).
  * **Erase PDM**: the Zigbee network must be created again, and all devices paired again.
* A few settings only appear with a given coordinator family (for example Silicon Labs EZSP or Texas Instruments ZNP); they are noted below.
* The debug and logging options are not on this page: they are in **Tools > Debug**, see [Debug mode](Problem_Debuging-mode.md).
* The settings are saved in `Conf/PluginConf-XX.json` in the plugin folder (XX is the hardware idx of the plugin in DomoticZ), with a copy in the DomoticZ database.
* The hardware parameters of the plugin (coordinator model, serial port, WebUI port...) are not here: they are in the DomoticZ hardware page, see [Plugin settings](Plugin_Settings.md).

The tables below list every setting visible in the WebUI, with its name in the plugin and the text shown in the WebUI. The *Restart* column tells what a change requires (empty: the change applies immediately).

## Available services

Enable the services you want to be active

### Parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `MatomoOptIn` | Enable the plugin to collect informations for analyticz purposes such as Coordinator model, version... | on |  |  | See [Plugin statistics](WebUI_Statistics.md) for what is sent. |
| `enablegroupmanagement` | Enable Groups | off |  | plugin restart | See [Group Management](HowTo_Group-management.md). |
| `internetAccess` | Allow Internet access | on |  | plugin restart | Used to check for plugin and firmware updates, to update the certified devices database and for OTA firmware repositories. It doesn't control the [statistics](WebUI_Statistics.md). |
| `CheckSSLCertificateValidity` | Check the validity of SSL certificates | off |  | plugin restart |  |
| `DomoticzCustomMenu` | Enable Plugin WebUI from Domoticz Custom menu | on |  | plugin restart | See [Plugin integration](Plugin_Integration.md). |
| `NightShift` | Push background activity from 11PM to 6AM | off |  |  |  |

### Advanced parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `pingDevices` | Ping main-powered devices regularly to vérify their health | on |  | plugin restart | See also `pingDevicesFeq` (Coordinator settings). |

## Group management settings

Here are all setting to enable and configure the Group management feature.

### Parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `GroupOnBattery` | Enable group creation to a battery devices | off |  |  |  |
| `OnIfOneOn` | Group is On if one device is On (otherwise needs all devices On) | on |  |  |  |
| `TradfriKelvinStep` | Kelvin step for Tradfri remote | `51` | K |  |  |
| `pingViaGroup` | Group address used to ping devices (0 to disable) | `0000` |  |  |  |

### Advanced parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `forceGroupDeviceRefresh` | Refresh the widgets of all group members after a group command | on |  |  |  |
| `reComputeGroupState` | Recompute the group state regularly | on |  |  |  |
| `allowGroupMembership` | Add newly paired devices to their group membership | on |  | plugin restart |  |
| `zigatePartOfGroupTint` | Add the coordinator to the Tint remote group | off |  | plugin restart | Shown with Silicon Labs (EZSP) coordinators only. See [Muller Licht / Tint](Corner_Tint.md). |
| `zigatePartOfGroup0000` | Create Group 0000 | off |  | plugin restart | Shown with Silicon Labs (EZSP) coordinators only. Group 0000 is used by Ikea and Xiaomi switches, see [Ikea Tradfri](Corner_Ikea-Tradfri.md). |

## Zigpy CIE specific configuration

Specific to some CIE as ConBeeII and RasBeeII it might required to enable some CIE specific item for some brand

### Parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `autoBackup` | Automatic backup of coordinator | on |  |  | See [Backup a ZigPy coordinator](HowTo_Backup-zigpy-coordinators.md) and [Plugin Backup](Plugin_Backup.md). |
| `MonitorLoopLatency` | Monitor the zigpy event loop latency | off |  |  |  |
| `BackupFullDevices` | backup device information | off |  |  | Shown with Texas Instruments (ZNP) coordinators only. |

### Advanced parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `Konke` | Enable the Konke specific endpoint | off |  | plugin restart |  |
| `Livolo` | Enable the Livolo specific endpoint | off |  | plugin restart | See [Livolo](Corner_Livolo.md). |
| `Orvibo` | Enable the Orvibo specific endpoint | off |  | plugin restart |  |
| `Terncy` | Enable the Terncy specific endpoint | off |  | plugin restart |  |
| `Wiser` | Enable the Schneider Wiser specific endpoint | off |  | plugin restart | See [Schneider Wiser](Corner_Schneider_Wiser.md). |
| `Wiser2` | Enable the Schneider Wiser 2 specific endpoint | off |  | plugin restart | See [Schneider Wiser](Corner_Schneider_Wiser.md). |
| `OverWriteCoordinatorIEEEOnlyOnce` | Overwrite the coordinator IEEE only once (EZSP) | off |  | plugin restart | Shown with Silicon Labs (EZSP) coordinators only. |
| `autoRestore` | Automaticaly apply the most recent coordinator backup when a clean coordinator is found | on |  |  | Used when you replace the coordinator by a new one of the same family. |
| `ZigpyTopologyReport` | Enable the use of zigpy Topology Scanner | on |  |  |  |
| `ZigpyTopologyReportAutoBackup` | Automaticaly backup auto-triggered Topology scan | off |  |  |  |
| `ZigpyAutoTopology` | Automatic topology scan by zigpy (every 12 hours) | off |  |  |  |
| `CaptureRxFrames` | Capture received frames | off |  | plugin restart |  |
| `CaptureTxFrames` | Capture transmitted frames | off |  | plugin restart |  |
| `enableZclDuplicatecheck` | Discard duplicated ZCL messages | off |  |  |  |
| `EzspAllowUnsecuredRejoins` | Allow unsecured rejoins (EZSP) | off |  | plugin restart | Shown with Silicon Labs (EZSP) coordinators only. |
| `BellowsNoMoreEndDeviceChildren` | Disable direct pairing on Coordinator | off |  | plugin restart | Shown with Silicon Labs (EZSP) coordinators only. End devices then pair through a router. |
| `zigpySourceRouting` | Enable Zigbee Source routing (plugin) | off |  | plugin restart |  |

## Device firmware update Over-The-Air

Parameters which allow to configure how the plugin Over-The-Air upgrade would behave.

### Parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `autoServeOTA` | Allow automatic update when firmware found | off |  |  | See [Upgrading device firmware](HowTo_Update-device-firmware.md). |
| `checkFirmwareAgainstZigbeeOTARepository` | Check if there is a firmware available in one of the repository | on |  |  | See [Upgrading device firmware](HowTo_Update-device-firmware.md). |

### Advanced parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `EnableOTATracing` | Enable detailed tracing of the Over-The-Air process | off |  |  |  |
| `ZigbeeOTA_Repository` | Zigbee OTA firmware (build by Internet community) | `https://raw.githubusercontent.com/Koenkk/zigbee-OTA/master/index.json` |  | plugin restart |  |
| `IkeaTradfri_Repository` | IKEA-TRADFRI Official repository | `http://fw.ota.homesmart.ikea.net/feed/version_info.json` |  | plugin restart |  |
| `Sonoff_Repository` | SONOFF firmware repository URL | `https://zigbee-ota.sonoff.tech/releases/upgrade.json` |  | plugin restart |  |

## Pairing settings

Special settings for special devices or special conditions

### Parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `LegrandCompatibilityMode` | Enable to simulate a Legrand Netamo Hub | off |  |  | See [Legrand Netatmo](Corner_Legrand-Netatmo.md). |
| `enableSchneiderWiser` | Enable if you have Legacy Wiser devices | off |  |  | See [Schneider Wiser](Corner_Schneider_Wiser.md). |

### Advanced parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `TuyaMagicRead` | Send the Tuya magic read command when pairing | on |  |  |  |
| `ConfigureReportingChunk` | Max number of attributes when Configure Reporting | `3` |  |  |  |
| `AqaraOppleBulbMode` | Enable to have Aqara Opple remote commanding directly devices | off |  |  |  |
| `reenforcementWiser` | Enable reenforcement messages (legacy Wiser only) | `300` | s |  |  |
| `ReadAttributeChunk` | Max number of attributes when Read Attributes | `10` |  |  |  |
| `ReadAttributeChunkWhenPairing` | Max number of attributes per Read Attributes while pairing | `3` |  |  |  |
| `ZiGateConfigureReporting` | Let the ZiGate firmware handle Configure Reporting | on |  |  | ZiGate coordinators only. |
| `bindingDelay` | Delay in sec after each binding command | `0.75` | s |  |  |
| `pairingCommandsDelay` | Delay in sec between commands sent during pairing | `0` | s |  |  |

## Web Interface settings

Allows to enable/disable Web UI

### Parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `Lang` | Web UI language | `en-US` | en-US, fr-FR, de-DE, es-ES, it-IT, nl-NL |  | Also the language of the selector levels of some widgets created after the change. |
| `numTopologyReports` | Number of Topology reports saved | `4` |  |  |  |
| `numEnergyReports` | Number of Interference reports saved | `4` |  |  |  |

### Advanced parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `TopologyV2` | Network Topology based on routing and neighbourghs tables | on |  |  |  |

## Device Management settings

Here are all settings related to Devices and how the coordinator interact with them

### Parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `resetMotiondelay` | Delay in sec to reset motion detection | `30` | s |  |  |
| `resetSwitchSelectorPushButton` | Number of sec after the Selector is reset to Off | `0` | s |  |  |
| `forceSwitchSelectorPushButton` | Workaround Domoticz issue #4143 | off |  |  | See [domoticz/domoticz#4143](https://github.com/domoticz/domoticz/issues/4143). |
| `TrackingEraticValue` | Log attribute values received out of the expected range | off |  |  | Useful when [writing a device configuration](HowTo_Device-Customization.md) with a `Range`. |

### Advanced parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `deviceOffWhenTimeOut` | Switch device to Off when network Timeout | off |  |  |  |
| `forcePollingAfterAction` | Get device status after action | on |  |  |  |
| `forcePassiveWidget` | Allow Domoticz actions on Widgets from remote devices | off |  |  |  |
| `ForceDeviceTimedOut_afterXhours` | Mark device as Timed Out after X hours without traffic (0 to disable) | `0` | h |  | 0 disables. |
| `resetConfigureReporting` | Reset all existing Configure Reporting | off |  | plugin restart | One shot: the plugin clears it after the restart. |
| `checkConfigurationReporting` | Check the device Report configuration regularly | `75600` | s |  | 75600 s = 21 hours. 0 disables. |
| `resetReadAttributes` | Reset all read attributes | off |  | plugin restart | One shot: the plugin clears it after the restart. |
| `resetOTAUpdate` | Reset the OTA update status of all devices at startup | off |  | plugin restart |  |
| `doUnbindBind` | Unbind and then bind, when doing a binding operation | off |  |  |  |
| `allowReBindingClusters` | Enable re-binding clusters during configure reporting operations | on |  |  | See [FAQ Q8](Problem_FAQ.md#q8-my-device-is-not-updated-in-domoticz-when-interacting-via-a-remote-control-or-manually). |

## Coordinator settings

Here are all settings related to the coordinator hardware.

### Parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `blueLedOnOff` | Enable Coordinator Blue Led | on |  |  |  |
| `Certification` | Certification ( FCC or CE ) | CE regulation | CE regulation, FCC regulation | plugin restart |  |

### Advanced parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `pingDevicesFeq` | Frequency of regular ping main-powered devices | `3600` | s |  |  |
| `resetPermit2Join` | Reset permit to join at startup | on |  |  |  |
| `Ping` | Enable Ping | on |  |  |  |
| `channel` | Coordinator chanel (default 0) | default | default, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26 | coordinator reset | **Changing it requires a coordinator reset.** See [Change the ZigBee Channel](HowTo_Change-ZigBee-channel.md). |
| `TXpower_set` | Coordinator transmission power level | 0dbM | 0dbM, -9 dbM, -20dbM, -32dbM | plugin restart |  |
| `extendedPANID` | Zigbee Extended PAN Identifier | `0000` |  | erase network | **Changing it erases the network: all devices must be paired again.** |
| `forceClosingAllNodes` | Enable to close Pairing mode in each router | off |  | plugin restart | When pairing mode is switched off, the plugin also closes it on every router. |

## Command transitions for Lights in Groups

For Groups only. You can specify the transition time in 10th of seconds with which the transition from current to target stage. For example how many 10th of second it will take to move from the current Color to the Color I requested via Domoticz. Color temp is used for White Color

### Parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `GrpfadingOff` | Fadding mode | default | default, 50% fade, 12s to off, 20% dim up, 1s off, No fade |  |  |
| `GrpmoveToColourTemp` | Transition time for TEMP move color | `0` | 1/10 s |  |  |
| `GrpmoveToColourRGB` | Transition time for RGB move color | `0` | 1/10 s |  |  |
| `GrpmoveToLevel` | Transition time for one dim position to an other one | `0` | 1/10 s |  |  |
| `GroupLevelWithOnOff` | Send Move to Level with On/Off for groups | on |  |  |  |

## Plugin environment settings

Here are all Plugin environements settings

### Parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `numDeviceListVersion` | Number of DeviceList history | `12` |  |  | Number of old copies of `Data/DeviceList-XX.txt` (and of the coordinator backup) kept. |

### Advanced parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `storeDomoticzDb` | Store the plugin device list in the Domoticz database | on |  |  | See [Plugin Backup](Plugin_Backup.md). |
| `useDomoticzDb` | Read the plugin device list from the Domoticz database | on |  |  | See [Plugin Backup](Plugin_Backup.md). |
| `PluginLogMode` | File permissions applied to the plugin log files | system default | system default, 0600, 0640, 0644 | plugin restart |  |
| `pluginData` | Plugin data folder | (empty) |  | plugin restart | Empty means the `Data` folder of the plugin. |
| `pluginConfig` | Plugin configuration folder | (empty) |  | plugin restart | Empty means the `Conf` folder of the plugin. |
| `pluginOTAFirmware` | OTA firmware folder | (empty) |  | plugin restart | Empty means the `OTAFirmware` folder of the plugin. |
| `pluginReports` | Plugin reports folder | (empty) |  | plugin restart | Empty means the `Reports` folder of the plugin. |
| `pluginWWW` | Web UI files folder | (empty) |  | plugin restart | Empty means the `www` folder of the plugin. |
| `pluginLogs` | Plugin logs folder | (empty) |  | plugin restart | Empty means the `Logs` folder of the plugin. |
| `SSLCertificate` | Path to the SSL certificate used by the Web UI | (empty) |  | plugin restart | Empty means `server.crt` in the plugin folder. When a valid certificate and key are found, the WebUI is served over https. |
| `SSLPrivateKey` | Path to the SSL private key used by the Web UI | (empty) |  | plugin restart | Empty means `server.key` in the plugin folder. See `SSLCertificate`. |

## Device patches and workarounds

Enable a corrective patch for a known device issue. Use it only if you have been asked to.

### Advanced parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `Bug566` | Apply the issue #566 fix on TRADFRI control outlet | off |  |  |  |

## Experimental parameters

Use it only if you have been asked to

### Advanced parameters

| Setting | Shown in the WebUI as | Default | Unit / values | Restart | Notes |
| :------ | :-------------------- | :------ | :------------ | :------ | :---- |
| `ControllerInRawMode` | Use the coordinator in raw mode | off |  |  |  |
| `enableZigpyPersistentInMemory` | Keep the zigpy database in memory instead of a file | on |  | plugin restart |  |
| `EventLoopInstrumentation` | Instrument the zigpy event loop | on |  | plugin restart |  |
| `DomoticzDB_Stats` | Collect statistics on Domoticz database accesses | on |  |  |  |
| `ZigpyTransport_Stats` | Collect statistics on the zigpy transport | on |  |  |  |
| `EnableTraceMalloc` | Enable memory allocation tracing (tracemalloc) | off |  |  |  |
