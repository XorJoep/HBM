#ifndef __DMA_H_
#define __DMA_H_

#include <stdbool.h>

// to use axidma
#include "xaxidma.h"

// to know stuff about the devices
#include "config.h"

// to debug easily
#include "status.h"

// to use cbuf
#include "cbuf.h"
#include "channel.h"

#define S2MM XAXIDMA_DEVICE_TO_DMA
#define MM2S XAXIDMA_DMA_TO_DEVICE

typedef struct dma_t {
	XAxiDma dma_instance;

	channel_t s2mm;
	channel_t mm2s;
} dma_t;

typedef dma_t* dma_pt;

void dma_init(dma_pt DMA, int device_ID, int internal_dma, cbuf_pt cbuf_input, cbuf_pt cbuf_output);

void dma_reset(dma_pt dma);

void checkDMAs(dma_t *dmas);

void startDMAs(dma_t *dmas);

//todo: dma_free

#endif //__DMA_H_
