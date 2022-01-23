<a href="Home.md"><img align="left" width="80" height="80" src="../Images/zigbee4domoticz-logo.png" alt="Logo"></a>

# Plugin directory structure

</br>

Starting with release 4.1 the plugin directory structure is :


+ domoticz/plugins/Domoticz-Zigbee

| root | 1st level | Description | Access right |
| ---  | --------- | ----------- | ------------ |
| +    | Classes   | All python classes | read only for user running domoticz (except when updating) |
| +    | Modules   | All python modules | read only for user running domoticz (except when updating ) |
| +    | Conf      | Configuration file | Must be RW for user to update config file |
| +    | Data      | Live data as plugin databases ( DeviceList and GroupList ) | must be RW for user running domoticz|
