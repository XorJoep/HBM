#ifndef CIRCULAR_BUFFER_H_
#define CIRCULAR_BUFFER_H_

#include <stdint.h>

/*
 * Inspiration from
 * https://github.com/embeddedartistry/embedded-resources/blob/master/examples/c/circular_buffer/circular_buffer.c
 * With reference guide at
 * https://embeddedartistry.com/blog/2017/05/17/creating-a-circular-buffer-in-c-and-c/
 */

//#include "dma.h" // for num of DMAs
#define NUM_OF_DMAS 2 // temp...?

typedef struct circular_buf_t {
	uintptr_t r_head;
	uintptr_t r_tail;

	uintptr_t w_head;
	uintptr_t w_tail;

	long long base_address;
	int size; //of the buffer

	uintptr_t heads[NUM_OF_DMAS * 2];
	uintptr_t tails[NUM_OF_DMAS * 2];
	int base;
} circular_buf_t;

typedef circular_buf_t* cbuf_pt;

cbuf_pt circular_buf_init(uintptr_t base_address, int bank_size, int n_banks);

void circular_buf_reset(cbuf_pt cbuf);

void updateCBuf(cbuf_pt cbuf);
#endif //CIRCULAR_BUFFER_H_
