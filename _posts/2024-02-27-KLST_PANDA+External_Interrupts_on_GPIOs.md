---
layout: post
title:  "KLST_PANDA + External Interrupts on GPIOs"
date:   2024-02-27 10:00:00 +0100
---

a bit embarrassing to be THIS late to the game. but i only just recently realized how nice the feature for external interrupts on GPIO pins is. the controller is referred to as `EXTI` ( EXTernal Interrupt ).

in a nutshell, STM32H7[^1] GPIO pins can generate interrupts ( e.g when a button is pressed ). STM32H7 has 16 independent interrupt lines that are assigned to ( all?[^2] ) GPIO pins and correlate with their ID ( e.g `PG5` is on line 5 or `GPIO_EXTI5` ). interrupts can be generated on *rising* ( i.e from `LOW` to `HIGH` ), *falling* ( i.e from `HIGH` to `LOW` ) or on both edges.

a quick round up shows that the following KLST_PANDA GPIO pins are usable for peripheral or application purposes: 

```
| PIN  | INTERRUPT   | FUNCTION                 |
|------|-------------|--------------------------|
|      | GPIO_EXTI0  | GPIO_03                  |         
|      | GPIO_EXTI1  | GPIO_02                  |         
|      | GPIO_EXTI2  | GPIO_01 + 16             |         
|      | GPIO_EXTI3  | GPIO_00 + 15             |         
|      | GPIO_EXTI4  | GPIO_07 + 11 + 12 + 14   |         
| PG5  | GPIO_EXTI5  | _ENCODER_00_BUTTON       | 
|      | GPIO_EXTI6  |                          |         
|      | GPIO_EXTI7  |                          |         
|      | GPIO_EXTI8  |                          |         
|      | GPIO_EXTI9  |                          |         
|      | GPIO_EXTI10 |                          |         
| PB11 | GPIO_EXTI11 | _ENCODER_01_BUTTON       | 
|      | GPIO_EXTI12 |                          |         
| PD13 | GPIO_EXTI13 | _DISPLAY_TOUCH_INTERRUPT |
| PD14 | GPIO_EXTI14 | _MECH_BUTTON_00          |
| PD15 | GPIO_EXTI15 | _MECH_BUTTON_01          | 
```

once a GPIO pin is configured as `GPIO_EXTI` and the interrupt is enabled ( in this case on *falling* and *rising* edges ) the callback `HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)` is called in case of an external event ( i.e button pressed or released ). note that the callback only supplies the pin ID not the port. they share the same interrupt line. i.e pins with similar IDs but different ports can not be distinguished[^3]. an example implementation for a button could look like this:

```
#define _MECH_BUTTON_00_Pin GPIO_PIN_14
#define _MECH_BUTTON_00_GPIO_Port GPIOD
bool MECH_00_state = false;

void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin) {
    if (GPIO_Pin == _MECH_BUTTON_00_Pin) {
        MECH_00_state = !HAL_GPIO_ReadPin(_MECH_BUTTON_00_GPIO_Port, 
                                          _MECH_BUTTON_00_Pin);
        // trigger application pressed or released callback
    }
}
```

the GPIO state is read to determine whether this is a *pressed* or *released*.

[^1]: i have not done any research and therefore am not sure how the situation on other STM32 MCUs is.
[^2]: again, have not done any research but it seems as if almost all GPIO pins can generate an interrupt.
[^3]: this can be addressed by reading and caching GPIO states but surely requires some extra effort.