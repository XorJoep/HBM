#ifndef __STATUS_H_
#define __STATUS_H_

#include "xparameters.h"
#include "xil_io.h"
#include "MB_Debug.h"

#define DEBUG_BASE_ADDR 	XPAR_MB_DEBUG_0_S00_AXI_INPUT_BASEADDR
#define REG0 				MB_DEBUG_S00_AXI_input_SLV_REG0_OFFSET
#define REG1 				MB_DEBUG_S00_AXI_input_SLV_REG1_OFFSET
#define REG2 				MB_DEBUG_S00_AXI_input_SLV_REG2_OFFSET
#define REG3 				MB_DEBUG_S00_AXI_input_SLV_REG3_OFFSET

#define ST_START				0x0
#define ST_SETUP_TRAFGEN		0x1
#define ST_SETUP_DMA			0x2
#define ST_SETUP_TX				0x3
#define ST_ENABLE_TRAFGEN		0x4
#define ST_SEND_DATA			0x5
#define ST_WAIT_FOR_DONE		0x6
#define ST_DONE					0xFFFF


#define DMA_GET_TX_RING			0x1
#define DMA_SET_INT_DIS			0x2
#define DMA_SET_COALESCE		0x3
#define DMA_RING_CALC			0x4
#define DMA_MALLOC_BDSPACE		0x5
#define DMA_RING_CREATE			0x6
#define DMA_BD_CLEAR			0x7
#define DMA_BD_CLONE			0x8
#define DMA_BD_RING_START		0x9
#define DMA_SETUP_DONE			0xF


#define DMA_BD_RING_ALLOC		0x10
#define DMA_BD_SET_BUFFER		0x11
#define DMA_BD_SET_LENGTH		0x12
#define DMA_BD_SET_CTRL			0x13
#define DMA_BD_SET_ID			0x14
#define DMA_BD_RING_TO_HW		0x15
#define DMA_SEND_DONE			0xFF


void setStatus(int regnum, int status);

#endif
