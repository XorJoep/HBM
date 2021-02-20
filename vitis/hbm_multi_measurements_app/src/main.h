/*******************************************************************************
Vendor: Xilinx
Associated Filename: kernel_control.h
Purpose: MicroBlaze RTL kernel control application
*******************************************************************************/
#ifndef _MAIN_H_
#define _MAIN_H_

#include "xparameters.h"
#include "xstatus.h"
#include "xil_io.h"
#include "dma.h"
#include "timer.h"
#include "llist.h"
#include "status.h"

#define KERNEL_NAME    "hbm_measurements"
#define KERNEL_VENDOR  "Joep"
#define KERNEL_LIBRARY "kernel"

#define NUM_INPUT_ARGS 4
#define NUM_M_AXI      16
#define NUM_M_AXI_ARGS 2
#define NUM_M_AXI_STS  1
#define NUM_M_AXI_PTRS NUM_M_AXI * NUM_M_AXI_ARGS + NUM_M_AXI_STS

#define CONTROL_OFFSET 0x000
#define SCALAR_ARGS_OFFSET 0x010
#define SCALAR_ARGS_SIZE 0x002 * sizeof(uint32_t)

#define AXI_PTR_OFFSET SCALAR_ARGS_OFFSET + SCALAR_ARGS_SIZE * NUM_INPUT_ARGS
#define AXI_PTR_SIZE 0x003 * sizeof(uint32_t)

#define END_OF_REG_OFFSET AXI_PTR_OFFSET + NUM_M_AXI_PTRS * AXI_PTR_SIZE

#define CONTROL_START_MASK 0x00000001
#define CONTROL_DONE_MASK  0x00000002
#define CONTROL_IDLE_MASK  0x00000004

#define GPIO_DATA_REG      XPAR_GPIO_0_BASEADDR + 0x0000
#define GPIO_READY_MASK    0x00000001
#define GPIO_START_MASK    0x00000004

#define GPIO_IPISR_REG     XPAR_GPIO_0_BASEADDR + 0x0120
#define C2IS_MASK          0x00000002

#define SET(offset, mask) Xil_Out32(offset, Xil_In32(offset) | (mask))
#define CLR(offset, mask) Xil_Out32(offset, Xil_In32(offset) & ~(mask))

#define write_stream(value, channel) asm volatile ("putd\t%0,%1" :: "d" (value), "d" (channel))
#define read_stream(channel) ({unsigned int value; asm volatile ("getd\t%0,%1" : "=d" (value) : "d" (channel)); value; })

#endif // _MAIN_H_
