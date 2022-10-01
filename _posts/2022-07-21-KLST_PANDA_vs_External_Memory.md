---
layout: post
title:  "KLST_PANDA vs External Memory"
date:   2022-07-21 08:00:00 +0100
---

adding external memory to KLST_PANDA design … it s complicated

as it turns out there a more than one way to add external memory into a system. i have narrowed down my research to *Octo-SPI* and *Flexible Memory Controller* (FMC) interfaces.

FMC looks more like the *traditional* way of connecting external memory ICs. it is a more or less a parallel connecting of the memory IC to the MCU including all advantages and disadvantages of parallel connections: high speeds but also high number of pins. in contrast the *Octo-SPI* interface seems to be a bit more exclusive ( and in it s special variant HyperRAM™ even proprietary ). also the number of available memory ICs that implement *Octo-SPI* appears to be much lower than for FMC.

however, despite the potential better performance and the greater choice of memory ICs, i decided to opt for the HyperRAM™ way. the main reason being the lower demands in hardware resources. a few notes from my reseach and thinking process:

## notes (20220714)

*STM32H735G-DK* uses two kinds of memory: *FLASH* and *RAM* both memories are interfaced via *Octo-SPI* and *HyperRAM™* interfaces. note that *STM32H743I-EVAL* and *STM32H753I-EVAL* implements *SDRAM* memory via *FMC* interface.

for KLST audio applications FLASH memory is not suitable. therefore only the RAM version can be considered. however, suppliers are very short on memory ICs ( @JLCPCB there is literally no *DRAM* in stock ).

however, there are a few SDRAM chips in stock. however, however the FMC interface needs many more resources ( in case of *STM32H743I-EVAL* it requires 55 pins )! therefore i would stick with *HyperRAM™* for now. PS ( DaisySeed seems to be using *AS4C16M16SA* SDRAM chip … which is currently available at JLCPCB ).

## notes (20220716)

when the smoke has cleared i am left with an external RAM memory extension connected to an *Octo-SPI/HyperRAM™* interface. some of the things i learned so far are:

- connect external memory via Octo-SPI interface
- STM32H73x MCU have 2 Octo-SPI interface but only one is available ( due to other peripherals )
- try to use the IC specified by ST i.e `S70KL1281DABHI023` ( 128Mb(=16MB), 3V3 ). there are quite a few subtle differences.
- Octo-SPI RAM can be memory mapped and used ( almost ) like internal RAM ( e.g `Octo-SPI1` > `0x90000000`–`0x9FFFFFFF` i.e `0xFFFFFFF*4 = 1073741820bytes ≈ 1GB address space` )
- look into *Master Direct Aemory Access controller* (MDMA) + *Memory Protection Unit* (MPU)
- Octo-SPI RAM can be used as frame buffer for LCDisplays
- 16MB ( or 128Mb ) equal approx 90sec of audio data ( 32f ): `(128Mb*1024*1024/8bits)/(48000Hz*1Channel*4bytes) ≈ 87,4sec`
- LCD framebuffer (RGB888) would require 225KB: `320*240*3/1024/1024 = 225KB ≈ 0.22MB`
- read *Octo-SPI interface on STM32 microcontrollers (AN5050)* + *STM32H72x, … system architecture and performance (AN4891)*

it is soooo important to test on *STM32H735G-DK* first. especially the combination of LCD and sound is crucial to be tested. also make sure to look into existing examples.

### S70KL1281DABHI023 ordering part number deciphered 

( see datasheet, p44 )

- S70KL :: Device Family == 3.0V ( *`KS` is for 1V8* )
- 128   :: Density == 128MB
- 1     :: Device Technology == 63nm
- DA    :: Speed == 100 MHz
- B     :: Package Type == 24-ball FBGA, 1.00 mm pitch
- H     :: Package Materials == Low-Halogen, Lead (Pb)-free
- I     :: Temperature Range == Industrial ( –40°C to +85°C )
- 02    :: Model Number == Standard 6×8×1.0 mm package ( VAA024 )
- 3     :: Packing Type == Tape and Reel

## references

- [STM32H72x, STM32H73x, and single-core STM32H74x/75x system architecture and performance (AN4891)](https://www.st.com/resource/en/application_note/an4891-stm32h72x-stm32h73x-and-singlecore-stm32h74x75x-system-architecture-and-performance-stmicroelectronics.pdf)
- [Octo-SPI interface on STM32 microcontrollers (AN5050)](https://www.st.com/content/ccc/resource/technical/document/application_note/group0/91/dd/af/52/e1/d3/48/8e/DM00407776/files/DM00407776.pdf/jcr:content/translations/en.DM00407776.pdf)

## orthographical persepctive 

what is the correct way of writing *Octo-SPI* anyway?

- Octo-SPI
- Octo SPI
- OctoSPI
- Octo-Spi
- OCTOSPI
- OCTO-SPI

from what i am seeing in written documents in text `Octo-SPI` is the most common version and `OCTOSPI` is often used when to reference the actual hardware component.
