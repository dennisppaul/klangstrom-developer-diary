---
layout: post
title:  "KLST_PANDA v1.0a Errata"
date:   2024-02-05 18:00:00 +0100
---

here i will shamelessly collect all the things that are wrong, not ideal or not perfect in version v1.0a of KLST_PANDA. this list will be updated as i continue to test modules.

- @module(battery) SS14 diode which i added as polarity protection prevents the battery from charging. @fix(remove diode and replaced with solder bridge )
- outer PCB layers ( top and bottom ) have no copper pour ( they got lost when uploading files a second time ). @fix(take extra care to add pours next iteration)
- @module(on-board_microphone) missing decoupling capacitors at right ( i.e on-off switch side ) microphone
- @module(audio_codec) some units must receive 3.3V instead of 1.8V
