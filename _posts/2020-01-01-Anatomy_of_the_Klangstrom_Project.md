---
layout: post
title:  "Anatomy of the Klangstrom Project"
date:   2020-01-01 00:00:00 +0100
---

![Anatomy of the Klangstrom Project](/assets/2020-01-01-Anatomy_of_the_Klangstrom_Project.png) a brief overview of the *klangstrom* (KLST) project.

*klangstrom* is an infrastructure to facilitate generative, networked, embedded sound + music + composition making. 

*klangstrom* aims to support the creation of audio-based applications that either run on microcontrollers (MCU) or personal computers (PC).

*klangstrom* is comprised of two software libraries ( *klang* a node+text-based synthesizer library, *strom* a node+text-based generative composition library ), an embedded hardware platform, and a programming environment and a set of tools to allow seamless development of such applications.

## libraries

- software libraries
- *klang* a node+text-based synthesizer library for creating sounds
    - (DSP)
- *strom* a node+text-based generative composition library for creating musical compositions
    - (composition)

- node-based
- floating-point arithmetic
- extendable
- extensions
- examples
- external controller

## hardware

- embedded hardware platform
- *KLST_CORE* is a dedicated embedded platform 
- based on STM32H7 microcontroller unit (MCU)
- audio codec
- connections ( USB, UART, SPI, I2C, GPIO )
- interface ( buttons, encoders, SD card, LEDs, eurorack )

## programming

- programming environments + tools

KLST can be programmed via Arduino IDE, Cmake or any other C/C++ based build system

MCU, simulator and VCV Rack can be programmed and uploaded/started from within Arduino IDE.

### Arduino Library for STM32

- extension of [STM32duino](https://github.com/stm32duino)

### Simulator for Linux, MacOS and iOS

- SDL

### Plugin for VCV Rack

- proof of concept
- dynamic loading of sketches

### VST Plugin

### Patch Drawing Tool