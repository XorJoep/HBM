#ifndef __CONFIG_H_
#define __CONFIG_H_

#include "xparameters.h"

#define TDATA_WIDTH 256 // bits [set in vivado tfcg IP]
#define PKT_SIZE 128 * 8 // data elements per packet
#define PKT_CNT 10 // how many packets tfcg sends before stop
#define MAX_LENGTH PKT_SIZE * TDATA_WIDTH / 8 // bytes

enum DMA_AMOUNT {
	N_EXT_DMA = 1,
	N_INT_DMA = 1,
	N_TOTAL_DMA = XPAR_XAXIDMA_NUM_INSTANCES,
};

#endif //__CONFIG_H_
