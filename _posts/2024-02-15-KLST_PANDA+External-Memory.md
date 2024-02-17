---
layout: post
title:  "KLST_PANDA + External Memory"
date:   2024-02-15 18:00:00 +0100
---

![KLST_PANDA--front-with-screen](/assets/2024-02-08-KLST_PANDA+External-Memory.jpg)

KLST_PANDA features a DRAM (PSRAM) *S70KL1282* 128MBit ( i.e 16MB ) memory connected via HyperRAM™ ( on `OCTOSPI1` ).

the `OCTOSPI` clock is configured to run at `300MHz` via `PLL2R`. the `ClockPrescaler` value is set to `2` which results in a memory IC frequency of `100MHz` ( `=300MHz/(ClockPrescaler+1)` ).

## Clock Configuration

`OCTOSPI` clock is configured to run at `300MHz` via `PLL2R`. the `ClockPrescaler` value is set to `2` which results in a frequency of `100MHz` ( `=300MHz/(ClockPrescaler+1)` ).

## `OCTOSPI` configuration

*S70KL1282* is connected via `OCTOSPI1` as HyperBus™ memory type in memory mapped mode. the address space for 16MB of memory in `OCTOSPI1` is `0x90000000–0x90FFFFFF`.

GPIO speed is set to `Very High`. `ICache` and `DCache` are enabled. 

### Generated Configuration Code and User-Added Code for `OCTOSPI1` in *Memory-Mapped Mode*

at `100MHz` Clock Speed one cycle has a duration of `10ns` ( `=1000*1000*1000/100000000Hz` )

```c
/**
 * @brief OCTOSPI1 Initialization Function
 * @param None
 * @retval None
 */
static void MX_OCTOSPI1_Init(void) {

    /* USER CODE BEGIN OCTOSPI1_Init 0 */

    /* USER CODE END OCTOSPI1_Init 0 */

    OSPIM_CfgTypeDef sOspiManagerCfg = { 0 };
    OSPI_HyperbusCfgTypeDef sHyperBusCfg = { 0 };

    /* USER CODE BEGIN OCTOSPI1_Init 1 */

    /* USER CODE END OCTOSPI1_Init 1 */
    /* OCTOSPI1 parameter configuration*/
    hospi1.Instance = OCTOSPI1;
    hospi1.Init.FifoThreshold = 4;
    hospi1.Init.DualQuad = HAL_OSPI_DUALQUAD_DISABLE;
    hospi1.Init.MemoryType = HAL_OSPI_MEMTYPE_HYPERBUS;
    hospi1.Init.DeviceSize = 24;
    hospi1.Init.ChipSelectHighTime = 2;
    hospi1.Init.FreeRunningClock = HAL_OSPI_FREERUNCLK_DISABLE;
    hospi1.Init.ClockMode = HAL_OSPI_CLOCK_MODE_0;
    hospi1.Init.WrapSize = HAL_OSPI_WRAP_NOT_SUPPORTED;
    hospi1.Init.ClockPrescaler = 2;
    hospi1.Init.SampleShifting = HAL_OSPI_SAMPLE_SHIFTING_NONE;
    hospi1.Init.DelayHoldQuarterCycle = HAL_OSPI_DHQC_ENABLE;
    hospi1.Init.ChipSelectBoundary = 0;
    hospi1.Init.DelayBlockBypass = HAL_OSPI_DELAY_BLOCK_USED;
    hospi1.Init.MaxTran = 23;
    hospi1.Init.Refresh = 799;
    if (HAL_OSPI_Init(&hospi1) != HAL_OK) {
        Error_Handler();
    }
    sOspiManagerCfg.ClkPort = 1;
    sOspiManagerCfg.DQSPort = 1;
    sOspiManagerCfg.NCSPort = 1;
    sOspiManagerCfg.IOLowPort = HAL_OSPIM_IOPORT_1_LOW;
    sOspiManagerCfg.IOHighPort = HAL_OSPIM_IOPORT_1_HIGH;
    if (HAL_OSPIM_Config(&hospi1,
                         &sOspiManagerCfg,
                         HAL_OSPI_TIMEOUT_DEFAULT_VALUE) != HAL_OK) {
        Error_Handler();
    }
    sHyperBusCfg.RWRecoveryTime = 4;
    sHyperBusCfg.AccessTime = 7;
    sHyperBusCfg.WriteZeroLatency = HAL_OSPI_LATENCY_ON_WRITE;
    sHyperBusCfg.LatencyMode = HAL_OSPI_FIXED_LATENCY;
    if (HAL_OSPI_HyperbusCfg(&hospi1,
                             &sHyperBusCfg,
                             HAL_OSPI_TIMEOUT_DEFAULT_VALUE) != HAL_OK) {
        Error_Handler();
    }
    /* USER CODE BEGIN OCTOSPI1_Init 2 */

    /* USER CODE END OCTOSPI1_Init 2 */

}
```

