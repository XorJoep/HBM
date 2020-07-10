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
	uintptr_t cbuf_head; // only cbuf->head gets updated and differs per direction
	bool bank_state_required;
	
	// skip any already started channels
	if(channel->started) { 
		return;
	}

	// set variables that correspond to the direction
	if (channel->direction == MM2S) { 
		cbuf_head = channel->cbuf->r_head;
		bank_state_required = BANK_READY_TO_READ;
	}
	else {
		cbuf_head = channel->cbuf->w_head;
		bank_state_required = BANK_READY_TO_WRITE;
	}

	// default place for where the new head will be at cbuf_head + package_size;
	// has to be checked for bank or cbuf border crossing
	channel->head = cbuf_head + package_size; 
	
	// check border of bank and cbuf
	if (channel->head > channel->cbuf->size) { // will have to start at 0 again in the cbuf
		channel->p_tail = 0; //physical tail address is reset to 0
	}
	else if (pointer_to_bank(channel->head) > pointer_to_bank(cbuf_head)) { // going to new bank
		channel->p_tail = pointer_to_bank(channel->head) * HBM_BANK_SIZE; // physical tail is at start of new bank
	}
	else {
		channel->p_tail = cbuf_head; //physical tail is where previous package ended (same as channel->tail)
	}

	// check if a read/write would be from an available space
	if (channel->cbuf->bank_state[pointer_to_bank(channel->p_tail)] != bank_state_required) {
		return; // bank is not yet ready to be read/write.
	}

	// update head with (possibly newly) set p_tail
	channel->head = channel->p_tail + package_size;

	channel->tail = cbuf_head; // link (virtual) tail and head
	channel->cbuf->r_head = channel->head; // update cbuf head

	XAxiDma_SimpleTransfer(
					channel->dma_inst_ptr, // module
					(UINTPTR) (channel->p_tail + channel->cbuf->base_address), // base address
					package_size, // size
					channel->direction);  // read / write

	channel->started = 1;
}


