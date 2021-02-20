#ifndef __CHANNEL_H_
#define __CHANNEL_H_

#include "xaxidma.h"
#include "status.h"

#define S2MM XAXIDMA_DEVICE_TO_DMA
#define MM2S XAXIDMA_DMA_TO_DEVICE

#define MIN(x, y) (((x) < (y)) ? (x) : (y))

#define MAX_PACKET_SIZE (1<<26)

typedef struct channel_t {
	XAxiDma *dma_inst_ptr;
	int direction;

	uint64_t base_address;
	uint32_t packet_size;

	uint32_t initial_transfer;

} channel_t;

typedef channel_t* channel_pt;

void channel_init(channel_pt channel, XAxiDma *dma_inst_ptr, int direction);
void channel_reset(channel_pt channel);
// void channel_check(channel_pt channel);
void channel_setPacketSize(channel_pt channel, uint32_t packet_size);
void channel_setBaseAddr(channel_pt, uint64_t base_address);
int channel_IsBusy(channel_pt channel);
void channel_start(channel_pt channel);

u32 simpleTransfer_64bit(XAxiDma *InstancePtr, uint64_t BuffAddr, u32 Length, int Direction);
#endif //__CHANNEL_H_
