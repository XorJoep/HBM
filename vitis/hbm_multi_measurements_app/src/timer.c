#include "timer.h"

uint64_t timer_init(XTmrCtr *timer) {

	uint64_t init_timer;
	uint64_t curr_timer;
	uint64_t calibration;

	//Initialize the timer functions:
	XTmrCtr_Initialize(timer, TIMER_ID);
	XTmrCtr_SetOptions(timer, TIMER_ID, XTC_CASCADE_MODE_OPTION 
									  | XTC_AUTO_RELOAD_OPTION
									  | XTC_ENABLE_ALL_OPTION);

	//Set calibration
	init_timer = XTmrCtr_GetValue(timer, TIMER_LOWER_32);
	curr_timer = XTmrCtr_GetValue(timer, TIMER_LOWER_32);
	calibration = curr_timer - init_timer;

	return calibration;
}

uint64_t getTime(XTmrCtr *timer) {
	unsigned int lower32b = XTmrCtr_GetValue(timer, TIMER_LOWER_32);
	uint64_t upper32b = ((uint64_t) XTmrCtr_GetValue(timer, TIMER_UPPER_32)) << 32;
	return upper32b | lower32b;
}

void timer_reset(XTmrCtr *timer) {
	XTmrCtr_Reset(timer, TIMER_LOWER_32);
	XTmrCtr_Reset(timer, TIMER_UPPER_32);
}