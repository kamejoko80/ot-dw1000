#!/bin/bash
#******************************************************************#
# Author     : Nishal
# Date       : 5th June 2017
# File       : build.sh
# Version    : 0.1
# Description: This script initializes the path as enviroment
#              variables for the following
#              1) OT_ROOT(open source)
#              2) DW_OT_ROOT(DW specific)
#              3) Updating the path variables to the bashrc file
#
#******************************************************************#

#Get the real path of the script
BASEDIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

#Export the Environment variables.
OT_ROOT=$BASEDIR/openthread-master
DW_OT_ROOT=$BASEDIR/DW1000
TOOLCHAINS_DIR=gcc-arm-none-eabi-10.3-2021.10

#export toolchains PATH
if [[ $PATH == *$TOOLCHAINS_DIR* ]]; then
    echo "Toolchains detected"
    echo $TOOLCHAINS_DIR
else
    echo "export toolchains install dir..."
    export PATH=$PATH:$BASEDIR/toolchains/$TOOLCHAINS_DIR/bin
fi

export OT_ROOT
export DW_OT_ROOT