---
layout: post
title:  "KLST_PANDA starting design phase"
date:   2022-07-19 08:00:00 +0100
---

![](/assets/2022-07-19-KLST_PANDA--preview.png)   
starting the design phase for KLST_PANDA.

as described in [KLST_PANDA preview]({% post_url 2022-02-23-KLST_PANDA-preview %}) the new board is going to be really, really interesting!

> *PANDA* you ask? well, it will be a bit bigger than KLST_SHEEP, will come with a general friendly attitude towards things but also be a bit cumbrously, it will exist in small numbers only, it will be a bit more independent of others, and most importantly hopefully finally black&white.

after a lot of research ( which i will release the next days ) i have refined the technical specifications. the board is more or less a combination of KLST_SHEEP + [KLST_GRASS]({% post_url 2021-11-26-KLST_GRASS-preview %}) with a few tweaks and updates:

- STM32H723ZGT MCU ( 550MHz )
- WM8904 audio codec
- 16MB external memory
- TFT display ( with parallel interface and mounted directly on PCB )
- SD Card ( with SDIO/SDMMC support )
- battery holder ( for 18650 cell ) + charger circuit
- USB-C connector ( for Device or Host )
- MEMS microphone ( mounted on PCB )
- black&white PCB
- hole in PCB for strap
- CNC-milled POM case

the aim is that this board will be entirely produced at JLCPCB. it will feature the following peripherals:  

- 1× USB
- 1× TFT
- 1× SDCard ( 4-bit via `SDMMC1` )
- 1× external memory ( Octo-SPI/HyperRAM™ via `OCTOSPI1` )
- 1× SAI+I2C audiocodec ( via `SAI1` )
- 2× encoders ( via timers `TIM1` + `TIM2` )
- 2× buttons ( with interrupts via `TIM12` )
- 3× UARTs ( via `USART2`, `USART3` + `UART8` )
- 1× I2C ( via `I2C1` )
- 2× SPI ( via `SPI2` + `SPI4` )
- 1× DAC
- 3× ADC
- 4× LEDs ( dimmable via one PWM timer `TIM23 ` on different channels )
- 5× GPIO PWM ( via dedicated timers 2× `TIM3` + 2× `TIM4` + `TIM24` )
- 16× GPIO
