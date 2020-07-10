#ifndef __CIRCULAR_BUFFER_H_
#define __CIRCULAR_BUFFER_H_

#include <stdint.h>
#include "config.h"

/*
 * First inspiration from
 * https://github.com/embeddedartistry/embedded-resources/blob/master/examples/c/circular_buffer/circular_buffer.c
 * With reference guide at
 * https://embeddedartistry.com/blog/2017/05/17/creating-a-circular-buffer-in-c-and-c/
 */


typedef struct cbuf_t {
	uintptr_t r_head;
	uintptr_t r_tail;

	uintptr_t w_head;
	uintptr_t w_tail;

	long long base_address;
	int size; //of the buffer

	bool bank_state[HBM_N_BANKS];

	uintptr_t heads[N_TOTAL_DMA * 2];
	uintptr_t tails[N_TOTAL_DMA * 2];
	int base;
} cbuf_t;

typedef cbuf_t* cbuf_pt;

void circular_buf_init(cbuf_pt cbuf, uintptr_t base_address, int bank_size, int n_banks);

void circular_buf_reset(cbuf_pt cbuf);

void updateCBuf(cbuf_pt cbuf);
#endif //__CIRCULAR_BUFFER_H_