<!--
### *S70KL1282* timing characteristics 

from *S70KL1282* datasheet *10.5 AC characteristics* (p48ff) for timing specifications at 166MHz:

- HYPERRAMTM read-write recovery time (tRWR): `36ns` (min)
- Chip select HIGH between transactions: `6ns` (min)
- Refresh time: `36ns` (min)
- Maximum access time (tACC): `35ns` 

==Refresh rate: 667ticks * `6ns` equals approx `4μs` ( as proposed in AN5050 )==
-->

### Generated Configuration Code for `MPU`

`MPU` is configured as follows:

```c
/* MPU Configuration */

void MPU_Config(void) {
	MPU_Region_InitTypeDef MPU_InitStruct = { 0 };

	/* Disables the MPU */
	HAL_MPU_Disable();

	/** Initializes and configures the Region and the memory to be protected
	 */
	MPU_InitStruct.Enable = MPU_REGION_ENABLE;
	MPU_InitStruct.Number = MPU_REGION_NUMBER0;
	MPU_InitStruct.BaseAddress = KLST_DISPLAY_FRAMEBUFFER_ADDRESS;
	MPU_InitStruct.Size = MPU_REGION_SIZE_16MB;
	MPU_InitStruct.SubRegionDisable = 0x0;
	MPU_InitStruct.TypeExtField = MPU_TEX_LEVEL0;
	MPU_InitStruct.AccessPermission = MPU_REGION_FULL_ACCESS;
	MPU_InitStruct.DisableExec = MPU_INSTRUCTION_ACCESS_DISABLE;
	MPU_InitStruct.IsShareable = MPU_ACCESS_NOT_SHAREABLE;
	MPU_InitStruct.IsCacheable = MPU_ACCESS_CACHEABLE;
	MPU_InitStruct.IsBufferable = MPU_ACCESS_NOT_BUFFERABLE;

	HAL_MPU_ConfigRegion(&MPU_InitStruct);
	/* Enables the MPU */
	HAL_MPU_Enable(MPU_PRIVILEGED_DEFAULT);

}
```

## Performance Test

a *naive* performance test involving *reading* and *writing* the entire 16MB in three iterations:

```
@100MHz

writing 0s   : 305ms
writing byte : 396ms
reading byte : 555ms
errors       : 0
```

## References

- [Getting started with Octo-SPI and Hexadeca-SPI Interface on STM32 microcontrollers (AN5050)](https://www.st.com/content/ccc/resource/technical/document/application_note/group0/91/dd/af/52/e1/d3/48/8e/DM00407776/files/DM00407776.pdf/jcr:content/translations/en.DM00407776.pdf)
- [Infineon S70KL1282 DataSheet](https://www.infineon.com/dgdl/Infineon-S70KL1282_S70KS1282_3.0_V_1.8_V_128_Mb_(16_MB)_HYPERBUS_INTERFACE_HYPERRAM_(SELF-REFRESH_DRAM)-DataSheet-v02_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee9315b7210).
