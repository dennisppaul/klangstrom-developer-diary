---
layout: post
title:  "KLST_TINY First Draft"
date:   2021-03-17 11:13:00 +0100
---

![2021-03-17-KLST_TINY--first-draft-PCB](/assets/2021-03-17-KLST_TINY--first-draft-PCB.png)   
a first draft of a new klangstrom board based on a slightly smaller STM32F446RET.   

this is the first spin off of the KLST_CORE. it is a slightly reduced version. the MCU is not as fast, has less memory and far less pins. however it is smaller and cheaper.

the idea is to design an infrastructure with a set of *proposals* for new musical interfaces ( 3 encoders with buttons, 3 LEDs, 2 serial connectors + a some GPIOs ). the board aims to emanate the charisma of a portable instrument (hub). powered by a USB powerbank and connected to a portable speaker it can easily be used in the field.

another idea is to design the board so that it can be completely produced at JLCPCB. 

![2021-03-17-KLST_TINY--first-draft-PCB](/assets/2021-03-17-KLST_TINY--first-draft.png)

## feature list (20210317)

- STM32F446 MCU with 180MHz, 128KB RAM, 512KB Flash
- WM8731 Audio Codec with 2× AUDIO DAC + 2× AUDIO ADC ( 24BIT )
- Audio Connectors for Line-Input + -Output + Headphones with Microphone
- 2× ADC ( 12BIT, opt 6 extra channels )
- 2× DAC ( 12BIT )
- 3× UART ( serial )
- 8× GPIO
- 1× USB @todo(optional footprint for USB-A connector?)
- 1× I2C 
- 1× SPI 
- 3× ENCODERS WITH BUTTONS ( TIM2, TIM3, TIM8 )
- 1× programmable LEDs + 1× Power LED
- 11× TIMERS
- 1× SD CARD READER
- 1× JTAG/SWD Interface ( 10-Pin )
- Reset + Boot Flash Buttons
- 4× Mounting Holes
