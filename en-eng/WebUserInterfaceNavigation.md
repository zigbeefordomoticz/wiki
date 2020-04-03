# Zigate Web Admin Interface

You have a navigation tab in the header bar, from which you can move to
- Dashboard
- Group and Device management
- Network Topology and Energy graphical presentation
- Admin commands
- Settings
- Admin tools

## 1. Dashboard
![Zigate Web Admin Interface](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Dashboard.png)

This is a Plugin Dashboard from which you can in a short time if anything else is going wrong on the Zigate environment.
This is some how self explanatory and you have comments for eahc section.
In the header where you have the navigation tabs, you have also a switch which allow you to move Zigate and plugin into Pairing Mode (In case Zigate is already in pairing mode, the switch will automatically enabled).

In the footer (here in Green) you have some quick overview of :
* when the plugin has been started
* a quick plugin status "Ready" here
* the Plugin Version
* the Firmware version on Zigate

## 2. Group and Device Management
### 2.1 Device Management

![Device Management](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Device-Management.png)

The Device Management can be used for 2 purposes:

* To assign a Friendly name to each of your devices, so it will be easier to identify them

* To get more information such as :
  * what are ShortId (Network Address) and IEEE (Mac Address) of the device
  * what is the Model Name
  * what are the Domoticz Widget names attached to this device
  * an Health status
  
### 2.2 Group Management

![Group Management](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Group-Management.png)

## 3. Network Topology and Energy

### 31. Network Topology

![Network Topology](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Network_Topology.png)

At plugin start a report is triggered. It could take up to 15' to get the report extracted.
You can after that manually trigger a scan

All available reports are available in the upper-left list, sorted by date. From the list you can either:
* delete a report
* display the report

There are 2 graphical representations of the report.

#### Left: Topology weel

Here are shown on a weel, all links between 2 devices. If you leave the mouse on a link, you'll see the direction and a number which correspond to the Link Quality ( the worst is 0, the best is 255).

#### Right: Topology graph

Here you can see more the hierarchical structure of your Zigbee network.

### 3.2 Network Energy 

![Network Energy ](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/InterferenceLevels.png)
