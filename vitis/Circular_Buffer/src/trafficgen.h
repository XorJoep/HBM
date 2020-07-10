#ifndef __DEVICES_H_
#define __DEVICES_H_

// to use traffic generator
#include "xtrafgen.h"
#include "xparameters.h"

#define TRAFGEN_DEV_ID	XPAR_AXI_TRAFFIC_GEN_0_DEVICE_ID

setupTrafGen(XTrafGen *TrafGenPtr, int data_size, int pkt_cnt);

#endif
