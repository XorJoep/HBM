#ifndef __CHANNEL_H_
#define __CHANNEL_H_

#include "xaxidma.h"
#include "cbuf.h"

#define S2MM XAXIDMA_DEVICE_TO_DMA
#define MM2S XAXIDMA_DMA_TO_DEVICE

typedef struct channel_t {
	XAxiDma *dma_inst_ptr;
	int direction;

	cbuf_pt cbuf;
	uintptr_t head;
	uintptr_t tail;

	int started;
} channel_t;

typedef channel_t* channel_pt;

void channel_init(channel_pt channel, int direction, XAxiDma *dma_instance, cbuf_pt cbuf);
void channel_reset(channel_pt channel);
void channel_check(channel_pt channel);
void channel_start(channel_pt channel, int package_size);

#endif //__CHANNEL_H_
