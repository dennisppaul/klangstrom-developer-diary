---
layout: post
title:  "KLST_PANDA External Memory"
date:   2024-02-08 18:00:00 +0100
---

![KLST_PANDA--front-with-screen](/assets/2024-02-08-KLST_PANDA+External-Memory.jpg)

i am following [Getting started with Octo-SPI and Hexadeca-SPI Interface on STM32 microcontrollers (AN5050)](https://www.st.com/content/ccc/resource/technical/document/application_note/group0/91/dd/af/52/e1/d3/48/8e/DM00407776/files/DM00407776.pdf/jcr:content/translations/en.DM00407776.pdf) + [Infineon S70KL1282 DataSheet](https://www.infineon.com/dgdl/Infineon-S70KL1282_S70KS1282_3.0_V_1.8_V_128_Mb_(16_MB)_HYPERBUS_INTERFACE_HYPERRAM_(SELF-REFRESH_DRAM)-DataSheet-v02_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee9315b7210) for setting up *S70KL1282* external memory via OCTOSPI.

## Enabling interrupts

`OCTOSPI global interrupt` is enabled in `NVIC Settings`.

## Clock configuration

*S70KL1282* is connected via `OCTOSPI1`.

OCTOSPI clock is configured to run at 328MHz via `PLL2R`. the minimum `ClockPrescaler` value is `1` which results in a maximum frequency for interfacing with *S70KL1282* is 164MHz ( OCTOSPI ). this is close enough to 166MHz which is one of the suggested frequencies in the datasheet.

BTW at 164MHz one tick has a duration of approx 6ns.

### *S70KL1282* timing characteristics 

from *S70KL1282* datasheet *10.5 AC characteristics* (p48ff) for timing specifications at 166MHz:

- HYPERRAMTM read-write recovery time (tRWR): `36ns` (min)
- Chip select HIGH between transactions: `6ns` (min)
- Refresh time: `36ns` (min)
- Maximum access time (tACC): `35ns` 

==Refresh rate: 667ticks * 6ns equals approx 4μs ( as proposed in AN5050 )==

### 5.3 OCTOSPI/HSPI configuration for HyperBus protocol ( from AN5050 )

The HyperBus protocol must be used when an external HyperRAM or HyperFlash memory is connected to the STM32.

The user must configure the following parameters:

- [x] memory type: HyperBus
- [x] device size: number of bytes in the device = 2[DEVSIZE+1] ==Device Size: 24==
- [ ] chip-select high time (CSHT): must be configured according to the memory datasheet. CSHT is commonly named CS# Deselect Time and represents the period between two successive operations in which the memory is deselected.
- [x] clock mode low (Mode 0) or high (Mode 3) ==Clock Mode: Low==
- [x] clock prescaler: must be set to get the targeted operating clock
- [ ] DTR mode: must be enabled for HyperBus
- [ ] DHQC: recommended when writing to the memory. It shifts the outputs by a 1/4 OCTOSPI/HSPI clock cycle and avoids hold issues on the memory side.
- [ ] SSHIFT: must be disabled since HyperBus operates in DTR mode read-write recovery time (tRWR): used only for HyperRAM and must be configured according to the memory device
- [ ] initial latency (tACC): must be configured according to the memory device and the operating frequency ==Access Time: 6==
- [ ] latency mode: fixed or variable latency
- [ ] latency on write access: enabled or disabled
- [ ] for HyperBus 16-bit mode, it is required to configure the DMODE[2:0] field
- [ ] CSBOUND: can be used to limit a transaction of aligned addresses in order to respect some memory page boundary crossing
- [ ] REFRESH: used with HyperRAM memories to enable the refresh mechanism

## generated configuration code + user added code for *memory-mapped mode configuration*

```
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
	if (HAL_OSPIM_Config(&hospi1, &sOspiManagerCfg, HAL_OSPI_TIMEOUT_DEFAULT_VALUE) != HAL_OK) {
		Error_Handler();
	}
	sHyperBusCfg.RWRecoveryTime = 4;
	sHyperBusCfg.AccessTime = 7;
	sHyperBusCfg.WriteZeroLatency = HAL_OSPI_LATENCY_ON_WRITE;
	sHyperBusCfg.LatencyMode = HAL_OSPI_FIXED_LATENCY;
	if (HAL_OSPI_HyperbusCfg(&hospi1, &sHyperBusCfg, HAL_OSPI_TIMEOUT_DEFAULT_VALUE) != HAL_OK) {
		Error_Handler();
	}
	/* USER CODE BEGIN OCTOSPI1_Init 2 */
	OSPI_HyperbusCmdTypeDef sCommand;
	OSPI_MemoryMappedTypeDef sMemMappedCfg;

	/* Memory-mapped mode configuration --------------------------------------- */
	sCommand.AddressSpace = HAL_OSPI_MEMORY_ADDRESS_SPACE;
	sCommand.AddressSize = HAL_OSPI_ADDRESS_32_BITS;
	sCommand.DQSMode = HAL_OSPI_DQS_ENABLE;
	sCommand.Address = 0;
	sCommand.NbData = 1;

	if (HAL_OSPI_HyperbusCmd(&hospi1, &sCommand,
	HAL_OSPI_TIMEOUT_DEFAULT_VALUE) != HAL_OK) {
		Error_Handler();
	}

	sMemMappedCfg.TimeOutActivation = HAL_OSPI_TIMEOUT_COUNTER_DISABLE;

	if (HAL_OSPI_MemoryMapped(&hospi1, &sMemMappedCfg) != HAL_OK) {
		Error_Handler();
	}
	/* USER CODE END OCTOSPI1_Init 2 */

}
```
