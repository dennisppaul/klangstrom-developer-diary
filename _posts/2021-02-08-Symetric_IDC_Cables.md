---
layout: post
title:  "Symetric IDC Cables"
date:   2021-02-08 10:39:00 +0100
---

![Symetric_IDC_Cables](/assets/2021-02-08-Symetric_IDC_Cables.png)
a proposal for a type of connection that allows server-client + client-client connections.

the connectors are designed in a way that the pin functions are arranged symetrically. the benefit of this approach is that one does not need to worry about interfaces if a connection requires a *crossed* ( e.g SPI, I2C ) cable or a direct connection ( e.g UART/serial ).

![Why so Complicated](/assets/2021-02-08-Symetric_IDC_Cables-why_so_complicated.png)

@note(2022-02-22, the principle only works if pins are arranged on a single row. the implementation on KLST_CORE + KLST_TINY is flawed because it uses 2 row connectors)
