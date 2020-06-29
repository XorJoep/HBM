#include "trafficgen.h"

void initTrafGen(XTrafGen *TrafGenPtr, int data_size, int pkt_cnt){
	XTrafGen_Config *Config;

	/* Initialize the Device Configuration Interface driver */
	Config = XTrafGen_LookupConfig(TRAFGEN_ID);
//	if (!Config) {
//		return XST_FAILURE;
//	}

	/*
	 * This is where the virtual address would be used, this example
	 * uses physical address.
	 */
	XTrafGen_CfgInitialize(TrafGenPtr, Config,
				Config->BaseAddress);
//	if (Status != XST_SUCCESS) {
//		return Status;
//	}

	/* Check for the Streaming Mode */
//	if(TrafGenPtr->OperatingMode != XTG_MODE_STREAMING) {
//		return XST_FAILURE;
//	}

	/*
	 * Set the Required transaction length
	 * and required transaction count
	 */
	XTrafGen_ResetStreamingRandomLen(TrafGenPtr); // reset to 0
	XTrafGen_SetStreamingTransLen(TrafGenPtr , (data_size - 1)); //-1 because 0-length becomes 1 etc
	XTrafGen_SetStreamingTransCnt(TrafGenPtr , pkt_cnt);
}

