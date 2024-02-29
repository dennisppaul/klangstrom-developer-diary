---
layout: post
title:  "KLST_PANDA + Audio Codec"
date:   2024-02-29 10:00:00 +0100
---

![KLST_PANDA+AudioCodec-WM8904-WM8731](/assets/2024-02-29-KLST_PANDA+AudioCodec-WM8904-WM8731.jpg) wow, this was a *tour de force*.

i was REALLY struggling with the new audio codec! i had moved on from `WM8731`[^1] to `WM8904` because `WM8731` was [discontinued by Cirrus Logic](https://www.cirrus.com/products/wm8731/). and as so often in this world, the new audio codec is 1.000.000× more complex.

but to start at the end: `WM8904` is now interfaced via `I2C4` for configuration and `SAI1` for audio data transfer. it is configured with the internal Frequency Locked Loop ( `FLL` ) but not the default startup sequence. STM32H7 `SAI1` clock is set to `12.5MHz` and adjusted to `12.288MHz` via `FLL`.

one of my main problems was that of configuring the audio codec’s internal system clock. it took quite a bit of datasheet[^2] ( and forum ) digging to understand how to set it up. as far as i understood, some audio codec properties ( e.g `FLL` which makes sense ) can be configured without a proper internal system clock, while other require a properly configured clock.

## Calculating FLL values

The FLL operating frequency, FVCO is set according to the following equation:

```
FVCO = (FREF x N.K x FLL_FRATIO) ( "FVCO must be in the range 90-100 MHz" )

FREF = 12500000Hz
FLL_FRATIO = 1MHz - 13.5MHz = 0h (divide by 1) = 0
```

The FLL output frequency is generated according to the following equation:

```
FOUT = (FVCO / FLL_OUTDIV)
FLL_OUTDIV = 11.25 MHz - 12.5 MHz = 000111 (divide by 8) = 7

FVCO = (FOUT x FLL_OUTDIV) = 12288000 8 = 98304000Hz
N.K  = FVCO / (FLL_FRATIO x FREF) = 98304000Hz / ( 1 12500000Hz ) = 7.86432
K    = 0.86432 * 65536 = 56644.07552 = 56644
N    = 7
```

see chapter "FREQUENCY LOCKED LOOP (FLL)" ( WM8904 datasheet[^3], p104ff )

## Starting Up WM8904

```
void setup_FLL() {
    //                                               FLL Disable
    WM8904_write_register(WM8904_R116_FLL_CONTROL_1, 0x0000);
    //                                               FLL FOUT clock divider: 7=divide by 8
    //                                               FVCO clock divider:     0=divide by 1 TODO(not sure about this `4`)
    WM8904_write_register(WM8904_R117_FLL_CONTROL_2, WM8904_FLL_OUTDIV(7) | WM8904_FLL_FRATIO(0));
    //                                               Fractional multiply for FREF
    WM8904_write_register(WM8904_R118_FLL_CONTROL_3, WM8904_FLL_K(56644));
    //                                               Integer multiply for FREF
    WM8904_write_register(WM8904_R119_FLL_CONTROL_4, WM8904_FLL_N(7));
    //                                               FLL Clock source: 0 = MCLK
    //                                               Frequency of the FLL: 0 = FVCO / 1
    //                                               FLL Clock Reference Divider: 0 = MCLK / 1 "... bring the reference down to 13.5MHz or below."
    WM8904_write_register(WM8904_R120_FLL_CONTROL_5, WM8904_FLL_CLK_REF_SRC(0) | WM8904_FLL_CTRL_RATE(0) | WM8904_FLL_CLK_REF_DIV(0));
    //                                               FLL Fractional enable
    //                                               FLL Enable
    WM8904_write_register(WM8904_R116_FLL_CONTROL_1, WM8904_FLL_FRACN_ENA | WM8904_FLL_ENA);
    delay_ms(5);
}

void setup_peripherals() {
    /* --- POWER ---------------------------------------------------------------------------------------------------- */
    WM8904_write_register(WM8904_BIAS_CONTROL_0, WM8904_ISEL_HP_BIAS);
    WM8904_write_register(WM8904_VMID_CONTROL_0, WM8904_VMID_BUF_ENA | WM8904_VMID_RES_FAST | WM8904_VMID_ENA);
    delay_ms(5);
    WM8904_write_register(WM8904_VMID_CONTROL_0, WM8904_VMID_BUF_ENA | WM8904_VMID_RES_NORMAL | WM8904_VMID_ENA);
    WM8904_write_register(WM8904_BIAS_CONTROL_0, WM8904_ISEL_HP_BIAS | WM8904_BIAS_ENA);
    WM8904_write_register(WM8904_POWER_MANAGEMENT_0, WM8904_INL_ENA | WM8904_INR_ENA);
    WM8904_write_register(WM8904_POWER_MANAGEMENT_2, WM8904_HPL_PGA_ENA | WM8904_HPR_PGA_ENA);
    WM8904_write_register(WM8904_DAC_DIGITAL_1, WM8904_DEEMPH(0));
    WM8904_write_register(WM8904_ANALOGUE_OUT12_ZC, 0x0000);
    WM8904_write_register(WM8904_CHARGE_PUMP_0, WM8904_CP_ENA);
    WM8904_write_register(WM8904_CLASS_W_0, WM8904_CP_DYN_PWR);

    /* --- AUDIO_INTERFACE ------------------------------------------------------------------------------------------ */
    WM8904_write_register(WM8904_R25_AUDIO_INTERFACE_1, WM8904_AIF_WL_16BIT | WM8904_AIF_FMT_I2S);
    WM8904_write_register(WM8904_R26_AUDIO_INTERFACE_2, 0);
    WM8904_write_register(WM8904_R27_AUDIO_INTERFACE_3, 0);
    WM8904_write_register(WM8904_R18_WM8904_POWER_MANAGEMENT_6, WM8904_DACL_ENA | WM8904_DACR_ENA | WM8904_ADCL_ENA | WM8904_ADCR_ENA);
    delay_ms(5);

    /* --- INPUT_OUTPUT --------------------------------------------------------------------------------------------- */
    WM8904_write_register(WM8904_ANALOGUE_LEFT_INPUT_0, WM8904_LIN_VOL(0x10));
    WM8904_write_register(WM8904_ANALOGUE_RIGHT_INPUT_0, WM8904_RIN_VOL(0x10));
    WM8904_write_register(WM8904_ANALOGUE_HP_0, WM8904_HPL_ENA | WM8904_HPR_ENA);
    WM8904_write_register(WM8904_ANALOGUE_HP_0, WM8904_HPL_ENA_DLY | WM8904_HPL_ENA | WM8904_HPR_ENA_DLY | WM8904_HPR_ENA);
    WM8904_write_register(WM8904_DC_SERVO_0, WM8904_DCS_ENA_CHAN_3 | WM8904_DCS_ENA_CHAN_2 | WM8904_DCS_ENA_CHAN_1 | WM8904_DCS_ENA_CHAN_0);
    WM8904_write_register(WM8904_DC_SERVO_1,
    WM8904_DCS_TRIG_STARTUP_3 | WM8904_DCS_TRIG_STARTUP_2 | WM8904_DCS_TRIG_STARTUP_1 | WM8904_DCS_TRIG_STARTUP_0);
    delay_ms(100);

    /* --- HEADPHONES ----------------------------------------------------------------------------------------------- */
    WM8904_write_register(WM8904_R90_WM8904_ANALOGUE_HP_0,
    WM8904_HPL_ENA_OUTP | WM8904_HPL_ENA_DLY | WM8904_HPL_ENA | WM8904_HPR_ENA_OUTP | WM8904_HPR_ENA_DLY | WM8904_HPR_ENA);
    WM8904_write_register(WM8904_ANALOGUE_OUT1_LEFT, WM8904_HPOUT_VU | WM8904_HPOUTL_VOL(0x39));
    WM8904_write_register(WM8904_ANALOGUE_OUT1_RIGHT, WM8904_HPOUT_VU | WM8904_HPOUTR_VOL(0x39));
    delay_ms(100);
}
void setup_SCLK_FLL() {
    //                                              select SYSCLK / fs ratio = 12288000Hz/48000Hz = 256 = 0b0011 = 3
    //                                              select Sample Rate (fs) = 44.1kHz, 48kHz = 0b101 = 5
    WM8904_write_register(WM8904_R21_CLOCK_RATES_1, WM8904_CLK_SYS_RATE(3) | WM8904_SAMPLE_RATE(5));
    //                                              0 = SYSCLK = MCLK
    WM8904_write_register(WM8904_R20_CLOCK_RATES_0, 0x0000);
    //                                              SYSCLK Source Select to FLL output
    //                                              System Clock enable
    //                                              DSP Clock enable
    WM8904_write_register(WM8904_R22_CLOCK_RATES_2, WM8904_SYSCLK_SRC | WM8904_CLK_SYS_ENA | WM8904_CLK_DSP_ENA);
}

void setup_WM8904() {
    setup_FLL();
    delay_ms(50);
    setup_peripherals();
    delay_ms(50);
    setup_SCLK_FLL();
}
```

## DMA vs DCache … again!

and once again DMA handling is a bit tricky on STM32H7. although i am getting the hand of it. in a nutshell: memory that’s used in conjunction with DMA needs to be configured as *non-cacheable* in the MPU ( if `DCache` ( data cache ) is enabled, which it should ).

## A Toxic Mixture of Ignorance and Arrogance

i will write about this in depth at some point but until then i can only say that i am really angry at myself for being this stupid and ignorant despite my better knowledge. i intentionally did not add any test points or other hardware debugging options to the board. i had to pay with this with hours and hours of headache not knowing where the problem was. lesson learned … again.

[^1]: used in KLST_SHEEP
[^2]: internal question: is it actually ok to write *datasheet* in one word or is it *data sheet*. internet predicts it will be *datasheet* in the future all the way. *datasheet* is future proof then, nice. *audiocodec* however seems to be not acceptable … schade.
[^3]: [WM8904 Datasheet](https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf)