# rtl8821CU
[![Build Status](https://travis-ci.org/whitebatman2/rtl8821CU.svg?branch=master)](https://travis-ci.org/whitebatman2/rtl8821CU)

Drivers for rtl8811CU and rtl8821CU Wi-Fi chipsets. This repository is based on soruce code found on a CD shipped with a rtl8811CU based card. It's updated to build on newer kernel versions.

## Build and install
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
