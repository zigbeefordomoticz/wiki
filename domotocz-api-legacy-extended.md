## Overview

This page is aimed at developers wishing to improve Domoticz
functionality via Python Plugins. If you simply want to use a plugin
that a developer has already created for you, please see [Using Python
plugins](Using_Python_plugins "wikilink"). To see the Plugins already
developed (for a reference) got to page [Plugins](Plugins "wikilink").

The Domoticz Python Framework is not a general purpose Domoticz
extension. It is designed to allow developers to easily create an
interface between a piece of Hardware (or Virtual Hardware) and
Domoticz. To that end it provides capabilities that seek to do the hard
work for the developer leaving them to manage the messages that move
backwards and forwards between the two.

The Framework provides the plugin with a full Python 3 instance that
exists for as long as Domoticz is running. The plugin is called by
Domoticz when relevant events occur so that it can manage connectivity
to the hardware and state synchronisation.

Multiple copies of the same plugin can run for users that have more than
one instance of a particular hardware type.

### Plugin Framework types {#plugin_framework_types}

There are current two variations of the Plugin Framework available,
plugin authors can use either but **not both** at the same time:

1.  Legacy Framework: This has been stable for several years, invoked by
    importing \'Domoticz\' into the plugin
2.  Extended Framework:
    -   Built on Legacy Framework but has a new object model and event
        localisation
    -   Invoked by importing \'DomoticzEx\' into the plugin.
    -   Creates a two layer mapping over the DeviceStatus table of
        Devices and Units
    -   Plugins are not restricted to 256 Units (each Device can have
        256 Units)

### Sleeping and multi-threading details: {#sleeping_and_multi_threading_details}

The following things should not be attempted using the Python Framework:

-   Waiting or sleepingin Domoticz callbacks. Plugin callbacks are
    single threaded so the whole plugin system will wait.

The Python Framework has been uplifted to support multi-threaded
plugins, key points:

-   Use of asynchronous code or modules and callback functions are now
    supported. These should function as expected.
