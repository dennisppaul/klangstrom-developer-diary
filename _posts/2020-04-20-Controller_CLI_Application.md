---
layout: post
title:  "Controller CLI Application"
date:   2020-04-20 07:00:00 +0100
---

![Controller CLI Application](/assets/2020-04-20-Controller_CLI_Application--Commands.gif)    
a command-line interface (CLI) application that creates, configures and controls *klangstrom* patches

the idea of this approach is to facilitate an interface to communicate with a KLST application at runtime. the fundamental idea is to use commands (`CMD`) and values to configure the application.

the command sequence `KLANG_CMD_CREATE_NODE_I8 KLANG_NODE_VCO_WAVETABLE` e.g would create a wavetable node. if it is the first node created it will receive ID `0`. the command sequence `KLANG_SET_WAVEFORM_I8 0 1` will then set the node with the ID `0` to the waveform `1` ( i.e a triangle shape ).

a short demo of how to set `amplitude` and `frequency` of an oscillator node:

![Controller CLI Application](/assets/2020-04-20-Controller_CLI_Application--Execute.png)

the following command sequence aims to "setup a VCO with freq and amp an connect it to DAC". it can either be written using predefined human-readable commands or more concise but also *raw* byte or hexdecimal representations:

```shell
    ./klang_ext KLANG_CMD_CREATE_NODE_I8 KLANG_NODE_DAC KLANG_CMD_CREATE_NODE_I8 KLANG_NODE_VCO_WAVETABLE KLANG_SET_WAVEFORM_I8 1 1 KLANG_CMD_OUTPUT_NODE_I8 0 KLANG_CMD_CONNECT_NODES_I8_I8_I8_I8 1 0 0 0 KLANG_SET_FREQUENCY_F32 1 110.0 KLANG_SET_AMPLITUDE_F32 1 0.2
```

the same command sequence sent in bytes format:
    
```shell
    ./klang_ext 5 71 5 96 72 1 1 7 0 9 1 0 0 0 44 1 0 0 220 66 34 1 205 204 76 62 # command sequence (BYTE)
```
    
or in hex format:
    
```shell
    ./klang_ext 0x05 0x47 0x05 0x60 0x48 0x01 0x01 0x07 0x00 0x09 0x01 0x00 0x00 0x00 0x2C 0x01 0x00 0x00 0xDC 0x42 0x22 0x01 0xCD 0xCC 0x4C 0x3E # command sequence (HEX)
```
    
note that floating point values ( i.e `_F32` ) are chopped up into 4 bytes in the raw formats.

a few examples of commands from the header file `KlangCommands.hpp`:

```c++
static const KLANG_CMD_TYPE KLANG_CMD_CREATE_NODE_I8                      = 0x05;
static const KLANG_CMD_TYPE KLANG_SET_FEEDBACK_F32                        = 0x2A;
static const KLANG_CMD_TYPE KLANG_SET_FILTER_F32                          = 0x2B;
static const KLANG_CMD_TYPE KLANG_SET_FREQUENCY_F32                       = 0x2C;
static const KLANG_CMD_TYPE KLANG_NODE_DELAY                              = 0x48;
static const KLANG_CMD_TYPE KLANG_NODE_DISTORTION                         = 0x49;
static const KLANG_CMD_TYPE KLANG_NODE_ENVELOPE                           = 0x4A;
```
