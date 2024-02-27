---
layout: post
title:  "KLST_PANDA+ADC+DAC"
date:   2024-02-28 10:00:00 +0100
---

![KLST_PANDA+ADC+DAC](/assets/2024-02-28-KLST_PANDA+ADC+DAC.jpeg) DAC stepping through the full voltage range from 0.0–3.3V 

KLST_PANDA features an ADC[^1] and a DAC exposed via 3.5mm audio jacks. both audio connectors are configured so that `TIP` carries input or output signal while `RINGS` and `SLEEVE` are tied to `GND`.

the DAC has a voltage range from 0.0–3.3V and a resolution of 12-bit. it is also reverse voltage protected. the DAC uses the peripheral `DAC1`.

the ADC is clamped at a voltage range from 0.0–3.3V. the ADC is clocked at ADC at 64MHz but takes one-shot measures at speed of 2.5 cycles[^2]. the ADC uses peripheral `ADC3`.

[^1]: there are actually 2 other ADCs exposed via the GPIO port.
[^2]: a quick measurement shows that it takes slightly less then 3ms to generate one sample. which is interesting as i would associate *cycle* with *clock* cycles. i need to investigate this.