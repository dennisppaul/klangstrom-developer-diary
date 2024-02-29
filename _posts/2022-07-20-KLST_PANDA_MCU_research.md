---
layout: post
title:  "KLST_PANDA MCU research"
date:   2022-07-20 08:00:00 +0100
---

![2022-07-20-KLST_PANDA_MCU_research--pinout_sketch](/assets/2022-07-20-KLST_PANDA_MCU_research--pinout_sketch.png)   
finding the right MCU for KLST_PANDA is not a trivial exercise.

in short: the winner is **STM32H723ZGT**

long version: MCU Universe of Madness. ST’s STM32 MCU options are … a lot and the differences are sometimes very, very subtle. don’t get me wrong: everything is well designed and presented. however, it is a *very* iterative process to choose features. what i found is that it is absolutely crucial to use *STM32CubeIDE* to literally activate every single feature in an actual project in order to determine if a MCU is suitable. there are a lot of limitation that are not always immediately apparent e.g in my preferred MCU ( STM32H723ZGT, 144-pin ) it is impossible to use the TFT driver ( in `RGB88` mode ) in combination with a 2nd DAC channel or a second external memory controller.

i have looked into STM32H72x + STM32H73x MCUs only as they seem to meet most of the features we want to have in KLST_PANDA and are relatively cost efficient. i also wanted to use an MCU that is already available on a NUCLEO of DISCOVERY board from ST because i like to test the interaction of different modules ( SAI, USB, TFT) before i have the board manufactured.

i narrowed my research down to the STM32H7x5xGT + STM32H7x3ZGT branches of the familiy. all run at an amazing 550MHz and some come with a sizable internal FLASH and RAM memory. they also come with an *Octo-SPI* interface for external memory.

- STM32H7x5xGT ( see STM32H735G-DISCO, STM32H735IG ) 1M/564K, 550MHz "TFT-LCD, Ethernet, dual Octo-SPI with on-the-fly decryption, SMPS (for improved dynamic power efficiency)"
    - STM32H735IGT LQFP176[^1], $7.1034 pP10K
    - STM32H725IGT LQFP176[^1], $6.7170 pP10K ( s.o but without HW crypto/hash )
    - STM32H725ZGT LQFP144[^2], $6.9116 pP10K
    - STM32H735ZGT LQFP144[^2], $7.9079 pP10K ( s.o but without HW crypto/hash ) 
- STM32H7x3ZGT ( see NUCLEO-H723ZG ) 1M/564K, 550MHz "TFT-LCD, Ethernet, dual Octo-SPI with on-the-fly decryption"
    - STM32H733ZGT LQFP144[^2], $6.8457 pP10K
    - STM32H723ZGT LQFP144[^2], $6.4595 pP10K ( s.o but without HW crypto/hash ) 
- pin compatible with STM32H7x3ZGT
    - STM32H723ZET 564K/564K ( pin compatible with STM32H7x3ZGT, smaller flash memory )
    - STM32H730ZBT 128K/564K ( pin compatible with STM32H7x3ZGT, smaller flash memory )

[^1]: package dimensions 24×24×1.4mm
[^2]: package dimensions 20×20×1.4mm

i decided to go with **STM32H723ZGT**. it comes in a 144-pin, hand-solderable package. it is relatively affordable, has some pin compatible *relatives*. and is currently available in great numbers at JLCPCB.

below is a draft of a list of features that are possible to configure simultanously on a STM32H723ZGT MCU:

- 1× USB
- 1× TFT
- 1× SDCard ( 4-bit via `SDMMC1` )
- 1× external memory ( Octo-SPI/HyperRAM™ via `OCTOSPI1` )
- 1× SAI+I2C audiocodec ( via `SAI1` )
- 2× encoders ( via timers `TIM1` + `TIM2` )
- 3× UARTs ( via `USART2`, `USART3` + `UART8` )
- 1× I2C ( via `I2C1` )
- 2× SPI ( via `SPI2` + `SPI4` )
- 1× DAC
- 3× ADC
- 4× LEDs ( dimmable via one PWM timer `TIM4` on different channels )
- 2× buttons ( with interrupts via `TIM12` )
- 3× GPIO PWM ( via dedicated timers `TIM3` + `TIM23` + `TIM24` )
- 23× GPIO

the only tiny bit of disappointment is that the MCU ( and the entire MCU branch ) only features a single USB controller. 

during my research i found out that an LQFP100 version is not enough to host audio codec, memory, SDcard, TFT display + single USB interface at the same time ( e.g STM32H725VG ). whereas a LQFP176 would have too many unused pins and would potentially require too much PCB surface area.