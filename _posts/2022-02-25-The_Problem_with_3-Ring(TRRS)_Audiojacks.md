---
layout: post
title:  "The Problem with 3-Ring(TRRS) Audiojacks"
date:   2022-02-25 10:00:00 +0100
---

![2022-02-25-The_Problem_with_3-Ring(TRRS)_Audiojacks](/assets/2022-02-25-The_Problem_with_3-Ring(TRRS)_Audiojacks.png)   
lesson learned: TRRS audio jacks come in 2 different flavors: OMTP + CTIA   

this topic is actually a bit dated ( 2021-04-27 ). i ran into problems when i first tested the KLST_TINY boards. it turns out that the TRRS ( tip-ring-ring-sleeve ) audio jack ( `HEADPHONE+MIC` aka headset ) comes in two different versions or standards:

| CONN   | OMTP   | CTIA   |
|--------|--------|--------|
| TIP    | LEFT   | LEFT   |
| RING#1 | RIGHT  | RIGHT  |
| RING#2 | MIC    | GND    |
| SLEEVE | GND    | MIC    |

the only difference between OMTP and CTIA ( or AHJ ) is the different arrangement of `MIC` + `GND`. unfortunately, i carelessly chose the less common ( in my universe )  OMTP standard for KLST_TINY but switched to CTIA in KLST_SHEEP. in summary, if a headset ( TRRS ) is used make sure that it has uses a standard that fits with the KSLT boards. alternatively there are also adapters that switch the arrangement.

a quick research showed that most international manufacturers use CTIA standards and it is often used by the following brands:

- Apple
- HTC
- LG
- Samsung
- Huawei
- and most android devices

for more information see the wikipedia article on [TRRS standards](https://en.wikipedia.org/wiki/Phone_connector_(audio\)#TRRS_standards).
