---
layout: post
title:  "Simulator is now called Emulator and got Face Lift"
date:   2022-02-22 10:00:00 +0100
---

![](/assets/2022-02-22-Simulator_is_now_called_Emulator_and_got_Face_Lift.png)   

it is now agnostic to different board types. there is an option in the Arduino IDE to select target boards for to be emulated ( in respect to number of LEDs, rotary encoders, displays etcerera ). also the visual appearence of the emulator application window has been cleaned up.

the emulator can now mimic rotary encoders more realistically. once `CAPS` is pressed the arrow keys can be used to rotate and select encoders. encoders now also have a visual representation in the emulator.

the emulator can also mimic SD card interactions. once an SD card started from an application, a *file chooser dialog* is opened ( via [tiny file dialogs](http://tinyfiledialogs.sourceforge.net/) ) and files can be read form HD.

the emulator can also mimic the behavior of a display via the display library. it is more or less pixel accurate.
