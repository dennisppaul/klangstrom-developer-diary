---
layout: post
title:  "KLST_PANDA + Battery"
date:   2024-02-14 10:00:00 +0100
---

![KLST_PANDA--front-with-screen](/assets/2024-02-12-KLST_PANDA-is-Looking-Good-02.jpg)

quite straight forward was the integration of the [`18650`](https://en.wikipedia.org/wiki/18650_battery) rechargeable lithium-ion battery. 

there is also an on-off switch at the top of the board. the board can be powered via the USB-C connector or from battery. the battery is also charged via USB-C. the charging is controlled by the charge controller `TP5400`.

two LEDs mounted on the back of the board indicate *charging* or *stand-by* mode ( TBH the *stand-by* LED is already annoying ).

## references

- [Charge Controller `TP5400` (chinese)](https://datasheet.lcsc.com/lcsc/2109091030_TOPPOWER-Nanjing-Extension-Microelectronics-TP5400_C2891434.pdf)
- [Rechargeable Battery `18650`](https://en.wikipedia.org/wiki/18650_battery)