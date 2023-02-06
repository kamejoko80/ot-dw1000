#!/bin/bash
#******************************************************************#
# Author     : Nishal
# Date       : 2nd June 2017
# File       : setup.sh
# Version    : 0.1
# Description: This script does the setup for the system to work
#              with DW1000 examples with OpenThread stack
#
#******************************************************************#
#Initialising the necessary variables required for this script
DIR=$(pwd)
OT_COMMIT_ID=915261b36b256234ef6b40f6cbad69f036851385

PATCH_FILE=ot-dw1000.patch
TOOLCHAINS_DIR=gcc-arm-none-eabi-10.3-2021.10
TOOLCHAINS_FILE=gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
TOOLCHAINS_URL=https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10

echo ""
echo "<SCRIPT_LOG> Current directory $DIR"

if [ "$#" -ne  "0" -a "$1" == "INITIAL" ]; then
    #Extract the file if not done
    if [ -d $DIR/toolchains/$TOOLCHAINS_DIR ]; then
       echo "<SCRIPT_LOG> $TOOLCHAINS_DIR already exists..."
       echo "<SCRIPT_LOG> Extract skipped as directory already exists."
    else
       cd toolchains
       echo "<SCRIPT_LOG> Extracting $TOOLCHAINS_FILE ..."
       wget $TOOLCHAINS_URL/$TOOLCHAINS_FILE
       tar -xvf $TOOLCHAINS_FILE
       cd ../
    fi
else
    echo "<SCRIPT_LOG> Setting up the dependencies for project not required..."
fi

#To be called in case of INITIAL or UPDATE
if [ "$#" -ne  "0" ]; then
if [ "$1" == "INITIAL" -o "$1" == "UPDATE" ]; then

    #clone the OT repo and respective commit id
    echo "<SCRIPT_LOG> Cloning OpenThread repository..."
    if [ -d "$OT_ROOT" ]; then
        echo "<SCRIPT_LOG> $OT_ROOT already exists."
        rm -rf $OT_ROOT
    fi
    echo "<SCRIPT_LOG> Cloning OpenThread(OT) code to $OT_ROOT directory."
    git clone https://github.com/openthread/openthread.git $OT_ROOT
    cd $OT_ROOT
    git checkout $OT_COMMIT_ID

    #Enable execute permission for the files
    chmod a+x third_party/nlbuild-autotools/repo/autoconf/ltmain.sh
    cd -

    #Create symlinks
    echo "<SCRIPT_LOG> Removing the previous symbolic links if any..."
    rm -rf $OT_ROOT/examples/platforms/dw1000
    rm -rf $OT_ROOT/examples/Makefile-nrf52840-dw1000
    rm -rf $OT_ROOT/scripts
    rm -rf $OT_ROOT/third_party/decawave
    rm -rf $OT_ROOT/third_party/NordicSemiconductor/drivers/nrf_delay.h
    rm -rf $OT_ROOT/third_party/NordicSemiconductor/drivers/nrf_drv_spi.h
    rm -rf $OT_ROOT/third_party/NordicSemiconductor/drivers/nrf_error.h
    rm -rf $OT_ROOT/third_party/NordicSemiconductor/drivers/sdk_common.h
    rm -rf $OT_ROOT/third_party/NordicSemiconductor/drivers/sdk_config.h
    rm -rf $OT_ROOT/third_party/NordicSemiconductor/drivers/sdk_errors.h
    rm -rf $OT_ROOT/third_party/NordicSemiconductor/drivers/nrf_drv_spi.c
    rm -rf $OT_ROOT/third_party/NordicSemiconductor/hal/nordic_common.h
    rm -rf $OT_ROOT/third_party/NordicSemiconductor/hal/nrf_gpiote.h
    rm -rf $OT_ROOT/third_party/NordicSemiconductor/hal/nrf_spi.h
    rm -rf $OT_ROOT/third_party/NordicSemiconductor/hal/nrf_spim.h    
    
    echo "<SCRIPT_LOG> Creating symbolic links..."
    sudo ln -s $DW_OT_ROOT/examples/platforms/dw1000 $OT_ROOT/examples/platforms/dw1000
    sudo ln -s $DW_OT_ROOT/examples/Makefile-nrf52840-dw1000 $OT_ROOT/examples/Makefile-nrf52840-dw1000
    sudo ln -s $DW_OT_ROOT/scripts $OT_ROOT/scripts
    sudo ln -s $DW_OT_ROOT/third_party/decawave $OT_ROOT/third_party/decawave
    sudo ln -s $DW_OT_ROOT/third_party/NordicSemiconductor/drivers/nrf_delay.h $OT_ROOT/third_party/NordicSemiconductor/drivers/nrf_delay.h
    sudo ln -s $DW_OT_ROOT/third_party/NordicSemiconductor/drivers/nrf_drv_spi.h $OT_ROOT/third_party/NordicSemiconductor/drivers/nrf_drv_spi.h
    sudo ln -s $DW_OT_ROOT/third_party/NordicSemiconductor/drivers/nrf_error.h $OT_ROOT/third_party/NordicSemiconductor/drivers/nrf_error.h
    sudo ln -s $DW_OT_ROOT/third_party/NordicSemiconductor/drivers/sdk_common.h $OT_ROOT/third_party/NordicSemiconductor/drivers/sdk_common.h
    sudo ln -s $DW_OT_ROOT/third_party/NordicSemiconductor/drivers/sdk_config.h $OT_ROOT/third_party/NordicSemiconductor/drivers/sdk_config.h
    sudo ln -s $DW_OT_ROOT/third_party/NordicSemiconductor/drivers/sdk_errors.h $OT_ROOT/third_party/NordicSemiconductor/drivers/sdk_errors.h
    sudo ln -s $DW_OT_ROOT/third_party/NordicSemiconductor/drivers/nrf_drv_spi.c $OT_ROOT/third_party/NordicSemiconductor/drivers/nrf_drv_spi.c
    sudo ln -s $DW_OT_ROOT/third_party/NordicSemiconductor/hal/nordic_common.h $OT_ROOT/third_party/NordicSemiconductor/hal/nordic_common.h
    sudo ln -s $DW_OT_ROOT/third_party/NordicSemiconductor/hal/nrf_gpiote.h $OT_ROOT/third_party/NordicSemiconductor/hal/nrf_gpiote.h
    sudo ln -s $DW_OT_ROOT/third_party/NordicSemiconductor/hal/nrf_spi.h $OT_ROOT/third_party/NordicSemiconductor/hal/nrf_spi.h
    sudo ln -s $DW_OT_ROOT/third_party/NordicSemiconductor/hal/nrf_spim.h $OT_ROOT/third_party/NordicSemiconductor/hal/nrf_spim.h
    sync

    #Apply a patch for the makefile changes.
    echo "<SCRIPT_LOG> Applying patch $PATCH_FILE for the common files..."
    if [ -f $DIR/$PATCH_FILE ]; then
        echo "<SCRIPT_LOG> $DIR/$PATCH_FILE file exists"
        patch -p0 -b < $PATCH_FILE
    else
        echo "<SCRIPT_LOG> $DIR/$PATCH_FILE not found"
    fi
fi
fi

