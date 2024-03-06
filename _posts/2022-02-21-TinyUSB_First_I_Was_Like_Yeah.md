---
layout: post
title:  "TinyUSB First I Was Like Yeah! Then I Was Like Naaaargh!"
date:   2022-02-21 08:00:00 +0100
---

Device OK, HOST !OK, Arduino :(

this was actually quite a ride! some time last year i had discovered ( by browsing through some Adafruit Libraries ) the very interesting project [TinyUSB](https://github.com/hathach/tinyusb):

> TinyUSB is an open-source cross-platform USB Host/Device stack for embedded system, designed to be memory-safe with no dynamic allocation and thread-safe with all interrupt events are deferred then handled in the non-ISR task function.

i wasn’t so much interested in the *cross-platform* aspect but what i found really tempting was the great number of already implemented USB Device + Host classes ( including a *MIDI* class and a *Hub* class … my long term nemesis ). also, from browsing through the source code it appeared to be really nicely structured and well written.

i started adding USB HID + MIDI Device and that worked really well. the interface to the library was much, much clearer and coherent than the HAL version from STM32CubeIDE: Yeah!

but then the first disappointment lurked into the picture: it turns out that the  Host stack is not implemented for STM32 MCUs. not happy. unfortunately, i also still did not feel like investing time and energy to get into implementing that myself ( despite the fact that this would be a really nice contribution to the TinyUSB project ). so i decided to introduce ST’s Host stack ( from STM32CubeIDE ). this worked fine for KLST_CORE and was a bit flakely for KLST_TINY. however, i never really like that fact that i now had two different USB libraries at work.

the second and final disappointment came when i tried to implement the libraries for KLST_SHEEP. long story short: it took me a whole 2 weeks to get *something* to work. i still do not exactly now what the root of the problem is, but for some reason KLST_SHEEP could not run the Device stack properly … while KLST_CORE still worked ( nearly identical MCUs ). however this behavior i could only observe in the Arduino context; the examples provided by TinyUSB worked fine for both boards. i have compared every single line of platform specific (BSP) code but could not find the difference: Naaaargh!

i ended up giving up and used the HAL library also for the Device stack instead. this did work mostly. the MIDI Device class has some weird behavior still: the boards shows up as a MIDI Device but can not send or receive MIDI messages. i am still investigating this one but found out that i can hack/fix it by copying all USB Device source files into the `core` folder. without pointing any fingers i believe that a lot of the trouble comes from the more or less messy way in which the Arduino Build System is structured and works.

in retrospect i still believe [TinyUSB](https://github.com/hathach/tinyusb) to be an amazing project. however, for my purposes and in combination with the Arduino ecosystem it does not work … ATM … maybe later.
