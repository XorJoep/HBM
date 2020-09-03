#include "cbuf.h"

void circular_buf_init(cbuf_pt cbuf, long long base_address) {
	circular_buf_reset(cbuf);

	cbuf->size = HBM_N_BANKS * HBM_BANK_SIZE;
	cbuf->base_address = base_address;
	}

void circular_buf_reset(cbuf_pt cbuf) {
	cbuf->w_head = 0;
	cbuf->w_tail = 0;
	cbuf->r_head = 0;
	cbuf->r_tail = 0;

	cbuf->base_address = 0;
	cbuf->size = 0; 
	memset(cbuf->bank_state, BANK_READY_TO_WRITE, sizeof(cbuf->bank_state));
	memset(cbuf->heads, -1, sizeof(cbuf->heads)); // -1 is the 'off' state
	memset(cbuf->tails, -1, sizeof(cbuf->tails)); // -1 is the 'off' state
	cbuf->base = 0;
}

void updateCBuf(cbuf_pt cbuf) {
	int ii;
	int nn;
	for (ii = 0; ii < cbuf->base; ++ii) {
		if (cbuf->tails[ii] == cbuf->w_tail) { // done writing -> can move tail
			if (pointer_to_bank(cbuf->heads[ii]) > pointer_to_bank(cbuf->w_tail)) {
				// moving w_tail to new bank
				cbuf->bank_state[pointer_to_bank(cbuf->w_tail)] = BANK_READY_TO_READ;
			}
			cbuf->w_tail = cbuf->heads[ii];
			cbuf->tails[ii] = -1;
			ii = 0; // return to start, since pointers are not ordered
		}

		else if (cbuf->tails[ii] == cbuf->r_tail) { // done reading -> can move tail
			if (pointer_to_bank(cbuf->heads[ii]) > pointer_to_bank(cbuf->r_tail)) {
				// moving r_tail to new bank
				cbuf->bank_state[pointer_to_bank(cbuf->r_tail)] = BANK_READY_TO_WRITE;
			}
			cbuf->r_tail = cbuf->heads[ii];
			cbuf->tails[ii] = -1;
			ii = 0; // return to start, since pointers are not ordered
		}       
	}

	// order the remaining points so there are not empty slots between them
	nn = cbuf->size; // outside of array
	for (ii = 0; ii < cbuf->base; ++ii) {
		if(cbuf->tails[ii] != -1) {
			if (nn < ii){ // check if nn is initialized
				cbuf->tails[nn] = cbuf->tails[ii]; // place in empty spot,
				cbuf->heads[nn] = cbuf->heads[ii];
				cbuf->tails[ii] = -1; // make spot empty
				cbuf->heads[ii] = -1;

				nn++;
			}
		}
		else if (nn == cbuf->size) { // find first empty slot
			nn = ii;
		}
	}

	if(cbuf->base != 0) {
		cbuf->base = nn; // some HaTs removed so, lower base (first empty spot)
	}
}

