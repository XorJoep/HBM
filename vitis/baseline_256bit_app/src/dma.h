#ifndef __DMA_H_
#define __DMA_H_

// to use axidma
#include "xaxidma.h"

// to debug easily
#include "xstatus.h"
#include "channel.h"
#include "llist.h"

#define S2MM XAXIDMA_DEVICE_TO_DMA
#define MM2S XAXIDMA_DMA_TO_DEVICE

typedef struct dma_t {
	XAxiDma dma_instance;

	channel_t s2mm;
	channel_t mm2s;
	
} dma_t;

typedef dma_t* dma_pt;

XStatus dma_init(dma_pt dma, int device_ID);

void dma_reset(dma_pt dma);

void startDMA(dma_pt dma, snap_header_pt header);

int DMAisDone(dma_pt dma);

dma_pt get_idle_dma(dma_pt dmas, uint32_t num_dmas);
void wait_dmas_done(dma_pt dmas, uint32_t num_dmas);

int DMAisBusy(dma_pt dma);

#endif //__DMA_H_
