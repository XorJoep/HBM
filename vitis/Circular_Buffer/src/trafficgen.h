#ifndef __DEVICES_H_
#define __DEVICES_H_

// to use traffic generator
#include "xtrafgen.h"
#include "xparameters.h"
#include "config.h"

#define TRAFGEN_ID	XPAR_XTRAFGEN_0_DEVICE_ID

void initTrafGen(XTrafGen *TrafGenPtr);

#endif
