## Preamble
The purpose of this document is to help you in the installation of the Zigate plugin on a Synlology platform

## Pre-requisites

* First of all, please go through the  [Domoticz Python page](https://www.domoticz.com/wiki/Synology_installation_folder)
* The Domoticz for Synology package to be installed is the version 'with Python'
* Python Module must be installed. [Python Module](https://www.synology.com/en-uk/dsm/packages/PythonModule)
* The GitHub server Synology package must be installed . Install Git Server package via Diskstation. We don't need the 'Server' part of the GitHub Server package, just the 'git command', so no specific configurations are required.
* it is assumed that you have 'root'/'admin' right access with the use of 'sudo' command

## Installation of the Plugin

cd /volume1/domoticz
cd plugins
git clone https://github.com/sasu-drooz/Domoticz-Zigate.git


## Warnings:
* Domoticz 4.9700 stable for DSM6.1 With Python PluginManager Requires Python 3.5.1.spk from Synology



