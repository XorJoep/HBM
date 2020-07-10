#include "hbm.h"

int pointer_to_bank(uintptr_t address) {
	return address / HBM_BANK_SIZE;
}