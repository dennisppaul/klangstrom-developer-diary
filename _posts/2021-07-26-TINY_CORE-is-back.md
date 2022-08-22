---
layout: post
title:  "TINY_CORE is back"
date:   2021-07-26 16:00:00 +0100
---

![2021-07-26-TINY_CORE-is-back](/assets/2021-07-26-TINY_CORE-is-back.png){:width="100%"}    
after a few days of hard work ( a reoccuring theme ) it is done: KLST_CORE now has a board defintion again.

i have refactored and cleaned up the entire project quite a lot in the last days. the result is a much nicer way of integrating new MCUs without having to write ( too much ) redundant code, while at the same time being able to use some of the auto-generated STM32CubeIDE code.

especially in light of the current world-wide MCU shortage, i am particularily exited to be able to use KLST_CORE as well as KLST_TINY now. not all KLST_CORE features have been test yet ( most notably the Eurorack connection ), but sound and USB seems to work just fine.