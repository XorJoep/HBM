#ifndef __TIMER_H_
#define __TIMER_H_

#include "xtmrctr.h"

#define TIMER_ID XPAR_CONTROL_AXI_TIMER_0_DEVICE_ID

#define TIMER_LOWER_32 0
#define TIMER_UPPER_32 1


uint64_t timer_init(XTmrCtr *timer);
uint64_t getTime(XTmrCtr *timer);
void timer_reset(XTmrCtr *timer);

#endif //__TIMER_H_
