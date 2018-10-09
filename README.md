# rtl8821CU
[![Build Status](https://travis-ci.org/whitebatman2/rtl8821CU.svg?branch=master)](https://travis-ci.org/whitebatman2/rtl8821CU)

Drivers for rtl8811CU and rtl8821CU Wi-Fi chipsets. This repository is based on soruce code found on a CD shipped with a rtl8811CU based card. It's updated to build on newer kernel versions.

## Build and install with DKMS

DKMS is a system which will automatically recompile and install a kernel module when a new kernel gets installed or updated. To make use of DKMS, install the dkms package, which on Debian (based) systems is done like this:

    apt-get install dkms

To make use of the DKMS feature with this project, do the following:

    DRV_NAME=rtl8821CU
    DRV_VERSION=5.2.5.3
    sudo mkdir /usr/src/${DRV_NAME}-${DRV_VERSION}
    git archive master | sudo tar -x -C /usr/src/${DRV_NAME}-${DRV_VERSION}
    sudo dkms add -m ${DRV_NAME} -v ${DRV_VERSION}
    sudo dkms build -m ${DRV_NAME} -v ${DRV_VERSION}
    sudo dkms install -m ${DRV_NAME} -v ${DRV_VERSION}

If you later on want to remove it again, do the following:

    DRV_NAME=rtl8821CU
    DRV_VERSION=5.2.5.3
    sudo dkms remove ${DRV_NAME}/${DRV_VERSION} --all

## Build and install without DKMS
Use following commands in source directory:
```
make
sudo make install
sudo modprobe 8821cu
```
## Raspberry Pi
To build this driver on Raspberry Pi you need to set correct platform in Makefile.
Change
```
CONFIG_PLATFORM_I386_PC = y
CONFIG_PLATFORM_ARM_RPI = n
CONFIG_PLATFORM_ARM_RPI3 = n
```
to
```
CONFIG_PLATFORM_I386_PC = n
CONFIG_PLATFORM_ARM_RPI = y
CONFIG_PLATFORM_ARM_RPI3 = n
```
For the Raspberry Pi 3 you need to change it to
```
CONFIG_PLATFORM_I386_PC = n
CONFIG_PLATFORM_ARM_RPI = n
CONFIG_PLATFORM_ARM_RPI3 = y
```
