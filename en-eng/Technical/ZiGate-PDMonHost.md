# ZiGate PDM on host

## Preamble

The purpose is to externalize the ZiGate Permanent Data Memory (PDM) which is usally store on the EEPROM. 
Instead the PDM storage will be delegated to the Host (the plugin).

### The expected benefits are:
* larger PDM which will contribute to more devices to be paired with Zigate
* bring the ZiGate HW limit from the EEPROM limit to the RAM limits


### Potential traps.
* As the PDM read/write will be done over the communication channel between ZiGate UART and plugin, we could expect some 
latency.
* The latency impacts are expected to be mainly around the time of pairing a new devices.
* You need to have the Host __always__ up and running to get the Zigbee network alive. (with PDM on Zigate, the Zigate can remains active while Host like plugin can be down).


### References:
* https://zigate.fr/documentation/deplacer-le-pdm-de-la-zigate/
* https://zigate.fr/files/Pack_Dev_ZiGate_Host.zip
* https://www.nxp.com/docs/en/user-guide/JN-UG-3116.pdf
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

* Description: This function saves the specified application data from RAM to the specified record in EEPROM. The record is identified by means of a 16-bit user-defined value.
Could be broken in several blocks.

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

PDM_E_STATUS_OK (success)
PDM_E_STATUS_INVLD_PARAM (specified record ID is invalid)
PDM_E_STATUS_NOT_SAVED (save to EEPROM failed)



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
* Description: This function reads the specified record of application data from the EEPROM and stores the read data in the supplied data buffer in RAM. The record is specified using its unique 16-bit identifier.
Could be one block out of many.
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


### E_SL_MSG_DELETE_ALL_PDM_RECORDS_REQUEST = 0x0202

* Source: __Zigate__

* Description: This function deletes all records in EEPROM, including both application data and stack context data, resulting in an empty PDM file system. The EEPROM segment Wear Count values are preserved (and incremented) throughout this function call.

* Data : none

* Response: none



### E_SL_MSG_DELETE_PDM_RECORD_REQUEST = 0x0203

* Source: __Zigate__

* Description: This function deletes the specified record of application data in EEPROM.

* Data :
  | data | Type | Value |
  | ---- | ---- | ----- |
  | RecordId | uint16 | RecordId of the data sent| 
  
* Response: none



### PDMCreateBitmap = 0x0204

* Source: __Zigate__

* Description:The function creates a bitmap structure for a counter in a segment of the EEPROM. A user-defined ID and a start value for the bitmap counter must be specified. The start value is stored in the counter’s header. A bitmap is created to store the incremental value of the counter (over the start value). This bitmap can subsequently be incremented (by one) by calling the function PDM_eIncrementBitmap(). The incremental value stored in the bitmap and the start value stored in the header can be read at any time using the function PDM_eGetBitmap().If the specified ID value has already been used or the specified start value is NULL, the function returns PDM_E_STATUS_INVLD_PARAM. If the EEPROM has no free segments, the function returns PDM_E_STATUS_USER_PDM_FULL. 
    

* Data :

* Response:

PDM_E_STATUS_OK (success)
PDM_E_STATUS_INVLD_PARAM (an invalid parameter value was supplied)
PDM_E_STATUS_PDM_FULL (there is no space to store this bitmap)

### PDMDeleteBitmapRequest = 0x0205

* Source: __Zigate__

* Description: This function deletes the specified counter in the EEPROM. The counter must be identified using the user-defined ID value assigned when the bitmap was created using the function PDM_eCreateBitmap().The function can be used to formally delete a counter. It clears the current segment occupied by the counter and also all the older (expired) segments used for the counter. This deletion increments the Wear Counts for these segments and should be done only if absolutely necessary, as the expired segments can be re-used directly via the PDM without formal deletion.

* Data :

* Response:

PDM_E_STATUS_OK (success)
PDM_E_STATUS_INVLD_PARAM (an invalid parameter value was supplied)



### E_SL_MSG_GET_BITMAP_RECORD_REQUEST = 0x0206

* Source: __Zigate__

* Description: The function reads the specified counter value from the EEPROM.
    The counter must be identified using the user-defined ID value assigned when the counter was created using
    the function PDM_eCreateBitmap().
    The function returns the counter’s start value (from the counter’s header) and incremental value
    (from the counter’s bitmap).
    The counter value is calculated as:
        Start Value + Incremental Value
    or in terms of the function parameters:
        *pu32InitialValue + *pu32BitmapValueNote
    that the start value may be different from the one specified when the counter was created,
    as the start value is updated each time the counter outgrows a segment and the bitmap is
    reset to zero.
    This function should be called when the device comes up from a cold start,
    to check whether a bitmap counter is present in EEPROM.
    If the specified ID value has already been used or a NULL pointer is provided for the received values,
    the function returns PDM_E_STATUS_INVLD_PARAM.

* Data :

* Response:

PDM_E_STATUS_OK (success)
PDM_E_STATUS_INVLD_PARAM (an invalid parameter value was supplied)


### E_SL_MSG_GET_BITMAP_RECORD_RESPONSE = 0x8206

* Source: __Host__

* Description:

* Data :

* Response :



### E_SL_MSG_INCREMENT_BITMAP_RECORD_REQUEST = 0x0207

* Source: __Zigate__

* Description: The function increments the bitmap value of the specified counter in the EEPROM.
    The counter must be identified using the user-defined ID value assigned when the counter
    was created using the function PDM_eCreateBitmap().
    The bitmap can be incremented within an EEPROM segment until its value saturates (contains all 1s).
    At this point, the function returns the code PDM_E_STATUS_SATURATED_OK.
    The next time that this function is called, the counter is automatically moved to a
    new segment (provided that one is available), the start value in its header is increased appropriately and
    the bitmap is reset to zero.
    To avoid increasing the segment Wear Count, the old segment is not formally deleted before a new segment is started.
    If the EEPROM has no free segments when the above overflow occurs,
    the function returns the code PDM_E_STATUS_USER_PDM_FULL.
    If the specified ID value has already been used, the function returns PDM_E_STATUS_INVLD_PARAM.

* Data:

* Response:

PDM_E_STATUS_OK (success)
PDM_E_STATUS_INVLD_PARAM (an invalid parameter value was supplied)
PDM_E_STATUS_PDM_FULL (no further EEPROM segments for the bitmap)
PDM_E_STATUS_BITMAP_SATURATED_OK (increment made but segment now saturated)

### E_SL_MSG_INCREMENT_BITMAP_RECORD_RESPONSE = 0x8207

* Source: __Host__

* Description:

* Data:

* Response:



### E_SL_MSG_PDM_EXISTENCE_REQUEST = 0x0208

* Source: __Zigate__

* Description: This function checks whether data associated with thd specified record ID exists in the EEPROM. If the data record exists, the function returns the data length, in bytes, in a location to which a pointer must be provided.

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




