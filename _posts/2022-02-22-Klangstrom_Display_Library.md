---
layout: post
title:  "Klangstrom Display Library"
date:   2022-02-22 14:00:00 +0100
---

![](/assets/2022-02-22-Klangstrom_Display_Library.gif){: width="100%" }   

the display library is SPI based and mostly used on the KLST_SHEEP 2.8" TFT display. it’s been re-written ( #reinventingthewheel ) from ground up and was inspired by the Adafruit display library and some other bits and bobs from here and there. appart from the standard things it can do ( e.g draw primitive shapes, bitmaps, and fonts ) it is worth mentioning that i also added a **bitmap converter** ( located in `./tools/ImageConverter888_565` ) that converts RGB image files into c-style header files that can be integrated into the display library. i also added a **font editor** ( located in `./tools/Font565Editor` ) that allows the creation of simple bitmap fonts that can be used in the display library ( BTW `565` stands for the slightly weird 16-bit color format that the display driver uses ).
