#ifndef __CONFIG_H_
#define __CONFIG_H_

#include "xparameters.h"

#define TDATA_WIDTH_BIT 256 // bits [set in vivado tfcg IP]
#define TDATA_WIDTH_BYTE (TDATA_WIDTH_BIT / 8) // bits [set in vivado tfcg IP]

#define PKT_SIZE_KBYTE 1 // In KB
#define PKT_SIZE_BYTE PKT_SIZE_KBYTE * 1024 // in B

#define PKT_LEN (PKT_SIZE_BYTE / TDATA_WIDTH_BYTE) // data elements per packet

#define PKT_CNT 10 // how many packets tfcg sends before stop

enum DMA_AMOUNT {
	N_EXT_DMA = 1,
	N_INT_DMA = 1,
	N_TOTAL_DMA = XPAR_XAXIDMA_NUM_INSTANCES,
};

#endif //__CONFIG_H_
