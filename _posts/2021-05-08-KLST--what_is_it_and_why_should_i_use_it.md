---
layout: post
title:  "KLST / what is it and why should i use it?"
date:   2021-05-08 10:00:00 +0100
---

![](/assets/2021-05-08-KLST--what_is_it_and_why_should_i_use_it.png).   

Klangstrom (KLST) is an infrastructure to facilitate generative, networked, embedded sound + music + composition. klangstrom is comprised of two software libraries ( *klang* a node+text-based sound synthesis library and *strom* a node+text-based generative composition library ), an embedded hardware platform, and a programming environment to allow seamless development of generative, networked, embedded sound + music + composition applications.

in other words it is the idea of *klangstrom* to make it easier to build e.g electronic musical instruments, sound installations, or microcontroller-based projects that include sound. it tries to achieve this by connecting to existing tools and idioms. 

on the software side *klangstrom* applications can be developed in the Arduino IDE and be either uploaded to a *klangstrom* ( or compatible ) board or run in a desktop simulator. the latter can improves your *turnaround time* in the software development process dramatically. although *klang* comes with an educated set of nodes that can be configured into more complex patches ( e.g oscillators, filters, envelopes ) it is deliberately made easy to write your own nodes. the library tries to uphold a certain degree of simplicity and accessibility, refraining from introducing overly complex programming gymnastics. 

currently there are two *klangstrom* boards available. KLST_CORE which aims to connect to a wide range of peripherals ( incl modular synthesizers and access to a wide range of the microcontroller peripherals / pins ) and KLST_TINY which aims to facilitate the *playful* development of simple musical instruments. despite the existence of concrete *klangstrom* boards, the project first and foremost aims to facilitate the development and production of your own designs. therefore the hardware development process is completely open source. 

so why should you use it? obviously there are already many extremely brilliant and well-crafted projects out there with which similar or even more tech-savvy results can be achieved. for example:

- Teensy 4.x + Audio Adaptor Board
- Daisy Seed ( Electrosmith )
- Raspberry Pi Pico + Audio Pack
- Bela Mini
- Axoloti 

perhaps there is no single powerful reason to use *klangstrom*. however, we like to think of it more as an environment for your own works ( hardware, software and conceptual ) rather than a finished product. ideally *klangstrom* hard- and software is used to experiment and develop ideas and concepts, only to cast the final idea into a design of your own using only as much of *klangstrom* as necessary ( i.e copying sections from of the board design and using snippets from the *klang* library ).

in essence *klangstrom* is first and foremost an infrastructure build to be used, modified, chopped up and put back together in new ways.

## outlooks+plans+extensions

since *klangstrom* is basically just a c/c++ library it can also be implemented on other platforms. and we have been busy experimenting. there are currently working prototypes or proof of concepts for the following platforms:

- Cinder Application ( iOS + MacOS + Windows + Linux )
- SDL Application ( MacOS + Linux )
- CLI Tool via OSC ( MacOS + Linux )
- VCV Rack Plugin ( MacOS )
- Teensy

*klangstrom* is also a playground for our ideas and projects ( this is where the idea actually originated from ). therefore we have an ever growing list of planned boards, modules and extensions:

- KLST_TINY++ :: KLST_TINY with STM32H743VI MCU
- KLST_LUA :: KLST_TINY with electret microphone, speaker + battery
- KLST_WIGGLE :: KLST_TINY with battery + stepper motor
- KLST_PWR :: extension with USB-rechargeable battery power
- KLST_SPKR :: extension with speaker audio output 
- KLST_INTERFACE :: collection of encoders, sliders, and knobs + USB-MIDI
- KLST_MIDI :: UART to MIDI converter
- KLST_MODULAR :: modular synthesizer adapter 
