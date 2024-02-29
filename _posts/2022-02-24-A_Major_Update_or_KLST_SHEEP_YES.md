---
layout: post
title:  "A Major Update or KLST_SHEEP==YES"
date:   2022-02-24 10:00:00 +0100
---

![2022-02-24-Major_Update_or_TL_DR_KLST_SHEEP](/assets/2022-02-24-A_Major_Update_or_KLST_SHEEP_YES.jpg)   
TL;DR KLST_SHEEP is really nice, it has a screen, reads WAV files from the SD Card and behaves like it’s supposed to.

it has been a while since the last update to the developer diary this however does not mean that i wasn’t busy. the main focus in the last weeks was set on updating the new KLST_SHEEP board and getting it’s features to work. still some other things happend, too.

the long detailed version follows below:

![2022-02-24-KLST_SHEEP](/assets/2022-02-24-KLST_SHEEP.jpg)

## KLST_SHEEP and next steps

the new KLST_SHEEP has proven to be really solid; in a sense that up until now i could not find any hardware errors. all peripherals work as expected. e.g:

- USB peripherals :: work as device and host and both at the same time
- TFT display ::  tested with different sizes and types
- SD card :: can load and save sample data
- audio jack :: works with 3-ring connector ( head phones + mic aka headset )

however i would not call the board perfect … just yet. i am still not happy with the green color of the PCB and the tiny RAM is bugging me as well. therefore a new board is planning: [KLST_PANDA]({% post_url 2022-02-23-KLST_PANDA-preview %})

apart from the hardware side there were also quite a lot of changes on the software side, too. a lot of bug fixed and some new features:

## Klangstrom

two libraries have been added: one for reading from ( and writing to WIP ) an SD card and one for drawing on a TFT display.

### Display Library

read about the display library at [Klangstrom Display Library]({% post_url 2022-02-22-Klangstrom_Display_Library %})

### SD Card Library

the SD card library is based on the SdFat library for Arduino. it is still very basic but one thing it can ( on top ) is parse ( some ) WAV files. this is, of course, very handy for loading sample data into RAM.

### Under the Hood

there were also some a bit more *under the hood* changes.

syntax coloring for klangstrom-related keywords was added. this has turned the examples into very colorful texts now … i like it.

the documentation has been extended by a page for KLST_SHEEP and *Klang* source code to documentation has been added-

there is now an option to select *sampling rate* and *audio block size* in the Arduino IDE ( although the default values are quite reasonable as they are ).

the underlying STM32duino project was updated to the most current verion: v2.2.0

there is now a method to retreive a single lengthy string with a unique identifier ( `U_ID` ) that is different for every single MCU. the `U_ID` can be retreived via `klangstrom::U_ID()` and is represented as a `string`. it can be very helpful e.g for writing applications that are supposed to behave slightly but not entirely differently on multiple boards.

an equally minor but handy change was made to the LEDs. they can now be toggled, turned on and off from a single method: `LED(ID,STATE)` ( e.g `LED(LED_03, LED_TOGGLE);` ).

and finally the examples were cleaned up ( WIP ) and rearranged quite a bit.

### STM32

apart from adding KLST_SHEEP to the platform, most work ( or at least time … and nerves ) went into *USB Device + Host* implementation. i must say it is still not 100% but most things work now. 

*USB Device* support for Mouse + Keyboard + MIDI is now implented via the HAL library ( that is the one maintained by ST themselves ). i.e boards can act as USB devices such as computer mouses, keyboards or MIDI devices. i was already considering to maybe add support for USB audio devices so that the boards can act as *sound cards* with digital audio in- and outputs.

*USB Host* support for Mouse + Keyboard + MIDI is now implemented also via HAL library. i.e boards can now host USB devices like computer mouses, keyboards and MIDI devices. there is still no support for USB Hubs. which in itself is not such a big issue because i do not expect to connect loads of devices to the boards. however, a lot of computer keyboards act as USB Hubs ( e.g when the have extra USB connectors on the side ). such keyboards are not recognized by this library.

support for USB Devices via TinyUSB has been deprecated and will probably be removed in a next release. for more details read [TinyUSB First I Was Like Yeah! Then I Was Like Naaaargh!]({% post_url 2022-02-21-TinyUSB_First_I_Was_Like_Yeah %})

