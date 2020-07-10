#ifndef __HBM_H_
#define __HBM_H_

// for uintptr_t
#include <stdint.h>

// HBM Bank 0 address is shared with instruction memory... so cannot be fully used yet
#define HBM_N_BANKS				0x10 - 1
//#define HBM_BANK_SIZE			0x010000000
#define HBM_BANK_SIZE			0x010000 // 65536 bytes
#define HBM_BASE_INPUT_ADDR		0x010000000
#define HBM_BASE_OUTPUT_ADDR	0x110000000

#define BANK_READY_TO_READ		0x1
#define BANK_READY_TO_WRITE		0x0

int pointer_to_bank(uintptr_t address);

#endif //__HBM_H_
