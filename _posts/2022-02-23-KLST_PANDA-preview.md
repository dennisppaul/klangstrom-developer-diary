---
layout: post
title:  "KLST_PANDA preview"
date:   2022-02-23 08:00:00 +0100
---

![2022-02-23-KLST_PANDA-preview](/assets/2022-02-23-KLST_PANDA-preview.jpg)   
slightly bigger, a bit cumbrously + black&white.   

although KLST_SHEEP turned out to be really nice it is not at all perfect yet. i am still not happy with the green color of the PCB, the tiny RAM is a problem when working with pre- or live-recorded audio data, and the TFT display on an extra PCB is just not cool. 

for these, and some other reasons, i have already started planning a new board: KLST_PANDA

*PANDA* you ask? well, it will be a bit bigger than KLST_SHEEP, will come with a general friendly attitude towards things but also be a bit cumbrously, it will exist in small numbers only, it will be a bit more independent of others, and most importantly hopefully finally black&white.

the rough description of the changes compared to KLST_SHEEP are as follows:

- combination of KLST_SHEEP + [KLST_GRASS]({% post_url 2021-11-26-KLST_GRASS-preview %}) ( which i might not produce at all then )
- 64MB SDRAM
- built-in TFT display ( directly on PCB + maybe parallel interface )
- SD Card with SDIO/SDMMC support
- STM32H7II MCU ( as used in KLST_CORE with enought pins for SDRAM and *parallel* display interface ) 
- battery holder ( 18650 cells ) + charger circuit
- USB-C connector
- black&white PCB
- and maybe a case
