---
layout: post
title:  "Klangstrom Release 0.0.1"
date:   2021-06-14 10:00:00 +0100
---

<span style="background:#F2F2F2;font-size:154px;">&nbsp;v0.0.1&nbsp;</span>

since the intial release klangstrom has evolved quite a lot. appart from an extensive ever growing documentation website at [klangstrom-for-arduino.dennisppaul.de](http://klangstrom-for-arduino.dennisppaul.de), firmware and klang sound library have undergone some changes.

below are the release notes:

## 0.0.1

- `NodeADSR`+ `NodeRamp` + `NodeEnvelope` can now be triggered by an input channel signal
- `NodeADSR`+ `NodeRamp` + `NodeEnvelope` now also accept microsecond values ( and use them internally as well )
- `NodeSampler` now works with different data types ( `float`, `uint8_t` and `uint16_t` )
- speed of serial port ( `SERIAL_00` + `SERIAL_01` ) is now an option
- `NodeTextToSpeechSAM` now has a customizable buffer size
- `NodeVCOWavetable` can now share wavetable data
- added `NodeRamp` for linear value interpolation
- improved + fixed mixer nodes ( there are now static mixers for 4–32 channels and one node with multiple channels plus 2 stereo versions )
- added mechanism to measure performance of code blocks ( in clock cycles or μs )
- fixed intial encoder button states
- set MCU speed to 180MHz ( from 90MHz )
- added tool to generate sample files
- improved `NodeWavetable` speed by 4.5×
- boards have now unique identifiers `ID()` ( based on their hardware serial number )
- added application to examples ( drum machine + sequencer )
- added documentation ( e.g node library )
- fixed DFU mode ( USB peripherals had to be deinitialized before reset )
- added desktop simulator (SDL)
- added extensions ( i.e reverb, vocoder + TTS )
- cleaned up and improved examples