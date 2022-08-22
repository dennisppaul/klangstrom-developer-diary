---
layout: post
title:  "Klang / Performance Tests with Mixers"
date:   2021-05-31 10:00:00 +0100
---

![](/assets/*.jpg) 

testing `NodeMixer32` with a single wavetable oscillators to each used channel ( i.e `01`, `04`, `08`, `16`, `32` ) on KLST_TINY board.

the time measured below shows amount of micro seconds (μs) it takes to compute one audioblock ( 128 samples ). note, that the absolute maximum duration of an audioblock is 2666μs ( = μs_per_second/(sampling_rate/sampler_per_block) = 1000000/(48000/128).

### Duration Mixer Nodes

(20210603)

all channels were used with a single wavetable oscillator connected:

| Node Type                              | Optimize | Duration Audioblock (μs) |
|----------------------------------------|----------|-------------------------:|
| NodeMixer32                            | `-Os`    |                   2026.7 |
| NodeMixer32                            | `-O3`    |                   1952.3 |
| NodeMulti, 32 channels                 | `-Os`    |                   2106.1 |
| NodeMulti, 32 channels                 | `-O3`    |                   2052.3 |
| NodeMixer16                            | `-Os`    |                   1019.7 |
| NodeMixer16                            | `-O3`    |                    930.6 |
| NodeMulti, 16 channels                 | `-Os`    |                   1061.6 |
| NodeMulti, 16 channels                 | `-O3`    |                   1035.0 |
| NodeMixer16, only 12 OSCs              | `-O3`    |                    821.4 |
| NodeMulti, 12 channels                 | `-Os`    |                    806.9 |
| NodeMixer4                             | `-Os`    |                    263.8 |
| NodeMulti, 4 channels                  | `-Os`    |                    290.8 |
| NodeMixer4Stereo                       | `-Os`    |                    306.4 |
| NodeMixerMultiStereo, 4 channels       | `-Os`    |                    818.9 |
| NodeMixerMultiStereo, 8 channels       | `-Os`    |                   1622.2 |
| NodeMixerMultiStereo, 12 channels      | `-Os`    |                   2421.3 |

## Duration Measurement Code

```c
void audioblock(SIGNAL_TYPE* pOutputLeft, SIGNAL_TYPE* pOutputRight,
                SIGNAL_TYPE* pInputLeft, SIGNAL_TYPE* pInputRight)  {
    const uint32_t start = klst_get_cycles();
    mDAC.process_frame(pOutputLeft, pOutputRight);
    const uint32_t delta = klst_get_cycles() - start;
    mAudioblockDuration = klst_cyclesToMicros(delta);
}
```