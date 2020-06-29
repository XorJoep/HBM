#ifndef __DMA_H_
#define __DMA_H_

// to use axidma
#include "xaxidma.h"

// to know stuff about the devices
#include "xparameters.h"

// to debug easily
#include "status.h"

#define DMA_DEV_ID		XPAR_AXIDMA_0_DEVICE_ID

// HBM Bank 0 address is shared with instruction memory... so cannot be fully used yet
#define HBM_N_BANKS		0x20 - 1
#define HBM_BASE_ADDR	0x010000000
#define HBM_BASE_ADDR2	0x020000000
#define HBM_BANK_SIZE	0x010000000
#define HBM_TOP_ADDR	HBM_N_BANKS * HBM_MEM_BANK_SIZE - 1

int setupDMA(XAxiDma *AxiDmaPtr);
int simpleTransfer(XAxiDma * AxiDmaPtr, int max_pkt_len);

#endif
