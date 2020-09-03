#include "trafficgen.h"

void initTrafGen(XTrafGen *TrafGenPtr){
	XTrafGen_Config *Config;

	Config = XTrafGen_LookupConfig(TRAFGEN_ID);

	XTrafGen_CfgInitialize(TrafGenPtr, Config,
				Config->BaseAddress);
	XTrafGen_ResetStreamingRandomLen(TrafGenPtr); // reset to 0
	XTrafGen_SetStreamingTransLen(TrafGenPtr , (PKT_LEN - 1)); //-1 because 0-length becomes 1 etc
	XTrafGen_SetStreamingTransCnt(TrafGenPtr , PKT_CNT);
}

