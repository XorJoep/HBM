#ifndef __DMA_H_
#define __DMA_H_

#include <stdbool.h>

// to use axidma
#include "xaxidma.h"

// to know stuff about the devices
#include "xparameters.h"

// to debug easily
#include "status.h"

// to use cbuf
#include "cbuf.h"

#define NUM_OF_DMAS 2 // temp...?

#define DMA_ID_EXTERNAL_0		XPAR_AXIDMA_1_DEVICE_ID
#define DMA_ID_INTERNAL_0		XPAR_AXIDMA_0_DEVICE_ID

#define DIR_WRITE XAXIDMA_DEVICE_TO_DMA
#define DIR_READ XAXIDMA_DMA_TO_DEVICE

typedef struct dma_t dma_t;

typedef dma_t* dma_pt;

dma_pt dma_init(int device_ID, int max_pkt_len, bool internal_dma);

void dma_reset(dma_pt dma);

int dma_isBusy(dma_pt dma, char direction);

void checkDMAs(dma_pt *dmas, cbuf_pt cbuf_input, cbuf_pt cbuf_output, int num_of_dmas);
void checkDMA(dma_pt dma, cbuf_pt cbuf_R, cbuf_pt cbuf_W);

void startDMAs(dma_pt *dmas, cbuf_pt cbuf_input, cbuf_pt cbuf_output, int num_of_dmas);
void startDMA(dma_pt dma, cbuf_pt cbuf_R, cbuf_pt cbuf_W);
void dma_start_W(dma_pt dma, uintptr_t base_address);
void dma_start_R(dma_pt dma, uintptr_t base_address);
//todo: dma_free

#endif
