#!/bin/sh

## FIX THIS to point to your unzip'd TRD directory
#TRD_HOME=${PWD}/../rdf0421-zcu102-base-trd-2018-2
# Correct the path accordingly
#TRD_HOME=/home/zary/zcu102/rdf0421-zcu102-base-trd-2018-2
#HW_DIR=${PWD}/hw

## FIX THIS to point to your petalinux install directory
## PETALINUX_DIR=/raid/xilinx/petalinux/2017.1
## PETALINUX_DIR=/home/zary/PetaLinux
PETALINUX_DIR="$1"

#### https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18841801/Zynq+UltraScale+MPSoC+Base+TRD+2018.2+-+Design+Module+1
####     
####     % cd $TRD_HOME/petalinux
####     % petalinux-create -t project -s zcu102-base-trd.bsp -n bsp
####     % cd bsp
####     % petalinux-config --get-hw-description=$TRD_HOME/zcu102_base_trd/sw/a53_linux/a53_linux/prebuilt --oldconfig
####     

## step 1 - load the petalinux settings
. ${PETALINUX_DIR}/settings.sh

## step 2 - create the project, derived from the .bsp included in the TRD
#petalinux-create -t project -s ${TRD_HOME}/petalinux/zcu102-base-trd.bsp -n bsp
# created project including libiio already in github
#petalinux-create -t project -s xilinx-zcu102-v2017.1-final.bsp -n bsp

## step 2.1 - fixup CONFIG_TMP_DIR_LOCATION.  This is a known-problem with using
## petalinux config files checked into version control systems:
## https://forums.xilinx.com/t5/Embedded-Linux/Absolute-path-in-config-file/td-p/776685
##
( 
#    cd bsp 
    SUFFIX=$$
    cp bsp/project-spec/configs/config bsp/project-spec/configs/config.old.${SUFFIX}
    sed -e s:CONFIG_TMP_DIR_LOCATION.*:CONFIG_TMP_DIR_LOCATION=\"${PWD}/bsp/build/tmp/\": bsp/project-spec/configs/config > bsp/project-spec/configs/config.${SUFFIX}
    cp bsp/project-spec/configs/config.${SUFFIX} bsp/project-spec/configs/config 
)

## step 3 - run the config
# ( cd bsp && petalinux-config --get-hw-description=${HW_DIR} --oldconfig )
( cd bsp && petalinux-config --get-hw-description=${PWD}/components/plnx_workspace/fsbl_hwproj --oldconfig )
## step 4 - build the project
( cd bsp && petalinux-build )
