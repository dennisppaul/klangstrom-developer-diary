---
layout: post
title:  "KLST_PANDA Final Design Concept"
date:   2023-07-19 10:00:00 +0100
---

![2023-07-19-KLST_PANDA-final-design-concept](/assets/2023-07-19-KLST_PANDA-final-design-concept.png)

one year later and the concept for the hardware design of the next board KLST_PANDA is finalized. it has evolved quite a bit from the considerations in [KLST_PANDA_starting_design_phase]({% post_url 2022-07-19-KLST_PANDA_starting_design_phase %}) and [2023-04-17-KLST_PANDA-Prototyping]({% post_url 2023-04-17-KLST_PANDA-Prototyping %}).

the general idea is now to build the *final* version of the board that will incorporate a lot of features that may ( or may not ) be used in future projects or implementations. this resonates with the idea that *Klangstrom* is on the one hand a development plattform for audio-based applications but also a modular blueprint for all sorts of hardware projects.

## features

- core or MCU
    - `STM32H723ZGT`
- display
    - 4.3" 480×272px 24bit color `ER-TFT043A2-3`
    - capacitive touch panel `FT5206`
    - dimmable backlight `‌CAT4139‌ `
    - LTDC interface ( parallel )
- rechargeable battery
    - type `18650` cells
    - on-off switch
- USB-C
    - 2× connectors
    - USB Device + charging
    - USB Host
- audio codec
    - `WM8904`
    - stereo in+output audio codec
    - headphone amplifier
- external memory 
    - `S70KL1282`
    - 16MB ( 128Mb )
    - Octo-SPI/HyperRAM™ interface
- SDCard
    - 4-bit wide bus
    - with card detect
- microphone
    - on-board MEMS microphone 
    - via I2S
- DAC+ADC
    - range 0.0–3.3V
    - DAC interfaced via 3.5mm mono audio connector
    - ADC interfaced via 3.5mm mono audio connector
- MIDI ( analog )
    - interfaced via 3.5mm stereo audio connector ( TRS with `Type A` allocation )
- GPIO
    - 4× programmable PWM pins
    - 1× I2C ( 2 pins )
    - 1× SPI ( 4 pins )
    - 1× USART ( 2 pins )
    - 3× ADC ( in addition to ADC via audio connector )
    - 10× standard digital in-/output pins
    - GND ( 3 pins )
    - 5.0V
    - 3.3V
- LEDs
    - 2 dimmable LEDs
- buttons
    - reset, boot, programmer
    - 2× mechanical keybord keys
- programmer interface
    - STD14
    - Tag Connect TC2070 pogo pin connector ( without housing on front-side )
- case+shape
    - black&white PCB
