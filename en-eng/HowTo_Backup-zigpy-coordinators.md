# How to backup zigpy compatible coordinators

## Zigpy compatible coordinators

* Texas Instrument CCxxxx based chipset using zigpy-znp 
* Sililabs based chipset using bellows
* ConBee and RaspBee based chipset from deConz using zigpy-deconz

## 1. Pre-requisities

pip install git+https://github.com/zigpy/zigpy-cli.git


## 2. Backup your zigpy compatible key

```
zigpy radio --baudrate 115200 ezsp /dev/ttyAMA0  backup 
```

## References

* [zigpy-cli utility](https://github.com/zigpy/zigpy-cli)
