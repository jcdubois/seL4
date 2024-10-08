/*
 * Copyright 2024, Jean-Christophe Dubois <jcd@tribudubois.net>
 *
 * SPDX-License-Identifier: GPL-2.0-only
 */

#include <config.h>
#include <stdint.h>
#include <util.h>
#include <machine/io.h>
#include <plat/machine/devices_gen.h>

#define THR        0x0
#define RHR        0x0
#define LSR        0x5

#define LSR_THRE   BIT(5)
#define LSR_RDR    BIT(0)

#define UART_REG(x) ((volatile uint8_t *)(UART_PPTR + (x)))

#ifdef CONFIG_PRINTING
void uart_drv_putchar(unsigned char c)
{
    while ((*UART_REG(LSR) & LSR_THRE) == 0);
    *UART_REG(THR) = c;
}
#endif /* CONFIG_PRINTING */

#ifdef CONFIG_DEBUG_BUILD
unsigned char uart_drv_getchar(void)
{
    while ((*UART_REG(LSR) & LSR_RDR) == 0);
    return *UART_REG(RHR);
}
#endif /* CONFIG_DEBUG_BUILD */
