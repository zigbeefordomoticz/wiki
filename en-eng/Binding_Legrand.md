# How to Bind Legrand-Netatmo Remote with a Micromodule


## Overview

Purpose of this page is to document how to bind a "Double gangs remote switch_Legrand" with a "Micromodule".

This will be applicable for most of the devices as soon as they support binding between 2 end devices


## Step 1 : Pairing

1. Put the Zigate in Pairing mode
1. Pair the "Micromodule" with Zigate, and check after pairing that you can command the Micromodule from Domoticz
1. Pair the "Double gangs remote" with Zigate, and check that any actions on the remote is seen on Domoticz

At that stage you should have :

1. One widget for the Micromodule
1. 2 widgets for the Double Gange Remote ( one widget for the left gang and one widget for the right gang)

You can easily check which widget is the left and the right, 

Here after is an exemple of the 2 widgets created. Notices the '-01' and '-02'

```
DIN Zigate - Double gangs remote switch_LegrandSelector-000474000082702a-01
DIN Zigate - Double gangs remote switch_LegrandSelector-000474000082702a-02
```

Here after is an example of the widget created. 

```
DIN Zigate - Micromodule switch_Switch-00047400001f09a4-01
```


## Step 2: Bindings

We are going to bind the On/Off cluster ( 0x0006 ) between the Double gangs remote switch (Left or Right) with the Micromodule.
For such , we are going to use the Web Admin page 

![Bindings](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Binding.png)


### What to bind

* Cluster: 0x0006  ( ON and OFF )
* Cluster: 0x0008  ( Dimmer and Level Control )





