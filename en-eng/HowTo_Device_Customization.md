# How-To Customize Devices

## Overview

It might happen that your device is well paired with the coordinator and the plugin, but do not behave has expected.
The plugin is providing a way to overwrite the Zigbee standard behaviour by adding specifics to the device plugin configuration.

## Properties

| Level      | Object Name              | default | Description |
| -----      | -----------              | ------- | ----------- |
| main       | ClusterId                |         |  Cluster ID defined in this json file |
| main       | Description              |         |  Description of the Cluster ID |
| main       | Version                  |         |  Version number of this cluster definition |
| main       | Enabled                  |         |  Is this Cluster definition is enabled or not |
| main       | Attributes               |         |  list of Attribute and their definition |
| attribute  | xxxx                     |         |  Object describing attribute xxxx of ClusterId |
| attribute  | Enabled                  |         |  Is this attribute definition enabled or nor |
| attribute  | Name                     |         |  Name of the attribute |
| attribute  | DataType                 |         |  Attribute data type in hexa |
| attribute  | Range                    |         |  Attribute value ranges in hexa |
| attribute  | Acc                      |         |  Attribute access right ( RP: Reporting, R: read, W, write |
| attribute  | Default                  |         |  Attribute default value |
| attribute  | Mandatory                |         |  Attribute mandatory flag. |
| attribute  | DomoClusterType          |         |  Plugin ClusterType info ( Lux, Switch, Motion, ...) |
| attribute  | EvalExp                  |  value  |  string containing a forumla to compute the attribute value. Based on python3 eval() function|
| attribute  | EvalFunc                 |         |  Function name define in a module in the DevicesModules (see Devices modules for more info.) |
| attribute  | ActionList               |         |  List of action(s) to be triggered
| attribute  | DecodedValueList         |         |  List of values with a decoded value in string |
| attribute  | SpecialValues            |         |  List of special values |
| attribute  | ValidValuesDomoDevices  | True    | Evaluation which should return True or False, and which will condition the MajDomoDevice call |
| attribute  | DomoDeviceFormat        | result of eval |  format on how the value should be formated before sent to majDomoDevice ( str, float, int ) |
| attribute  | UpdDomoDeviceWithCluster |         |  Force to do the majDomoDevice on a specified Cluster , despite the current clsuter |
| attribute  | UpdDomoDeviceWithAttibute| none    |  Force to do the majDomoDevice on a specific attribute |
| attribute  | ValueOverwrite           |         |  Overwrite the value, by the one given here |
| attribute  | EvalExpCustomVariables   |         |  list of variables to be retreived in the device.  {"yyy": { "Cluster": "0403", "Attribute": "0014"}} |
| evalInputs | yyyy                     |         |  variable name to be used in the eval string |
| evalInputs | ClusterId                |         |  cluster from which the variable value should be retreived |
| evalInputs | AttributeId              |         |  attribute from which the variable should be retreived |

## __action__

| name          | function |
| ----          | -------- |
| check_store_value    | store the value to the corresponding Ep, Cluster,Attribute |
| upd_domo_device | request an update of the corresponding ClusterType for this value of Cluster|

## evaluation

* _value_ is a special variable which contained the zigbee device value

1. Transform a centi-degree _value_ into degree

    ``` "eval": "round(int(value) / 100, 1)", ```

2. transform the received data ( _value_ ) into the Atmo Pressure as per the Zigbee standard

    ``` "eval": "round(int(value) * pow( 10, scale), 1)", ```

3. transform the Scaled Pressure measurement.

   1. retreive the _scale_ in attribute 0x0014 of cluster 0x0403
   2. evaluate the the formula with the retreived _scale_ information

    ```json
    {
     "evalInputs": {"scale": { "Cluster": "0403", "Attribute": "0014"}},
     "eval": "round(int(value) * pow( 10, scale), 1)",
    }
     ```

## Device module

### overview

instead of using eval which is limited to simple expression, you can implement a full python function to handle the value as an input and return the result.
If returning None, no action will be taken

### How-to

1. Create your python3 module file in the  `DevicesModules`folder
1. Code your custom function in the \<manufacturer\>.py module

    * The function can take only 2 parameters `self` and `value`
    * The function must return something

    ```python
    def custom_<manufactuer>_function(self, value):

        return value
    ```

1. Integrate the function in the flow
    1. Edit the file DevicesModules/__init__.py, just follow the same as what has already been done
       * import your module
       * link the function to the stanza you will put in the conf file

    ```python
    from DevicesModules.custom_konke import konke_onoff

    FUNCTION_MODULE = {
        "konke_onoff": konke_onoff,
    }
    ```
