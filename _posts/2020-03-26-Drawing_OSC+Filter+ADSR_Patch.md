---
layout: post
title:  "Drawing OSC+Filter+ADSR Patch"
date:   2020-03-26 08:29:00 +0100
---

![drawing_osc-filter-adsr_patch](/assets/2020-03-26-drawing_osc-filter-adsr_patch.png)   
*source code* and ASCII schematic generated with klangstrom drawing tool.

today i finished a first version of a drawing tool that can be used to draw klangstrom patches ( in ASCII style ) and then export them as source code and as ASCII schematics.

![ascii-patch-drawing--app](/assets/2020-03-03-ascii-patch-drawing--app.gif)

schematic output of the example above:

```
              [ NODE_WAVETABLE ]                                                                                
              +----------------+                                                                                
              |                |                                                                                
        IN00--| FREQ    SIGNAL |--OUT00 >--+                                                                    
        IN01--| AMP            |           |                                                                    
              |                |           |                                                                    
              +----------------+           |                                                                    
                                           |          [ NODE_WAVETABLE ]                                        
          [ NODE_ADSR       ]              |          +----------------+                                        
          +-----------------+              |          |                |                                        
          |                 |              +--> IN00--| FREQ    SIGNAL |--OUT00                                 
    IN00--| SIGNAL   SIGNAL |--OUT00 >---+----> IN01--| AMP            |                                        
          |                 |                         |                |                                        
          +-----------------+                         +----------------+                                        
```