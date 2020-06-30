# Runnning the plugin under a Windows installation


## Preamble

Most of the developement are done on Linux platform ( Rasbian, Fedora ), and we rely on the python code to run smoothly on Windows platform


## Advices

1. You must run Domoticz with "administrator" privileges in order to create/update files.
1. You might have to disable the "Allow Internet access" parameter which will prevent the plugin for checking if a new version is available



* Example of Conf/PluginConf-xx.json file which allow to have the updated datas on a separate folder (with access rights)

  ```
  {
    "channel": "11",
    "filename":          "D:\\DomoticzExtra\\Zigate\\Conf\\PluginConf-19.json",
    "homedirectory":     "C:\\Program Files(x86)\\Domoticz\\plugins\\Domoticz-Zigate\\",
    "pluginConfig":      "D:\\DomoticzExtra\\Zigate\\Conf\\",
    "pluginData":        "D:\\DomoticzExtra\\Zigate\\Data\\",
    "pluginHome":        "C:\\Program Files(x86)\\Domoticz\\plugins\\Domoticz-Zigate\\",
    "pluginLogs":        "D:\\DomoticzExtra\\Zigate\\Logs\\",
    "pluginOTAFirmware": "D:\\DomoticzExtra\\Zigate\\OTAFirmware\\",
    "pluginReports":     "D:\\DomoticzExtra\\Zigate\\Reports\\",
    "pluginWWW":         "C:\\Program Files(x86)\\Domoticz\\plugins\\Domoticz-Zigate\\www\\"
  }
  ```
