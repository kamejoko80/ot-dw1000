#!/bin/bash
#******************************************************************#
# Author     : Nishal
# Date       : 5th June 2017
# File       : build_setup.sh
# Version    : 0.1
# Description: This script does the following thing
#              1)setup for the system to work when called with INITIAL
#              2)git clone of opensource repo when called with UPDATE
#              3)builds an application
#
#******************************************************************#

#Export environment variable
source setenv.sh

if [ "$#" -ne  "0" -a "$1" == "--build" ]; then
echo "==========Build the firmware========="
#Build command for application
$OT_ROOT/scripts/build.sh
fi

echo "==========Flash the firmware========="

echo "Device list"
nrfjprog --ids

echo "Flashing master device..."
nrfjprog --snr 683103016 -f nrf52 --chiperase --program openthread-master/output/nrf52840/bin/ot-cli-ftd.hex

echo "Flashing slave device..."
nrfjprog --snr 683907792 -f nrf52 --chiperase --program openthread-master/output/nrf52840/bin/ot-cli-ftd.hex