-   All threads started within the plugin (either directly or by
    imported modules) must be terminated by the plugin prior to the
    plugin stopping (\'onStop\' is the recommended place for this).
    Failure to do this will result in Python aborting Domoticz during
    hardware \'Stops\' &/or \'Updates\'. The Plugin Framework cannot
    enumerate threads started by the plugin or stop them (Python
    limitation) and any active threads when the plugin interpreter is
    destroyed will cause Python to abort. **YOU HAVE BEEN WARNED !**

An example of a multi-threaded plugin including how to show running
threads and thread shutdown can be found [here on
Github](https://github.com/domoticz/domoticz/blob/development/plugins/examples/Mutli-Threaded.py)

## Overall Structure {#overall_structure}

The plugin documentation is split into two distinct parts:

-   Plugin Definition - Telling Domoticz about the plugin
-   Runtime Structure - Interfaces and APIs to manage message flows
    between Domoticz and the hardware

### Getting started {#getting_started}

If you are writing a Python plugin from scratch, you may want to begin
by using the **Script Template** in
*domoticz/plugins/examples/BaseTemplate.py*, which is also available
from the github source repo at
<https://github.com/domoticz/domoticz/blob/master/plugins/examples/BaseTemplate.py>

## Plugin Definition {#plugin_definition}

To allow plugins to be added without the need for code changes to
Domoticz itself requires that the plugins be exposed to Domoticz in a
generic fashion. This is done by having the plugins live in a set
location so they can be found and via an XML definition embedded in the
Python script itself that describes the parameters that the plugin
requires.

During Domoticz startup all directories directly under the \'plugins\'
directory are scanned for python files named `plugin.py` and those that
contain definitions are indexed by Domoticz. When the Hardware page is
loaded the plugins defined in the index are merged into the list of
available hardware and are indistinguishable from natively supported
hardware. For the example below the Kodi plugin would be in a file
`domoticz/plugins/Kodi/plugin.py`. Some example Python scripts can be
found in the `domoticz/plugins/examples` directory.

Plugin definitions expose some basic details to Domoticz and a list of
the parameters that users can configure. Each defined parameters will
appear as an input on the Hardware page when the plugin is selected in
the dropdown.

Definitions look like this:

``` xml
"""
<plugin key="Kodi" name="Kodi Players" author="dnpwwo" version="1.0.0" wikilink="http://www.domoticz.com/wiki/plugins/Kodi.html" externallink="https://kodi.tv/">
    <description>
        <h2>Kodi Media Player Plugin</h2><br/>
        <h3>Features</h3>
        <ul style="list-style-type:square">
            <li>Comes with three selectable icon sets: Default, Black and Round</li>
            <li>Display Domoticz notifications on Kodi screen if a Notifier name is specified and events configured for that notifier</li>
            <li>Multiple Shutdown action options</li>
            <li>When network connectivity is lost the Domoticz UI will optionally show the device(s) with a Red banner</li>
        </ul>
        <h3>Devices</h3>
        <ul style="list-style-type:square">
            <li>Status - Basic status indicator, On/Off. Also has icon for Kodi Remote popup</li>
            <li>Volume - Icon mutes/unmutes, slider shows/sets volume</li>
            <li>Source - Selector switch for content source: Video, Music, TV Shows, Live TV, Photos, Weather</li>
            <li>Playing - Icon Pauses/Resumes, slider shows/sets percentage through media</li>
        </ul>
    </description>
    <params>
        <param field="Address" label="IP Address" width="200px" required="true" default="127.0.0.1"/>
        <param field="Port" label="Port" width="30px" required="true" default="9090"/>
        <param field="Mode1" label="MAC Address" width="150px" required="false"/>
        <param field="Mode2" label="Shutdown Command" width="100px">
            <options>
                <option label="Hibernate" value="Hibernate"/>
                <option label="Suspend" value="Suspend"/>
                <option label="Shutdown" value="Shutdown"/>
                <option label="Ignore" value="Ignore" default="true" />
            </options>
        </param>
        <param field="Mode3" label="Notifications" width="75px">
            <options>
                <option label="True" value="True"/>
                <option label="False" value="False"  default="true" />
            </options>
        </param>
        <param field="Mode6" label="Debug" width="75px">
            <description><h2>Debugging</h2>Select the desired level of debug messaging</description>
            <options>
                <option label="True" value="Debug"/>
                <option label="False" value="Normal"  default="true" />
            </options>
        </param>
    </params>
</plugin>
"""
```

Definition format details:

+------------------------+--------------------------------------------+
| Tag                    | Description/Attributes                     |
+========================+============================================+
| `<plugin>`{=html}      | Required.                                  |
|                        |                                            |
|                        |   Attribute      Purpose                   |
|                        |   -------------- --------                  |
|                        | ------------------------------------------ |
|                        | ------------------------------------------ |
|                        | ------------------------------------------ |
|                        | ------------------------------------------ |
|                        | ------------------------------------------ |
|                        | ------------------------------------------ |
|                        | ------------------------------------------ |
|                        |   key            Requir                    |
|                        | ed. Unique identifier for the plugin. Neve |
|                        | r visible to users this should be short, m |
|                        | eaningful and made up of characters A-Z, a |
|                        | -z, 0-9 and -\_ only. Stored in the 'Extra |
|                        | ' field in the Hardware. Used as the base  |
|                        | name for the plugin Python file, e.g. 'Den |
|                        | onAVR' maps to /plugins/DenonAVR/plugin.py |
|                        |   name           Required. Me              |
|                        | aningful description for plugin. Shown in  |
|                        | the 'Type' drop down on the Hardware page. |
|                        |   version                                  |
|                        |     Required. Plugin version. Used to comp |
|                        | are plugin version against repository vers |
|                        | ion to determine if updates are available. |
|                        |   author                                   |
|                        |          Optional. Plugin author. Supplied |
|                        |  to Hardware page but not currently shown. |
|                        |   wikilink       Optional. Link            |
|                        |  to the plugin usage documentation on the  |
|                        | Domoticz wiki. Shown on the Hardware page. |
|                        |   exter                                    |
|                        | nallink   Optional. Link to an external UR |
|                        | L that contains additional information abo |
|                        | ut the device. Shown on the Hardware page. |
|                        |                                            |
+------------------------+--------------------------------------------+
| `<description>`{=html} | HTML description, contained within         |
|                        | `<plugin>`{=html} and `<param>`{=html}     |
|                        | tags. This is displayed in the Hardware    |
|                        | page when configuring a plugin. Embedded   |
|                        | HTML tags are allowed and respected.       |
+------------------------+--------------------------------------------+
| `<params>`{=html}      | Simple wrapper for param tags. Contained   |
|                        | within `<plugin>`{=html}.                  |
+------------------------+--------------------------------------------+
| `<param>`{=html}       | Parameter definitions, Contained within    |
|                        | `<params>`{=html}. Parameters are used by  |
|                        | the Hardware page during plugin addition   |
|                        | and update operations. These are stored in |
|                        | the Hardware table in the database and are |
|                        | made available to the plugin at runtime.   |
|                        |                                            |
|                        | +-----------+-------------------------+    |
|                        | | Attribute | Purpose                 |    |
|                        | +===========+=========================+    |
|                        | | field     | Required. Column in the |    |
|                        | |           | hardware table to store |    |
|                        | |           | the parameter.\         |    |
|                        | |           | Valid values:           |    |
|                        | |           |                         |    |
|                        | |           | -   SerialPort - used   |    |
|                        | |           |     by 'serial'         |    |
|                        | |           |     transports          |    |
|                        | |           | -   Address - used by   |    |
|                        | |           |     non-serial          |    |
|                        | |           |     transports          |    |
|                        | |           | -   Port - used by      |    |
|                        | |           |     non-serial          |    |
|                        | |           |     transports          |    |
|                        | |           | -   Mode1 - General     |    |
|                        | |           |     purpose             |    |
|                        | |           | -   Mode2 - General     |    |
|                        | |           |     purpose             |    |
|                        | |           | -   Mode3 - General     |    |
|                        | |           |     purpose             |    |
|                        | |           | -   Mode4 - General     |    |
|                        | |           |     purpose             |    |
|                        | |           | -   Mode5 - General     |    |
|                        | |           |     purpose             |    |
|                        | |           | -   Mode6 - General     |    |
|                        | |           |     purpose             |    |
|                        | |           | -   Username - Username |    |
|                        | |           |     for authentication  |    |
|                        | |           | -   Password - Password |    |
|                        | |           |     for authentication  |    |
|                        | +-----------+-------------------------+    |
|                        | | label     | Required. Field label.  |    |
|                        | |           | Where possible standard |    |
|                        | |           | labels should be used   |    |
|                        | |           | so that Domoticz can    |    |
|                        | |           | translate them when     |    |
|                        | |           | languages other than    |    |
|                        | |           | English are enabled.    |    |
|                        | +-----------+-------------------------+    |
|                        | | width     | Optional. Width of the  |    |
|                        | |           | field                   |    |
|                        | +-----------+-------------------------+    |
|                        | | required  | Optional. Marks the     |    |
|                        | |           | field as mandatory and  |    |
|                        | |           | the device will not be  |    |
|                        | |           | added unless a value is |    |
|                        | |           | provided                |    |
|                        | +-----------+-------------------------+    |
|                        | | default   | Optional. Default value |    |
|                        | |           | for the field. Ignored  |    |
|                        | |           | when `<options>`{=html} |    |
|                        | |           | are specified.          |    |
|                        | +-----------+-------------------------+    |
|                        | | password  | Optional. Makes the     |    |
|                        | |           | text unreadable during  |    |
|                        | |           | entry and when hardware |    |
|                        | |           | page is viewed          |    |
|                        | |           | subsequently. Ignored   |    |
|                        | |           | when `<options>`{=html} |    |
|                        | |           | are specified.          |    |
|                        | +-----------+-------------------------+    |
|                        | |           |                         |    |
|                        | +-----------+-------------------------+    |
+------------------------+--------------------------------------------+
| `<options>`{=html}     | Simple wrapper for option tags. Contained  |
|                        | within `<param>`{=html}. Parameter         |
|                        | definitions that contain this tag will be  |
|                        | shown as drop down menus in the Hardware   |
|                        | page. Available values are defined by the  |
|                        | `<option>`{=html} tag.                     |
+------------------------+--------------------------------------------+
| `<option>`{=html}      | Instance of a drop down option. Contained  |
|                        | within `<options>`{=html}.                 |
|                        |                                            |
|                        |   Attribute   Purpose                      |
|                        |   ----------- --                           |
|                        | ------------------------------------------ |
|                        | ------------------------------------------ |
|                        |   label                                    |
|                        | Required. Text to show in dropdown menu. W |
|                        | ill be translated if a translation exists. |
|                        |   value       Requi                        |
|                        | red. Associated value to store in database |
|                        |   default     Optional. Valid value: true  |
|                        |                                            |
+------------------------+--------------------------------------------+
|                        |                                            |
+------------------------+--------------------------------------------+

## Runtime Structure {#runtime_structure}

Domoticz exposes settings and device details through four Python
dictionaries.

### Settings

Contents of the Domoticz Settings page as found in the Preferences
database table. These are always available and will be updated if the
user changes any settings. The plugin is not restarted. They can be
accessed by name for example: `Settings["Language"]`

### Parameters

These are always available and remain static for the lifetime of the
plugin. They can be accessed by name for example:
`Parameters["SerialPort"]`

                      Description
  ------------------- ------------------------------------------------------------
  Key                 Unique short name for the plugin, matches python filename.
  Name                Name assigned by the user to the hardware.
  HomeFolder          Folder or directory where the plugin was run from.
  Author              Plugin Author.
  Version             Plugin version.
  Address             IP Address, used during connection.
  Port                IP Port, used during connection.
  Username            Username.
  Password            Password.
  Mode1               General Parameter 1
  \...                
  Mode6               General Parameter 6
  SerialPort          SerialPort, used when connecting to Serial Ports.
  DomoticzVersion     Domoticz version, for instance 4.11774
  DomoticzHash        Domoticz hash, for instance a06400e05
  DomoticzBuildTime   Domoticz build time, for instance 2020-03-03 15:41:00

### Extended Plugin Framework {#extended_plugin_framework}

Available in Domoticz Stable 2022.1!

#### Devices

+-----------+---------------------------------------------------------+
|           | Description                                             |
+===========+=========================================================+
| Members   | DeviceID. Devices are a container class designed to     |
|           | hold the Units that share a common DeviceID             |
|           |                                                         |
|           |   Function   Access       Description                   |
|           |   ---------- --                                         |
|           | ---------- -------------------------------------------- |
|           |   DeviceID   Read         External device identifier    |
|           |   TimedO                                                |
|           | ut   Read/Write   Device TimedOut flag. 1=True, 0=False |
|           |   Units                                                 |
|           | Read         Dictionary of Units that have the DeviceID |
|           |                                                         |
+-----------+---------------------------------------------------------+
| Methods   | Per device calls into Domoticz to manipulate specific   |
|           | devices                                                 |
|           |                                                         |
|           | +--------------+------------------------------------+   |
|           | | Function     | Description                        |   |
|           | +==============+====================================+   |
|           | | \_\_init\_\_ | +-----------+-----------------+    |   |
|           | |              | | Parameter | Description     |    |   |
|           | |              | +===========+=================+    |   |
|           | |              | | DeviceID  | Mandatory.\     |    |   |
|           | |              | |           | The DeviceID to |    |   |
|           | |              | |           | be used with    |    |   |
|           | |              | |           | the device.\    |    |   |
|           | |              | |           | Device objects  |    |   |
|           | |              | |           | will be created |    |   |
|           | |              | |           | automatically   |    |   |
|           | |              | |           | either during   |    |   |
|           | |              | |           | plugin load or  |    |   |
|           | |              | |           | when Unit       |    |   |
|           | |              | |           | objects are     |    |   |
|           | |              | |           | created with    |    |   |
|           | |              | |           | new DeviceIDs\  |    |   |
|           | |              | |           | Field type is   |    |   |
|           | |              | |           | Varchar(25)     |    |   |
|           | |              | +-----------+-----------------+    |   |
|           | |              | |           |                 |    |   |
|           | |              | +-----------+-----------------+    |   |
|           | +--------------+------------------------------------+   |
|           | | Refresh      | Parameters: None. Refreshes the    |   |
|           | |              | Device and the Units with the      |   |
|           | |              | matching DeviceID from the         |   |
|           | |              | Domoticz database.                 |   |
|           | |              |                                    |   |
|           | |              | Not normally required because      |   |
|           | |              | device values are updated when     |   |
|           | |              | callbacks are invoked.             |   |
|           | +--------------+------------------------------------+   |
|           | |              |                                    |   |
|           | +--------------+------------------------------------+   |
+-----------+---------------------------------------------------------+
| Callbacks | If defined, these callbacks will be sent to the Device  |
|           | object rather than to the module level function. Note   |
|           | that the function definitions are different because the |
|           | API only passes the required parameters so no Device    |
|           | details are passed.                                     |
|           |                                                         |
|           | To define these callback plugin authors need to         |
|           | register a local object that extends the Domoticz       |
|           | default. See the Register function in the               |
|           | [#                                                      |
|           | C.2B.2B_Callable_API](#C.2B.2B_Callable_API "wikilink") |
|           | section for details                                     |
|           |                                                         |
|           | +------------------+--------------------------------+   |
|           | | Callback         | Description                    |   |
|           | +==================+================================+   |
|           | | onDeviceAdded    | Parameters: Unit Called just   |   |
|           | |                  | after a new device has been    |   |
|           | |                  | added to the hardware, for     |   |
|           | |                  | example by a Domoticz Web API  |   |
|           | |                  | call.                          |   |
|           | |                  |                                |   |
|           | |                  | onDeviceAdded is not called    |   |
|           | |                  | when the plugin adds a device. |   |
|           | +------------------+--------------------------------+   |
|           | | onDeviceModified | Parameters: Unit Called just   |   |
|           | |                  | after a device owned by the    |   |
|           | |                  | plugin has been modifed, for   |   |
|           | |                  | example by a Domoticz Web API  |   |
|           | |                  | call.                          |   |
|           | |                  |                                |   |
|           | |                  | onDeviceModified is not called |   |
|           | |                  | when the plugin initiated the  |   |
|           | |                  | change e.g. by calling Update. |   |
|           | +------------------+--------------------------------+   |
|           | | onDeviceDeleted  | Parameters: Unit Called just   |   |
|           | |                  | before a device owned by the   |   |
|           | |                  | plugin is been removed, for    |   |
|           | |                  | example by a Domoticz Web API  |   |
|           | |                  | call.                          |   |
|           | |                  |                                |   |
|           | |                  | onDeviceRemoved is not called  |   |
|           | |                  | when the plugin removed the    |   |
|           | |                  | device by calling Delete.      |   |
|           | +------------------+--------------------------------+   |
|           | | onCommand        | Parameters: Unit, Command,     |   |
|           | |                  | Level, Hue Called by Domoticz  |   |
|           | |                  | in response to a script or     |   |
|           | |                  | Domoticz Web API call sending  |   |
|           | |                  | a command to a Unit in the     |   |
|           | |                  | Device\'s Units dictionary     |   |
|           | +------------------+--------------------------------+   |
|           | | onSecurityEvent  | Parameters: Level,             |   |
|           | |                  | Description.                   |   |
|           | +------------------+--------------------------------+   |
|           |                                                         |
|           | ``` python3                                             |
|           | import DomoticzEx as Domoticz                           |
|           |                                                         |
|           | ...                                                     |
|           |                                                         |
|           | class hvacDevice(Domoticz.Device):                      |
|           |                                                         |
|           |     def __init__(self, DeviceID):                       |
|           |         super().__init__(DeviceID)                      |
|           |                                                         |
|           |     def onDeviceAdded(self, Unit):                      |
|           |         Domoticz.Log("                                  |
|           | Device onDeviceAdded for Unit: "+str(self.Units[Unit])) |
|           |                                                         |
|           |     def onDeviceModified(self, Unit):                   |
|           |         Domoticz.Log("Dev                               |
|           | ice onDeviceModified for Unit: "+str(self.Units[Unit])) |
|           |                                                         |
|           |     def onDeviceRemoved(self, Unit):                    |
|           |         Domoticz.Log("De                                |
|           | vice onDeviceRemoved for Unit: "+str(self.Units[Unit])) |
|           |                                                         |
|           |     def onCommand(self, Unit, Command, Level, Hue):     |
|           |         Domoticz.Log("onCommand called f                |
|           | or Device '" + DeviceID + "', Unit " + str(Unit) + ": P |
|           | arameter '" + str(Command) + "', Level: " + str(Level)) |
|           |                                                         |
|           |         Command = Command.strip()                       |
|           |         action, sep, params = Command.partition(' ')    |
|           |         action = action.capitalize()                    |
|           |                                                         |
|           | # Overr                                                 |
|           | ide the default Domoticz device object with custom one  |
|           | Domoticz.Register(Device=hvacDevice)                    |
|           |                                                         |
|           | def onDeviceModified(self, DeviceID, Unit):             |
|           |     # This will never be                                |
|           | called because the Device specific version overrides it |
|           |     Domoticz.Log("Device onDeviceModified")             |
|           | ```                                                     |
+-----------+---------------------------------------------------------+
|           |                                                         |
+-----------+---------------------------------------------------------+

#### Units

+-----------+---------------------------------------------------------+
|           | Description                                             |
+===========+=========================================================+
| Members   | Unit. Unit number for the device as specified in the    |
|           | Manifest. Note: Units can be deleted in Domoticz so not |
|           | all Units specified will necessarily still be present.  |
|           | E.g: `Domoticz.Log(Devices["123456"].Units[2].Name)`    |
|           |                                                         |
|           |   Function       Access       Description               |
|           |   -------------- ---------                              |
|           | --- --------------------------------------------------- |
|           | ------------------------------------------------------- |
|           | ------------------------------------------------------- |
|           | ------------------------------------------------------- |
|           |   ID             Read         The Domoticz Device ID    |
|           |   Unit           Read         The Unit number           |
|           |   Name           Read/Write   Current Name in Domoticz  |
|           |   nValue         Read/Write   Current numeric value     |
|           |   sValue         Read/Write   Current string value      |
|           |   SignalLevel    Read/Write   Numeric signal level      |
|           |   BatteryLevel   Read/Write   Numeric battery level     |
|           |   Image          Read/Write   Current image number      |
|           |   Type           Read/Write   Numeric device type       |
|           |   SubType        Read/Write   Numeric device subtype    |
|           |   Switchtype     Read/Write   Numeric device switchtype |
|           |   Used                                                  |
|           |          Read/Write   Device Used flag. 1=True, 0=False |
|           |   Option                                                |
|           | s        Read/Write   Current Device options dictionary |
|           |                                                         |
|           | LastLevel      Read/Write   Last level as reported by D |
|           | omoticz, used to control sliders on Dimmers and Blinds. |
|           |   LastUpdate     Read                                   |
|           |  Timestamp of the last update, e.g: 2017-01-22 01:21:11 |
|           |   Description    Read/Write   Description of the        |
|           |  device, visible in \"Edit\" dialog in Domoticz Web UI. |
|           |   Color          Read/Write   Current color, see doc    |
|           | umentation of [onCommand callback](Developing_a_Python_ |
|           | plugin#Callbacks "wikilink") for details on the format. |
|           |   Adjustment     Read                                   |
|           |        Float value representing the adjustment value se |
|           | t for the Unit (via the web UI) Note: This is made avai |
|           | lable to the Plugin author so it can be applied if requ |
|           | ired, it is not applied by the framework automatically. |
|           |   Multiplier     Read                                   |
|           |       Float value representing the multiplier value set |
|           |  for the Unit (via the web UI). Note: This is made avai |
|           | lable to the Plugin author so it can be applied if requ |
|           | ired, it is not applied by the framework automatically. |
|           |   P                                                     |
|           | arent         Read         The \'owning\' Device object |
|           |                                                         |
+-----------+---------------------------------------------------------+
| Methods   | Per device calls into Domoticz to manipulate specific   |
|           | devices                                                 |
|           |                                                         |
|           | +--------------+-----------------+-----------------+    |
|           | | Function     | Description     | Example         |    |
|           | +==============+=================+=================+    |
|           | | \_\_init\_\_ | <table>         | Both positional |    |
|           | |              | <thead>         | and named       |    |
|           | |              | <tr             | parameters are  |    |
|           | |              | class="header"> | supported.\     |    |
|           | |              | <th><p>Par      | Creates a new   |    |
|           | |              | ameter</p></th> | Unit object in  |    |
|           | |              | <th><p>Descr    | Python. E.g:    |    |
|           | |              | iption</p></th> |                 |    |
|           | |              | </tr>           | ``` python3     |    |
|           | |              | </thead>        | myUnit1 =       |    |
|           | |              | <tbody>         |  DomoticzEx.Uni |    |
|           | |              | <tr             | t("Total", "000 |    |
|           | |              | class="odd">    | A0001", 1, 113) |    |
|           | |              | <td><           | myUnit2 = Domot |    |
|           | |              | p>Name</p></td> | iczEx.Unit(Name |    |
|           | |              | <td><p>M        | ="My Counter",  |    |
|           | |              | andatory.<br /> | DeviceID="000A0 |    |
|           | |              | Is appended     | 001", Unit=2, T |    |
|           | |              | to the          | ypeName="Counte |    |
|           | |              | Hardware name   | r Incremental") |    |
|           | |              | to set the      | ```             |    |
|           | |              | initial         |                 |    |
|           | |              | Domoticz        | or              |    |
|           | |              | Device          |                 |    |
|           | |              | name.<br />     | ``` python3     |    |
|           | |              | This should     | im              |    |
|           | |              | not be used     | port DomoticzEx |    |
|           | |              | in Python       |                 |    |
|           | |              | because it      | def onStart():  |    |
|           | |              | can be          |     if (len(    |    |
|           | |              | changed in      | Devices) == 0): |    |
|           | |              | the Web         |         Do      |    |
|           | |              | UI.</p></td>    | moticzEx.Unit(N |    |
|           | |              | </tr>           | ame="Status", \ |    |
|           | |              | <tr             |                 |    |
|           | |              | class="even">   | DeviceID="myDev |    |
|           | |              | <td><p>De       | ice", Unit=1, \ |    |
|           | |              | viceID</p></td> |             Ty  |    |
|           | |              | <td><p>M        | pe=17, Switchty |    |
|           | |              | andatory.<br /> | pe=17).Create() |    |
|           | |              | Set the         | ```             |    |
|           | |              | DeviceID to     |                 |    |
|           | |              | be used with    |                 |    |
|           | |              | the device.     |                 |    |
|           | |              | Only required   |                 |    |
|           | |              | to override     |                 |    |
|           | |              | the default     |                 |    |
|           | |              | which is and    |                 |    |
|           | |              | eight digit     |                 |    |
|           | |              | number          |                 |    |
|           | |              | dervice from    |                 |    |
|           | |              | the             |                 |    |
|           | |              | HardwareID      |                 |    |
|           | |              | and the Unit    |                 |    |
|           | |              | number in the   |                 |    |
|           | |              | format          |                 |    |
|           | |              | "0              |                 |    |
|           | |              | 00H000U".<br /> |                 |    |
|           | |              | Field type is   |                 |    |
|           | |              | Varch           |                 |    |
|           | |              | ar(25)</p></td> |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | <tr             |                 |    |
|           | |              | class="odd">    |                 |    |
|           | |              | <td><           |                 |    |
|           | |              | p>Unit</p></td> |                 |    |
|           | |              | <td><p>M        |                 |    |
|           | |              | andatory.<br /> |                 |    |
|           | |              | Plugin index    |                 |    |
|           | |              | for the         |                 |    |
|           | |              | Device. This    |                 |    |
|           | |              | can not         |                 |    |
|           | |              | change and      |                 |    |
|           | |              | should be       |                 |    |
|           | |              | used            |                 |    |
|           | |              | reference       |                 |    |
|           | |              | Domoticz        |                 |    |
|           | |              | devices         |                 |    |
|           | |              | associated      |                 |    |
|           | |              | with the        |                 |    |
|           | |              | plugin. This    |                 |    |
|           | |              | is also the     |                 |    |
|           | |              | key for the     |                 |    |
|           | |              | Devices         |                 |    |
|           | |              | Dictionary      |                 |    |
|           | |              | that Domoticz   |                 |    |
|           | |              | prepopulates    |                 |    |
|           | |              | for the         |                 |    |
|           | |              | plugin.<br />   |                 |    |
|           | |              | Unit numbers    |                 |    |
|           | |              | must be less    |                 |    |
|           | |              | than            |                 |    |
|           | |              | 256.</p></td>   |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | <tr             |                 |    |
|           | |              | class="even">   |                 |    |
|           | |              | <td><p>Ty       |                 |    |
|           | |              | peName</p></td> |                 |    |
|           | |              | <td><p>         |                 |    |
|           | |              | Optional.<br /> |                 |    |
|           | |              | Common device   |                 |    |
|           | |              | types, this     |                 |    |
|           | |              | will set the    |                 |    |
|           | |              | values for      |                 |    |
|           | |              | Type, Subtype   |                 |    |
|           | |              | and             |                 |    |
|           | |              | Sw              |                 |    |
|           | |              | itchtype.<br /> |                 |    |
|           | |              | See <a          |                 |    |
|           | |              | href="#Availabl |                 |    |
|           | |              | e_Device_Types" |                 |    |
|           | |              | title="w        |                 |    |
|           | |              | ikilink">#Avail |                 |    |
|           | |              | able_Device_Typ |                 |    |
|           | |              | es</a></p></td> |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | <tr             |                 |    |
|           | |              | class="odd">    |                 |    |
|           | |              | <td><           |                 |    |
|           | |              | p>Type</p></td> |                 |    |
|           | |              | <td><p>         |                 |    |
|           | |              | Optional.<br /> |                 |    |
|           | |              | Directly set    |                 |    |
|           | |              | the numeric     |                 |    |
|           | |              | Type value.     |                 |    |
|           | |              | Should only     |                 |    |
|           | |              | be used if      |                 |    |
|           | |              | the Device to   |                 |    |
|           | |              | be created is   |                 |    |
|           | |              | not supported   |                 |    |
|           | |              | by              |                 |    |
|           | |              | Typ             |                 |    |
|           | |              | eName.</p></td> |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | <tr             |                 |    |
|           | |              | class="even">   |                 |    |
|           | |              | <td><p>S        |                 |    |
|           | |              | ubtype</p></td> |                 |    |
|           | |              | <td><p>         |                 |    |
|           | |              | Optional.<br /> |                 |    |
|           | |              | Directly set    |                 |    |
|           | |              | the numeric     |                 |    |
|           | |              | Subtype         |                 |    |
|           | |              | value. Should   |                 |    |
|           | |              | only be used    |                 |    |
|           | |              | if the Device   |                 |    |
|           | |              | to be created   |                 |    |
|           | |              | is not          |                 |    |
|           | |              | supported by    |                 |    |
|           | |              | Typ             |                 |    |
|           | |              | eName.</p></td> |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | <tr             |                 |    |
|           | |              | class="odd">    |                 |    |
|           | |              | <td><p>Swit     |                 |    |
|           | |              | chtype</p></td> |                 |    |
|           | |              | <td><p>         |                 |    |
|           | |              | Optional.<br /> |                 |    |
|           | |              | Directly set    |                 |    |
|           | |              | the numeric     |                 |    |
|           | |              | Switchtype      |                 |    |
|           | |              | value. Should   |                 |    |
|           | |              | only be used    |                 |    |
|           | |              | if the Device   |                 |    |
|           | |              | to be created   |                 |    |
|           | |              | is not          |                 |    |
|           | |              | supported by    |                 |    |
|           | |              | Typ             |                 |    |
|           | |              | eName.</p></td> |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | <tr             |                 |    |
|           | |              | class="even">   |                 |    |
|           | |              | <td><p          |                 |    |
|           | |              | >Image</p></td> |                 |    |
|           | |              | <td><p>         |                 |    |
|           | |              | Optional.<br /> |                 |    |
|           | |              | Set the image   |                 |    |
|           | |              | number to be    |                 |    |
|           | |              | used with the   |                 |    |
|           | |              | device. Only    |                 |    |
|           | |              | required to     |                 |    |
|           | |              | override the    |                 |    |
|           | |              | default.<br />  |                 |    |
|           | |              | All images      |                 |    |
|           | |              | available by    |                 |    |
|           | |              | JSON API call   |                 |    |
|           | |              | "/json.htm?typ  |                 |    |
|           | |              | e=custom_light_ |                 |    |
|           | |              | icons"</p></td> |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | <tr             |                 |    |
|           | |              | class="odd">    |                 |    |
|           | |              | <td><p>O        |                 |    |
|           | |              | ptions</p></td> |                 |    |
|           | |              | <td><p>         |                 |    |
|           | |              | Optional.<br /> |                 |    |
|           | |              | Set the         |                 |    |
|           | |              | Device          |                 |    |
|           | |              | Options         |                 |    |
|           | |              | field. A few    |                 |    |
|           | |              | devices, like   |                 |    |
|           | |              | Selector        |                 |    |
|           | |              | Switches,       |                 |    |
|           | |              | require         |                 |    |
|           | |              | additional      |                 |    |
|           | |              | details to be   |                 |    |
|           | |              | set in this     |                 |    |
|           | |              | field. It is    |                 |    |
|           | |              | a Python        |                 |    |
|           | |              | dictionary      |                 |    |
|           | |              | consisting of   |                 |    |
|           | |              | key values      |                 |    |
|           | |              | pairs, where    |                 |    |
|           | |              | the keys and    |                 |    |
|           | |              | values must     |                 |    |
|           | |              | be strings.     |                 |    |
|           | |              | See the         |                 |    |
|           | |              | example to      |                 |    |
|           | |              | the             |                 |    |
|           | |              | right.</p></td> |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | <tr             |                 |    |
|           | |              | class="even">   |                 |    |
|           | |              | <td><           |                 |    |
|           | |              | p>Used</p></td> |                 |    |
|           | |              | <td><p          |                 |    |
|           | |              | >Optional<br /> |                 |    |
|           | |              | Values<br />    |                 |    |
|           | |              | 0 (default)     |                 |    |
|           | |              | Unused<br />    |                 |    |
|           | |              | 1 Used.<br />   |                 |    |
|           | |              | Set the         |                 |    |
|           | |              | Device Used     |                 |    |
|           | |              | field. Used     |                 |    |
|           | |              | devices         |                 |    |
|           | |              | appear in the   |                 |    |
|           | |              | appropriate     |                 |    |
|           | |              | tab(s),         |                 |    |
|           | |              | unused          |                 |    |
|           | |              | devices         |                 |    |
|           | |              | appear only     |                 |    |
|           | |              | in the          |                 |    |
|           | |              | Devices page    |                 |    |
|           | |              | and must be     |                 |    |
|           | |              | manually        |                 |    |
|           | |              | marked as       |                 |    |
|           | |              | Used.</p></td>  |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | <tr             |                 |    |
|           | |              | class="odd">    |                 |    |
|           | |              | <td><p>Descr    |                 |    |
|           | |              | iption</p></td> |                 |    |
|           | |              | <td><p>Optional |                 |    |
|           | |              | The             |                 |    |
|           | |              | description     |                 |    |
|           | |              | of the          |                 |    |
|           | |              | Unit</p></td>   |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | <tr             |                 |    |
|           | |              | class="even">   |                 |    |
|           | |              | <td></td>       |                 |    |
|           | |              | <td></td>       |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | </tbody>        |                 |    |
|           | |              | </table>        |                 |    |
|           | +--------------+-----------------+-----------------+    |
|           | | Create       | Parameters:     | Creates the     |    |
|           | |              | None, acts on   | Unit in         |    |
|           | |              | current object. | Domoticz from   |    |
|           | |              | Successfully    | the object.     |    |
|           | |              | created Units   | E.g:            |    |
|           | |              | are immediately |                 |    |
|           | |              | added to the    | ``` python3     |    |
|           | |              | Devices         | myUnit = Do     |    |
|           | |              | dictionary      | moticzEx.Unit(N |    |
|           | |              |                 | ame="Kilo Watts |    |
|           | |              |                 | ", DeviceID="Po |    |
|           | |              |                 | wer", Unit=16,  |    |
|           | |              |                 | TypeName="kWh") |    |
|           | |              |                 | myUnit.Create() |    |
|           | |              |                 | Domotic         |    |
|           | |              |                 | z.Log("Created  |    |
|           | |              |                 | device: "+Devic |    |
|           | |              |                 | es["Power"].Uni |    |
|           | |              |                 | ts[16].Name+ \  |    |
|           | |              |                 |                 |    |
|           | |              |                 |       ", myUnit |    |
|           | |              |                 |  also still poi |    |
|           | |              |                 | nts to the Unit |    |
|           | |              |                 | : "+myDev.Name) |    |
|           | |              |                 | ```             |    |
|           | |              |                 |                 |    |
|           | |              |                 | or              |    |
|           | |              |                 |                 |    |
|           | |              |                 | ``` python3     |    |
|           | |              |                 | DomoticzEx.     |    |
|           | |              |                 | Unit(Name="Kilo |    |
|           | |              |                 |  Watts", Device |    |
|           | |              |                 | ID="Power", Uni |    |
|           | |              |                 | t=16, TypeName= |    |
|           | |              |                 | "kWh").Create() |    |
|           | |              |                 | Domo            |    |
|           | |              |                 | ticz.Log("Creat |    |
|           | |              |                 | ed device: "+De |    |
|           | |              |                 | vices["Power"]. |    |
|           | |              |                 | Units[16].Name) |    |
|           | |              |                 | ```             |    |
|           | |              |                 |                 |    |
|           | |              |                 | \               |    |
|           | +--------------+-----------------+-----------------+    |
|           | | Update       | Applies the     | ``` python3     |    |
|           | |              | Unit\'s current | Devices["       |    |
|           | |              | values to the   | myDevice"].Unit |    |
|           | |              | Domoticz        | [1].nValue = 42 |    |
|           | |              | database.       | Devices["       |    |
|           | |              |                 | myDevice"].Unit |    |
|           | |              | <table>         | [1].sValue = "U |    |
|           | |              | <thead>         | ltimate answer" |    |
|           | |              | <tr             | Devices["myDev  |    |
|           | |              | class="header"> | ice"].Unit[1].U |    |
|           | |              | <th><p>Par      | pdate(Log=True) |    |
|           | |              | ameter</p></th> | ```             |    |
|           | |              | <th><p>Descr    |                 |    |
|           | |              | iption</p></th> |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | </thead>        |                 |    |
|           | |              | <tbody>         |                 |    |
|           | |              | <tr             |                 |    |
|           | |              | class="odd">    |                 |    |
|           | |              | <td>            |                 |    |
|           | |              | <p>Log</p></td> |                 |    |
|           | |              | <               |                 |    |
|           | |              | td><p>Optional, |                 |    |
|           | |              | Boolean,        |                 |    |
|           | |              | Default:        |                 |    |
|           | |              | False During    |                 |    |
|           | |              | the update a    |                 |    |
|           | |              | row will be     |                 |    |
|           | |              | written to      |                 |    |
|           | |              | the log         |                 |    |
|           | |              | table.</p></td> |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | <tr             |                 |    |
|           | |              | class="even">   |                 |    |
|           | |              | <td><p>Ty       |                 |    |
|           | |              | peName</p></td> |                 |    |
|           | |              | <               |                 |    |
|           | |              | td><p>Optional, |                 |    |
|           | |              | String.<br />   |                 |    |
|           | |              | Common device   |                 |    |
|           | |              | types, this     |                 |    |
|           | |              | will set the    |                 |    |
|           | |              | values for      |                 |    |
|           | |              | Type, Subtype   |                 |    |
|           | |              | and             |                 |    |
|           | |              | Switchtype      |                 |    |
|           | |              | prior to the    |                 |    |
|           | |              | database        |                 |    |
|           | |              | update.<br />   |                 |    |
|           | |              | See <a          |                 |    |
|           | |              | href="#Availabl |                 |    |
|           | |              | e_Device_Types" |                 |    |
|           | |              | title="w        |                 |    |
|           | |              | ikilink">#Avail |                 |    |
|           | |              | able_Device_Typ |                 |    |
|           | |              | es</a></p></td> |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | <tr             |                 |    |
|           | |              | class="odd">    |                 |    |
|           | |              | <td></td>       |                 |    |
|           | |              | <td></td>       |                 |    |
|           | |              | </tr>           |                 |    |
|           | |              | </tbody>        |                 |    |
|           | |              | </table>        |                 |    |
|           | |              |                 |                 |    |
|           | |              | If either the   |                 |    |
|           | |              | nValue or       |                 |    |
|           | |              | sValues have    |                 |    |
|           | |              | changed then    |                 |    |
|           | |              | the update      |                 |    |
|           | |              | function will   |                 |    |
|           | |              | signal the      |                 |    |
|           | |              | event and       |                 |    |
|           | |              | notification    |                 |    |
|           | |              | systems         |                 |    |
|           | +--------------+-----------------+-----------------+    |
|           | | Delete       | Parameters:     | Deletes the     |    |
|           | |              | None, acts on   | device in       |    |
|           | |              | current object. | Domoticz.E.g:   |    |
|           | |              | Deleted Units   |                 |    |
|           | |              | are immediately | ` Devices       |    |
|           | |              | removed from    | ["myDevice"].Un |    |
|           | |              | the Devices     | it[1].Delete()` |    |
|           | |              | dictionary but  |                 |    |
|           | |              | local instances | or              |    |
|           | |              | of the object   |                 |    |
|           | |              | are unchanged.  | ` myDev =       |    |
|           | |              |                 |  Devices["myDev |    |
|           | |              |                 | ice"].Unit[1]`\ |    |
|           | |              |                 | `               |    |
|           | |              |                 | myDev.Delete()` |    |
|           | +--------------+-----------------+-----------------+    |
|           | | Refresh      | Parameters:     | ``` python3     |    |
|           | |              | None. Refreshes | Devices         |    |
|           | |              | the values for  | ["myDevice"].Un |    |
|           | |              | the current     | it[1].Refresh() |    |
|           | |              | Unit from the   | ```             |    |
|           | |              | Domoticz        |                 |    |
|           | |              | database.       |                 |    |
|           | |              |                 |                 |    |
|           | |              | Not normally    |                 |    |
|           | |              | required        |                 |    |
|           | |              | because Unit    |                 |    |
|           | |              | values are      |                 |    |
|           | |              | updated when    |                 |    |
|           | |              | callbacks are   |                 |    |
|           | |              | invoked.        |                 |    |
|           | +--------------+-----------------+-----------------+    |
|           | | Touch        | Parameters:     | ``` python3     |    |
|           | |              | None. Updates   | Devic           |    |
|           | |              | the Unit\'s     | es["myDevice"]. |    |
|           | |              | \'last seen\'   | Unit[1].Touch() |    |
|           | |              | time in the     | ```             |    |
|           | |              | database and    |                 |    |
|           | |              | nothing else.   |                 |    |
|           | |              | No events or    |                 |    |
|           | |              | notifications   |                 |    |
|           | |              | are triggered   |                 |    |
|           | |              | as a result of  |                 |    |
|           | |              | touching a      |                 |    |
|           | |              | Unit.           |                 |    |
|           | |              |                 |                 |    |
|           | |              | After the call  |                 |    |
|           | |              | the Unit\'s     |                 |    |
|           | |              | LastUpdate      |                 |    |
|           | |              | field will      |                 |    |
|           | |              | reflect the new |                 |    |
|           | |              | value.          |                 |    |
|           | +--------------+-----------------+-----------------+    |
|           | |              |                 |                 |    |
|           | +--------------+-----------------+-----------------+    |
+-----------+---------------------------------------------------------+
| Callbacks | +---------------------------------------------------+   |
|           | | If defined, these callbacks will be sent to the   |   |
|           | | Unit object rather than to the Device or module   |   |
|           | | level function. Note that the function            |   |
|           | | definitions are different because the API only    |   |
|           | | passes the required parameters so no Device or    |   |
|           | | Unit details are passed.                          |   |
|           | |                                                   |   |
|           | | To define these callback plugin authors need to   |   |
|           | | register a local object that extends the Domoticz |   |
|           | | default. See the Register function in the         |   |
|           | | [#C.2B.2                                          |   |
|           | | B_Callable_API](#C.2B.2B_Callable_API "wikilink") |   |
|           | | section for details                               |   |
|           | |                                                   |   |
|           | | +------------------+--------------------------+   |   |
|           | | | Callback         | Description              |   |   |
|           | | +==================+==========================+   |   |
|           | | | onDeviceAdded    | Parameters: None Called  |   |   |
|           | | |                  | just after a new device  |   |   |
|           | | |                  | has been added to the    |   |   |
|           | | |                  | hardware, for example by |   |   |
|           | | |                  | a Domoticz Web API call. |   |   |
|           | | |                  |                          |   |   |
|           | | |                  | onDeviceAdded is not     |   |   |
|           | | |                  | called when the plugin   |   |   |
|           | | |                  | adds a device by calling |   |   |
|           | | |                  | Create.                  |   |   |
|           | | +------------------+--------------------------+   |   |
|           | | | onDeviceModified | Parameters: None Called  |   |   |
|           | | |                  | just after a device      |   |   |
|           | | |                  | owned by the plugin has  |   |   |
|           | | |                  | been modifed, for        |   |   |
|           | | |                  | example by a Domoticz    |   |   |
|           | | |                  | Web API call.            |   |   |
|           | | |                  |                          |   |   |
|           | | |                  | onDeviceModified is not  |   |   |
|           | | |                  | called when the plugin   |   |   |
|           | | |                  | initiated the change     |   |   |
|           | | |                  | e.g. by calling Update.  |   |   |
|           | | +------------------+--------------------------+   |   |
|           | | | onDeviceRemoved  | Parameters: None Called  |   |   |
|           | | |                  | just before a device     |   |   |
|           | | |                  | owned by the plugin is   |   |   |
|           | | |                  | removed, for example by  |   |   |
|           | | |                  | a Domoticz Web API call. |   |   |
|           | | |                  |                          |   |   |
|           | | |                  | onDeviceRemoved is not   |   |   |
|           | | |                  | called when the plugin   |   |   |
|           | | |                  | removed the device by    |   |   |
|           | | |                  | calling Delete.          |   |   |
|           | | +------------------+--------------------------+   |   |
|           | | | onCommand        | Parameters: Command,     |   |   |
|           | | |                  | Level, Hue Called by     |   |   |
|           | | |                  | Domoticz in response to  |   |   |
|           | | |                  | a script or Domoticz Web |   |   |
|           | | |                  | API call sending a       |   |   |
|           | | |                  | command to the Unit      |   |   |
|           | | +------------------+--------------------------+   |   |
|           | | | onSecurityEvent  | Parameters: Level,       |   |   |
|           | | |                  | Description.             |   |   |
|           | | +------------------+--------------------------+   |   |
|           | |                                                   |   |
|           | | ``` python3                                       |   |
|           | | import DomoticzEx as Domoticz                     |   |
|           | |                                                   |   |
|           | | ...                                               |   |
|           | |                                                   |   |
|           | | class hvacDevice(Domoticz.Device):                |   |
|           | |     def __init__(self, DeviceID):                 |   |
|           | |         super().__init__(DeviceID)                |   |
|           | |                                                   |   |
|           | |     def onDeviceModified(self, Unit):             |   |
|           | |         # This will never be call                 |   |
|           | | ed because the Unit specific version overrides it |   |
|           | |         Domoticz.Log("Device on                   |   |
|           | | DeviceModified for Unit: "+str(self.Units[Unit])) |   |
|           | |                                                   |   |
|           | | class hvacUnit(Domoticz.Unit):                    |   |
|           | |                                                   |   |
|           | |     def __init__(self, Name, DeviceID,            |   |
|           | |  Unit, TypeName="", Type=0, Subtype=0, Switchtype |   |
|           | | =0, Image=0, Options="", Used=0, Description=""): |   |
|           | |         super().__in                              |   |
|           | | it__(Name, DeviceID, Unit, TypeName, Type, Subtyp |   |
|           | | e, Switchtype, Image, Options, Used, Description) |   |
|           | |                                                   |   |
|           | |     def onDeviceAdded(self):                      |   |
|           | |         Domot                                     |   |
|           | | icz.Log("Unit onDeviceAdded for "+str(self.Name)) |   |
|           | |                                                   |   |
|           | |     def onDeviceModified(self):                   |   |
|           | |         Domoticz                                  |   |
|           | | .Log("Unit onDeviceModified for "+str(self.Name)) |   |
|           | |                                                   |   |
|           | |     def onDeviceRemoved(self):                    |   |
|           | |         Domotic                                   |   |
|           | | z.Log("Unit onDeviceRemoved for "+str(self.Name)) |   |
|           | |                                                   |   |
|           | |     def onCommand(self, Command, Level, Hue):     |   |
|           | |         Domoticz.Log("onCom                       |   |
|           | | mand called for '" + str(self.Name)+ "': Paramete |   |
|           | | rs '" + str(Command) + "', Level: " + str(Level)) |   |
|           | |                                                   |   |
|           | |         Command = Command.strip()                 |   |
|           | |                                                   |   |
|           | |      action, sep, params = Command.partition(' ') |   |
|           | |         action = action.capitalize()              |   |
|           | |                                                   |   |
|           | | # Overri                                          |   |
|           | | de the default Domoticz objects with custom ones  |   |
|           | | Do                                                |   |
|           | | moticz.Register(Device=hvacDevice, Unit=hvacUnit) |   |
|           | |                                                   |   |
|           | | def onDeviceModified(self, DeviceID, Unit):       |   |
|           | |     # This will never be call                     |   |
|           | | ed because the Unit specific version overrides it |   |
|           | |     Domoticz.Log("Device onDeviceModified")       |   |
|           | | ```                                               |   |
|           | +---------------------------------------------------+   |
+-----------+---------------------------------------------------------+
|           |                                                         |
+-----------+---------------------------------------------------------+

### Legacy Plugin Framework {#legacy_plugin_framework}

#### Devices {#devices_1}

+---------+-----------------------------------------------------------+
|         | Description                                               |
+=========+===========================================================+
| Key     | Unit. Unit number for the device as specified in the      |
|         | Manifest. Note: Devices can be deleted in Domoticz so not |
|         | all Units specified will necessarily still be present.    |
|         | E.g: `Domoticz.Log(Devices[2].Name)`                      |
|         |                                                           |
|         |   Function       Description                              |
|         |   -------------- --------------------                     |
|         | --------------------------------------------------------- |
|         | --------------------------------------------------------- |
|         |   ID             The Domoticz Device ID                   |
|         |   Name           Current Name in Domoticz                 |
|         |   DeviceID       External device identifier               |
|         |   nValue         Current numeric value                    |
|         |   sValue         Current string value                     |
|         |   SignalLevel    Numeric signal level                     |
|         |   BatteryLevel   Numeric battery level                    |
|         |   Image          Current image number                     |
|         |   Type           Numeric device type                      |
|         |   SubType        Numeric device subtype                   |
|         |   Switchtype     Numeric device switchtype                |
|         |   Used           Device Used flag. 1=True, 0=False        |
|         |   Options        Current Device options dictionary        |
|         |   TimedOut       Device TimedOut flag. 1=True, 0=False    |
|         |   LastLevel      Last level as reported by Domoticz       |
|         |   LastUpdate                                              |
|         |    Timestamp of the last update, e.g: 2017-01-22 01:21:11 |
|         |   Description    Description of t                         |
|         | he device, visible in \"Edit\" dialog in Domoticz Web UI. |
|         |   Color          Current color, see                       |
|         |  documentation of [onCommand callback](Developing_a_Pytho |
|         | n_plugin#Callbacks "wikilink") for details on the format. |
|         |                                                           |
+---------+-----------------------------------------------------------+
| Methods | Per device calls into Domoticz to manipulate specific     |
|         | devices                                                   |
|         |                                                           |
|         | +--------------+------------------+------------------+    |
|         | | Function     | Description      | Example          |    |
|         | +==============+==================+==================+    |
|         | | \_\_init\_\_ | <table>          | Both positional  |    |
|         | |              | <thead>          | and named        |    |
|         | |              | <tr              | parameters are   |    |
|         | |              | class="header">  | supported.\      |    |
|         | |              | <th><p>Pa        | Creates a new    |    |
|         | |              | rameter</p></th> | device object in |    |
|         | |              | <th><p>Desc      | Python. E.g:     |    |
|         | |              | ription</p></th> |                  |    |
|         | |              | </tr>            | ` myDev1 = Do    |    |
|         | |              | </thead>         | moticz.Device("T |    |
|         | |              | <tbody>          | otal", 1, 113)`\ |    |
|         | |              | <tr              | ` myDe           |    |
|         | |              | class="odd">     | v2 = Domoticz.De |    |
|         | |              | <td>             | vice(Name="My Co |    |
|         | |              | <p>Name</p></td> | unter", Unit=2,  |    |
|         | |              | <td><p>          | TypeName="Counte |    |
|         | |              | Mandatory.<br /> | r Incremental")` |    |
|         | |              | Is appended to   |                  |    |
|         | |              | the Hardware     | or               |    |
|         | |              | name to set      |                  |    |
|         | |              | the initial      | ` i              |    |
|         | |              | Domoticz         | mport Domoticz`\ |    |
|         | |              | Device           | ` #`\            |    |
|         | |              | name.<br />      | `                |    |
|         | |              | This should      | def onStart():`\ |    |
|         | |              | not be used in   | `   if (len(D    |    |
|         | |              | Python because   | evices) == 0):`\ |    |
|         | |              | it can be        | `                |    |
|         | |              | changed in the   |       Domoticz.D |    |
|         | |              | Web              | evice(Name="Stat |    |
|         | |              | UI.</p></td>     | us",  Unit=1, Ty |    |
|         | |              | </tr>            | pe=17,  Switchty |    |
|         | |              | <tr              | pe=17).Create()` |    |
|         | |              | class="even">    |                  |    |
|         | |              | <td>             | Options =        |    |
|         | |              | <p>Unit</p></td> | {\               |    |
|         | |              | <td><p>          | "LevelActions\": |    |
|         | |              | Mandatory.<br /> | \"               |    |
|         | |              | Plugin index     |                  |    |
|         | |              | for the          |                  |    |
|         | |              | Device. This     |                  |    |
|         | |              | can not change   |                  |    |
|         | |              | and should be    |                  |    |
|         | |              | used reference   |                  |    |
|         | |              | Domoticz         |                  |    |
|         | |              | devices          |                  |    |
|         | |              | associated       |                  |    |
|         | |              | with the         |                  |    |
|         | |              | plugin. This     |                  |    |
|         | |              | is also the      |                  |    |
|         | |              | key for the      |                  |    |
|         | |              | Devices          |                  |    |
|         | |              | Dictionary       |                  |    |
|         | |              | that Domoticz    |                  |    |
|         | |              | prepopulates     |                  |    |
|         | |              | for the          |                  |    |
|         | |              | plugin.<br />    |                  |    |
|         | |              | Unit numbers     |                  |    |
|         | |              | must be less     |                  |    |
|         | |              | than             |                  |    |
|         | |              | 256.</p></td>    |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td><p>T         |                  |    |
|         | |              | ypeName</p></td> |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >Optional.<br /> |                  |    |
|         | |              | Common device    |                  |    |
|         | |              | types, this      |                  |    |
|         | |              | will set the     |                  |    |
|         | |              | values for       |                  |    |
|         | |              | Type, Subtype    |                  |    |
|         | |              | and              |                  |    |
|         | |              | S                |                  |    |
|         | |              | witchtype.<br /> |                  |    |
|         | |              | See <a           |                  |    |
|         | |              | href="#Availab   |                  |    |
|         | |              | le_Device_Types" |                  |    |
|         | |              | title            |                  |    |
|         | |              | ="wikilink">#Ava |                  |    |
|         | |              | ilable_Device_Ty |                  |    |
|         | |              | pes</a></p></td> |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="even">    |                  |    |
|         | |              | <td>             |                  |    |
|         | |              | <p>Type</p></td> |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >Optional.<br /> |                  |    |
|         | |              | Directly set     |                  |    |
|         | |              | the numeric      |                  |    |
|         | |              | Type value.      |                  |    |
|         | |              | Should only be   |                  |    |
|         | |              | used if the      |                  |    |
|         | |              | Device to be     |                  |    |
|         | |              | created is not   |                  |    |
|         | |              | supported by     |                  |    |
|         | |              | Ty               |                  |    |
|         | |              | peName.</p></td> |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td><p>          |                  |    |
|         | |              | Subtype</p></td> |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >Optional.<br /> |                  |    |
|         | |              | Directly set     |                  |    |
|         | |              | the numeric      |                  |    |
|         | |              | Subtype value.   |                  |    |
|         | |              | Should only be   |                  |    |
|         | |              | used if the      |                  |    |
|         | |              | Device to be     |                  |    |
|         | |              | created is not   |                  |    |
|         | |              | supported by     |                  |    |
|         | |              | Ty               |                  |    |
|         | |              | peName.</p></td> |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="even">    |                  |    |
|         | |              | <td><p>Swi       |                  |    |
|         | |              | tchtype</p></td> |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >Optional.<br /> |                  |    |
|         | |              | Directly set     |                  |    |
|         | |              | the numeric      |                  |    |
|         | |              | Switchtype       |                  |    |
|         | |              | value. Should    |                  |    |
|         | |              | only be used     |                  |    |
|         | |              | if the Device    |                  |    |
|         | |              | to be created    |                  |    |
|         | |              | is not           |                  |    |
|         | |              | supported by     |                  |    |
|         | |              | Ty               |                  |    |
|         | |              | peName.</p></td> |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td><            |                  |    |
|         | |              | p>Image</p></td> |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >Optional.<br /> |                  |    |
|         | |              | Set the image    |                  |    |
|         | |              | number to be     |                  |    |
|         | |              | used with the    |                  |    |
|         | |              | device. Only     |                  |    |
|         | |              | required to      |                  |    |
|         | |              | override the     |                  |    |
|         | |              | default.<br />   |                  |    |
|         | |              | All images       |                  |    |
|         | |              | available by     |                  |    |
|         | |              | JSON API call    |                  |    |
|         | |              | "/json.htm?t     |                  |    |
|         | |              | ype=custom_light |                  |    |
|         | |              | _icons"</p></td> |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="even">    |                  |    |
|         | |              | <td><p>          |                  |    |
|         | |              | Options</p></td> |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >Optional.<br /> |                  |    |
|         | |              | Set the Device   |                  |    |
|         | |              | Options field.   |                  |    |
|         | |              | A few devices,   |                  |    |
|         | |              | like Selector    |                  |    |
|         | |              | Switches,        |                  |    |
|         | |              | require          |                  |    |
|         | |              | additional       |                  |    |
|         | |              | details to be    |                  |    |
|         | |              | set in this      |                  |    |
|         | |              | field. It is a   |                  |    |
|         | |              | Python           |                  |    |
|         | |              | dictionary       |                  |    |
|         | |              | consisting of    |                  |    |
|         | |              | key values       |                  |    |
|         | |              | pairs, where     |                  |    |
|         | |              | the keys and     |                  |    |
|         | |              | values must be   |                  |    |
|         | |              | strings. See     |                  |    |
|         | |              | the example to   |                  |    |
|         | |              | the              |                  |    |
|         | |              | right.</p></td>  |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td>             |                  |    |
|         | |              | <p>Used</p></td> |                  |    |
|         | |              | <td><            |                  |    |
|         | |              | p>Optional<br /> |                  |    |
|         | |              | Values<br />     |                  |    |
|         | |              | 0 (default)      |                  |    |
|         | |              | Unused<br />     |                  |    |
|         | |              | 1 Used.<br />    |                  |    |
|         | |              | Set the Device   |                  |    |
|         | |              | Used field.      |                  |    |
|         | |              | Used devices     |                  |    |
|         | |              | appear in the    |                  |    |
|         | |              | appropriate      |                  |    |
|         | |              | tab(s), unused   |                  |    |
|         | |              | devices appear   |                  |    |
|         | |              | only in the      |                  |    |
|         | |              | Devices page     |                  |    |
|         | |              | and must be      |                  |    |
|         | |              | manually         |                  |    |
|         | |              | marked as        |                  |    |
|         | |              | Used.</p></td>   |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="even">    |                  |    |
|         | |              | <td><p>D         |                  |    |
|         | |              | eviceID</p></td> |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >Optional.<br /> |                  |    |
|         | |              | Set the          |                  |    |
|         | |              | DeviceID to be   |                  |    |
|         | |              | used with the    |                  |    |
|         | |              | device. Only     |                  |    |
|         | |              | required to      |                  |    |
|         | |              | override the     |                  |    |
|         | |              | default which    |                  |    |
|         | |              | is and eight     |                  |    |
|         | |              | digit number     |                  |    |
|         | |              | dervice from     |                  |    |
|         | |              | the HardwareID   |                  |    |
|         | |              | and the Unit     |                  |    |
|         | |              | number in the    |                  |    |
|         | |              | format           |                  |    |
|         | |              | "                |                  |    |
|         | |              | 000H000U".<br /> |                  |    |
|         | |              | Field type is    |                  |    |
|         | |              | Varc             |                  |    |
|         | |              | har(25)</p></td> |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td></td>        |                  |    |
|         | |              | <td></td>        |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | </tbody>         |                  |    |
|         | |              | </table>         |                  |    |
|         | +--------------+------------------+------------------+    |
|         | | Create       | Parameters:      | Creates the      |    |
|         | |              | None, acts on    | device in        |    |
|         | |              | current object.  | Domoticz from    |    |
|         | |              |                  | the object. E.g: |    |
|         | |              |                  |                  |    |
|         | |              |                  | ` myDev          |    |
|         | |              |                  |  = Domoticz.Devi |    |
|         | |              |                  | ce(Name="Kilo Wa |    |
|         | |              |                  | tts", Unit=16, T |    |
|         | |              |                  | ypeName="kWh")`\ |    |
|         | |              |                  | `                |    |
|         | |              |                  | myDev.Create()`\ |    |
|         | |              |                  | ` Domot          |    |
|         | |              |                  | icz.Log("Created |    |
|         | |              |                  |  device: "+Devic |    |
|         | |              |                  | es[16].Name+ \`\ |    |
|         | |              |                  | `                |    |
|         | |              |                  |               ", |    |
|         | |              |                  |  myDev also poin |    |
|         | |              |                  | ts to the Device |    |
|         | |              |                  | : "+myDev.Name)` |    |
|         | |              |                  |                  |    |
|         | |              |                  | or               |    |
|         | |              |                  |                  |    |
|         | |              |                  | ` Domoti         |    |
|         | |              |                  | cz.Device(Name=" |    |
|         | |              |                  | Kilo Watts", Uni |    |
|         | |              |                  | t=16, TypeName=" |    |
|         | |              |                  | kWh").Create()`\ |    |
|         | |              |                  | ` Do             |    |
|         | |              |                  | moticz.Log("Crea |    |
|         | |              |                  | ted device: "+De |    |
|         | |              |                  | vices[16].Name)` |    |
|         | |              |                  |                  |    |
|         | |              |                  | Successfully     |    |
|         | |              |                  | created devices  |    |
|         | |              |                  | are immediately  |    |
|         | |              |                  | added to the     |    |
|         | |              |                  | Devices          |    |
|         | |              |                  | dictionary.      |    |
|         | +--------------+------------------+------------------+    |
|         | | Update       | Updates the      | Both positional  |    |
|         | |              | current values   | and named        |    |
|         | |              | in Domoticz.     | parameters are   |    |
|         | |              |                  | supported. E.g   |    |
|         | |              | <table>          |                  |    |
|         | |              | <thead>          | ` Devices[1].    |    |
|         | |              | <tr              | Update(1,”10”)`\ |    |
|         | |              | class="header">  | `                |    |
|         | |              | <th><p>Pa        | Devices[Unit].Up |    |
|         | |              | rameter</p></th> | date(nValue=nVal |    |
|         | |              | <th><p>Desc      | ue, sValue=str(s |    |
|         | |              | ription</p></th> | Value), SignalLe |    |
|         | |              | </tr>            | vel=5, Image=8)` |    |
|         | |              | </thead>         |                  |    |
|         | |              | <tbody>          |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >nValue</p></td> |                  |    |
|         | |              | <                |                  |    |
|         | |              | td><p>Mandatory. |                  |    |
|         | |              | The Numerical    |                  |    |
|         | |              | device           |                  |    |
|         | |              | value</p></td>   |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="even">    |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >sValue</p></td> |                  |    |
|         | |              | <                |                  |    |
|         | |              | td><p>Mandatory. |                  |    |
|         | |              | The string       |                  |    |
|         | |              | device           |                  |    |
|         | |              | value</p></td>   |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td><            |                  |    |
|         | |              | p>Image</p></td> |                  |    |
|         | |              | <td><p>Optional. |                  |    |
|         | |              | Numeric custom   |                  |    |
|         | |              | image            |                  |    |
|         | |              | number</p></td>  |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="even">    |                  |    |
|         | |              | <td><p>Sign      |                  |    |
|         | |              | alLevel</p></td> |                  |    |
|         | |              | <td><p>Optional. |                  |    |
|         | |              | Device signal    |                  |    |
|         | |              | strength,        |                  |    |
|         | |              | default          |                  |    |
|         | |              | 12</p></td>      |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td><p>Batte     |                  |    |
|         | |              | ryLevel</p></td> |                  |    |
|         | |              | <td><p>Optional. |                  |    |
|         | |              | Device battery   |                  |    |
|         | |              | strength,        |                  |    |
|         | |              | default          |                  |    |
|         | |              | 255</p></td>     |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="even">    |                  |    |
|         | |              | <td><p>          |                  |    |
|         | |              | Options</p></td> |                  |    |
|         | |              | <td><p>Optional. |                  |    |
|         | |              | Dictionary of    |                  |    |
|         | |              | device           |                  |    |
|         | |              | options,         |                  |    |
|         | |              | default is       |                  |    |
|         | |              | empty            |                  |    |
|         | |              | {}</p></td>      |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td><p>T         |                  |    |
|         | |              | imedOut</p></td> |                  |    |
|         | |              | <td><p>Optional. |                  |    |
|         | |              | Numeric field    |                  |    |
|         | |              | where 0          |                  |    |
|         | |              | (false) is not   |                  |    |
|         | |              | timed out and    |                  |    |
|         | |              | other value      |                  |    |
|         | |              | marks the        |                  |    |
|         | |              | device as        |                  |    |
|         | |              | timed out,       |                  |    |
|         | |              | default is       |                  |    |
|         | |              | 0.<br />         |                  |    |
|         | |              | Timed out        |                  |    |
|         | |              | devices show     |                  |    |
|         | |              | with a red       |                  |    |
|         | |              | header in the    |                  |    |
|         | |              | Domoticz web     |                  |    |
|         | |              | UI.</p></td>     |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="even">    |                  |    |
|         | |              | <td>             |                  |    |
|         | |              | <p>Name</p></td> |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >Optional.<br /> |                  |    |
|         | |              | Is appended to   |                  |    |
|         | |              | the Hardware     |                  |    |
|         | |              | name to set      |                  |    |
|         | |              | the initial      |                  |    |
|         | |              | Domoticz         |                  |    |
|         | |              | Device           |                  |    |
|         | |              | name.<br />      |                  |    |
|         | |              | This should      |                  |    |
|         | |              | not be used in   |                  |    |
|         | |              | Python because   |                  |    |
|         | |              | it can be        |                  |    |
|         | |              | changed in the   |                  |    |
|         | |              | Web              |                  |    |
|         | |              | UI.</p></td>     |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td><p>T         |                  |    |
|         | |              | ypeName</p></td> |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >Optional.<br /> |                  |    |
|         | |              | Common device    |                  |    |
|         | |              | types, this      |                  |    |
|         | |              | will set the     |                  |    |
|         | |              | values for       |                  |    |
|         | |              | Type, Subtype    |                  |    |
|         | |              | and              |                  |    |
|         | |              | S                |                  |    |
|         | |              | witchtype.<br /> |                  |    |
|         | |              | See <a           |                  |    |
|         | |              | href="#Availab   |                  |    |
|         | |              | le_Device_Types" |                  |    |
|         | |              | title            |                  |    |
|         | |              | ="wikilink">#Ava |                  |    |
|         | |              | ilable_Device_Ty |                  |    |
|         | |              | pes</a></p></td> |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="even">    |                  |    |
|         | |              | <td>             |                  |    |
|         | |              | <p>Type</p></td> |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >Optional.<br /> |                  |    |
|         | |              | Directly set     |                  |    |
|         | |              | the numeric      |                  |    |
|         | |              | Type value.      |                  |    |
|         | |              | Should only be   |                  |    |
|         | |              | used if the      |                  |    |
|         | |              | Device to be     |                  |    |
|         | |              | created is not   |                  |    |
|         | |              | supported by     |                  |    |
|         | |              | Ty               |                  |    |
|         | |              | peName.</p></td> |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td><p>          |                  |    |
|         | |              | Subtype</p></td> |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >Optional.<br /> |                  |    |
|         | |              | Directly set     |                  |    |
|         | |              | the numeric      |                  |    |
|         | |              | Subtype value.   |                  |    |
|         | |              | Should only be   |                  |    |
|         | |              | used if the      |                  |    |
|         | |              | Device to be     |                  |    |
|         | |              | created is not   |                  |    |
|         | |              | supported by     |                  |    |
|         | |              | Ty               |                  |    |
|         | |              | peName.</p></td> |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="even">    |                  |    |
|         | |              | <td><p>Swi       |                  |    |
|         | |              | tchtype</p></td> |                  |    |
|         | |              | <td><p           |                  |    |
|         | |              | >Optional.<br /> |                  |    |
|         | |              | Directly set     |                  |    |
|         | |              | the numeric      |                  |    |
|         | |              | Switchtype       |                  |    |
|         | |              | value. Should    |                  |    |
|         | |              | only be used     |                  |    |
|         | |              | if the Device    |                  |    |
|         | |              | to be created    |                  |    |
|         | |              | is not           |                  |    |
|         | |              | supported by     |                  |    |
|         | |              | Ty               |                  |    |
|         | |              | peName.</p></td> |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td>             |                  |    |
|         | |              | <p>Used</p></td> |                  |    |
|         | |              | <td><            |                  |    |
|         | |              | p>Optional<br /> |                  |    |
|         | |              | Values<br />     |                  |    |
|         | |              | 0 (default)      |                  |    |
|         | |              | Unused<br />     |                  |    |
|         | |              | 1 Used.<br />    |                  |    |
|         | |              | Set the Device   |                  |    |
|         | |              | Used field.      |                  |    |
|         | |              | Used devices     |                  |    |
|         | |              | appear in the    |                  |    |
|         | |              | appropriate      |                  |    |
|         | |              | tab(s), unused   |                  |    |
|         | |              | devices appear   |                  |    |
|         | |              | only in the      |                  |    |
|         | |              | Devices page     |                  |    |
|         | |              | and must be      |                  |    |
|         | |              | manually         |                  |    |
|         | |              | marked as        |                  |    |
|         | |              | Used.</p></td>   |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="even">    |                  |    |
|         | |              | <td><p>Desc      |                  |    |
|         | |              | ription</p></td> |                  |    |
|         | |              | <td><            |                  |    |
|         | |              | p>Optional<br /> |                  |    |
|         | |              | </p></td>        |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td><            |                  |    |
|         | |              | p>Color</p></td> |                  |    |
|         | |              | <td><            |                  |    |
|         | |              | p>Optional<br /> |                  |    |
|         | |              | Current color,   |                  |    |
|         | |              | see              |                  |    |
|         | |              | documentation    |                  |    |
|         | |              | of <a            |                  |    |
|         | |              | href="Devel      |                  |    |
|         | |              | oping_a_Python_p |                  |    |
|         | |              | lugin#Callbacks" |                  |    |
|         | |              | title="wik       |                  |    |
|         | |              | ilink">onCommand |                  |    |
|         | |              | callback</a>     |                  |    |
|         | |              | for details on   |                  |    |
|         | |              | the              |                  |    |
|         | |              | format.</p></td> |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="even">    |                  |    |
|         | |              | <td><p>SuppressT |                  |    |
|         | |              | riggers</p></td> |                  |    |
|         | |              | <td><            |                  |    |
|         | |              | p>Optional<br /> |                  |    |
|         | |              | Default: False   |                  |    |
|         | |              | Boolean flag     |                  |    |
|         | |              | that allows      |                  |    |
|         | |              | device           |                  |    |
|         | |              | attributes to    |                  |    |
|         | |              | be updated       |                  |    |
|         | |              | without          |                  |    |
|         | |              | notifications,   |                  |    |
|         | |              | scene or MQTT,   |                  |    |
|         | |              | event            |                  |    |
|         | |              | triggers.        |                  |    |
|         | |              | nValue and       |                  |    |
|         | |              | sValue are not   |                  |    |
|         | |              | written to the   |                  |    |
|         | |              | database and     |                  |    |
|         | |              | will be          |                  |    |
|         | |              | overwritten      |                  |    |
|         | |              | with current     |                  |    |
|         | |              | database         |                  |    |
|         | |              | values.</p></td> |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | <tr              |                  |    |
|         | |              | class="odd">     |                  |    |
|         | |              | <td></td>        |                  |    |
|         | |              | <td></td>        |                  |    |
|         | |              | </tr>            |                  |    |
|         | |              | </tbody>         |                  |    |
|         | |              | </table>         |                  |    |
|         | +--------------+------------------+------------------+    |
|         | | Delete       | Parameters:      | Deletes the      |    |
|         | |              | None, acts on    | device in        |    |
|         | |              | current object.  | Domoticz.E.g:    |    |
|         | |              |                  |                  |    |
|         | |              |                  | ` Devi           |    |
|         | |              |                  | ces[1].Delete()` |    |
|         | |              |                  |                  |    |
|         | |              |                  | or               |    |
|         | |              |                  |                  |    |
|         | |              |                  | ` myDe           |    |
|         | |              |                  | v = Devices[2]`\ |    |
|         | |              |                  | `                |    |
|         | |              |                  |  myDev.Delete()` |    |
|         | |              |                  |                  |    |
|         | |              |                  | Deleted devices  |    |
|         | |              |                  | are immediately  |    |
|         | |              |                  | removed from the |    |
|         | |              |                  | Devices          |    |
|         | |              |                  | dictionary but   |    |
|         | |              |                  | local instances  |    |
|         | |              |                  | of the object    |    |
|         | |              |                  | are unchanged.   |    |
|         | +--------------+------------------+------------------+    |
|         | | Refresh      | Parameters:      | Refreshes the    |    |
|         | |              | None.            | values for the   |    |
|         | |              |                  | device from the  |    |
|         | |              |                  | Domoticz         |    |
|         | |              |                  | database. Not    |    |
|         | |              |                  | normally         |    |
|         | |              |                  | required because |    |
|         | |              |                  | device values    |    |
|         | |              |                  | are updated when |    |
|         | |              |                  | callbacks are    |    |
|         | |              |                  | invoked.         |    |
|         | +--------------+------------------+------------------+    |
|         | | Touch        | Parameters:      | Updates the      |    |
|         | |              | None.            | Device\'s \'last |    |
|         | |              |                  | seen\' time and  |    |
|         | |              |                  | nothing else. No |    |
|         | |              |                  | events or        |    |
|         | |              |                  | notifications    |    |
|         | |              |                  | are triggered as |    |
|         | |              |                  | a result of      |    |
|         | |              |                  | touching a       |    |
|         | |              |                  | Device. After    |    |
|         | |              |                  | the call the     |    |
|         | |              |                  | Device\'s        |    |
|         | |              |                  | LastUpdate field |    |
|         | |              |                  | will reflect the |    |
|         | |              |                  | new value.       |    |
|         | +--------------+------------------+------------------+    |
|         | |              |                  |                  |    |
|         | +--------------+------------------+------------------+    |
+---------+-----------------------------------------------------------+
|         |                                                           |
+---------+-----------------------------------------------------------+

### Available Device Types {#available_device_types}

Filling is in progress, table doesn\'t contain full available list yet.
Look at the [Domoticz API/JSON page section Update
Devices](Domoticz_API/JSON_URL's "wikilink") for more background
information.

+------+-------------------+-------------------+-------------------+
| Type | Subtype           | TypeName          | Description       |
+======+===================+===================+===================+
| ID   | Name              | ID                | Name              |
+------+-------------------+-------------------+-------------------+
| 17   | Lighting 2        |                   |                   |
+------+-------------------+-------------------+-------------------+
| 80   | Temp              | 5                 | LaCrosse TX3      |
+------+-------------------+-------------------+-------------------+
| 81   | Humidity          | 1                 | LaCrosse TX3      |
+------+-------------------+-------------------+-------------------+
| 82   | Temp+Hum          | 1                 | LaCrosse TX3      |
+------+-------------------+-------------------+-------------------+
| 84   | Temp+Hum+Baro     | 1                 | THB1 - BTHR918,   |
|      |                   |                   | BTHGN129          |
+------+-------------------+-------------------+-------------------+
|      |                   | 2                 | THB2 - BTHR918N,  |
|      |                   |                   | BTHR968           |
+------+-------------------+-------------------+-------------------+
| 16   | Weather Station   |                   |                   |
+------+-------------------+-------------------+-------------------+
| 85   | Rain              | 1                 |                   |
+------+-------------------+-------------------+-------------------+
| 86   | Wind              | 1                 |                   |
+------+-------------------+-------------------+-------------------+
|      | 4                 |                   | Wind+Temp+Chill   |
+------+-------------------+-------------------+-------------------+
| 87   | UV                | 1                 |                   |
+------+-------------------+-------------------+-------------------+
| 89   | Current           | 1                 |                   |
+------+-------------------+-------------------+-------------------+
| 93   | Scale             | 1                 | Weight            |
+------+-------------------+-------------------+-------------------+
| 113  | Counter           | 0                 |                   |
+------+-------------------+-------------------+-------------------+
| 241  | Color Switch      | 1                 | RGBW              |
+------+-------------------+-------------------+-------------------+
|      |                   | 2                 | RGB               |
+------+-------------------+-------------------+-------------------+
| 3    | White             |                   | Monochrome white  |
+------+-------------------+-------------------+-------------------+
| 4    | RGBWW             |                   | RGB + cold        |
|      |                   |                   | white + warm      |
|      |                   |                   | white, either RGB |
|      |                   |                   | or white can be   |
|      |                   |                   | lit               |
+------+-------------------+-------------------+-------------------+
| 6    | RGBWZ             |                   | Like RGBW, but    |
|      |                   |                   | allows combining  |
|      |                   |                   | RGB and white     |
+------+-------------------+-------------------+-------------------+
| 7    | RGBWWZ            |                   | Like RGBWW, but   |
|      |                   |                   | allows combining  |
|      |                   |                   | RGB and white     |
+------+-------------------+-------------------+-------------------+
| 8    | Cold white + Warm |                   |                   |
|      | white             |                   |                   |
+------+-------------------+-------------------+-------------------+
| 242  | Thermostat        | 1                 | Setpoint          |
+------+-------------------+-------------------+-------------------+
| 243  | General           | 1                 | Visibility        |
+------+-------------------+-------------------+-------------------+
|      |                   | 2                 | Solar Radiation   |
+------+-------------------+-------------------+-------------------+
| 3    | Soil Moisture     | Soil Moisture     |                   |
+------+-------------------+-------------------+-------------------+
| 4    | Leaf Wetness      | Leaf Wetness      |                   |
+------+-------------------+-------------------+-------------------+
| 6    | Percentage        | Percentage        |                   |
+------+-------------------+-------------------+-------------------+
| 8    | Voltage           | Voltage           |                   |
+------+-------------------+-------------------+-------------------+
| 9    | Pressure          | Pressure          |                   |
+------+-------------------+-------------------+-------------------+
| 19   | Text              | Text              |                   |
+------+-------------------+-------------------+-------------------+
| 22   | Alert             | Alert             |                   |
+------+-------------------+-------------------+-------------------+
| 23   | Ampere (1 Phase)  | Current (Single)  |                   |
+------+-------------------+-------------------+-------------------+
| 24   | Sound Level       | Sound Level       |                   |
+------+-------------------+-------------------+-------------------+
| 26   | Barometer         | Barometer         | nValue: 0,        |
|      |                   |                   | sValue:           |
|      |                   |                   | \"pre             |
|      |                   |                   | ssure;forecast\"\ |
|      |                   |                   | Forecast:\        |
|      |                   |                   | 0 - Stable\       |
|      |                   |                   | 1 - Sunny\        |
|      |                   |                   | 2 - Cloudy\       |
|      |                   |                   | 3 - Unstable\     |
|      |                   |                   | 4 - Thunderstorm\ |
|      |                   |                   | 5 - Unknown\      |
|      |                   |                   | 6 - Cloudy/Rain   |
+------+-------------------+-------------------+-------------------+
| 27   | Distance          | Distance          |                   |
+------+-------------------+-------------------+-------------------+
| 28   | Counter           | Counter           | Incremental       |
|      | Incremental       | Incremental       | counter used to   |
|      |                   |                   | measure energy    |
|      |                   |                   | (used or          |
|      |                   |                   | produced), gas,   |
|      |                   |                   | water. Does not   |
|      |                   |                   | compute the power |
|      |                   |                   | or flow rate.     |
|      |                   |                   | nValue=0,         |
|      |                   |                   | sValu             |
|      |                   |                   | e=INCREMENT_VALUE |
|      |                   |                   | to increase       |
|      |                   |                   | counter by        |
|      |                   |                   | INCREMENT_VALUE,  |
|      |                   |                   | or                |
|      |                   |                   | sVal              |
|      |                   |                   | ue=NEGATIVE_VALUE |
|      |                   |                   | to reset the      |
|      |                   |                   | counter.          |
|      |                   |                   |                   |
|      |                   |                   | Additional        |
|      |                   |                   | attribute         |
|      |                   |                   | Switchtype is     |
|      |                   |                   | applicable        |
|      |                   |                   |                   |
|      |                   |                   |   ID   Name       |
|      |                   |                   |   ---- -          |
|      |                   |                   | ----------------- |
|      |                   |                   |   0    Energy     |
|      |                   |                   |   1    Gas        |
|      |                   |                   |   2    Water      |
|      |                   |                   |   3    Counter    |
|      |                   |                   |   4               |
|      |                   |                   |  Energy Generated |
|      |                   |                   |   5    Time       |
+------+-------------------+-------------------+-------------------+
| 29   | kWh               | kWh               | Electric          |
|      |                   |                   | (                 |
|      |                   |                   | Instant+Counter)\ |
|      |                   |                   | nValue should be  |
|      |                   |                   | zero\             |
|      |                   |                   | sValue are two    |
|      |                   |                   | numbers separated |
|      |                   |                   | by semicolon like |
|      |                   |                   | \"123;123456\"    |
|      |                   |                   | The first number  |
|      |                   |                   | is the actual     |
|      |                   |                   | power in Watt,    |
|      |                   |                   | the second number |
|      |                   |                   | is actual energy  |
|      |                   |                   | in kWh. When the  |
|      |                   |                   | option            |
|      |                   |                   | \"                |
|      |                   |                   | EnergyMeterMode\" |
|      |                   |                   | is set to         |
|      |                   |                   | \"Calculated\",   |
|      |                   |                   | the second value  |
|      |                   |                   | is ignored\       |
|      |                   |                   | Optional argument |
|      |                   |                   | Options can set   |
|      |                   |                   | the               |
|      |                   |                   | EnergyMeterMode.\ |
|      |                   |                   | Use               |
|      |                   |                   | Options={\'E      |
|      |                   |                   | nergyMeterMode\': |
|      |                   |                   | \'1\' } to set    |
|      |                   |                   | energyMeterMode   |
|      |                   |                   | to                |
|      |                   |                   | \"Calculated\".   |
|      |                   |                   | Default is \"From |
|      |                   |                   | Device\"          |
+------+-------------------+-------------------+-------------------+
| 30   | Waterflow         | Waterflow         |                   |
+------+-------------------+-------------------+-------------------+
| 31   | Custom Sensor     | Custom            | nValue: 0,        |
|      |                   |                   | sValue:           |
|      |                   |                   | \"floatValue\",   |
|      |                   |                   | Options:          |
|      |                   |                   | {\'Custom\':      |
|      |                   |                   | \'1;`<axis        |
|      |                   |                   | Units>`{=html}\'} |
+------+-------------------+-------------------+-------------------+
| 33   | Managed counter   |                   | nValue is always  |
|      |                   |                   | 0\                |
|      |                   |                   | sValue must be 2  |
|      |                   |                   | semicolon         |
|      |                   |                   | separated values  |
|      |                   |                   | to update         |
|      |                   |                   | Dashboard, for    |
|      |                   |                   | instance          |
|      |                   |                   | \"123456;78\",    |
|      |                   |                   | 123456 being the  |
|      |                   |                   | absolute counter  |
|      |                   |                   | value, 78 being   |
|      |                   |                   | the usage (Wh).   |
|      |                   |                   | Set counter to -1 |
|      |                   |                   | if you can\'t     |
|      |                   |                   | know the counter  |
|      |                   |                   | absolute value\   |
|      |                   |                   | sValue must 3     |
|      |                   |                   | semicolon         |
|      |                   |                   | separated values, |
|      |                   |                   | the last value    |
|      |                   |                   | being a date      |
|      |                   |                   | (\"%Y-%m-%d\"     |
|      |                   |                   | format) to update |
|      |                   |                   | last              |
|      |                   |                   | week/month/year   |
|      |                   |                   | history, for      |
|      |                   |                   | instance          |
|      |                   |                   | \"123456          |
|      |                   |                   | ;78;2019-09-24\"\ |
|      |                   |                   | sValue must 3     |
|      |                   |                   | semicolon         |
|      |                   |                   | separated values, |
|      |                   |                   | the last value    |
|      |                   |                   | being a date a    |
|      |                   |                   | space and a time  |
|      |                   |                   | (\"%Y-%m-%d       |
|      |                   |                   | %H:%M:%S\"        |
|      |                   |                   | format) to update |
|      |                   |                   | last days         |
|      |                   |                   | history, for      |
|      |                   |                   | instance          |
|      |                   |                   | \"123             |
|      |                   |                   | 456;78;2019-10-03 |
|      |                   |                   | 14:55:00\"\       |
|      |                   |                   | \                 |
|      |                   |                   | Additional        |
|      |                   |                   | attribute         |
|      |                   |                   | Switchtype is     |
|      |                   |                   | applicable        |
|      |                   |                   |                   |
|      |                   |                   |   ID   Name       |
|      |                   |                   |   ---- -          |
|      |                   |                   | ----------------- |
|      |                   |                   |   0    Energy     |
|      |                   |                   |   1    Gas        |
|      |                   |                   |   2    Water      |
|      |                   |                   |   3    Counter    |
|      |                   |                   |   4               |
|      |                   |                   |  Energy Generated |
|      |                   |                   |   5    Time       |
+------+-------------------+-------------------+-------------------+
| 244  | Light/Switch      | 62                | Selector Switch   |
+------+-------------------+-------------------+-------------------+
| 73   | Switch            | Check: Additional |                   |
|      |                   | attribute         |                   |
|      |                   | Switchtype        |                   |
+------+-------------------+-------------------+-------------------+
| 246  | Lux               | 1                 | Lux               |
+------+-------------------+-------------------+-------------------+
| 247  | Temp+Baro         | 1                 | LaCrosse TX3      |
+------+-------------------+-------------------+-------------------+
| 248  | Usage             | 1                 | Electric          |
+------+-------------------+-------------------+-------------------+
| 249  | Air Quality       | 1                 |                   |
+------+-------------------+-------------------+-------------------+
| 250  | P1 Smart Meter    | 1                 | Energy            |
+------+-------------------+-------------------+-------------------+
| 251  | P1 Smart Meter    | 2                 | Gas               |
+------+-------------------+-------------------+-------------------+

\
====Note on counters==== Usually, counters are updated daily to feed
week/month/year history log views. Starting version 4.11774, if you want
to disable that behavior to control everything from an external script
or a plugin (already the case for managed counter), you can set the
\"DisableLogAutoUpdate\" device option to \"true\", for instance in a
Python plugin:

`Domoticz.Device(Name="MyCounter", Unit=1, Type=0xfa, Subtype=0x01, Options={"DisableLogAutoUpdate"``<span>`{=html}` ``</span>`{=html}`: "true").Create()`

Starting version 4.11774, you can too directly insert data in in history
log. Set the \"AddDBLogEntry\" device option to \"true\", for instance
in a Python plugin:

`Domoticz.Device(Name="MyCounter", Unit=1, Type=0xfa, Subtype=0x01, Options={"AddDBLogEntry"``<span>`{=html}` ``</span>`{=html}`: "true").Create()`

Then, depending on counters, you can insert values in history log. For
most counters:

`Devices[Unit].Update(nValue=nValue, sValue="COUNTER;USAGE;DATE")`

-   COUNTER = absolute counter energy (Wh)
-   USAGE = energy usage in Watt-hours (Wh)
-   DATE = date with %Y-%m-%d format (for instance 2019-09-24) to put
    data in last week/month/year history log, or \"%Y-%m-%d %H:%M:%S\"
    format (for instance 2019-10-03 14:00:00) to put data in last days
    history log

For multi meters (P1 Smart Meter, CM113, Electrisave and CM180i):

`Devices[Unit].Update(nValue=nValue, sValue="USAGE1;USAGE2;RETURN1;RETURN2;CONS;PROD;DATE")`

-   USAGE1= energy usage meter tariff 1, This is an incrementing counter
-   USAGE2= energy usage meter tariff 2, This is an incrementing counter
-   RETURN1= energy return meter tariff 1, This is an incrementing
    counter
-   RETURN2= energy return meter tariff 2, This is an incrementing
    counter
-   CONS= actual usage power (Watt)
-   PROD= actual return power (Watt)
-   DATE = date with %Y-%m-%d format (for instance 2019-09-24) to put
    data in last week/month/year history log, or \"%Y-%m-%d %H:%M:%S\"
    format (for instance 2019-10-03 14:00:00) to put data in last days
    history log

or

`Devices[Unit].Update(nValue=nValue, sValue="USAGE1;USAGE2;RETURN1;RETURN2;CONS;PROD;COUNTER1;COUNTER2;COUNTER3;COUNTER4;DATE")`

as previously, plus absolute counter values

for counters with custom units: Use RFXCom customer counter, e.g.
Domoticz.Unit(Name=name, Unit=unit, Type=113, Switchtype=3,
Options={\"ValueQuantity\": \"Custom\", \"ValueUnits\":
\"customunit\"}).Create()

\

### Connections

Connection objects allow plugin developers to connect to multiple
external sources using a variety of transports and protocols
simultaneously. By using the plugin framework to handle connectivity
Domoticz will remain responsive no matter how many connections the
plugin handles.\
Connections remain active only while they are in scope in Python after
that Domoticz will actively disconnect them so plugins should store
Connections that they want to keep in global or class variables.

+--------------+------------------------------------------------------+
| Function     | Description/Attributes                               |
+==============+======================================================+
| \_\_init\_\_ | Defines the connection type that will be used by the |
|              | object.                                              |
|              |                                                      |
|              | +-----------+-----------------------------------+    |
|              | | Parameter | Description                       |    |
|              | +===========+===================================+    |
|              | | Name      | Required.\                        |    |
|              | |           | Name of the Connection. For       |    |
|              | |           | incoming connections Domoticz     |    |
|              | |           | will assign a unique name.        |    |
|              | +-----------+-----------------------------------+    |
|              | | Transport | Required.\                        |    |
|              | |           | Valid values:                     |    |
|              | |           |                                   |    |
|              | |           | -   TCP/IP: Connect over an IP    |    |
|              | |           |     network then send or receive  |    |
|              | |           |     messages\                     |    |
|              | |           |                                   |    |
|              | |           | See [HTTP/HTTPS Client            |    |
|              | |           | example](https://githu            |    |
|              | |           | b.com/domoticz/domoticz/blob/deve |    |
|              | |           | lopment/plugins/examples/HTTP.py) |    |
|              | |           | that uses GET and POST over HTTP  |    |
|              | |           | or HTTPS\                         |    |
|              | |           | See [HTTP Listener                |    |
|              | |           | example](https://github.com/domot |    |
|              | |           | icz/domoticz/blob/development/plu |    |
|              | |           | gins/examples/HTTP%20Listener.py) |    |
|              | |           | that acts as a lightweight        |    |
|              | |           | webserver                         |    |
|              | |           |                                   |    |
|              | |           | -   TLS/IP: Connect over an IP    |    |
|              | |           |     network using TLS security    |    |
|              | |           |     then send or receive          |    |
|              | |           |     messages\                     |    |
|              | |           |                                   |    |
|              | |           | See [HTTP/HTTPS Client            |    |
|              | |           | example](https://githu            |    |
|              | |           | b.com/domoticz/domoticz/blob/deve |    |
|              | |           | lopment/plugins/examples/HTTP.py) |    |
|              | |           |                                   |    |
|              | |           | -   UDP/IP: Send or recieve UDP   |    |
|              | |           |     messages, useful for          |    |
|              | |           |     discovering hardware on a     |    |
|              | |           |     network.\                     |    |
|              | |           |                                   |    |
|              | |           | See [UDP Discovery                |    |
|              | |           | e                                 |    |
|              | |           | xample](https://github.com/domoti |    |
|              | |           | cz/domoticz/blob/development/plug |    |
|              | |           | ins/examples/UDP%20Discovery.py)\ |    |
|              | |           | See [UDP broadcast                |    |
|              | |           | example](https://githu            |    |
|              | |           | b.com/domoticz/domoticz/blob/deve |    |
|              | |           | lopment/plugins/examples/Kodi.py) |    |
|              | |           | (onNotification function)         |    |
|              | |           |                                   |    |
|              | |           | -   ICMP/IP: Send or recieve ICMP |    |
|              | |           |     messages, useful for          |    |
|              | |           |     discovering or pinging        |    |
|              | |           |     hardware on a network.\       |    |
|              | |           |                                   |    |
|              | |           | See [Pinger                       |    |
|              | |           | example](https://github.          |    |
|              | |           | com/domoticz/domoticz/blob/develo |    |
|              | |           | pment/plugins/examples/Pinger.py) |    |
|              | |           |                                   |    |
|              | |           | -   Serial: Connect to serial     |    |
|              | |           |     ports, see [RAVEn power       |    |
|              | |           |     monitoring                    |    |
|              | |           |     example](https://github       |    |
|              | |           | .com/domoticz/domoticz/blob/devel |    |
|              | |           | opment/plugins/examples/RAVEn.py) |    |
|              | +-----------+-----------------------------------+    |
|              | | Protocol  | Required. The protocol that will  |    |
|              | |           | be used to talk to the external   |    |
|              | |           | hardware. This is used to allow   |    |
|              | |           | Domoticz to break incoming data   |    |
|              | |           | into single messages to pass to   |    |
|              | |           | the plugin. Valid values:         |    |
|              | |           |                                   |    |
|              | |           | -   None (default)                |    |
|              | |           | -   Line                          |    |
|              | |           | -   JSON                          |    |
|              | |           | -   XML                           |    |
|              | |           | -   HTTP                          |    |
|              | |           | -   HTTPS                         |    |
|              | |           | -   WS (Web Socket)               |    |
|              | |           | -   WSS                           |    |
|              | |           | -   MQTT                          |    |
|              | |           | -   MQTTS                         |    |
|              | |           | -   ICMP                          |    |
|              | +-----------+-----------------------------------+    |
|              | | Address   | Optional.\                        |    |
|              | |           | TCP/IP or UDP/IP Address or       |    |
|              | |           | SerialPort to connect to.         |    |
|              | +-----------+-----------------------------------+    |
|              | | Port      | Optional.\                        |    |
|              | |           | TCP/IP & UDP/IP connections only, |    |
|              | |           | string containing the port        |    |
|              | |           | number.                           |    |
|              | +-----------+-----------------------------------+    |
|              | | Baud      | Optional.\                        |    |
|              | |           | Serial connections only, the      |    |
|              | |           | required baud rate.\              |    |
|              | |           | Default: 115200                   |    |
|              | +-----------+-----------------------------------+    |
|              | |           |                                   |    |
|              | +-----------+-----------------------------------+    |
|              |                                                      |
|              | This allows Domoticz to make connections on behalf   |
|              | of the plugin. E.g:                                  |
|              |                                                      |
|              | ``` python                                           |
|              |  myConn = Domoticz.Connection(Name="JSON C           |
|              | onnection", Transport="TCP/IP", Protocol="JSON", Add |
|              | ress=Parameters["Address"], Port=Parameters["Port"]) |
|              |  myConn.Connect()                                    |
|              |  secureConn = Domoticz.Connection(Na                 |
|              | me="Secure Connection", Transport="TCP/IP", Protocol |
|              | ="HTTPS", Address=Parameters["Address"], Port="443") |
|              |  secureConn .Connect()                               |
|              |  mySerialConn = Domoticz.Connection(Name             |
|              | ="Serial Connection", Transport="Serial", Protocol=" |
|              | XML", Address=Parameters["SerialPort"], Baud=115200) |
|              |  mySerialConn.Connect()                              |
|              | ```                                                  |
|              |                                                      |
|              | Both positional and named parameters are supported.  |
+--------------+------------------------------------------------------+
| Name         | Returns the Name of the Connection.                  |
+--------------+------------------------------------------------------+
| Address      | Return/Set the Address associated with the           |
|              | Connection.                                          |
+--------------+------------------------------------------------------+
| Port         | Return/Set the Port associated with the Connection.  |
+--------------+------------------------------------------------------+
| Baud         | Returns the Baud Rate of the Connection.             |
+--------------+------------------------------------------------------+
| Target       | Get or Set the event target for the Connection. See  |
|              | Target parameter description on Connect and Listen   |
|              | for more detail.                                     |
+--------------+------------------------------------------------------+
| Parent       | Normally \'None\' but for incoming connections this  |
|              | will hold the Connection object that is              |
|              | \'Listening\' for the connection.                    |
+--------------+------------------------------------------------------+
| Connecting   | Parameters: None. Returns True if a connection has   |
|              | been requested but has yet to complete (or fail),    |
|              | otherwise False.                                     |
+--------------+------------------------------------------------------+
| Connected    | Parameters: None. Returns True if the connection is  |
|              | connected or listening, otherwise False.             |
+--------------+------------------------------------------------------+
| Connect      | Initiate a connection to a external hardware using   |
|              | transport details.                                   |
|              |                                                      |
|              | +-----------+-----------------------------------+    |
|              | | Parameter | Description                       |    |
|              | +===========+===================================+    |
|              | | Target    | Optional. A Python object where   |    |
|              | |           | the Connection\'s callbacks       |    |
|              | |           | should be sent rather than        |    |
|              | |           | sending them to the module level  |    |
|              | |           | functions.                        |    |
|              | |           |                                   |    |
|              | |           | Applies to: onConnect, onMessage, |    |
|              | |           | onTimeout and onDisconnect.       |    |
|              | |           |                                   |    |
|              | |           | This functionality is designed to |    |
|              | |           | allow plugin authors more         |    |
|              | |           | flexibility and to segregate      |    |
|              | |           | connection based code from other  |    |
|              | |           | callbacks.                        |    |
|              | +-----------+-----------------------------------+    |
|              | | Timeout   | Optional. Time in milliseconds to |    |
|              | |           | wait for either a connection to   |    |
|              | |           | occur or data to arrive on a      |    |
|              | |           | Connection before calling the     |    |
|              | |           | onTimeout callback.               |    |
|              | |           |                                   |    |
|              | |           | Applies to Serial, TCP and Secure |    |
|              | |           | TCP connections.                  |    |
|              | |           |                                   |    |
|              | |           | Valid values:                     |    |
|              | |           |                                   |    |
|              | |           | 0 - No timeout                    |    |
|              | |           |                                   |    |
|              | |           | 250 or greater - the milliseconds |    |
|              | |           | to wait before queuing an         |    |
|              | |           | onTimeout event                   |    |
|              | +-----------+-----------------------------------+    |
|              |                                                      |
|              | Connect returns immediately and the results of the   |
|              | actual connection operation will be returned via the |
|              | onConnect callback. If the address set via the       |
|              | Transport function translates to multiple endpoints  |
|              | they will all be tried in order until the connection |
|              | succeeds or the list of endpoints is exhausted.\     |
|              | The Connect operation works with connection based    |
|              | transports.\                                         |
|              | Note that I/O operations immediately after a Connect |
|              | (but before onConnect is called) may fail because    |
|              | the connection is still in progress so is            |
|              | technically not connected.                           |
+--------------+------------------------------------------------------+
| Listen       | Start listening on specifed Port using the specified |
|              | TCP/IP, UDP/IP or ICMP/IP transport.                 |
|              |                                                      |
|              | +-----------+-----------------------------------+    |
|              | | Parameter | Description                       |    |
|              | +===========+===================================+    |
|              | | Target    | Optional. A Python object where   |    |
|              | |           | the Connection\'s callbacks       |    |
|              | |           | should be sent rather than        |    |
|              | |           | sending them to the module level  |    |
|              | |           | functions.                        |    |
|              | |           |                                   |    |
|              | |           | Applies to: onConnect, onMessage, |    |
|              | |           | onTimeout and onDisconnect.       |    |
|              | |           |                                   |    |
|              | |           | This functionality is designed to |    |
|              | |           | allow plugin authors more         |    |
|              | |           | flexibility and to segregate      |    |
|              | |           | connection based code from other  |    |
|              | |           | callbacks.                        |    |
|              | +-----------+-----------------------------------+    |
|              |                                                      |
|              | Connection objects will be created for each client   |
|              | that connects and onConnect will be called.\         |
|              | If a Listen request is unsuccessful the plugin\'s    |
|              | onConnect callback will be called with failure       |
|              | details. If it is successful then onConnect will be  |
|              | called when incoming Connections are made. E.g:      |
|              |                                                      |
|              | ``` python                                           |
|              |  self.httpServerCo                                   |
|              | nn = Domoticz.Connection(Name="WebServer", Transport |
|              | ="TCP/IP", Protocol="HTTP", Port=Parameters["Port"]) |
|              |  self.httpServerConn.Listen()                        |
|              |                                                      |
|              |  self.Bea                                            |
|              | conConn = Domoticz.Connection(Name="Beacon", Transpo |
|              | rt="UDP/IP", Address="239.255.255.250", Port="1900") |
|              |  self.BeaconConn.Listen()                            |
|              | ```                                                  |
|              |                                                      |
|              | Listening on UDP/IP traffic is normally unicast      |
|              | (point to point) but there are some special cases    |
|              | based on the specified Address:                      |
|              |                                                      |
|              | -   Addresses between \"224.x.x.x\" and              |
|              |     \"239.x.x.x\" will be treated as multicast       |
|              |     listeners                                        |
|              | -   Address \"255.255.255.255\" will be treated as a |
|              |     broadcast listener                               |
+--------------+------------------------------------------------------+
| Send         | Send the specified message to the external hardware. |
|              |                                                      |
|              | +-----------+-----------------------------------+    |
|              | | Parameter | Description                       |    |
|              | +===========+===================================+    |
|              | | Message   | Mandatory.\                       |    |
|              | |           | Message text to send.\            |    |
|              | |           | For simple Protocols this can be  |    |
|              | |           | of type String, ByteArray or      |    |
|              | |           | Bytes.\                           |    |
|              | |           | For structured Protocols (such as |    |
|              | |           | HTTP) it should be a Dictionary.  |    |
|              | +-----------+-----------------------------------+    |
|              | | Delay     | Optional.\                        |    |
|              | |           | Number of seconds to delay        |    |
|              | |           | message send.\                    |    |
|              | |           | Note that Domoticz will send the  |    |
|              | |           | message sometime after this       |    |
|              | |           | period. Other events will be      |    |
|              | |           | processed in the intervening      |    |
|              | |           | period so delayed sends will be   |    |
|              | |           | processed out of order. This      |    |
|              | |           | feature may be useful during      |    |
|              | |           | delays when physical devices turn |    |
|              | |           | on.                               |    |
|              | +-----------+-----------------------------------+    |
|              | |           |                                   |    |
|              | +-----------+-----------------------------------+    |
|              |                                                      |
|              | Both positional and named parameters are supported.\ |
|              | E.g:                                                 |
+--------------+------------------------------------------------------+
| Disconnect   | Parameters: None. Terminate the connection to the    |
|              | external hardware for the connection.\               |
|              | Disconnect also terminates listening connections for |
|              | all transports (including connectionless ones e.g    |
|              | UDP/IP).                                             |
+--------------+------------------------------------------------------+

### Images

Developers can ship custom images with plugins in the standard Domoticz
format as described here:
[1](http://www.domoticz.com/wiki/Custom_icons_for_webinterface#Creating_simple_home_made_icons).
Resultant zip file(s) should be placed in the folder with the plugin
itself

+---------+-----------------------------------------------------------+
|         | Description                                               |
+=========+===========================================================+
| Key     | Base. The base value as specified in icons.txt file in    |
|         | custom image zip file.                                    |
|         |                                                           |
|         |   Function      Description                               |
|         |   ------------- -----------------------------             |
|         | --------------------------------------------------------- |
|         | --------------------------------------------------------- |
|         |   ID            Image ID in CustomImages table            |
|         |   Name          Name as specified in upload file          |
|         |   Base          This MUST start with (or be               |
|         | ) the plugin key as defined in the XML definition. If not |
|         |  the image will not be loaded into the Images dictionary. |
|         |   Description   Description as specified in upload file   |
|         |                                                           |
+---------+-----------------------------------------------------------+
| Methods | Per image calls into Domoticz to manipulate specific      |
|         | images                                                    |
|         |                                                           |
|         | +--------------+--------------------------------------+   |
|         | | Function     | Description                          |   |
|         | +==============+======================================+   |
|         | | \_\_init\_\_ | +-----------+-------------------+    |   |
|         | |              | | Parameter | Description       |    |   |
|         | |              | +===========+===================+    |   |
|         | |              | | Filename  | Mandatory.\       |    |   |
|         | |              | |           | The zip file name |    |   |
|         | |              | |           | containing images |    |   |
|         | |              | |           | formatted for     |    |   |
|         | |              | |           | Domoticz.         |    |   |
|         | |              | +-----------+-------------------+    |   |
|         | +--------------+--------------------------------------+   |
|         | | Create       | Parameters: None, acts on current    |   |
|         | |              | object.                              |   |
|         | +--------------+--------------------------------------+   |
|         | | Delete       | Parameters: None, acts on current    |   |
|         | |              | object.                              |   |
|         | +--------------+--------------------------------------+   |
|         | |              |                                      |   |
|         | +--------------+--------------------------------------+   |
+---------+-----------------------------------------------------------+
|         |                                                           |
+---------+-----------------------------------------------------------+

## Callbacks

Plugins are event driven. If a callback is not used by a plugin then it
should **not** be present in the plugin.py file, Domoticz will not
attempt to call callbacks that are not defined.

Domoticz will notify the plugin when certain events occur through a
number of callbacks, these are:

+------------------+--------------------------------------------------+
| Callback         | Description                                      |
+==================+==================================================+
| onStart          | Parameters: None. Called when the hardware is    |
|                  | started, either after Domoticz start, hardware   |
|                  | creation or update.                              |
+------------------+--------------------------------------------------+
| onConnect        | Parameters: Connection, Status, Description      |
|                  | Called when connection to remote device either   |
|                  | succeeds or fails, or when a connection is made  |
|                  | to a listening Address:Port. Connection is the   |
|                  | Domoticz Connection object associated with the   |
|                  | event. Zero Status indicates success. If Status  |
|                  | is not zero then the Description will describe   |
|                  | the failure.\                                    |
|                  | This callback is not called for connectionless   |
|                  | Transports such as UDP/IP.                       |
+------------------+--------------------------------------------------+
| onMessage        | Parameters: Connection, Data. Called when a      |
|                  | single, complete message is received from the    |
|                  | external hardware (as defined by the Protocol    |
|                  | setting). This callback should be used to        |
|                  | interpret messages from the device and set the   |
|                  | related Domoticz devices as required.\           |
|                  | Connection is the Domoticz Connection object     |
|                  | associated with the event.\                      |
|                  | Data is normally a ByteArray except where the    |
|                  | Protocol for the Connection has structure (such  |
|                  | as HTTP or ICMP), in that case Data will be a    |
|                  | Dictionary containing Protocol specific details  |
|                  | such as Status and Headers.                      |
+------------------+--------------------------------------------------+
| onNotification   | Parameters: Name, Subject, Text, Status,         |
|                  | Priority, Sound, ImageFile. Called when any      |
|                  | Domoticz device generates a notification. Name   |
|                  | parameter is the device that generated the       |
|                  | notification, the other parameters contain the   |
|                  | notification details. Hardware that can handle   |
|                  | notifications should be notified as required.    |
+------------------+--------------------------------------------------+
| onCommand        | **Legacy Plugin Framework (\'import              |
|                  | Domoticz\')**                                    |
|                  |                                                  |
|                  | -   Parameters: Unit, Command, Level, Color      |
|                  |                                                  |
|                  | **Extended Plugin Framework (\'import            |
|                  | DomoticzEx\')**                                  |
|                  |                                                  |
|                  | -   Parameters: DeviceID, Unit, Command, Level,  |
|                  |     Color                                        |
|                  | -   Can be overidden or Device or Unit objects,  |
|                  |     see docmentation elsewhere in this page      |
|                  |                                                  |
|                  | Called when a command is received from Domoticz. |
|                  | The Unit parameters matches the Unit specified   |
|                  | in the device definition and should be used to   |
|                  | map commands to Domoticz devices. Level is       |
|                  | normally an integer but may be a floating point  |
|                  | number if the Unit is linked to a thermostat     |
|                  | device. This callback should be used to send     |
|                  | Domoticz commands to the external hardware. The  |
|                  | Color parameter is valid if Command is \"Set     |
|                  | Color\" and is a JSON serialized Domoticz color  |
|                  | object.                                          |
|                  |                                                  |
|                  | Domoticz color format:                           |
|                  |                                                  |
|                  | ``` python3                                      |
|                  |                       ColorMode {                |
|                  |                                                  |
|                  |                  ColorModeNone = 0,   // Illegal |
|                  |                         C                        |
|                  | olorModeWhite = 1,  // White. Valid fields: none |
|                  |                         ColorModeTemp = 2,       |
|                  | // White with color temperature. Valid fields: t |
|                  |                         Color                    |
|                  | ModeRGB = 3,    // Color. Valid fields: r, g, b. |
|                  |                         ColorModeCustom          |
|                  |  = 4, // Custom (color + white). Valid fields: r |
|                  | , g, b, cw, ww, depending on device capabilities |
|                  |                                                  |
|                  |                 ColorModeLast = ColorModeCustom, |
|                  |                       };                         |
|                  |                                                  |
|                  |                       Color {                    |
|                  |                         ColorMode m;             |
|                  |                         uin                      |
|                  | t8_t t;     // Range:0..255, Color temperature ( |
|                  | warm / cold ratio, 0 is coldest, 255 is warmest) |
|                  |                                                  |
|                  |        uint8_t r;     // Range:0..255, Red level |
|                  |                                                  |
|                  |      uint8_t g;     // Range:0..255, Green level |
|                  |                                                  |
|                  |       uint8_t b;     // Range:0..255, Blue level |
|                  |                                                  |
|                  | uint8_t cw;    // Range:0..255, Cold white level |
|                  |                                                  |
|                  |       uint8_t ww;    // Range:0..255, Warm white |
|                  |  level (also used as level for monochrome white) |
|                  |                       }                          |
|                  | ```                                              |
+------------------+--------------------------------------------------+
| onHeartbeat      | Called every \'heartbeat\' seconds (default 10)  |
|                  | regardless of connection status. Heartbeat       |
|                  | interval can be modified by the Heartbeat        |
|                  | command:                                         |
|                  |                                                  |
|                  | ``` python3                                      |
|                  | Domoticz.Heartbeat(30)                           |
|                  | ```                                              |
|                  |                                                  |
|                  | to set the Heartbeat interval to 30s. Allows the |
|                  | Plugin to do periodic tasks including request    |
|                  | reconnection if the connection has failed.\      |
|                  | \                                                |
|                  | **Warning:** Setting this interval to greater    |
|                  | than 30 seconds will cause a \'thread seems to   |
|                  | have ended unexpectedly\' message to be written  |
|                  | to the log file every 30 seconds. The plugin     |
|                  | will function correctly but this message can not |
|                  | be suppressed because it is a standard warning   |
|                  | from Domoticz that a piece of hardware may have  |
|                  | stopped responding.\                             |
|                  | If a plugin wants to heartbeat every 100 seconds |
|                  | it should be coded with the heartbeat interval   |
|                  | set to 10, 20 or 25 seconds and only take action |
|                  | every 6th, 5th or 4th time the callback is       |
|                  | invoked.                                         |
+------------------+--------------------------------------------------+
| onTimeout        | Parameters: Connection Called in response to a   |
|                  | connection or read timeout.                      |
|                  |                                                  |
|                  | Timeout interval set configured for the          |
|                  | connection by the \'Timeout\' parameter          |
|                  | optionally specified on the Connect method.      |
+------------------+--------------------------------------------------+
| onDisconnect     | Parameters: Connection Called after the remote   |
|                  | device is disconnected, Connection is the        |
|                  | Domoticz Connection object associated with the   |
|                  | event\                                           |
|                  | This callback is not called for connectionless   |
|                  | Transports such as UDP/IP.                       |
+------------------+--------------------------------------------------+
| onStop           | Called when the hardware is stopped or deleted   |
|                  | from Domoticz.                                   |
+------------------+--------------------------------------------------+
| onDeviceAdded    | **Legacy Plugin Framework (\'import              |
|                  | Domoticz\')**                                    |
|                  |                                                  |
|                  | -   Parameters: Unit                             |
|                  |                                                  |
|                  | **Extended Plugin Framework (\'import            |
|                  | DomoticzEx\')**                                  |
|                  |                                                  |
|                  | -   Parameters: DeviceID, Unit                   |
|                  | -   Can be overidden or Device or Unit objects,  |
|                  |     see docmentation elsewhere in this page      |
|                  |                                                  |
|                  | Called just after a new device has been added to |
|                  | the hardware, for example by a Domoticz Web API  |
|                  | call.\                                           |
|                  | onDeviceAdded is not called when the plugin adds |
|                  | a device                                         |
+------------------+--------------------------------------------------+
| onDeviceModified | **Legacy Plugin Framework (\'import              |
|                  | Domoticz\')**                                    |
|                  |                                                  |
|                  | -   Parameters: Unit                             |
|                  |                                                  |
|                  | **Extended Plugin Framework (\'import            |
|                  | DomoticzEx\')**                                  |
|                  |                                                  |
|                  | -   Parameters: DeviceID, Unit                   |
|                  | -   Can be overidden or Device or Unit objects,  |
|                  |     see docmentation elsewhere in this page      |
|                  |                                                  |
|                  | Called just after a device owned by the plugin   |
|                  | has been modifed, for example by a Domoticz Web  |
|                  | API call.\                                       |
|                  | onDeviceModified is not called when the plugin   |
|                  | initiated the change e.g. by calling Update.     |
+------------------+--------------------------------------------------+
| onDeviceRemoved  | **Legacy Plugin Framework (\'import              |
|                  | Domoticz\')**                                    |
|                  |                                                  |
|                  | -   Parameters: Unit                             |
|                  |                                                  |
|                  | **Extended Plugin Framework (\'import            |
|                  | DomoticzEx\')**                                  |
|                  |                                                  |
|                  | -   Parameters: DeviceID, Unit                   |
|                  | -   Can be overidden or Device or Unit objects,  |
|                  |     see docmentation elsewhere in this page      |
|                  |                                                  |
|                  | Called just before a device owned by the plugin  |
|                  | is been removed, for example by a Domoticz Web   |
|                  | API call.\                                       |
|                  | onDeviceRemoved is not called when the plugin    |
|                  | removed the device by calling Delete.            |
+------------------+--------------------------------------------------+
| onSecurityEvent  | **Legacy Plugin Framework (\'import              |
|                  | Domoticz\')**                                    |
|                  |                                                  |
|                  | -   Parameters: Unit, Level, Description         |
|                  |                                                  |
|                  | **Extended Plugin Framework (\'import            |
|                  | DomoticzEx\')**                                  |
|                  |                                                  |
|                  | -   Parameters: DeviceID, Unit, Level,           |
|                  |     Description                                  |
|                  | -   Can be overidden or Device or Unit objects,  |
|                  |     see docmentation elsewhere in this page      |
+------------------+--------------------------------------------------+

## C++ Callable API {#c_callable_api}

Importing the 'Domoticz' module in the Python code exposes functions
that plugins can call to perform specific functions. All functions are
non-blocking and return immediately.

+---------------+-----------------------------------------------------+
| Function      | Description/Attributes                              |
+===============+=====================================================+
| Debug         | Parameters: String Write a message to Domoticz log  |
|               | only if verbose logging is turned on.               |
+---------------+-----------------------------------------------------+
| Log           | Parameters: String. Write a message to Domoticz log |
+---------------+-----------------------------------------------------+
| Status        | Parameters: String. Write a status message to       |
|               | Domoticz log                                        |
+---------------+-----------------------------------------------------+
| Error         | Parameters: String Write an error message to        |
|               | Domoticz log                                        |
+---------------+-----------------------------------------------------+
| Debugging     | Parameters: Integer. Set logging level and type for |
|               | debugging.                                          |
|               |                                                     |
|               |   Value   Meaning                                   |
|               |   ------- --------------------------------          |
|               | --------------------------------------------------- |
|               |   0       No                                        |
|               | ne. All Python and framework debugging is disabled. |
|               |   1       All. Very verbose l                       |
|               | og from plugin framework and plugin debug messages. |
|               |   2       Mask value. Show                          |
|               | s messages from Plugin Domoticz.Debug() calls only. |
|               |   4       Mask Value. Shows high le                 |
|               | vel framework messages only about major the plugin. |
|               |   8       Mask Value. Shows plugin f                |
|               | ramework debug messages related to Devices objects. |
|               |   16      Mask Value. Shows plugin frame            |
|               | work debug messages related to Connections objects. |
|               |   32      Mask Value. Shows plugin                  |
|               | framework debug messages related to Images objects. |
|               |   64      Mask Value. Dumps contents of             |
|               |  inbound and outbound data from Connection objects. |
|               |   128     Mask Value. Shows plugin fra              |
|               | mework debug messages related to the message queue. |
|               |                                                     |
|               |                                                     |
|               | Mask values can be added together, for example to   |
|               | see debugging details around the plugin and its     |
|               | objects use: `Domoticz.Debugging(62) # 2+4+8+16+32` |
+---------------+-----------------------------------------------------+
| Heartbeat     | Parameters: Integer (Optional). Set the heartbeat   |
|               | interval in seconds if parameter supplied (initial  |
|               | value 10 seconds).                                  |
|               |                                                     |
|               | Values greater than 30 seconds will cause a message |
|               | to be regularly logged about the plugin not         |
|               | responding. The plugin will actually function       |
|               | correctly with values greater than 30 though.       |
|               |                                                     |
|               | Returns current Heartbeat value in seconds.         |
+---------------+-----------------------------------------------------+
| Notifier      | Parameters: Name, String. Informs the plugin        |
|               | framework that the plugin\'s external hardware can  |
|               | comsume Domoticz Notifications.\                    |
|               | When the plugin is active the supplied Name will    |
|               | appear as an additional target for Notifications in |
|               | the standard Domoticz device notification editing   |
|               | page. The plugin framework will then call the       |
|               | onNotification callback when a notifiable event     |
|               | occurs.                                             |
+---------------+-----------------------------------------------------+
| Trace         | Parameters: N/A, Boolean. Default: False. When      |
|               | True, Domoticz will log line numbers of the lines   |
|               | being executed by the plugin. Calling Trace again   |
|               | with False will suppress line level logging. Usage: |
|               |                                                     |
|               | ``` python3                                         |
|               |   def onHeartBeat():                                |
|               |     Domoticz.Trace(True)                            |
|               |     Domoticz.Log("onHeartBeat called")              |
|               |     ...                                             |
|               |     Domoticz.Trace(False)                           |
|               | ```                                                 |
+---------------+-----------------------------------------------------+
| Configuration | Parameters: Dictionary (Optional). Returns a        |
|               | dictionary containing the plugin\'s configuration   |
|               | data that was previously stored. If a Dictionary    |
|               | paramater is supplied the database will be updated  |
|               | with the new configuration data.\                   |
|               | Values in the dictionary can be of types: String,   |
|               | Long, Float, Boolean, Bytes, ByteArray, List or     |
|               | Dictionary. Tuples can be specified but will be     |
|               | returned as a List.\                                |
|               | Configuration should not be confused with the       |
|               | Parameters dictionary. Parameters are set via the   |
|               | Hardware page and are read-only to the plugin,      |
|               | Configuration allows the plugin store structured    |
|               | data in the database rather than writing files or   |
|               | creating Domoticz variables to hold it.\            |
|               | Usage:                                              |
|               |                                                     |
|               | ``` python3                                         |
|               |     # Configuration Helpers                         |
|               |     def getConfigItem(Key=None, Default={}):        |
|               |         Value = Default                             |
|               |         try:                                        |
|               |             Config = Domoticz.Configuration()       |
|               |             if (Key != None):                       |
|               |                 Value = Confi                       |
|               | g[Key] # only return requested key if there was one |
|               |             else:                                   |
|               |                 Value = Con                         |
|               | fig      # return the whole configuration if no key |
|               |         except KeyError:                            |
|               |             Value = Default                         |
|               |         except Exception as inst:                   |
|               |             Domoticz.Error("Do                      |
|               | moticz.Configuration read failed: '"+str(inst)+"'") |
|               |         return Value                                |
|               |                                                     |
|               |     def setConfigItem(Key=None, Value=None):        |
|               |         Config = {}                                 |
|               |         try:                                        |
|               |             Config = Domoticz.Configuration()       |
|               |             if (Key != None):                       |
|               |                 Config[Key] = Value                 |
|               |             else:                                   |
|               |                 Config = V                          |
|               | alue  # set whole configuration if no key specified |
|               |             Config = Domoticz.Configuration(Config) |
|               |         except Exception as inst:                   |
|               |             Domoticz.Error("Domotic                 |
|               | z.Configuration operation failed: '"+str(inst)+"'") |
|               |         return Config                               |
|               | ```                                                 |
+---------------+-----------------------------------------------------+
| Register      | Parameters: Device (Class Object), Optional Unit    |
|               | (Class Object) Must be positioned outside of any    |
|               | class code so that the Plugin Framework can process |
|               | it during the module import.                        |
|               |                                                     |
|               | Changes the object type that Domoticz uses to       |
|               | represent Devices (and Units where applicable) to a |
|               | user defined type. The specified class must inherit |
|               | (directly or indirectly) from the default class     |
|               | type and the underlying object initialisation       |
|               | should be invoked (via super().\_\_init\_\_) to     |
|               | ensure there are no unexpected behaviours.          |
|               |                                                     |
|               | The purpose of this function is to support          |
|               | encapsulation and code segregation.                 |
|               |                                                     |
|               | When using the legacy Plugin Framework the          |
|               | following code will cause Domoticz to populate the  |
|               | Devices dictionary with objects of type             |
|               | \'myDevice\' rather than the default objects of     |
|               | type \'Domoticz.Device\':                           |
|               |                                                     |
|               | ``` python3                                         |
|               | import Domoticz                                     |
|               | from Domoticz import Device                         |
|               |                                                     |
|               | class myDevice(Domoticz.Device):                    |
|               |     def __init__(self, Name, Unit, Ty               |
|               | peName="", Type=0, Subtype=0, Switchtype=0, Image=0 |
|               | , Options="", Used=0, DeviceID="", Description=""): |
|               |         super().__init__(Name=Name, Unit=Unit, T    |
|               | ypeName=TypeName, Type=Type, Subtype=Subtype, Switc |
|               | htype=Switchtype, Image=Image, Options=Options, Use |
|               | d=Used, DeviceID=DeviceID, Description=Description) |
|               |         # Th                                        |
|               | is code will run prior to onStart for existing data |
|               |         self.localVariable = "Hello"                |
|               |                                                     |
|               |     def localFunction(self):                        |
|               |         Domoticz.Log("Function called")             |
|               |                                                     |
|               |     # Callbacks cannot be overridden                |
|               |                                                     |
|               | Domoticz.Register(Device=myDevice)                  |
|               | ```                                                 |
|               |                                                     |
|               | When using the extended Plugin Framework the        |
|               | following code will cause Domoticz to populate the  |
|               | Devices and Units dictionaries with objects of type |
|               | \'myDevice\' and \'myUnit\' respectively rather     |
|               | than the default objects of type                    |
|               | \'DomoticzEx.Device\' and \'DomoticzEx.Unit:        |
|               |                                                     |
|               | ``` python3                                         |
|               | import DomoticzEx as Domoticz                       |
|               | from DomoticzEx import Device, Unit                 |
|               |                                                     |
|               | class myUnit(Domoticz.Unit):                        |
|               |     def __init__(self, Name, Devic                  |
|               | eID, Unit, TypeName="", Type=0, Subtype=0, Switchty |
|               | pe=0, Image=0, Options="", Used=0, Description=""): |
|               |         super().                                    |
|               | __init__(Name, DeviceID, Unit, TypeName, Type, Subt |
|               | ype, Switchtype, Image, Options, Used, Description) |
|               |         # Th                                        |
|               | is code will run prior to onStart for existing data |
|               |         self.myVar = 0                              |
|               |                                                     |
|               |     # Optionally override onDeviceAdded, onDev      |
|               | iceModified, onDeviceRemoved or onCommand callbacks |
|               |     def onDeviceModified(self):                     |
|               |         Domoticz.Log("Unit onDeviceModified")       |
|               |                                                     |
|               | class myDevice(Domoticz.Device):                    |
|               |     def __init__(self, DeviceID):                   |
|               |         super().__init__(DeviceID)                  |
|               |         # Th                                        |
|               | is code will run prior to onStart for existing data |
|               |         self.localVariable = "Hello"                |
|               |                                                     |
|               |     def localFunction(self):                        |
|               |         Domoticz.Log("Function called")             |
|               |                                                     |
|               |     # Optionally override onDeviceAdded, onDev      |
|               | iceModified, onDeviceRemoved or onCommand callbacks |
|               |     def onDeviceModified(self, Unit):               |
|               |         Domoticz.Log("Device onDeviceModified")     |
|               |                                                     |
|               | Domoticz.Register(Device=myDevice, Unit=myUnit)     |
|               | ```                                                 |
+---------------+-----------------------------------------------------+
| Dump          | Parameters: None. Dumps current values to the       |
|               | Domoticz log, useful during debugging or exception  |
|               | handling.                                           |
|               |                                                     |
|               | Dumped values:                                      |
|               |                                                     |
|               | -   Current context                                 |
|               | -   Local variables                                 |
|               | -   Global variables                                |
|               |                                                     |
|               | Example:                                            |
|               |                                                     |
|               | ``` python3                                         |
|               | import DomoticzEx as Domoticz                       |
|               | from DomoticzEx import Device, Unit                 |
|               | import sys                                          |
|               | import datetime                                     |
|               | import json                                         |
|               |                                                     |
|               | modeC                                               |
|               | oolCmd = 'N000001{"SYST": {"OSS": {"MD": "C" } } }' |
|               | modeE                                               |
|               | vapCmd = 'N000001{"SYST": {"OSS": {"MD": "E" } } }' |
|               | modeH                                               |
|               | eatCmd = 'N000001{"SYST": {"OSS": {"MD": "H" } } }' |
|               |                                                     |
|               | #                                                   |
|               |  Heater, Cooling and Evaporate common functionality |
|               | class hvacBase(Domoticz.Connection):                |
|               |     def __                                          |
|               | init__(self, DeviceID, Name, Image, Address, Port): |
|               |         super().__init__(Name=Name, Transport="TC   |
|               | P/IP", Protocol="None", Address=Address, Port=Port) |
|               |                                                     |
|               |         self.isActive = False                       |
|               |         self.DeviceID = DeviceID                    |
|               |         self.DeviceImage = Image                    |
|               |         self.Device = None                          |
|               |         self.reportedMode = DeviceID                |
|               |                                                     |
|               |     de                                              |
|               | f onConnect(self, Connection, Status, Description): |
|               |                                                     |
|               |         if (self != Connection):                    |
|               |             Domoticz.Error("Connection '"+Conn      |
|               | ection.Name+"' is not the same as '"+self.Name+"'") |
|               |                                                     |
|               |         if (Status == 0):                           |
|               |                                                     |
|               |          Domoticz.Log(self.Name+" connected success |
|               | fully to: "+Connection.Address+":"+Connection.Port) |
|               |             for device in Devices:                  |
|               |                 Devices[device].TimedOut = 0        |
|               |         else:                                       |
|               |             Domo                                    |
|               | ticz.Log(self.Name+" failed to connect ("+str(Statu |
|               | s)+") to: "+Connection.Address+":"+Connection.Port) |
|               |             for device in Devices:                  |
|               |                 Devices[device].TimedOut = 1        |
|               |                                                     |
|               | class Heating(hvacBase):                            |
|               |     def __                                          |
|               | init__(self, DeviceID, Name, Image, Address, Port): |
|               |         sup                                         |
|               | er().__init__(DeviceID, Name, Image, Address, Port) |
|               |                                                     |
|               |     def onMessage(self, Connection, Response):      |
|               |         if (l                                       |
|               | en(Response) > 10):    # filter out 'HELLO' message |
|               |             self.Disconnect()                       |
|               |             jsonPayload = json.loads(Response[7:])  |
|               |             Domoticz.Dump()                         |
|               | ```                                                 |
|               |                                                     |
|               | would dump something like:                          |
|               |                                                     |
|               | ``` text                                            |
|               | 202                                                 |
|               | 1-07-06 15:18:34.296 Rinnai: (Rinnai) Context dump: |
|               | 2021-07-06 15:18:34.296                             |
|               |  Rinnai: (Rinnai) ----> 'Address' '192.168.999.999' |
|               | 2021-07                                             |
|               | -06 15:18:34.297 Rinnai: (Rinnai) ----> 'Baud' '-1' |
|               | 2021-07-06 15:18:34.297 Rinnai: (                   |
|               | Rinnai) ----> 'Device' 'DeviceID: 'HGOM', Units: 1' |
|               | 2021-07-06 15                                       |
|               | :18:34.298 Rinnai: (Rinnai) ----> 'DeviceID' 'HGOM' |
|               | 2021-07-06 15:                                      |
|               | 18:34.298 Rinnai: (Rinnai) ----> 'DeviceImage' '15' |
|               | 2021-07-06 1                                        |
|               | 5:18:34.298 Rinnai: (Rinnai) ----> 'Name' 'Heating' |
|               | 2021-07-06                                          |
|               | 15:18:34.299 Rinnai: (Rinnai) ----> 'Parent' 'None' |
|               | 2021-07-06                                          |
|               |  15:18:34.299 Rinnai: (Rinnai) ----> 'Port' '27847' |
|               | 2021-07-06 15:18:34.299 Rinnai: (Rinnai) ----> 'Tar |
|               | get' 'Name: 'Heating', Transport: 'TCP/IP', Protoco |
|               | l: 'None', Address: '192.168.999.999', Port: '27847 |
|               | ', Baud: -1, Timeout: 0, Bytes: 1071, Connected: Tr |
|               | ue, Last Seen: 2021-07-06 15:18:34, Parent: 'None'' |
|               | 2021-07-06 15                                       |
|               | :18:34.300 Rinnai: (Rinnai) ----> 'isActive' 'True' |
|               | 2021-07-06 15:18:                                   |
|               | 34.300 Rinnai: (Rinnai) ----> 'reportedMode' 'HGOM' |
|               | 20                                                  |
|               | 21-07-06 15:18:34.300 Rinnai: (Rinnai) Locals dump: |
|               | 2021-07-06 15:18:34.300 Rinnai: (Rinnai) ----> 's   |
|               | elf' 'Name: 'Heating', Transport: 'TCP/IP', Protoco |
|               | l: 'None', Address: '192.168.999.999', Port: '27847 |
|               | ', Baud: -1, Timeout: 0, Bytes: 1071, Connected: Tr |
|               | ue, Last Seen: 2021-07-06 15:18:34, Parent: 'None'' |
|               | 2021                                                |
|               | -07-06 15:18:34.301 Rinnai: (Rinnai) ----> 'Connect |
|               | ion' 'Name: 'Heating', Transport: 'TCP/IP', Protoco |
|               | l: 'None', Address: '192.168.999.999', Port: '27847 |
|               | ', Baud: -1, Timeout: 0, Bytes: 1071, Connected: Tr |
|               | ue, Last Seen: 2021-07-06 15:18:34, Parent: 'None'' |
|               | 2021-07-06 15:18:                                   |
|               | 34.301 Rinnai: (Rinnai) ----> 'Response' 'b'N000000 |
|               | [{"SYST": {"CFG": {"MTSP": ... "MT": "231" } } }]'' |
|               | 2021-07                                             |
|               | -06 15:18:34.302 Rinnai: (Rinnai) ----> 'jsonPayloa |
|               | d' '[{'SYST': {'CFG': {'MTSP': ... 'MT': '231'}}}]' |
|               | 202                                                 |
|               | 1-07-06 15:18:34.303 Rinnai: (Rinnai) Globals dump: |
|               | 2021-07-06 15:18:34.304 Rinnai: (Rinnai)            |
|               | ----> 'Domoticz' '<module 'DomoticzEx' (built-in)>' |
|               | 2021-07-06 15:18:34.304 Rinna                       |
|               | i: (Rinnai) ----> 'sys' '<module 'sys' (built-in)>' |
|               | 2021-07-06 15:18:34.304 Rinnai: (Rinnai             |
|               | ) ----> 'datetime' '<module 'datetime' from 'C:\\Pr |
|               | ogram Files (x86)\\Python39-32\\Lib\\datetime.py'>' |
|               | 2021-07-06 15:18:34.304 Rinnai: (Rinn               |
|               | ai) ----> 'json' '<module 'json' from 'C:\\Program  |
|               | Files (x86)\\Python39-32\\Lib\\json\\__init__.py'>' |
|               | 2                                                   |
|               | 021-07-06 15:18:34.305 Rinnai: (Rinnai) ----> 'mode |
|               | CoolCmd' 'N000001{"SYST": {"OSS": {"MD": "C" } } }' |
|               | 2                                                   |
|               | 021-07-06 15:18:34.305 Rinnai: (Rinnai) ----> 'mode |
|               | EvapCmd' 'N000001{"SYST": {"OSS": {"MD": "E" } } }' |
|               | 2                                                   |
|               | 021-07-06 15:18:34.306 Rinnai: (Rinnai) ----> 'mode |
|               | HeatCmd' 'N000001{"SYST": {"OSS": {"MD": "H" } } }' |
|               | 2021-07-06 15:18:34.306 Rinnai: (Rinnai) ----> '    |
|               | _plugin' '<plugin.BasePlugin object at 0x008544E0>' |
|               | 2021-07-06 15:18:34.306 Rinnai:                     |
|               | (Rinnai) ----> 'Parameters' '{'HardwareID': 2, 'Hom |
|               | eFolder': 'plugins\\Domoticz-RinnaiTouch-Plugin\\', |
|               |  'StartupFolder': '', 'UserDataFolder': '', 'WebRoo |
|               | t': '', 'Database': 'domoticz.db', 'Language': 'en' |
|               | , 'Version': '1.0.0', 'Author': 'dnpwwo', 'Name': ' |
|               | Rinnai', 'Address': '', 'Port': '27847', 'SerialPor |
|               | t': '', 'Username': '', 'Password': '', 'Key': 'Rin |
|               | naiTouch', 'Mode1': '', 'Mode2': '', 'Mode3': '', ' |
|               | Mode4': '', 'Mode5': 'True', 'Mode6': '0', 'Domotic |
|               | zVersion': '2021.1 (build 2107)', 'DomoticzHash': ' |
|               | 2107', 'DomoticzBuildTime': '1970-01-01 11:35:07'}' |
|               | 2021-0                                              |
|               | 7-06 15:18:34.307 Rinnai: (Rinnai) ----> 'Devices'  |
|               | '{'HGOM': <plugin.hvacDevice object at 0x008574E0>, |
|               |  'SYST': <plugin.hvacDevice object at 0x00857570>}' |
|               | 2021-07-0                                           |
|               | 6 15:18:34.307 Rinnai: (Rinnai) ----> 'Images' '{}' |
|               | 2021-07                                             |
|               | -06 15:18:34.308 Rinnai: (Rinnai) ----> 'Settings'  |
|               | '{'DB_Version': '148', 'Title': 'Domoticz', 'LightH |
|               | istoryDays': '30', ... 'MaxElectricPower': '6000'}' |
|               | ```                                                 |
+---------------+-----------------------------------------------------+
|               |                                                     |
+---------------+-----------------------------------------------------+

## Protocol Details {#protocol_details}

+------------+--------------------------------------------------------+
| Protocol   | Details                                                |
+============+========================================================+
| HTTP/HTTPS | HTTP and HTTPS are handled the same from a protocol    |
|            | perspective. HTTPS signals the underlying transport to |
|            | use SSL/TLS, see                                       |
|            | [Connections](https://www.domo                         |
|            | ticz.com/wiki/Developing_a_Python_plugin#Connections). |
|            | The HTTP protocol handles incoming and outgoing        |
|            | messages for both client connections requesting        |
|            | content from remote websites and server side listeners |
|            | waiting incoming requests. Data is passed to the       |
|            | protocol (Connection.Send()) and passed back to the    |
|            | plugin (onMessage) using dictionaries. Key values in   |
|            | these directories are described below with an emphasis |
|            | on the impact they have to what Domoticz transmits.    |
|            |                                                        |
|            | +---------+---------------------------------------+    |
|            | | Key     | Details                               |    |
|            | +=========+=======================================+    |
|            | | Verb    | Any valid HTTP verb (GET, POST etc)   |    |
|            | |         | although the passed value is not      |    |
|            | |         | checked but is converted to upper     |    |
|            | |         | case. If this key is present then an  |    |
|            | |         | HTTP Request will be created and sent |    |
|            | +---------+---------------------------------------+    |
|            | | Status  | String value with the HTTP Response   |    |
|            | |         | numeric code and text (e.g \'200 OK\' |    |
|            | |         | for success). The value is not        |    |
|            | |         | checked but sent as is. If this key   |    |
|            | |         | is present then an HTTP Response will |    |
|            | |         | be created and sent. Will be ignored  |    |
|            | |         | if \'Verb\' was specified.            |    |
|            | +---------+---------------------------------------+    |
|            | | URL     | The URL HTTP requests. Defaults to    |    |
|            | |         | \"/\"                                 |    |
|            | +---------+---------------------------------------+    |
|            | | Headers | A disctionary of headers to inject    |    |
|            | |         | into the request/response. Dictionary |    |
|            | |         | keys are header names and values are  |    |
|            | |         | header values. No processing is done  |    |
|            | |         | on the headers, they are passed as is |    |
|            | |         | but should ideally be capitalised by  |    |
|            | |         | convention.\                          |    |
|            | |         | Header values can be Unicode          |    |
|            | |         | (string), Bytes, ByteArrays or Lists  |    |
|            | |         | (for multiple values).\               |    |
|            | |         | Extra headers are conditionally       |    |
|            | |         | injected when the \'Verb\' or         |    |
|            | |         | \'Status\' key are present:           |    |
|            | |         |                                       |    |
|            | |         |   Header                Details       |    |
|            | |         |   --------------------- ----          |    |
|            | |         | ------------------------------------- |    |
|            | |         | ------------------------------------- |    |
|            | |         | ------------------------------------- |    |
|            | |         | ------------------------------------- |    |
|            | |         |   Authorization:Basic   If            |    |
|            | |         |  no \'Authorization:Basic\' header is |    |
|            | |         |  present for a Request but the Parame |    |
|            | |         | ters dictionary has Username and Pass |    |
|            | |         | word values then one will be created. |    |
|            | |         |   Date                  If no \'      |    |
|            | |         | Date\' header is present for a Respon |    |
|            | |         | se then one will be injected with the |    |
|            | |         |  value match the current system time. |    |
|            | |         |   User-Agent                          |    |
|            | |         | If no \'User-Agent\' header is presen |    |
|            | |         | t for a Request then one will be inje |    |
|            | |         | cted with the value \'Domoticz/1.0\'. |    |
|            | |         |   Server                              |    |
|            | |         |    If no \'Server\' header is present |    |
|            | |         |  for a Response then one will be inje |    |
|            | |         | cted with the value \'Domoticz/1.0\'. |    |
|            | |         |                                       |    |
|            | |         |  Content-Length        If no \'Conten |    |
|            | |         | t-Length\' header is present then one |    |
|            | |         |  will be injected with the value matc |    |
|            | |         | hing the length of the supplied Data. |    |
|            | |         |   Transfer-Encoding                   |    |
|            | |         |  If no \'Transfer-Encoding\' header i |    |
|            | |         | s present and \'Status\' and \'Chunk\ |    |
|            | |         | ' keys are specified then one will be |    |
|            | |         |  injected with the value \'Chunked\'. |    |
|            | +---------+---------------------------------------+    |
|            | | Data    | The data to be sent. This can be a    |    |
|            | |         | unicode string, bytes or a byte       |    |
|            | |         | array.                                |    |
|            | +---------+---------------------------------------+    |
|            | | Chunk   | Used during Responses only, Value is  |    |
|            | |         | irrelevant. Presence of this key      |    |
|            | |         | informs the framework that this that  |    |
|            | |         | is a partial HTTP Response using      |    |
|            | |         | [chunked transfer                     |    |
|            | |         | encoding](https://en.wikipedia        |    |
|            | |         | .org/wiki/Chunked_transfer_encoding). |    |
|            | |         | This encoding is used for large       |    |
|            | |         | responses to break them up or to      |    |
|            | |         | return partial data to a client       |    |
|            | |         | early. Sending chunked messages       |    |
|            | |         | should be be done using a sequence of |    |
|            | |         | Send directives like this:            |    |
|            | |         |                                       |    |
|            | |         | ``` python3                           |    |
|            | |         |   myConnection.Sen                    |    |
|            | |         | d({'Status':'200 OK', 'Headers':{'Con |    |
|            | |         | tent-Type': 'text/html'}, 'Chunk':Tru |    |
|            | |         | e, 'Data':'This is the first chunk'}) |    |
|            | |         |   myConnection.Send({'Chunk':True     |    |
|            | |         | , 'Data':'This is the second chunk'}) |    |
|            | |         |   m                                   |    |
|            | |         | yConnection.Send({'Chunk':True, 'Data |    |
|            | |         | ':'This is the last chunk'}, Delay=1) |    |
|            | |         |   myC                                 |    |
|            | |         | onnection.Send({'Chunk':True}, Delay= |    |
|            | |         | 1) # this will terminate the response |    |
|            | |         | ```                                   |    |
|            | |         |                                       |    |
|            | |         | Domoticz will send the data as fast   |    |
|            | |         | as it can so using the \'Delay\'      |    |
|            | |         | parameter to slow transmission of     |    |
|            | |         | large responses can prevent           |    |
|            | |         | overloading slow clients              |    |
|            | +---------+---------------------------------------+    |
+------------+--------------------------------------------------------+
| WS/WSS     | WebSockets (WS) and Secure WebSockets (WSS) are        |
|            | handled the same from a protocol perspective. WSS      |
|            | signals the underlying transport to use SSL/TLS.       |
|            | WebSocket connections are initially made over HTTP and |
|            | then \'upgraded\' to be Web Sockets. This means that   |
|            | the message parameters (and matching response) use the |
|            | protocol details for HTTP until the Server switches to |
|            | the WebSocket protocol. Successful upgrades to the     |
|            | WebSocket protocol are signalled by an HTTP response   |
|            | with a \"Status\" of \"101\".                          |
|            |                                                        |
|            | An example WebSockets client plugin can be found in    |
|            | the /plugins/examples folder.                          |
|            |                                                        |
|            | During the initial post connection message, the        |
|            | following HTTP headers will be injected if they are    |
|            | not supplied but can be overridden:                    |
|            |                                                        |
|            | -   Accept (\*/\*)                                     |
|            | -   Accept-Language (en-US,en;q=0.9)                   |
|            | -   Accept-Encoding (gzip, deflate)                    |
|            | -   Connection (keep-alive, Upgrade)                   |
|            | -   Sec-WebSocket-Version (13)                         |
|            | -   Sec-WebSocket-Extensions (permessage-deflate)      |
|            | -   Upgrade (websocket)                                |
|            | -   User-Agent (Domoticz/1.0)                          |
|            | -   Pragma (no-cache)                                  |
|            | -   Cache-Control (no-cache)                           |
|            |                                                        |
|            | WebSocket servers that the author tested with required |
|            | values for \'Host\', \'Origin\' and                    |
|            | \'Sec-WebSocket-Key\' in addition to the above list    |
|            | for example:                                           |
|            |                                                        |
|            | ``` python3                                            |
|            |                                                        |
|            |  def onConnect(self, Connection, Status, Description): |
|            |         if Status == 0:                                |
|            |             Domoticz.Log("Connected successful         |
|            | ly to: " + Connection.Address + ":" + Connection.Port) |
|            |             # End point                                |
|            | is now connected so request the upgrade to Web Sockets |
|            |             send_data = {'URL': Parameters["Mode1"],   |
|            |                                                        |
|            |             'Headers': {'Host': Parameters["Address"], |
|            |                                                        |
|            |          'Origin': 'https://' + Parameters["Address"], |
|            |                                                        |
|            |                             'Sec-WebSocket-Key': base6 |
|            | 4.b64encode(secrets.token_bytes(16)).decode("utf-8")}} |
|            |             Connection.Send(send_data)                 |
|            | ```                                                    |
|            |                                                        |
|            | Data is passed to the protocol (Connection.Send()) and |
|            | passed back to the plugin (onMessage) using            |
|            | dictionaries. Key values in these directories are      |
|            | described below.                                       |
|            |                                                        |
|            | +-----------+-------------------------------------+    |
|            | | Key       | Details                             |    |
|            | +===========+=====================================+    |
|            | | Operation | WebSocket control messages, can be  |    |
|            | |           | sent or recieved. Valid Values:     |    |
|            | |           | \"Ping\", \"Pong\" and \"Close\".   |    |
|            | |           |                                     |    |
|            | |           | Not required (or supplied) for      |    |
|            | |           | nornal data transfer mesages.       |    |
|            | |           |                                     |    |
|            | |           | The plugin must respond to incoming |    |
|            | |           | \"Ping\" messages with a \"Pong\"   |    |
|            | |           | otherwise the server may terminate  |    |
|            | |           | the connection.                     |    |
|            | |           |                                     |    |
|            | |           | ``` python3                         |    |
|            | |           |     def                             |    |
|            | |           |  onMessage(self, Connection, Data): |    |
|            | |           |         if "Operation" in           |    |
|            | |           |  Data:  # WebSocket control message |    |
|            | |           |                                     |    |
|            | |           |     if Data["Operation"] == "Ping": |    |
|            | |           |                 Connection.Send({   |    |
|            | |           | 'Operation': 'Pong', 'Payload': 'Po |    |
|            | |           | ng', 'Mask': secrets.randbits(32)}) |    |
|            | |           | ```                                 |    |
|            | +-----------+-------------------------------------+    |
|            | | Payload   | Message data. Can be of type String |    |
|            | |           | (Text Messages), Bytes or ByteArray |    |
|            | |           | (Binary messages).                  |    |
|            | +-----------+-------------------------------------+    |
|            | | Mask      | Data mask for security purposes.    |    |
|            | |           | Technically this is optional but    |    |
|            | |           | many servers will require it to be  |    |
|            | |           | specified.                          |    |
|            | |           |                                     |    |
|            | |           | ``` python3                         |    |
|            | |           | import secrets                      |    |
|            | |           | ...                                 |    |
|            | |           |                                     |    |
|            | |           |  if self.websocketConn.Connected(): |    |
|            | |           |             self.websock            |    |
|            | |           | etConn.Send({'Payload': 'Text messa |    |
|            | |           | ge', 'Mask': secrets.randbits(32)}) |    |
|            | |           | ...                                 |    |
|            | |           | ```                                 |    |
|            | +-----------+-------------------------------------+    |
|            | | Finish    | Indicates that this is the final    |    |
|            | |           | data for a message. Domoticz will   |    |
|            | |           | return each individual message to   |    |
|            | |           | the plugin but the server may break |    |
|            | |           | a large message into several        |    |
|            | |           | separate messages, when this flag   |    |
|            | |           | is False the plugin should expect   |    |
|            | |           | more data in a subsequent onMessage |    |
|            | |           | call.                               |    |
|            | +-----------+-------------------------------------+    |
+------------+--------------------------------------------------------+

## UI

There is no built-in capabilities to create UI for plugin but you can
use workaround with Domoticz Custom Page

Example of complex UI implementation you can find in [this
plugin](https://github.com/stas-demydiuk/domoticz-zigbee2mqtt-plugin)

### Setup custom page within plugin {#setup_custom_page_within_plugin}

1.  Create custom HTML file in your plugins\' folder, let\'s assume it
    is index.html
2.  General idea is to install custom page when your plugin starts and
    remove it when plugin stops. To do so you need to modify your
    plugin\'s onStart and onStop methods. Base folder for Python will be
    Domoticz root (not your plugin root)

\... from shutil import copy2 import os \...

class Plugin:

` def onStart(self):`\
`   ...`\
`   copy2('./plugins/myplugin/index.html', './www/templates/myplugin.html')`

` def onStop(self):`\
`   ...`\
`   if (os.path.exists('./www/templates/myplugin.html')):`\
`     os.remove('./www/templates/myplugin.html')`

```{=html}
</syntaxhighlight>
```
### Connect your page to Domoticz UI core {#connect_your_page_to_domoticz_ui_core}

Domoticz uses AngularJS framework for its UI. Additionally it uses
requirejs library for lazy loading. It is not required to follow the
same patterns in your custom pages but following them will allow to
access built-in classes and components. Every custom page would be
loaded and rendered as template for AngularJS framework with access to
\$rootScope and other global variables.

Example of custom page with access to AngularJS and domoticzApi service:

``` html
<!-- Placeholder for page content -->
<div id="plugin-view"></div>

<!-- Template for custom component -->
<script type="text/ng-template" id="app/myplugin/sampleComponent.html">
    <div class="container">
        <a class="btnstylerev" back-button>{{ ::'Back' | translate }}</a>
        <h2 class="page-header">My Plugin UI</h2>
        <p>{{ $ctrl.message }}</p>
    </div>
</script>

<script>
    require(['app'], function(app) {
        // Custom component definition
        app.component('myPluginRoot', {
            templateUrl: 'app/myplugin/sampleComponent.html',
            controller: function($scope, domoticzApi) {
                var $ctrl = this;
                $ctrl.message = 'This is my plugin'
            }
        });

        // This piece triggers Angular to re-render page with custom components support
        angular.element(document).injector().invoke(function($compile) {
            var $div = angular.element('<my-plugin-root />');
            angular.element('#plugin-view').append($div);

            var scope = angular.element($div).scope();
            $compile($div)(scope);
        });
    });
</script>
```

## Examples

There are a number of examples that are available that show potential
usages and patterns that may be useful that can be found [on
Github](https://github.com/domoticz/domoticz/tree/development/plugins/examples):

+-------------------+-------------------------------------------------+
| Example           | Description                                     |
+===================+=================================================+
| Base Template     | A good starting point for developing a plugin.  |
+-------------------+-------------------------------------------------+
| Denon/Marantz     | Support for Denon AVR amplifiers.               |
|                   |                                                 |
|                   | -   TCP/IP connectivity over Telnet using Line  |
|                   |     protocol.                                   |
|                   | -   Sending delays when the amplifier is        |
|                   |     powering on.                                |
|                   | -   Dynamic creation of Selector Switches       |
|                   | -   Dynamic discovery using UDP/IP              |
+-------------------+-------------------------------------------------+
| DLink DSP-W215    | TCP/IP connectivity using HTTP protocol.        |
|                   |                                                 |
|                   | -   Features use of SOAP to demonstrate use of  |
|                   |     HTTP headers                                |
+-------------------+-------------------------------------------------+
| HTTP              | Shows how to do HTTP connections and handle     |
|                   | redirects.                                      |
+-------------------+-------------------------------------------------+
| HTTP Listener     | Shows how to listen for incoming connections.   |
|                   |                                                 |
|                   | -   Implements a simple webserver and connects  |
|                   |     to itself.                                  |
+-------------------+-------------------------------------------------+
| Kodi              | Alternate Kodi plugin to the built in one.      |
|                   |                                                 |
|                   | -   TCP/IP connectivity and use of the JSON     |
|                   |     protocol.                                   |
|                   | -   Features three additional devices in        |
|                   |     Domoticz                                    |
+-------------------+-------------------------------------------------+
| RAVEn             | Alternate RAVEn Energy Monitor plugin to the    |
|                   | built in one.                                   |
|                   |                                                 |
|                   | -   Serial Port use with the XML protocol       |
+-------------------+-------------------------------------------------+
| UDP Discovery     | Logs incoming UDP Broadcast messages for either |
|                   | Dynamic Device Discovery (DDD) or Simple        |
|                   | Service Discovery Protocol (SSDP) protocols     |
|                   |                                                 |
|                   | -   UDP/IP Listening                            |
+-------------------+-------------------------------------------------+
| Mutli-Threaded    | Starts a Queue on a thread to write log         |
|                   | messages and shuts down properly                |
+-------------------+-------------------------------------------------+
| Web Socket Client | Establishes a Web Socket connection and shows   |
|                   | how to send and recieve messages                |
+-------------------+-------------------------------------------------+
|                   |                                                 |
+-------------------+-------------------------------------------------+

## Troubleshooting

### Importing Modules Fails {#importing_modules_fails}

Python \'import\' that are unsuccessful will stop the entrie plugin from
importing and running unless they are wrapped within a
\'try\'/\'except\' pair. If a module is not found the Plugin Framework
will provide as much information as it gets from Python. For example, an
attempt to `import fakemodule` in a plugin called \'Google Devices\'
will be reported like this in the Domoticz log:

` 2019-03-23 17:17:44.483  Error: (GoogleDevs) failed to load 'plugin.py', Python Path used was '/home/domoticz/plugins/Domoticz-Google-Plugin/:/usr/lib/python36.zip:/usr/lib/python3.6:/usr/lib/python3.6:/usr/lib/python3.6/lib-dynload:/usr/local/lib/python3.6/dist-packages:/usr/lib/python3/dist-packages:/usr/lib/python3.6/dist-packages'.`\
` 2019-03-23 17:17:44.483  Error: (Google Devices) Module Import failed, exception: 'ModuleNotFoundError'`\
` 2019-03-23 17:17:44.483  Error: (Google Devices) Module Import failed: ' Name: fakemodule'`\
` 2019-03-23 17:17:44.483  Error: (Google Devices) Error Line details not available.`

the framework shows the directories it searches. Broadly these are: the
plugin directory, the existing Python path as picked up when Domoticz
started and the \'site\' directories for **system level modules**
installed with pip3. Local \'site\' directories are not searched by
defaul although plugin developers can add any directory the like to the
path inside the plugin. Pip3 installs packages in system directories
when sudo is used on linux platforms.

### Plugin Crashes Domoticz {#plugin_crashes_domoticz}

Yes, this is unfortunately possible. Python3 itself is vulnerable to
segmentation faults and Domoticz just inherits this. If you don\'t
believe me try typing `python3 -c "import ctypes; ctypes.string_at(0)"`
at a linux command line with Python installed.\
To help troubleshoot these issues the Plugin Framework attempts to load
the standard \'faulthandler\' module for each plugin just before the
plugin itself is loaded. If the plugin triggers any signals a thread by
thread stack trace will be printed. To see this you will need to run
Domoticz from the command line or redirect sys.stderr to a file ([how
would I do
that?](https://stackoverflow.com/questions/1956142/how-to-redirect-stderr-in-python))\
\
Output for a multi-threaded plugin will look something like this, a
Python stack trace followed by a normal Domoticz one. The offending line
in the plugin is shown in bold:

`   Fatal Python error: Segmentation fault`\
`   `\
`   Thread 0xa8d0eb40 (most recent call first):`\
`     File "/usr/local/lib/python3.6/dist-packages/pychromecast/socket_client.py", line 361 in run_once`\
`     File "/usr/local/lib/python3.6/dist-packages/pychromecast/socket_client.py", line 341 in run`\
`     File "/usr/lib/python3.6/threading.py", line 916 in _bootstrap_inner`\
`     File "/usr/lib/python3.6/threading.py", line 884 in _bootstrap`\
`   `\
`   Current thread 0xab553b40 (most recent call first):`\
`   ....`\
`     File "<frozen importlib._bootstrap>", line 219 in _call_with_frames_removed`\
`     File "<frozen importlib._bootstrap_external>", line 678 in exec_module`\
`     File "<frozen importlib._bootstrap>", line 665 in _load_unlocked`\
`     File "<frozen importlib._bootstrap>", line 955 in _find_and_load_unlocked`\
`     File "<frozen importlib._bootstrap>", line 971 in _find_and_load`\
`     `**`File "/home/domoticz/plugins/Domoticz-Google-Plugin/plugin.py", line 322 in handleMessage`**\
`     File "/usr/lib/python3.6/threading.py", line 864 in run`\
`     File "/usr/lib/python3.6/threading.py", line 916 in _bootstrap_inner`\
`     File "/usr/lib/python3.6/threading.py", line 884 in _bootstrap`\
`   `\
`   Thread 0xad597b40 (most recent call first):`\
`     File "/usr/lib/python3.6/threading.py", line 299 in wait`\
`     File "/usr/local/lib/python3.6/dist-packages/zeroconf.py", line 1794 in wait`\
`     File "/usr/local/lib/python3.6/dist-packages/zeroconf.py", line 1365 in run`\
`     File "/usr/lib/python3.6/threading.py", line 916 in _bootstrap_inner`\
`     File "/usr/lib/python3.6/threading.py", line 884 in _bootstrap`\
`   `\
`   Thread 0xb57cfb40 (most recent call first):`\
`   2019-03-23 11:21:04.003  Error: Domoticz(pid:24259, tid:24500('PluginMgr')) received fatal signal 11 (Segmentation fault)`\
`   2019-03-23 11:21:04.003  Error: siginfo address=0x5ec3, address=0xb7f51d09`\
`   2019-03-23 11:21:04.741  Error: Thread 19 (Thread 0xab553b40 (LWP 24500)):`\
`   2019-03-23 11:21:04.741  Error: #0  0xb7f51d09 in __kernel_vsyscall ()`\
`   ...`

### Debugging

Debugging embedded Python can be done using the standard pdb
functionality that comes with Python using the `rpdb` (or \'Remote
PDB\') Python library.\
\
The only restriction is that it can not be done from a debug instance of
Domoticz running in Visual Studio on Windows.\
\
Download the `rpdb` library from <https://pypi.python.org/pypi/rpdb/>
and drop the \'rpdb\' directory into the directory of the plugin to be
debugged (or anywhere in the Python path). Alternatively, if pip3 is
installed (`sudo apt install python3-pip` if on Raspian or a Debian
distro) then install the debugger using `sudo pip3 install rpdb`

Import the library using something like:

`   def onStart(self):`\
`       if Parameters["Mode6"] == "Debug":`\
`           Domoticz.Debugging(1)`\
`           Domoticz.Log("Debugger started, use 'telnet 0.0.0.0 4444' to connect")`\
`           import rpdb`\
`           rpdb.set_trace()`\
`       else:`\
`         Domoticz.Log("onStart called")`

The `rpdb.set_trace()` command causes the Python Framework to be halted
and a debugger session to be started on port 4444. For the code above
the Domoticz log will show something like:

` 2017-04-17 15:39:25.448  (MyPlugin) Initialized version 1.0.0, author 'dnpwwo'`\
` 2017-04-17 15:39:25.448  (MyPlugin) Debug log level set to: 'true'.`\
` 2017-04-17 15:39:25.448  (MyPlugin) Debugger started, use 'telnet 0.0.0.0 4444' to connect`\
` pdb is running on 127.0.0.1:4444`

Connect to the debugger using a command line tool such as Telnet.
Attaching to the debugger looks like this if you start the session on
the same machine as Domoticz, otherwise supply the Domoticz IP address
instead of \'0.0.0.0\':

`pi@bob:~$ telnet 0.0.0.0 4444 `\
`Trying 0.0.0.0...`\
`Connected to 0.0.0.0.`\
`Escape character is '^]'.`\
`--Return--`\
`> /home/pi/domoticz/plugins/MyPlugin/plugin.py(30)onStart()->None`\
`-> rpdb.set_trace()`\
`(Pdb)`

enter commands at the prompt such as:

`(Pdb) l  `\
` 25        def onStart(self):`\
` 26            if Parameters["Mode6"] == "Debug":`\
` 27                Domoticz.Debugging(1)`\
` 28                Domoticz.Log("Debugger started, use 'telnet 0.0.0.0 4444' to connect")`\
` 29                import rpdb`\
` 30  ->                rpdb.set_trace()`\
` 31            else:`\
` 32              Domoticz.Log("onStart called")`\
` 33    `\
` 34        def onStop(self):`\
` 35            Domoticz.Log("onStop called")`\
`(Pdb) pp Parameters`\
` {'Address': `*`,`*\
` 'Author': 'dnpwwo',`\
` 'HardwareID': 7,`\
` 'HomeFolder': '/home/pi/domoticz/plugins/MyPlugin/',`\
` 'Key': 'Debug',`\
` 'Mode1': `*`,`*\
` 'Mode2': `*`,`*\
` 'Mode3': `*`,`*\
` 'Mode4': `*`,`*\
` 'Mode5': `*`,`*\
` 'Mode6': 'Debug',`\
` 'Name': 'MyPlugin',`\
` 'Password': `*`,`*\
` 'Port': '4444',`\
` 'SerialPort': `*`,`*\
` 'Username': `*`,`*\
` 'Version': '1.0.0'}`\
`(Pdb) b 53`\
`Breakpoint 1 at /home/pi/domoticz/plugins/MyPlugin/plugin.py:53`\
`(Pdb) continue`\
`> /home/pi/domoticz/plugins/MyPlugin/plugin.py(53)onHeartbeat()`\
`-> Domoticz.Log("onHeartbeat called")`\
`(Pdb) ll`\
` 52        def onHeartbeat(self):`\
` 53 B->            Domoticz.Log("onHeartbeat called")`\
`(Pdb) `

Details of debugging commands can be found here:
<https://docs.python.org/3/library/pdb.html#debugger-commands>\

[Category:Domoticz](Category:Domoticz "wikilink")
[Category:Manual](Category:Manual "wikilink")
[Category:Setup](Category:Setup "wikilink")
[Category:Software](Category:Software "wikilink")
[Category:Scripting‏‎](Category:Scripting‏‎ "wikilink")
[Category:JSON](Category:JSON "wikilink")
[Category:Plugins](Category:Plugins "wikilink")
[Category:Python](Category:Python "wikilink")
