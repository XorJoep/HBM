#include "cbuf.h"

cbuf_pt circular_buf_init(uintptr_t base_address, int bank_size, int n_banks) {
	cbuf_pt cbuf = malloc(sizeof(circular_buf_t));

	circular_buf_reset(cbuf);

	cbuf->size = bank_size * n_banks;
	cbuf->base_address = base_address;
	
	return cbuf;
}

void circular_buf_reset(cbuf_pt cbuf) {
	cbuf->w_head = 0;
	cbuf->w_tail = 0;
	cbuf->r_head = 0;
	cbuf->r_tail = 0;

	cbuf->base_address = 0;
	cbuf->size = 0; 

	memset(cbuf->heads, -1, sizeof(*cbuf->heads) * NUM_OF_DMAS * 2);
	memset(cbuf->tails, -1, sizeof(*cbuf->tails) * NUM_OF_DMAS * 2);
	cbuf->base = 0;
}

void updateCBuf(cbuf_pt cbuf) {
	int ii;
	int nn;
	for (ii = 0; ii < cbuf->base; ++ii) {
		if (cbuf->tails[ii] == cbuf->w_tail) { // done writing -> can move tail
			cbuf->w_tail = cbuf->heads[ii];
			cbuf->tails[ii] = -1;
			ii = 0; // return to start, since pointers are not ordered
		}

		else if (cbuf->tails[ii] == cbuf->r_tail) { // done reading -> can move tail
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

