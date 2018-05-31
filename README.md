# rtl8821CU
This repository contains drivers for rtl8811CU and rtl8821CU chipsets.

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
```
to
```
CONFIG_PLATFORM_I386_PC = n
CONFIG_PLATFORM_ARM_RPI = y
```

## ARM hard float workaround
For building on ARM based machines with hardware floating point kernels you will most likely get this error:
```
gcc: error: -mfloat-abi=soft and -mfloat-abi=hard may not be used together
```
The best solution would probably be to modify the driver not to use any double or float variables. For now you can change Makefile in kernel headers and it will build and work as it should.

1. Make backup
```
sudo cp /lib/modules/`uname -r`/build/arch/arm/Makefile /lib/modules/`uname -r`/build/arch/arm/Makefile.bak
```
2. Change following lines in ```/lib/modules/`uname -r`/build/arch/arm/Makefile```
```
KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
KBUILD_AFLAGS  +=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
```
to
```
KBUILD_CFLAGS   +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -Uarm
KBUILD_AFLAGS   +=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h
```
3. Build
4. Change Makefile back to its original state
```
sudo rm /lib/modules/`uname -r`/build/arch/arm/Makefile
sudo mv /lib/modules/`uname -r`/build/arch/arm/Makefile.bak /lib/modules/`uname -r`/build/arch/arm/Makefile
```
