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
	channel->p_tail = 0;
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
	uintptr_t new_head;
	// only cbuf->head gets updated
	if(!channel->started) { // skip any already started channels
		if (channel->direction == MM2S) { // different checks for reading or writing
			new_head = channel->cbuf->r_head + package_size;
			
			if (new_head > channel->cbuf->size) { // looping over cbuf max
				new_head = package_size; // new head is size of the package
				channel->p_tail = 0; //physical tail address is reset to 0
			}
			else {
				channel->p_tail = channel->cbuf->r_head; //physical tail is where previous package ended (same as channel->tail)
			}


			if( (new_head > channel->cbuf->w_tail &&
			    new_head <= channel->cbuf->w_head) || 
				channel->cbuf->r_head == channel->cbuf->w_tail) { // r_head on w_tail means there's nothing to be read yet.
				return; // check if a read would be within the "being written" region
			}
			

			channel->tail = channel->cbuf->r_head; // tail is where previous package started (and cbuf head is at)

			channel->head = new_head; // set channel head
			channel->cbuf->r_head = new_head; // update cbuf head
		}
		else {
			new_head = channel->cbuf->w_head + package_size;

			if (new_head > channel->cbuf-> size) {
				new_head = package_size;
				channel->p_tail = 0;
			}
			else {
				channel->p_tail = channel->cbuf->w_head;
			}
			channel->tail = channel->cbuf->w_head;

			channel->head = new_head;
			channel->cbuf->w_head = new_head;
		}

		XAxiDma_SimpleTransfer(
						channel->dma_inst_ptr, // module
						(UINTPTR) (channel->p_tail + channel->cbuf->base_address), // base address
						package_size, // size
						channel->direction);  // read / write

		channel->started = 1;
	}
}

