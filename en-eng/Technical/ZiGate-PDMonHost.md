# ZiGate PDM on host

## Preamble

The purpose is to externalize the ZiGate Permanent Data Memory (PDM) which is usally store on the EEPROM. 
Instead the PDM storage will be delegated to the Host (the plugin).

### The expected benefits are:
* larger PDM which will contribute to more devices to be paired with Zigate
* bring the ZiGate HW limit from the EEPROM limit to the RAM limits


### Expected issues
* As the PDM read/write will be done over the communication channel between ZiGate UART and plugin, we could expect some 
latency.
* The latency impacts are expected to be mainly around the time of pairing a new devices.


### References:
* https://zigate.fr/documentation/deplacer-le-pdm-de-la-zigate/
* https://zigate.fr/files/Pack_Dev_ZiGate_Host.zip
* https://github.com/fairecasoimeme/ZiGate/issues/280
* https://github.com/fairecasoimeme/ZiGate/pull/281


## Principles

In order to allow Read and Write on the onHostPDM, a new series of messages are available. Those messages will drive 
all Read/Write operations.

On the host side, you will have to store the PDM in order to get it available for a cold restart ( ZiGate power off ). 
Several alternatives are available, for ZGUI the implementation is based on an SQLITE3 Database, on the plugin this will 
mainly be managed in memory with a python3 dictionnary and then store on disk via a serialization method (json or pickle)

From the host side, you cannot figure out if the ZiGate state is the result of a cold restart (powered off) or hot restart (nothing change from last connection).

## Hot restart

* ZiGate has been powered off via an unplug/plug
* the end result is the ZiGate RAM has been reset and the PDM needs to be reloaded in order to have ZiGate ready.
* ZiGate is sending 0x0300 message in order to trigger the PDM load and initialisation into RAM

## Cold restart

* ZiGate is still alive.
* ZiGate is ready.

## Implementations

