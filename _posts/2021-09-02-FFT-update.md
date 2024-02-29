---
layout: post
title:  "FFT update"
date:   2021-09-02 10:00:00 +0100
---

updates on the FFT topic.

there is now a node `NodeFFT` that is capabable of analyzing audioblocks for their frequency spectrum. it is far from being perfect but it does work … basically.

i have added three techniques to improve the *quality* of the analysis and thereby the detected dominant frequency:

1. *Hamming Windowing* is used to shape the signal before transforming it to the frequency domain.
2. *Gaussian Interpolation* is used increase the frequency resolution by looking at neighboring bands.
3. *Accumulated Sample Buffer* is used to accumulate multiple audio buffers to achieve a higher *frequency resolution*. since the buffer is filled in a *rolling* manner the *time resolution* does not increase in a notable fashion:

example of the first 9 steps populating a 4 times longer *Accumulated Sample Buffer* with *Audio Buffer* samples:

```
1. |(1)|   |   |   |
2. |(1)|(2)|   |   |
3. |(1)|(2)|(3)|   |
4. |(1)|(2)|(3)|(4)|
5. |(5)|(2)|(3)|(4)|
6. |(5)|(6)|(3)|(4)|
7. |(5)|(6)|(7)|(4)|
8. |(5)|(6)|(7)|(8)|
9. |(9)|(6)|(7)|(8)|
```

note, that the accumulated *Audio Buffer* sample data would creates audible artifacts, e.g in step `5.` where the data of the newly added block connects to a much *older* block. although this is not correct it does not affect the analysis notably but reduces data handling time significantly.

performance-wise the algorithm is surprisingly fast. using dedicated DSP functions really paid off. the performance can be improved even more by precomputing a *Hamming Look Up Table*.

## Average Duration of Audioblock (μs) on KLST_TINY

| TASK                                      | μs     |
|-------------------------------------------|--------|
| no analysis                               | 112.94 |
| no analysis, but update FFT sample buffer | 133.90 |
| analysis every `beat()` [^1]              | 133.93 |
| analysis every `audioblock()`             | 228.54 |

- audio rate ......................... : 48000Hz
- samples per audio block ............ : 128
- max duration of audio block (μs) ... : 2667
- hamming windowing .................. : true
- precomputed hamming window ......... : true

[^1]: note that this measurement does bear much significance as the FFT analysis is performed outside of the `audioblock()` function but rather in the `beat()` function.