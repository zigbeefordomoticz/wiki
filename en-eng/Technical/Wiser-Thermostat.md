Wiser-Thermostat

Click once on thermostat - sync with controller about current temperature setpoint and update ambient temperature to actuator

| Source|Destination|Payload | action | ep |cluster|attribute |data type| value|
| :---- | :-------- | :----- |:------ |:--- |:---  |:------- |:------ |:---- |
| Thermostat|Controler| report ambient temperature| report attribute|11|0x0402|0x0000|0x29|temp*100|
| Thermostat|Actuator| report ambient temperature| report attribute|11|0x0402|0x0000|0x29|temp*100|
| Actuator|Controler| report ambient temperature| report attribute|11|0x0402|0x0000|0x29|temp*100|
||||||||||
| Thermostat|Actuator| ask for setpoint| read attribute|11|0x0201|0x0012| ||
| Actuator|Thermostat| answer setpoint | read attribute|11|0x0201|0x0012|0x29|temp*100|
| Actuator|Controler| ask for setpoint| read attribute|11|0x0201|0x0012|||
| Controler|Actuator| answer setpoint| read attribute|11|0x0201|0x0012|0x29|temp*100|
||||||||||
| Thermostat|Actuator| ask for mode| read attribute|11|0x0201|0xe010|||
| Actuator|Thermostat| asnwer mode| read attribute|11|0x0201|0xe010|0x30|mode|
| Actuator|Controler| ask for mode| read attribute|11|0x0201|0xe010|||
| Controler|Actuator| answer mode| read attribute|11|0x0201|0xe010|0x30|mode|
||||||||||
| Thermostat|Actuator| ask for maxHeatingsetpoint| read attribute|11|0x0201|0x0016 | ||
| Actuator|Thermostat| answer maxHeatingsetpoint| read attribute|11|0x0201|0x0016 |0x29 |temp*100|
| Actuator|Controler| ask for maxHeatingsetpoint| read attribute|11|0x0201|0x0016 | ||
| Controler|Actuator| answer maxHeatingsetpoint| read attribute|11|0x0201|0x0016 |0x29 |temp*100|
||||||||||
| Thermostat|Actuator| ask for minHeatingsetpoint| read attribute|11|0x0201|0x0015  | ||
| Actuator|Thermostat| answer minHeatingsetpoint| read attribute|11|0x0201|0x0016 |0x29 |temp*100|
| Actuator|Controler| ask for minHeatingsetpoint| read attribute|11|0x0201|0x0015  | ||
| Controler|Actuator| answer minHeatingsetpoint| read attribute|11|0x0201|0x0016 |0x29 |temp*100|


Click on + on the thermostat (increase setpoint temperature by 0.5 degree)

| Source|Destination|Payload | action | ep |cluster|command | value|
| :---- | :-------- | :----- |:------ |:--- |:---  |:------- |:---- |
| Thermostat|Actuator| setpoint temperature| command set temp|11|0x0201|0xe0|0x00 + zone + temp*100+ 0xFF|
| Actuator|Controler| setpoint temperature| command set temp|11|0x0201|0xe0|0x00 + zone + temp*100+ 0xFF|
| Controler|Actuator| setpoint temperature| command set temp|11|0x0201|0xe0|0x00 + zone + temp*100+ 0xFF|

Thermostat setpoint from hub

| Source|Destination|Payload | action | ep |cluster|command | value|
| :---- | :-------- | :----- |:------ |:--- |:---  |:------- |:---- |
| Controler|Actuator| setpoint temperature| command set temp|11|0x0201|0xe0|0x00 + zone + temp*100+ 0xFF|

