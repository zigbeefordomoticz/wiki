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

In order to allow Read and Write on the PDMonhost, a new series of messages are available. Those messages will drive 
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

## ZiGate APIs for PDMonhost

### E_SL_MSG_SAVE_PDM_RECORD = 0x0200

* Source: __Zigate__

* Description: ZiGate request host to save a Record on PDM. This record could be sent in blocks (of max 255 bytes)

* Data:

  | data | Type | Value |
  | ---- | ---- | ----- |
  | RecordId | uint16 | RecordId of the data to be store| 
  | u16Size  | uint16 | total PDM record size in bytes |
  | CurrentCount | uint16 | This number corresponds to the block id (starting 0) |
  | u16NumberOfWrites | unint16 | total number of block expected |
  | dataReceived | uint16 | size of this particular block (number of bytes) |
  | sWriteData | bytes | bytes of this record|
    
    
* Response: __0x8200__



### E_SL_MSG_SAVE_PDM_RECORD_RESPONSE = 0x8200

* Source: __Host__
* Description: Acknowledge the correct saving of the incoming recordId data
* Data:

  | data | Type | Value |
  | ---- | ---- | ----- |
  | Status | uint8 | PDM_E_STATUS_OK |
  | RecordId | uint16 | Should the recordId of the record you just save 
  | u16NumberOfWrites | total number of block expected |
  
* Response: none


### E_SL_MSG_LOAD_PDM_RECORD_REQUEST = 0x0201

* Source: __ZiGate__
* Description: Request a RecordID from the PDM on Host
* Data:

  | data | Type | Value |
  | ---- | ---- | ----- |
  | RecordId | uint16 | RecordId of the data sent| 

* Response: __0x8201__



### E_SL_MSG_LOAD_PDM_RECORD_RESPONSE = 0x8201

* Source: __Host__
* Description: Send a the Data related to the RecordID requested. Could be one block out of many.
  Tested with 128 bytes; Max block size is 256 Bytes
* Data :
  | data | Type | Value |
  | ---- | ---- | ----- |
  | Status | uint8 | 0x00 No data found ; 0x02 Sending Data |
  | RecordId | uint16 | RecordId of the data sent| 
  | u16Datalength  | uint16 | total PDM record size in bytes |
  | TotalBlocksToSend | uint16 | This number corresponds to the block id (starting 0) |
  | u16BlocksSent | unint16 | total number of block expected |
  | u16Size | uint16 | size of this particular block (number of bytes) |
  | sWriteData | bytes | bytes of this record|
  
* Response: __none__



### E_SL_MSG_GET_BITMAP_RECORD_REQUEST = 0x0206

* Source: __Zigate__

* Description:

* Data :

* Response:



### E_SL_MSG_GET_BITMAP_RECORD_RESPONSE = 0x8206

* Source: __Host__

* Description:

* Data :

* Response :



### E_SL_MSG_INCREMENT_BITMAP_RECORD_REQUEST = 0x0207

* Source: __Zigate__

* Description:

* Data:

* Response:



### E_SL_MSG_INCREMENT_BITMAP_RECORD_RESPONSE = 0x8207

* Source: __Host__

* Description:

* Data:

* Response:



### E_SL_MSG_PDM_EXISTENCE_REQUEST = 0x0208

* Source: __Zigate__

* Description:

* Data:

* Response:



### E_SL_MSG_PDM_EXISTENCE_RESPONSE = 0x8208

* Source: __Host__

* Description:

* Data:

* Response:



### E_SL_MSG_PDM_HOST_AVAILABLE = 0x0300

* Source: __ZiGate__
* Description: ZiGate indicated the need to initialise the PDM in memory.
* Data: none
* Response: __0x8300__


### E_SL_MSG_PDM_HOST_AVAILABLE_RESPONSE = 0x8300

* Source: __Host__
* Description: Indicates ready to load PDM
* Data:

| data | Type | Value |
| ---- | ---- | ----- |
| status | uint8 | PDM_E_STATUS_OK |

* Response: none

### E_SL_MSG_PDM_LOADED = 0x0302

* Source: __ZiGate__
* Description: ZiGate informs the correct load of the PDM into Memory. Zigate Ready
* Data: none
* Response: none




