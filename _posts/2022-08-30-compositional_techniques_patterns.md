---
layout: post
title:  "Compositional Techniques: Patterns"
date:   2022-08-30 10:00:00 +0100
---

`0, 1, 2, 3, 0, 1, 2, 3, 0, 1, 2, 3, 0, ...`    

the past days i have been looking into techniques for ( algorithmic ) compositions.

there is SOOOOooo... much stuff[^1][^2][^3] out there already. but apart from always enjoying to *reinvent the wheel*, in this endeavor i really want to put an emphasis on techniques that allow to create *articulate* compositions ( in contrast to techniques that rely mainly on controlling complexity and chaos … an interesting topic in itself ).

the first technique i am exploring is using loops and patterns ( not super happy about the term *patterns* in this context ). it is basically following the modulo `%` technique: a continuously increasing counter is modified by modulo to create a repeating pattern:

```
COUNTER   : 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
MODULO(4) : 0  1  2  3  0  1  2  3  0  1  2  3  0  1  2  3
```

if now tested again e.g `0` an *event* ( i.e test returns `true` ) occurs every 4 ticks or beats or counter increments. 

this very, very common technique is the basis for the `Loop` and `Pattern` classes ( for now only available in [Wellen](https://github.com/dennisppaul/wellen) ). 

`Loop` more or less implements exactly the modulo behavior without much extra features. `Pattern` adds the functionality to set *in points*, *out points*, *number of loops* and *relative tick* ( see `REL` ). both classes 

below is a series of examples of how `Pattern` can be used, first in *Human-Readable Format* (HRF) and then as output of a test program:

HRF: "the length of the loop is set to 3, the number of loop is set to 2. the in point is implicitly set to 0 ( default ). when starting to count at 0 two events occur at i=0 and i=3. after that no additional events occur because the number of loops is limited to 2."

```
set_length(3)
set_loop(2)

i=[0..11] > event(i, 0)

CNT   REL  EVT   LOP
--------------------
 0     0    +     0    
 1     1    -     0    
 2     2    -     0    
 3     0    +     1    
 4     1    -     1    
 5     2    -     1    
 6     0    -    -1    
 7     1    -    -1    
 8     2    -    -1    
 9     0    -    -1    
10     1    -    -1    
11     2    -    -1    
```

HRF: "the in point is set to 5 and the length of the loop is set to 3. the pattern loops infinitely. the event is tested against the ( relative ) tick value of 2. therefore the first event occur at i=7 and then every 3 ticks: i=10, i=13, ..."

```
set_in_point(5)
set_length(3)
set_loop(LOOP_INFINITE)

i=[0..19] > event(i, 2)

CNT   REL  EVT   LOP
--------------------
 0    -5    -    -1    
 1    -4    -    -1    
 2    -3    -    -1    
 3    -2    -    -1    
 4    -1    -    -1    
 5     0    -     0    
 6     1    -     0    
 7     2    +     0    
 8     0    -     1    
 9     1    -     1    
10     2    +     1    
11     0    -     2    
12     1    -     2    
13     2    +     2    
14     0    -     3    
15     1    -     3    
16     2    +     3    
17     0    -     4    
18     1    -     4    
19     2    +     4    
```

HRF: "the in point is set to 7, the out point is set to 9, and the pattern does not loop. therefore only events can occur between 7 and 9. since we test against 0 only one event occurs at i=7. note that the loop counter is always -1."

```
set_in_point(7)
set_out_point(9)
set_loop(NO_LOOP)

i=[0..19] > event(i, 0)

CNT   REL  EVT   LOP
--------------------
 0    -7    -    -1    
 1    -6    -    -1    
 2    -5    -    -1    
 3    -4    -    -1    
 4    -3    -    -1    
 5    -2    -    -1    
 6    -1    -    -1    
 7     0    +    -1    
 8     1    -    -1    
 9     2    -    -1    
10     3    -    -1    
11     4    -    -1    
12     5    -    -1    
13     6    -    -1    
14     7    -    -1    
15     8    -    -1    
16     9    -    -1    
17    10    -    -1    
18    11    -    -1    
19    12    -    -1    
```

HRF: "somewhat similar to the example above with the only difference that loop is set to 1. the only significant difference is that now the loop counter is 0 for the duration of the loop."

```
set_in_point(2)
set_out_point(4)
set_loop(1)

i=[0..11] > event(i, 0)

CNT   REL  EVT   LOP
--------------------
 0    -2    -    -1    
 1    -1    -    -1    
 2     0    +     0    
 3     1    -     0    
 4     2    -     0    
 5     0    -    -1    
 6     1    -    -1    
 7     2    -    -1    
 8     0    -    -1    
 9     1    -    -1    
10     2    -    -1    
11     0    -    -1    
```

HRF: "the in point is set to 2 and no out point is specified. therefore the only event, tested against 0, occurs at i=2. note, that if no out point is specified. the setting for loop becomes irrelevant."

```
set_in_point(2)
set_out_point(NO_OUTPOINT)

i=[0..7] > event(i, 0)

CNT   REL  EVT   LOP
--------------------
 0    -2    -    -1    
 1    -1    -    -1    
 2     0    +    -1    
 3     1    -    -1    
 4     2    -    -1    
 5     3    -    -1    
 6     4    -    -1    
 7     5    -    -1    
```

- `CNT` :: absolute tick or beat counter input
- `REL` :: relative tick or beat counter
- `EVT` :: result of event method: `+` true, event occurs + `-` false, no event
- `LOP` :: loop counter, returns `-1` when pattern is not in a loop.

#compositionaltechniques

[^1]: [Algorithmic symphonies from one line of code -- how and why?](http://countercomplex.blogspot.com/2011/10/algorithmic-symphonies-from-one-line-of.html)
[^2]: [algorithmic-symphonies](https://github.com/erlehmann/algorithmic-symphonies)
[^3]: [Total Serialism](https://github.com/tmhglnd/total-serialism)
