---
layout: post
title:  "KLST_PANDA + SD Card"
date:   2024-03-02 10:00:00 +0100
---



---

## FatFS with DMA

see [FatFS + DMA](https://yairgadelov.me/setup-sdcard-on-stm32-mcu/)

In the file, sd_diskio.c, enable the following definition:

```
#define ENABLE_SD_DMA_CACHE_MAINTENANCE  1 
#define ENABLE_SCRATCH_BUFFER 
```

Note that sd_diskio.c, s given by the CubeMX, which is specific for each architecture. This particular version for the STM32H743 supports the cache memory operation, and the definition above will enable it.

I changed the win element in the struct FATFS to be a pointer to char array. In addition, accoring to cache memory requirements, the char array is allocated to be 32 bytes aligned.

```
static BYTE buffer[1024] __attribute__ ((aligned (32))); 
```

I took a space of 512 to be on the safe side that invalidates cache operation won’t harm another data outside that array. To set the array in the new FATFS struct type:

```
FATFS fs
fs.win = buffer
```
