---
layout: post
title:  "Added USBMIDI via TinyUSB Library"
date:   2021-07-21 17:00:00 +0100
---

![2021-07-21-Added-USBMIDI-via-TinyUSB-Library](/assets/2021-07-21-Added-USBMIDI-via-TinyUSB-Library.gif){:width="100%"}    
after a few days of hard work it is done: KLST_TINY can now act as a MIDI device via USB.

although this is still very much a work in progress, i am very excited about it. first of all being able to use KLST_TINY as a MIDI device is very interesting in both directions: as a synthezier receiving MIDI messages from an application or as a controller sending messages to an application.

another really, really, really interesting aspect about this is that i managed to integrate the library [TinyUSB](https://github.com/hathach/tinyusb). not onluy is it IMHO very well written, it also comes with a wide range of prepared USB device and host(!) descriptors including USB HUBs. i definitely have *eine alte rechnung offen* with that whole topic!

there is quite a wide range of interesting possibilities coming with this integration. *Klangstrom* could act as a MIDI device, as a host for keyboards and other USB peripherals, as an USB audio interface and so on. let s see …
