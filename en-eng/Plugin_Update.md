## Plugin Update

"Update" can mean two different things — make sure you're following the right one:

* __Routine update__ — bug fixes and enhancements, staying on the branch you're already on (`stable8` or `stable9`). This is what this page covers.
* __Moving from `stable8` to `stable9`__ — a one-time, one-way switch to the new Domoticz Extended Framework branch. This is *not* a routine update and has its own procedure : see [Upgrading from stable8 to stable9](HowTo_Upgrade-stable8-to-stable9.md).

## Routine update

The plugin is regularly updated, for bug fixing or enhancement, without changing branch.

### From the WebUI

The plugin can be updated from its own administration page : Admin > Plugin > Update

* Open the plugin Web Interface

* Go to section [Admin > Plugin](WebUI_Admin.md#plugin).

* Click on the button **Start upgrade**


A box will appear above it with the result of the update as if you were launching it from your terminal.

* Once the update is complete, click on the **Restart** button.

### Manually

* Go in your DomoticZ directory using a command line and open the plugins directory then the ZigBeeForDomoticZ-Plugin directory.

* Run the commands (add sudo first if needed):

```bash
  git pull
  sudo python3 -m pip install -r requirements.txt --upgrade
 ```

* Restart DomoticZ.

### In case of error

If you have edited/updated some of the plugin controlled file, you might get an error message protecting any update. In such situation you can reset those files with the latest version with the following commands

  ```bash
  git reset --hard
  git pull --force
  ```

## Plugin branches

The plugin is under constant development in order to bug fix and add new features as well as taking into account new devices.

The code is currently available under two branches :

### stable8

This is the current default branch, and the one most users should be on. It requires Domoticz 2025.2+ and Python 3.11+, and uses Domoticz's legacy widget model.

### stable9

This is the newer branch, built exclusively on the **Domoticz Extended Framework** (`DomoticzEx`), available since Domoticz 2025.1. It is not a routine update — moving to `stable9` is a one-way switch performed with a dedicated tool, not with `git checkout`.

See [Upgrading from stable8 to stable9](HowTo_Upgrade-stable8-to-stable9.md) for the full prerequisites and procedure.
