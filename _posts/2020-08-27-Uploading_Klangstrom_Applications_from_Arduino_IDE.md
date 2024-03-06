---
layout: post
title:  "Uploading Klangstrom Applications from Arduino IDE"
date:   2020-08-27 09:39:00 +0100
---

uploading klangstrom sketches to STM32H7 MCU via Arduino IDE.

success! i finally managed to find a way to upload sketches from arduino to the *klangstrom board*: DfuSe ( USB Device Firmware Upgrade ) is the word.

now i only need to find as way to jump to the bootloader from the application … and i found it:

## jump to bootloader from application

```c
void JumpToBootloader(void)
{
  uint32_t i=0;
  void (*SysMemBootJump)(void);
 
  /* Set the address of the entry point to bootloader */
     volatile uint32_t BootAddr = 0x1FF09800;
 
  /* Disable all interrupts */
     __disable_irq();

  /* Disable Systick timer */
     SysTick->CTRL = 0;
     
  /* Set the clock to the default state */
     HAL_RCC_DeInit();

  /* Clear Interrupt Enable Register & Interrupt Pending Register */
     for (i=0;i<5;i++)
     {
      NVIC->ICER[i]=0xFFFFFFFF;
      NVIC->ICPR[i]=0xFFFFFFFF;
     }	
     
  /* Re-enable all interrupts */
     __enable_irq();
    
  /* Set up the jump to booloader address + 4 */
     SysMemBootJump = (void (*)(void)) (*((uint32_t *) ((BootAddr + 4))));
 
  /* Set the main stack pointer to the bootloader stack */
     __set_MSP(*(uint32_t *)BootAddr);
 
  /* Call the function to jump to bootloader location */
     SysMemBootJump(); 
  
  /* Jump is done successfully */
     while (1)
     {
      /* Code should never reach this loop */
     }
}
```

from [Jump to Bootloader from application on STM32H7 devices](https://community.st.com/s/article/STM32H7-bootloader-jump-from-application)

and this might also help: [stm32h743-how-to-start-the-system-boot-loader-via-software](https://community.st.com/s/question/0D50X00009XkW8QSAV/stm32h743-how-to-start-the-system-boot-loader-via-software)

## DfuSe for STM32H743ZI

today i have a new plan and 4 hours at my hands: i want to test out the *DfuSe* integrated into some STM32 devices.

- [Getting started with STM32 built-in USB DFU Bootloader](https://www.youtube.com/watch?v=Kx7yWVi8kbU)
- [AN3156--USB DFU protocol used in the STM32 bootloader](https://www.st.com/resource/en/application_note/cd00264379-usb-dfu-protocol-used-in-the-stm32-bootloader-stmicroelectronics.pdf)
- [AN2606--STM32 microcontroller system memory boot mode](https://www.st.com/resource/en/application_note/cd00167594-stm32-microcontroller-system-memory-boot-mode-stmicroelectronics.pdf)

### start device in DfuSe mode 

- connect the `BOOT0` pin to VDD ( i.e  )
- reset device
- device now starts in DFU mode e.g device identifies as `STMicroelectronics DFU in FS Mode  Serial: 200364500000` with `lsusb`

### flash with `dfu-util`

- install `dfu-util` with homebrew i.e `brew install dfu-util`
- [dfu-util - Device Firmware Upgrade Utilities](http://dfu-util.sourceforge.net)
- generate `.bin` file ( e.g in Arduino IDE or STM32CubeIDE )
- flash `.bin` onto device ( a.k.a `download` ) e.g `dfu-util -a 0 -s 0x08000000:leave -D Blink.ino.bin`
- ***it turns out it is not necessary ( or does not even work ) to convert  to `.dfu` first ***

## compile arduino sketch with generic serial support

make the following selections:

- `Board: "Klangstrom (STM32)"`
- `U(S)ART support: Enable (generic 'Serial')`
- `USB support (if available): "CDC (generic 'Serial' supersede U(S)ART)"`
