#include "status.h"


/* 	sets a status on a certain register that is outputted by a debug IP
	Useful during simulation debugging */
void setStatus(int regnum, int status){
	int offset;
	switch (regnum) {
		case 0:
			offset = REG0;
			break;
		case 1:
			offset = REG1;
			break;
		case 2:
			offset = REG2;
			break;
		case 3:
			offset = REG3;
			break;
		default:
			offset = REG0;
	}
	MB_DEBUG_mWriteReg(DEBUG_BASE_ADDR, offset,
		status);
}
