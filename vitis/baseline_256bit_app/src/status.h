#ifndef __STATUS_H_
#define __STATUS_H_

#include "xparameters.h"
#include "MB_Debug.h"
#include "xil_io.h"

#define DEBUG_BASE_ADDR 	XPAR_CONTROL_MB_DEBUG_0_S00_AXI_INPUT_BASEADDR
#define REG0 				MB_DEBUG_S00_AXI_input_SLV_REG0_OFFSET
#define REG1 				MB_DEBUG_S00_AXI_input_SLV_REG1_OFFSET
#define REG2 				MB_DEBUG_S00_AXI_input_SLV_REG2_OFFSET
#define REG3 				MB_DEBUG_S00_AXI_input_SLV_REG3_OFFSET

void setStatus(int regnum, int status);

#endif
