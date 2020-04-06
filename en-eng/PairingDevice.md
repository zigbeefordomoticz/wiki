# Pairing a Zigbee device with Zigate


## Introduction

Purpose is to explain the step process to pair a new device and get it into Domoticz


## Step1: Put Domoticz in 'Add New Hardware mode'

1. Check that Domoticz accept new Hardware Devices
   * Go in the Domoticz Setting menu, and check that Accept new Hardware Devices is enabled, as on the picture here after
   
   ![Domoticz Accept New Hardware](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/DzHardwareMode.png)


## Step2: Pairing and Provisioning in Domoticz

1. Assited Provisioning

   1. Go to the Admin -> Provisioning menu

      ![Domoticz Accept New Hardware](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images//Provisionning_1.png)
 
      from here you have 4 choices

      1. Use the Assisted Provisioning mode
      1. Accept new Hardware for a period of 4 minutes (same as section 2 but for a limited period of time)
      1. Accept new Hardware in a permanent maner (same as section 2)
      1. Stop accepting new Hardware
   
   1. Go for "Assisted Provisioning"

      ![Assisted Provisioning: Start](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Provisionning_2.png)

   1. Reset your Device to trigger the pairing

      ![Assisted Provisioning: Done](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Provisionning_3.png)

   1. If after a while ( 2 minutes ) nothing happen
   
      1. Check Domoticz Log to se if there is no error
      1. Restart the plugin and try the pairing once more time
      
1. Advanced provisioning

Here we will more rely on the Logs to see that the Provisioning is happening. The Domoticz logs are available via the Domoticz User Interface. 
You can eventually add a filter to get only the related logs

  1. You can check if the Accept new hardware`
  
  ![Domoticz Accept New Hardware](https://github.com/pipiche38/Domoticz-Zigate-Wiki/blob/master/Images/Dashboard_Accept_new_Hardware.png)
  
  You can easily switch it On, and the Zigate blue Led, must start flashing.
  
  1. reset the Device to trgger the pairing
  
  1. Watch the Domoticz log to see what is happening
  
  
