#include "switch.h"

void switch_init(XAxis_Switch *AxisSwitch) {
	XAxis_Switch_Config *Config;
//	int Status;

	Config = XAxisScr_LookupConfig(SWITCH_ID);

	XAxisScr_CfgInitialize(AxisSwitch, Config,
						Config->BaseAddress);

	/* Disable register update */
	XAxisScr_RegUpdateDisable(AxisSwitch);

	/* Disable all MI ports */
	XAxisScr_MiPortDisableAll(AxisSwitch);
}

void setSwitch_mblaze(XAxis_Switch *AxisSwitch) {
	XAxisScr_MiPortDisable(AxisSwitch, unzip_MI);
	XAxisScr_MiPortEnable(AxisSwitch, mblaze_MI, 0);
	XAxisScr_RegUpdateEnable(AxisSwitch);
}

void setSwitch_unzip(XAxis_Switch *AxisSwitch) {
	XAxisScr_MiPortDisable(AxisSwitch, mblaze_MI);
	XAxisScr_MiPortEnable(AxisSwitch, unzip_MI, 0);
	XAxisScr_RegUpdateEnable(AxisSwitch);
}
