---
layout: post
title:  "Atoms + Nodes in Klang"
date:   2022-09-13 10:00:00 +0100
---

![2022-09-13-atoms_and_nodes_in_klang](/assets/2022-09-13-atoms-and-nodes-in-klang.jpg)

today i have reworked the core digital signal processing (DSP) strategy in *Klang* into two concepts: *Atoms* and *Nodes*. 

the background is that while the *Nodes* concept is well developed, it is a bit stiff and does not allow for easy development of custom DSP units. *Atoms* now introduce the idea to create units that do one thing ( e.g filter, oscillator, effect, … ) but without the overhead of the whole *Nodes connecting to other Nodes*. therefore making it easier ( and potentially also faster ) to combine and design with them.

in programming code this means that *Atoms* have all ( at least the first ) of the follwing four methods implemented:

```
`float process(float)` :: single sample, with 1 channel
`float* process(float*, int)` :: sample  block, with 1 channel
`Signal process(Signal)` :: single sample, with 1 or more channels
`Signal* process(Signal*, int)` :: sample block, with 1 or more channels
```

or in a slighlty more *elaborate* form:

```
float process(float pSignal);
float *process(float *pSignalBlock, uint16_t pNumSamples);
const Signal &process_signal(const Signal &pSignal);
const Signal *&process_signal(const Signal *&pSignalBlock, uint16_t pNumSamples);
```

*atoms* can then be used e.g like this:

```
AtomOscillator mOSC;
AtomFilter     mFilter;
AtomADSR       mADSR;

float mSignal = mOSC.process(); // oscillators do not process input thus `process()` remains empty
mSignal = mFilter.process(mSignal);
float mAmplitude = mADSR.process();
mSignal *= mAmplitude; // ADSR output is multiplied to scale signal amplitude
mSignal *= 0.5f; // reduce signal strength to 50% 
```

the example above illustrates how it is easy to combine atoms and also use simple mathematical ( e.g multiplications ) and programming ( e.g conditionals ) concepts.

theoretically, *Atoms* can form the basis of all *Nodes*

## inheritance or not?

i am currently considering whether it is a good or a bad idea to derive all atoms classes from a base class.

while it seem structurally and design-wise tempting to do so, this concept might impact performance quite a lot as all `process` functions need to be virtual ( i.e need to be looked up in a `vtable` ).

```
class Atom {
public:
	virtual float process(float pSignal) = 0;
	virtual float *process(float *pSignalBlock, uint16_t pNumSamples) = 0;
	virtual const Signal &process(const Signal &pSignal) = 0;
	virtual const Signal *&process(const Signal *&pSignalBlock, uint16_t pNumSamples) = 0;
};
```

the only real functional benefit i can see from using an atom base class would be that atoms can be collected and processed in groups. this however, might not even be a likely scenario for klang applications. alternatively, i could just implement the process methods without any specific C++-structure.

TBH i was bit surprised that there does not seem to be a reliable way to inline inherited ( or pure virtual ) methods. while in high resources architectures ( i.e desktop computers ) this might not matter, in embedded systems especially in time-crucial applications ( i.e DSP ) there might very well be a significant performance impact. 

however, as always i think there is no way doing some *field tests* on a target embedded system.