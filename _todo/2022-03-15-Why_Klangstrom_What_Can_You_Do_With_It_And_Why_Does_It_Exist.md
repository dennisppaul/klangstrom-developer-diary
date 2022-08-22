---
layout: post
title:  "Why Klangstrom? What Can You Do With It? And Why Does It Exist?"
date:   2022-03-15 08:00:00 +0100
---

![2022-03-15-KLST_SHEEP](/assets/2022-03-15-KLST_SHEEP.jpg)   
ok, so *Klangstrom* is a bit of infrastructure … somehow related to sound and music and it is hardware + software. but why does it exist? what can one do with it? and where does it come from?

in essence *Klangstrom* is a potential, a set of possbilities. it is the catalyst for a lot of our interest that do not always align. these interest are obviously located in the areas of hardware and software development, music making ( i.e sound + muscial composition ), and sound+music-based devices or gadgets. this list might be best explained by example. so let’s have a look at possible *formats* we envisioned to be realized with *Klangstrom* or maybe even directions the *Klangstrom* project itself could evolve into:

![ELECTROSMITH DAISY SEED](/assets/2022-03-15-ELECTROSMITH_DAISY_SEED.jpg)   
( ELECTROSMITH DAISY SEED )

to begin with the obvious *Klangstrom* is *yet another* development platform. it is based on Arduino and thereby related to the whole *attitude* surrounding the Arduino *eco-system*. however, there are two projects that are closer than the general Arduino project: these are the [Teensy + Audio Adaptor Board](https://www.pjrc.com/store/teensy3_audio.html) and [Daisy Seed](https://www.electro-smith.com/daisy/daisy). both are really well crafted, persistent and commercial projects. TBH it is also sometimes hard for us to justify why we wouldn’t just use one of these projects for our interests ( like for example Dirtywave M8 which is entirely based on teensy ). of course our project has a slightly different scope ( e.g also looks at composition and not just sound processing ), or *Klangsstrom* is fully open source in hardware and software ( e.g teensy’s bootloaders are proprietary which is IMH perfectly legitimate ). maybe the only real and honest reason is that we develop *Klangstrom* and therefore can steer the directions it goes to and places it aims to explore. so yes, *reinventing the wheel* but in a reflected manner.

![ARTURIA MICROFREAK](/assets/2022-03-15-ARTURIA_MICROFREAK.jpg)
( ARTURIA MICROFREAK )

from on more pragmetic *Klangstrom* can be used to build stand-alone synthesizer. either in a more classical way ( like the Arturia MicroFreak above ) or with more experimental interface or sound ideas. the *Klang* library allows for the creation of complex, polyphonal sound engines and the Arudino-ness of *Klangstrom* allows the integration of the weirdest of interfaces.

![MUTABLE_INSTRUMENTS_CLOUDS](/assets/2022-03-15-MUTABLE_INSTRUMENTS_CLOUDS.jpg)      
( MUTABLE INSTRUMENTS CLOUDS )

it is not such a big step from standalone synthesizers to modules that are integrated into *Eurorack* setups ( i.e adapt power supply and input+output levels ). AAMOF we are currently working on extensions to *Klangstrom* that allow *Klangstrom* to produce and process controll and sound signals in an modular synthesizer context. and although it is not the focus or scope of *Klangstrom* it might still be worth noting that e.g KLST_SHEEP can run the code of ( some? ) Mutable Instruments modules e.g Braids, Plaids and Clouds ( they share a similar MCU ).

![](/assets/2022-03-15-TEENAGE_ENGINEERING_PO-14.jpg)   
( TEENAGE_ENGINEERING_PO-14 )
sequencer ( see TE POs )

![](/assets/2022-03-15-DIRTY_WAVE_M8.jpg)   
( DIRTYWAVE M8 )

audio applications and mod player ( see Dirtywave M8 )

![](/assets/2022-03-15-BOSS_FLANGER.jpg)   
( BOSS_FLANGER )
effect peddle ( see BOSS guitar effect )

![](/assets/2022-03-15-AUTOMATIQUE_ORCHESTRA.jpg)   
networked installation ( see automatique orchestra )

![](/assets/2022-03-15-NINTENDO_GAMEBOY.jpg)   
![TOSHIO IWAI ELECTROPLANKTON](/assets/2022-03-15-TOSHIO_IWAI_ELECTROPLANKTON.jpg)
handheld music gaming console ( see gameboy )
add Toshio Iwai: Electroplankton ( "interactive music video game" ) https://en.wikipedia.org/wiki/Electroplankton

![](/assets/2022-03-15-DENNISPPAUL_NMI-010.jpg)   
experimental interaction designs ( see NMI-002+010+011 )

… and more generally speaking: a learning environment for music composition + sound making.

so you might also ask why not use one of the existing platforms like bigger Arduino, Teensy + Audio Adaptor Board, Daisy Seed etcetera. 

## history

how and why we started klangstrom.

- people wanted to make sounds with MCUs ( PWM … then nothing … then super complex )
- NMI
- CFO
- automatique orchestra
