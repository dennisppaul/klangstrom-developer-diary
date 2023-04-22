---
layout: post
title:  "KlangWellen"
date:   2023-03-10 10:00:00 +0100
---

after contemplating the thoughts from [[2022-09-13-atoms_and_nodes_in_klang.md]] i decided to created an independent library: `KlangWellen`.

the main idea of the library is to facilitate lightweight DSP functionality. where lightweight means that the library should be easy to use and does not make use of any high-level design or programming concepts i.e no *node* structure ( like `Klang` ) and no advanced class structures or programming gymnastics. 

this is implemented by supplying a set of classes that perform ( more or less ) *atomic* DSP operations ( e.g signal generation, filtering, effects etcetera ). each unit is called `processor` and may implement one or more of the following functions:

```
/**
 * PROCESSOR INTERFACE
 *
 * - [ ] float process()
 * - [ ] float process(float)‌
 * - [ ] void process(Signal&)
 * - [ ] void process(float*, uint32_t)
 * - [ ] void process(float*, float*, uint32_t)
 * - [ ] float process(float, float)‌ // combines 2 signals into 1 e.g vocoder
 * - [ ] void process(float*, float*, float*, uint32_t) // combines 2 signals into 1 e.g vocoder
 */
 ```

some functions receive an input and produce an output, while other only produce output or receive input. the functions may process single samples or blocks of samples. since this concept is not implemented in any programming structure ( e.g OOP `interface`[^1] ) it is more of an *agreement* than an implemented programming concept. this makes it easy to extend `process` to facilitate e.g the combination of multiple signals ( see the last two methods in the code blokc above ).

this agreement allows to write code that can perform complex DSP operations e.g a simplified examples for a filtered, wavetable oscillator with an ADSR envelope could look something like this:

```
Wavetable oscillator;
ADSR      envelope;
Filter    filter;

// process each sample like this:

float output = oscillator.process();
output = filter.process(output);
output *= envelope.process();
```

i was surprised by how well this concept works ( IMHO even better than the node-based approach from `Klang` ) and how easy it is to create complex signal chains.

while the general approach has been implemented in many other contexts it is mostly inspired by a project for the processing.org environment that i am working on which is called [Wellen](http://github.com/dennisppaul/wellen).

[^1]: BTW i am still shocked that there is a significant performance impact when using *virtual methods* which is the strategy to implement interfaces