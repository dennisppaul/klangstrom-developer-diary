---
layout: post
title:  "KLST_SHEEP in production"
date:   2021-11-08 10:00:00 +0100
---

![2021-11-08-KLST_SHEEP-in-production](/assets/2021-11-08-KLST_SHEEP-in-production.jpg)   

in the eye of the storm of the chipocolypse a new board goes into production: KLST_SHEEP. it started as a variation of KLST_TINY only with a much faster MCU ( "a wolf in sheep's clothing" ). however, in the process it turned into a handheld-console-style board. 

![2021-11-08-KLST_SHEEP-in-production--detail](/assets/2021-11-08-KLST_SHEEP-in-production--detail.jpg)  

KLST_SHEEP is a 10×10cm board. the most important features are a screen ( 2.8" color or 1.25" b/w ), 16 programmable LEDs in the center and two rotary encoder left and right on the front side.

additional noteworthy features are all connectors located on the bottom edge for better ergonomics and a dedicated serial debug port integrated into the JTAG/SWD interface.

## feature list

- STM32H743 MCU with 480MHz, 864KB RAM, 2048KB Flash
- WM8731 audio codec with 2× audio DAC + 2× audio ADC ( 16/24BIT )
- 1× LINE OUT ( stereo )
- 1× LINE IN ( stereo )
- 1× HEADPHONE + MIC ( mono )
- 2× ADC ( 12BIT, opt 6 extra channels )
- 2× DAC ( 12BIT )
- 2× UART ( serial )
- 16× GPIO
- 1× USB Host
- 1× USB Device ( + Power Supply )
- 1× I2C 
- 1× SPI 
- 2× rotary encoders with push buttons
- 16× programmable LEDs with PWM + 1× power LED
- 1× SD card reader
- 1× JTAG/SWD interface + serial debug ( 14-pin )
- programmer + reset + boot flash buttons
- 4× Mounting Holes