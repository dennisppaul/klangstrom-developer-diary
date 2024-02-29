---
layout: post
title:  "Arduino IDE versus Klangstrom"
date:   2020-09-09 09:39:00 +0100
---

![2020-09-09-Arduino_IDE_versus_Klangstrom](/assets/2020-09-09-Arduino_IDE_versus_Klangstrom.png) writing, compiling and running klangstrom applications from with Arduino IDE.

ok so today i am licking my wounds ;) while consolidating the work of the last days. 

i have managed to establish ( and test ) a setup that we can now proceed with. although the *Arduino IDE* build system is quite a dirty hack, i managed to configure ( felt more like *hack* ) it to build for MCU ( STM32H743, based on the *STM32duino* project ) and for desktop ( using *CMake* and *SDL* ). i even managed to find a relatively painless way to utilize STM32’s built-in ( USB Device Firmware Upgrade ) to program the MCU via the standard USB port. what this boils down to is the following:

- MCU version is based on *STM32H743ZI* ( via *DfuSe* )
- CPU version is based on *SDL* ( via *CMake* )
- all platforms can be programmed from within *Arduino* ( and installed via *Board Manager* )
- *KLST_Core* is a PCB with a minimum setup ( audio codec, audio I/O, USB, module ports ) other functionalities ( e.g *Hardware MIDI*, *Eurorack I/O* ) will be realized as add-on *modules*.

## what s planned?

- @MCU although *Arduino IDE* will be the main focus, there will be other platforms developed:
    - `klangstrom_stm32cubeide` developed in *STM32CubeIDE* and programmed via ST-LINK ( ST’s programmer hardware with enhanced debugging capabilites ) or DFU command-line tool
    - `klangstrom_teensy` run on *Teensy 4.X* hardware and developed and programmed in *Arduino IDE*
- @CPU although *SDL* will be the main focus, there will be other platforms developed:
    - `klangstrom_macos_cinder` run on desktop, based on Cinder and developed in *XCode* ( on *macOS* )
    - `klangstrom_ios_cinder` run on *iOS*, based on Cinder and developed in *XCode*
    - `klangstrom_vcvrack` run in *VCV Rack*
- @modules in tandem with *KLST_Core* a collection of modules will be developed and can be connected via *ports*. these modules are:
    - *Hardware MIDI I/O*
    - *Eurorack I/O*

## what s working? 

- @MCU *STM32H743ZI* can be programmed via *Arduino IDE*
- @MCU *STM32H743ZI* can be programmed using STM32 built-in *DfuSe Mode* to program device. *DfuSe Mode* can be entered either from software ( i.e jump to bootloader ) or hardware ( i.e `BOOT0` set to `VDD` on startup )
- @CPU desktop application can ( almost ) be built and run from *Arduino IDE* via shell script and *CMake* ( on macOS and probably on linux … windows is anybody’s guess )
- @MCU is working with a series

