#!/bin/bash

#Get the real path of the script
CURRENT_DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
FATHER_DIR=$(dirname "$CURRENT_DIR")
BASEDIR=$(dirname "$FATHER_DIR")

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

#Build command for application
$OT_ROOT/scripts/build.sh
