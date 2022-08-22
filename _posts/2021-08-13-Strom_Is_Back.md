---
layout: post
title:  "Strom Is Back"
date:   2021-08-13 10:00:00 +0100
---

![2021-08-13-Strom_Is_Back](/assets/2021-08-13-Strom_Is_Back.png)   
*Strom* the generative composition part of the *Klangstrom* project is back.

like *Klang* it also works with a mixture of node+text-based paradigms. it comes with a series nodes that produce signals/values and events.

events and data can be exchange between *Klang* and *Strom*.

however, *Strom* and *Klang* are not the same. while *Klang* is designed to produce audio signals at very fast rates ( e.g 48000 samples per second ), *Strom* is intended to produce *musical* data at more *human* rate ( e.g 120 beats per minute ).

*Strom* uses a *downstream* model ( i.e nodes *push* events and data down to child nodes ) in contrast to *Klang* which uses an *upstream* model ( i.e nodes request parent nodes to update audioblocks ).

*Klang* child nodes ( e.g `NodeDAC` ) requests signals ( in blocks ) from parent nodes ( e.g `NodeOscillator` ):

``` 
KLANG:

[ PARENT ]            [ CHILD  ]
+--------+            +--------+
| SIGNAL | << PULL << | SIGNAL |
+--------+            +--------+
```

*Strom* parent nodes ( e.g `StromNodeSine` ) push data to child nodes ( e.g `StromNodeNotes` ):

```
STROM:

[ PARENT ]            [ CHILD  ]
+--------+            +--------+
| DATA   | >> PUSH >> | DATA   |
+--------+            +--------+
```

i am currently considering if it is good to have two different models …