Starting with release 4.1 the plugin directory structure is : 


+ domoticz/plugins/Domoticz-Zigate

| root | 1st level | Description | Access right |
| ---  | --------- | ----------- | ------------ |
| +    | Classes   | All python classes | read only for user running domoticz (except when updating) |
| +    | Modules   | All python modules | read only for user running domoticz (except when updating ) |
| +    | Conf      | Configuration file | Must be RW for user to update config file |
| +    | Data      | Live data as plugin databases ( DeviceList and GroupList ) | must be RW for user running domoticz|
