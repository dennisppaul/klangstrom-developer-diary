---
layout: post
title:  "Klangstrom VCV Rack Plugin"
date:   2020-09-21 10:00:00 +0100
---

![KLST--introducing_klang_vcvrack_plugin](/assets/2020-09-21-introducing_klang_vcvrack_plugin.png) running klangstrom applications in a dedicated Klangstrom VCV Rack Plugin and changing them at runtime.

today i was looking into integrating klangstrom into VCV rack. i was interested in finding a way to circumvent the complicated VCV-rack plugin build system. i came up with the idea to create and build a basic plugin structure that would call `setup` and `audioblock` functions in a *dynamic library* ( aka `.dylib` or `.so` ) and then only replace the *dynamic library*.

the approach works fine and i was even able to make it work from within the arduino enviroment. which i think is pretty, pretty cool. this now allows to develop a *klangstrom* sketch in the arduino IDE and then decide to either run it in a desktop environment, as a VCV Rack modul, or on a dedicated *klangstrom* board ( e.g KLST_CORE ).