#include "trafficgen.h"

int setupTrafGen(XTrafGen *TrafGenPtr){
	int Status = XST_SUCCESS;
	XTrafGen_Config *Config;

	/* Initialize the Device Configuration Interface driver */
	Config = XTrafGen_LookupConfig(TRAFGEN_DEV_ID);
	if (!Config) {
		return XST_FAILURE;
	}

	/*
	 * This is where the virtual address would be used, this example
	 * uses physical address.
	 */
	Status = XTrafGen_CfgInitialize(TrafGenPtr, Config,
				Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		return Status;
	}

	/* Check for the Streaming Mode */
	if(TrafGenPtr->OperatingMode != XTG_MODE_STREAMING) {
		return XST_FAILURE;
	}

	/*
	 * Set the Required transaction length
	 * and required transaction count
	 */

	XTrafGen_ResetStreamingRandomLen(TrafGenPtr);
	XTrafGen_SetStreamingTransLen(TrafGenPtr , MAX_PKT_LEN);
	XTrafGen_SetStreamingTransCnt(TrafGenPtr , MAX_PKT_CNT);

	return Status;
}