#ifndef __SWITCH_H_
#define __SWITCH_H_

#include "xaxis_switch.h"

#define SWITCH_ID XPAR_AXIS_SWITCH_0_DEVICE_ID

#define mblaze_MI 0
#define unzip_MI 1

void switch_init(XAxis_Switch *AxisSwitch);
void setSwitch_mblaze(XAxis_Switch *AxisSwitch);
void setSwitch_unzip(XAxis_Switch *AxisSwitch);

#endif //__SWITCH_H_
