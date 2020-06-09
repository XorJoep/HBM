#ifndef __DEVICES_H_
#define __DEVICES_H_

// to use traffic generator
#include "xtrafgen.h"
#include "xparameters.h"

#define TRAFGEN_DEV_ID	XPAR_AXI_TRAFFIC_GEN_0_DEVICE_ID

#define MAX_PKT_LEN 			0x1
#define MAX_PKT_CNT 			0x1

int setupTrafGen(XTrafGen *TrafGenPtr);

#endif
