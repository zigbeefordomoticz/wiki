# How to deal with missing modules



## Make sure that you have correctly installed the plugin 

from the plugin home directory _Domoticz-Zigbee_ or _Domoticz-Zigate_ do the following command


```
ls -l external/dnspython/

```

if the response is 
```
total 0
```

you need to run


```
git config --add submodule.recurse true
git submodule update --init --recursive

```

### Make sure that all dependencies have been installed


```
sudo pip3 install -r requirements.txt
```
