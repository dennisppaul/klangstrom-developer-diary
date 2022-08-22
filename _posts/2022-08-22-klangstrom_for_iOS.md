---
layout: post
title:  "Klangstrom for iOS … Proof of Concept"
date:   2022-08-22 18:00:00 +0100
---

![klangstrom_for_iOS](/assets/2022-08-23-klangstrom_for_iOS.png)   

<div class="video-container">
<iframe width="750" height="562" src="https://www.youtube.com/embed/E-C6VHxmvBo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>
[Klangstrom for iOS … Proof of Concept](https://youtu.be/E-C6VHxmvBo)

the Klangstrom emulator ( or simulator ) that is usually used from within the Arduino Environment can now also run as an iOS application.

although a lot of things are still unclear or unfinished i find the prospect of being able to run Klangstrom on iOS particularly exciting because iPhones and iPads can e.g act as really versatile mobile prototyping platforms.

the sketch that is running in this example is a bit blunt and comprised of the following code:

```
#include "Klangstrom.h"
#include "KlangNodes.hpp"

using namespace klang;
using namespace klangstrom;

NodeVCOFunction mVCO;
NodeDAC         mDAC;

void setup() {
    Klang::lock();
    Klang::connect(mVCO, Node::CH_OUT_SIGNAL, mDAC, NodeDAC::CH_IN_SIGNAL);
    mVCO.set_amplitude(0.5);
    mVCO.set_frequency(440.0);
    mVCO.set_waveform(NodeVCOFunction::WAVEFORM::SINE);
    Klang::unlock();
}

void loop() {
    LED(LED_00, LED_ON);        // turn LED_00 on 
    mVCO.set_amplitude(0.25);   // set amplitude to 25%
    delay(1000);                // wait for a second
    LED(LED_00, LED_OFF);       // turn LED_00 off 
    mVCO.set_amplitude(0.0);    // set amplitude to 0%
    delay(1000);                // wait for a second
}

void audioblock(SIGNAL_TYPE* pOutputLeft, SIGNAL_TYPE* pOutputRight, 
                SIGNAL_TYPE* pInputLeft, SIGNAL_TYPE* pInputRight) {
    mDAC.process_frame(pOutputLeft, pOutputRight);
}
```

 #weekendproject 
