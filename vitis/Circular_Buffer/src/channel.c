#include "channel.h"



void channel_init(channel_pt channel, int direction, XAxiDma *dma_instance, cbuf_pt cbuf) {
	channel->dma_inst_ptr = dma_instance;
	channel->direction = direction;
	channel->cbuf = cbuf;
}

void channel_reset(channel_pt channel) {
	
	// optional
	channel->dma_inst_ptr = NULL;
	channel->direction = 0;
	channel->cbuf = NULL;

	// required
	channel->head = 0;
	channel->tail = 0;
	channel->started = 0;
}

void channel_check(channel_pt channel) {
	if(channel->started && !XAxiDma_Busy(channel->dma_inst_ptr, channel->direction)) {

		channel->cbuf->tails[channel->cbuf->base] = channel->tail;
		channel->cbuf->heads[channel->cbuf->base] = channel->head;
		channel->cbuf->base++;

		channel->started = 0; // ready for new transaction
	}
}

void channel_start(channel_pt channel, int package_size) {
	if(!channel->started) {
		if (channel->direction == MM2S) {
			if(channel->cbuf->r_head >= channel->cbuf->w_tail) {
				return; // read not ready yet (could be chained with next if)
			}
			channel->head = channel->cbuf->r_head + package_size;
			channel->tail = channel->cbuf->r_head;
			channel->cbuf->r_head += package_size;
		}
		else {
			channel->head = channel->cbuf->w_head + package_size;
			channel->tail = channel->cbuf->w_head;
			channel->cbuf->w_head += package_size;
		}

		XAxiDma_SimpleTransfer(
						channel->dma_inst_ptr, // module
						(UINTPTR) (channel->tail + channel->cbuf->base_address), // base address
						package_size, // size
						channel->direction);  // read / write

		channel->started = 1;
	}
}
