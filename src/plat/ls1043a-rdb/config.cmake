#
# Copyright 2020, Data61, CSIRO (ABN 41 687 119 230)
# Copyright 2022, Capgemini Engineering
#
# SPDX-License-Identifier: GPL-2.0-only
#

cmake_minimum_required(VERSION 3.7.2)

declare_platform(ls1043a-rdb KernelPlatformls1043a-rdb PLAT_LS1043A KernelArchARM)

if(KernelPlatformls1043a-rdb)
    declare_seL4_arch(aarch64 aarch32)
    config_set(KernelPlatLs1043a PLAT_LS1043A ON)
    set(LS1043A_MAX_IRQ 256 CACHE INTERNAL "")
    set(KernelArmCortexA53 ON)
    set(KernelArchArmV8a ON)
    set(KernelArmGicV2 ON)
    config_set(KernelARMPlatform ARM_PLAT ${KernelPlatform})
    set(KernelArmMach "ls1043a-rdb" CACHE INTERNAL "")
    list(APPEND KernelDTSList "tools/dts/${KernelPlatform}.dts")
    list(APPEND KernelDTSList "src/plat/ls1043a-rdb/overlay-${KernelPlatform}.dts")
    if(KernelSel4ArchAarch32)
        list(APPEND KernelDTSList "src/plat/ls1043a-rdb/overlay-ls1043a-32bit.dts")
    endif()
    declare_default_headers(
        TIMER_FREQUENCY 8000000
        MAX_IRQ ${LS1043A_MAX_IRQ}
        TIMER drivers/timer/arm_generic.h
        INTERRUPT_CONTROLLER arch/machine/gic_v2.h
        NUM_PPI 32
        CLK_MAGIC 1llu
        CLK_SHIFT 3u
        KERNEL_WCET 10u
    )
endif()

add_sources(
    DEP "KernelPlatformls1043a-rdb"
    CFILES src/arch/arm/machine/gic_v2.c src/arch/arm/machine/l2c_nop.c
)