as mentioned above KLST_SHEEP now has native support for display and SD card which is quite a big leap in terms of applications ( #weekendprojects ).

and one really nerdy but interesting change i made to the way the memory is managed. i learned a lot about the different types of memory and how to specifically use them ( via *sections* defined in the linker script ( e.g `.dma_buffer` ) and *attributes* used in application code ( e.g `__attribute__((section(".dma_buffer")))` ) ). this allowed to optimize the usage of the RAM in a way that bigger chunks of memory can now be allocated ( e.g for sample data ).

### Emulator

![](/assets/2022-02-22-Simulator_is_now_called_Emulator_and_got_Face_Lift.png)   

the desktop version or *simulator* is now called *emulator*. read about all changes here: [Simulator is now called Emulator and got Face Lift]({% post_url 2022-02-22-Simulator_is_now_called_Emulator_and_got_Face_Lift %})

## Klang

although *Klang* is already pretty complete i still found some space to makes some changes.

the memory allocation for audio blocks was moved to static memory so that it interacts better with MCUs.

i started updating those nodes that store data in a way that they can accept different data types: 8/16-bit un/signed integers and 32-bit floats ( i.e `uint8_t`, `int8_t`, `uint16_t`, `int16_t` + `float` ). `NodeVCOWavetable` and `NodeSampler` now support these 5 different data types.

`NodeKernelBlockMulti` was added to the library. it supports ( theoretically ) up to 256 input and output channels. on a more general note: all `NodeKernel*` classes assist in the easy development of custom nodes. i don’t think that i will refactor all other nodes to be based on these classes but for quick testing or not-performance relevant nodes they are quite handy.

maximum delay ( line ) length for `NodeDelay`  can now be globally configured ( `#define NODE_DELAY_BUFFER_SIZE BUFFER_SIZE_IN_SAMPLES` ).

`NodeFFT` was added to perform *Fast Fourier Transfom* on audio signals. however, it seems to behave weirdly on MCUs. this needs some more testing.

## Strom

ok, *Strom* is somehow the *stepchild* of this whole project. i hope to soon rectify this. but at least *Strom* was now added to the repository and a few basic tools and utilities were implemented ( e.g events via `bit_bang()` ). but it is still very much a work-in-progress ( WIP ).

however one new member to the family was introduced: the `TaskScheduler`. it was added to easily created time-based callbacks. each task can be connected to a single function callback. the scheduler needs to be updated from within `loop()`. it’s not at all advanced but allows for some easy repetitive event scheduling.

## `git` Commit Messages

or to put the last weeks in `git` terms:

```
2022-02-21 : updated dev diary
2022-02-21 : added script to automatically test all examples
2022-02-21 : updated README
2022-02-18 : added test script for examples
2022-02-17 : reorganized examples, move usb option `none` to default
2022-02-17 : rearranged examples
2022-02-16 : added USB Device support for KLST_CORE
2022-02-16 : minor changes
2022-02-15 : revived KLST_CORE, fixed USB Host + Device options
2022-02-15 : added self powered flag
2022-02-14 : minor fixes
2022-02-14 : minor changes
2022-02-14 : minor changes
2022-02-14 : added USB Device MIDI ( not working yet )
2022-02-14 : USB Device now supports keyboard and mouse HID
2022-02-14 : renamed library to USBDeviceTinyUSB
2022-02-14 : minor changes
2022-02-14 : implemented USB Device HID with HAL library
2022-02-14 : added HAL based USB Device Library
2022-02-14 : minor changes
2022-02-14 : minor changes
2022-02-14 : moved USB clock init to `board_init`, cleaned up variants
2022-02-11 : update STM32duino files to 2.2.0
2022-02-11 : minor changes
2022-02-11 : back to C++17 again, minor changes
2022-02-11 : minor changes
2022-02-11 : minor changes
2022-02-11 : revived USB Host on KLST_SHEEP + KLST_CORE, reverted to C++11
2022-02-11 : USB Host ID (FS||HS) is now handle bsp
2022-02-11 : cleaned up host and got it to working again on
2022-02-10 : completely broke USB Device + Host for all boards
2022-02-10 : minor changes
2022-02-10 : minor changes
2022-02-10 : updated TinyUSB current version (0.12.0+)
2022-02-10 : tried optimizing variant definition to make USB DEvice work ( no success )
2022-02-09 : tried to fix USB Device … with no success … totally erratic
2022-02-09 : worked on USB Device
2022-02-07 : tried implementing USB Host + Device for KLST_SHEEP ( not working )
2022-02-07 : changed SAI clock speed, changed USB clock, minor changes
2022-02-04 : made wavetable now supports different dataypes
2022-02-03 : made VCO wavetable size fixed
2022-02-03 : updated copyright notice
2022-02-02 : added sampler view
2022-02-02 : updated keywords
2022-02-02 : updated copyright notice
2022-02-02 : updated keywords
2022-02-02 : updated copyright notice
2022-02-02 : updated copyright notice
2022-02-02 : minor updates
2022-02-01 : added stm32 includes
2022-01-31 : added `NodeBlockMulti` with up to 256 input and output channels
2022-01-31 : added amplification channel to NodeVCA ( + example with LFO )
2022-01-31 : added amplification channel to NodeVCA ( + example with LFO )
2022-01-31 : added in/out to NodeSampler, improved examples,
2022-01-30 : added applications
2022-01-30 : added option to pass folder path to `Card.begin` mainly for dev
2022-01-29 : improved serial data receive events
2022-01-28 : cleaned up examples
2022-01-28 : added display example
2022-01-28 : added display example
2022-01-28 : updated card examples
2022-01-28 : updated card examples
2022-01-28 : finished 4x4 drum machine
2022-01-26 : aborted DMA+display experiment for now
2022-01-26 : moved SPI do different clock
2022-01-26 : minor changes
2022-01-26 : added DMA on SPI3, transferred settings from CubeIDE
2022-01-26 : updated alternative drivers
2022-01-26 : preparing to add DMA driver for KLST_SHEEP display implementation
2022-01-24 : finished weekend project 4×4 drum machine
2022-01-24 : finished weekend project 4×4 drum machine
2022-01-24 : added master volume to multi stereo node
2022-01-24 : removed proportional volume adjustment in mixers
2022-01-24 : fixed audio block pool memory issue, increased C/C++ standard to C/C++17
2022-01-24 : minor changes
2022-01-22 : made a sample-based drum machine
2022-01-22 : minor changes
2022-01-22 : added task scheduler, minor changes
2022-01-20 : update WAV importer to I16
2022-01-20 : switched WAV importer to I16
2022-01-20 : started implementing different formats
2022-01-20 : improved node sample ( can play backwards now too )
2022-01-20 : cleaned up examples
2022-01-20 : added option to just read the header of a WAV file
2022-01-20 : improved type handling in sampler
2022-01-20 : added attribute `.sample_buffer` to RAM_D2 domain ( 288K on STM32H743VIT )
2022-01-20 : moved audio pool buffers to dedicated memory region ( on MCUs )
2022-01-19 : worked on memory management and linker script
2022-01-18 : updated includes, reduced buffer size for file reading ( needs testing )
2022-01-18 : added strom patterns
2022-01-18 : updated build system for card library
2022-01-18 : updated examples and sources
2022-01-18 : minor changes
2022-01-18 : fixed memory leak in audio player
2022-01-18 : added card library
2022-01-18 : added audio player example
2022-01-18 : fixed encoder ID
2022-01-18 : added `boards.txt` to suppress warnings
2022-01-18 : imporved encoder behavior in SDL + KLST
2022-01-18 : added `delta` to encoder rotated event
2022-01-17 : improved SDL view, implemented SDL encoder, cleaned up defines + events
2022-01-17 : refined event handling, renamed "encoder rotate" to "encoder rotated"
2022-01-17 : added encoders to SDL
2022-01-17 : minor changes
2022-01-16 : fixed card on MCU + CPU platforms ( card is now a library )
2022-01-16 : implemented Card KLST version ( mostly works )
2022-01-16 : added SdFat library, moved KlangstromCard to library folder ( not done yet )
2022-01-16 : extracted methods in Card, started KLST card implementation
2022-01-15 : made WAV reader multi-channel
2022-01-15 : added WAV file importer to SDL
2022-01-15 : added card, fixed KLST_SHEEP encoder
2022-01-14 : renamed tools
2022-01-14 : enabled software filtering for encoder
2022-01-13 : fixed encoders
2022-01-13 : finished draw audio buffer
2022-01-13 : cleaned up, started draw audio buffer
2022-01-12 : optimized display
2022-01-12 : implemented KLST display, cleaned up font
2022-01-12 : switched endianess in image converter
2022-01-11 : separated general and specific implementations
2022-01-11 : added display fonts
2022-01-11 : minor changes
2022-01-11 : cleaned up fonts
2022-01-11 : updated font, added  5x8 font, improved editor
2022-01-10 : updated font
2022-01-10 : added Font_7x9
2022-01-10 : added 565 image converter and 565 font editor
2022-01-09 : cleaning up fonts
2022-01-09 : introducing fonts
2022-01-08 : added font+image support, added address window emulation
2022-01-08 : updated display
2022-01-07 : renamed SD Card pin labels
2022-01-05 : reworked LEDs, started native SPI LCD support for KLST_SHEEP
2022-01-03 : started display
2022-01-03 : minor changes
2022-01-03 : added simluation platform
2022-01-03 : introduced build script for SDL
2021-12-21 : minor changes, trying to track 5min-switch-off-bug in SDL
2021-12-11 : fixed audio output
2021-12-08 : updated SAI configuration
2021-12-08 : cleaned up
2021-12-07 : cleaned up
2021-12-07 : updated STM32duino to 2.1.0 ( added build options )
2021-12-07 : updated STM32duino to 2.1.0 ( system )
2021-12-07 : updated STM32duino to 2.1.0 ( core )
2021-12-07 : updated STM32duino to 2.1.0 ( added build options )
2021-12-07 : updated STM32duino to 2.1.0 ( libraries )
2021-12-07 : updated STM32duino to 2.1.0
2021-12-04 : added LED
2021-12-04 : used original ld script … works
2021-12-03 : removed UART + PWM Msp functions
2021-12-03 : removed KLST_SHEEP compile time errors
2021-12-03 : added KLST_SHEEP
2021-12-03 : optimized modulo
2021-11-28 : added articles
```