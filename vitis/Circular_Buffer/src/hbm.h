#ifndef __HBM_H_
#define __HBM_H_

// HBM Bank 0 address is shared with instruction memory... so cannot be fully used yet
#define HBM_N_BANKS				0x10 - 1
#define HBM_BANK_SIZE			0x010000000
#define HBM_BASE_INPUT_ADDR		0x010000000
#define HBM_BASE_OUTPUT_ADDR	0x110000000

#endif //__HBM_H_
