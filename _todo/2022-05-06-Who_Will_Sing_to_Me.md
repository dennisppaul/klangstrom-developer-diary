---
layout: post
title:  "Who Will Sing to Me?"
date:   2022-05-06 08:00:00 +0100
---

![2022-05-06-Sing_to_Me](/assets/2022-05-06-Sing_to_Me.jpg)   
we want to make *Klangstrom* sing. a quick glance at TTS engines.

- https://youtu.be/aOnAYgOfQ1k
- https://youtu.be/t0W8P5xWSDw

> rabbid hole, rabbid hole, you send me down a rabbid hole.

so the task is to find a synthesis engine that meets the following criteria:

- small memory footprint
- compiles under GCC ( ARM )
- works on STM32
- should understand [SSML](https://en.wikipedia.org/wiki/Speech_Synthesis_Markup_Language)
- should have singing feature or enough controll to implent *singing*

## what actually *is* singing?

some engines ( e.g *Sinsy* ) are specificially made to *sing* or at least have a *singing* feature. most engines however are designed without a specific notion of *singing*. so what does it actually take to implement singing?

after some recherche, research and experimentation it turns that if a speech engine does not support *singing* right away at least the following to features are need to produce a *singing* output:

- pitch -- control of frequency ( ideally in Hz )
- speed -- control over the duration of word ( + opt. syllables )
- deviation -- control over change in pitch in a text, for *singing* there should be no deviation 
- volume ( opt. ) -- control of amplitude ( could also be handled after synthesis )
- phones ( opt. ) -- have the engine speak phone sounds instead of texts

## TTS enginge under consideration

- [Software Automatic Mouth (SAM)](https://github.com/discordier/sam)
- [eSpeak](https://github.com/eeejay/espeak)
- [eSpeak NG](https://github.com/espeak-ng/espeak-ng/)
- [Festival Speech Synthesis System](https://github.com/festvox/festival)
- [Flite: a small run-time speech synthesis engine](https://github.com/festvox/flite) ( see also [arduino-flite](https://github.com/pschatzmann/arduino-Flite) )
- [PicoTTS](https://github.com/naggety/picotts)
- [Sinsy](http://sinsy.sourceforge.net/)
- [MaryTTS](https://marytts.github.io/index.html) #java
- [PlainTalk]()

### Flite

- example > https://soundcloud.com/dennis-p-paul/tracks
- potential problem is memory footprint ( for all engines except SAM )

### SAM

### eSpeak

- small memory footprint ( see https://www.rockbox.org/wiki/pub/Main/TTSInCore/TTS_Comparison.pdf )

