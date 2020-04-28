# Configuration file for Devices


## Introduction


Purpose is to have a way to customize how a particular device must be handled accross the plugin.
Indeed by default, the plugin try to process each devices has much as it can. But some devices/brands are quiet specifics.


## Folder and File structures

The Device config files have to be store under the Conf/Certified directory.
A principle is to have one brand per directory and then the device config files underneeth. 
Each file are a JSON based structure

The filename is the device Model name to which we associate the '.json'

For exemple:

The Philips HUE Motion Sensor as a Model Name : `SML001`
The Config file name can be found : `Conf/Certified/Philips/SML001.json`

## Config File Parameters

| Parameter | Type | Mandatory | Description |
| --------- | ---- | --------- | ----------- |
| _comment  | string | Option | a comment associated to the file |
| _version  | string | Option | a version related to this file |
| Ep        | JSON | Mandatory | Device Endpoint list and attributes |
| Type      | string | Mandatory |  not used any more |
| ClusterToUnbind| List of strings | Option | List of Cluster to unbind from Zigate before |
| ClusterToBind | list of strings | Mandatory | List of Cluster to bind to Zigate |
| bindEp    | list of strings | Option |  Restricted List of device Endpoint to bind |
| overwriteZigateEpBind | string | Zigate Endpoint is "01" , you might want to over write it |
| ConfigureReporting | JSON | Mandatory | Cluster and Attribute to configure for reporting |
| ReadAttributes | JSOn | Mandatory | Cluster and Attributes for polling |



`
