#include "dma.h"

struct dma_t {
	XAxiDma DMA;
	XAxiDma *DMAPtr;

	uintptr_t w_head;
	uintptr_t w_tail;
	bool w_started;

	uintptr_t r_head;
	uintptr_t r_tail;
	bool r_started;

	int max_size;
	bool internal;
};

dma_pt dma_init(int device_ID, int max_pkt_len, bool internal_dma) {

	XAxiDma_Config *Config;
	dma_pt dma = malloc(sizeof(dma_t));
	dma->DMAPtr = &(dma->DMA);

	Config = XAxiDma_LookupConfig(device_ID);
//	if (!Config) {
//		return XST_FAILURE;
//	}

	XAxiDma_CfgInitialize(dma->DMAPtr, Config);
//	if (Status != XST_SUCCESS) {
//		return XST_FAILURE;
//	}

//	if(XAxiDma_HasSg(dma->DMAPtr)){
//		return XST_FAILURE;
//	}
	dma_reset(dma);

	/* Disable interrupts, we use polling mode
	 */
	XAxiDma_IntrDisable(dma->DMAPtr, XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrDisable(dma->DMAPtr, XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DMA_TO_DEVICE);


	dma->max_size = max_pkt_len;
	dma->internal = internal_dma;

	return dma;
}


void dma_reset(dma_pt dma) {
	dma->w_head = 0;
	dma->w_tail = 0;
	dma->w_started = false;

	dma->r_head = 0;
	dma->r_tail = 0;
	dma->r_started = false;

	XAxiDma_Reset(dma->DMAPtr);
	while (!XAxiDma_ResetIsDone(dma->DMAPtr)) {}
}


int dma_isBusy(dma_pt dma, char direction) {
	return XAxiDma_Busy(dma->DMAPtr, direction);
}


void checkDMAs(dma_pt *dmas, cbuf_pt cbuf_input, cbuf_pt cbuf_output, int num_of_dmas) {
	dma_pt curDMA;
	cbuf_pt cbuf_R;
	cbuf_pt cbuf_W;

	for (int i = 0; i < num_of_dmas; ++i)
	{
		curDMA = dmas[i];

		if(curDMA->internal) {
			cbuf_R = cbuf_input;
			cbuf_W = cbuf_output;
		}
		else {
			cbuf_R = cbuf_output;
			cbuf_W = cbuf_input;
		}

		checkDMA(curDMA, cbuf_R, cbuf_W);
	}
}


void checkDMA(dma_pt dma, cbuf_pt cbuf_R, cbuf_pt cbuf_W){
	
	// R
	if(dma->r_started && !dma_isBusy(dma, DIR_READ)) {
		
		dma->r_started = false; // ready for new transaction
	
		cbuf_R->tails[cbuf_R->base] = dma->r_tail;
		cbuf_R->heads[cbuf_R->base] = dma->r_head;
		cbuf_R->base++;
	}

	// W
	if(dma->w_started && !dma_isBusy(dma, DIR_WRITE)) {

		dma->w_started = false; // ready for new transaction

		cbuf_W->tails[cbuf_W->base] = dma->w_tail;
		cbuf_W->heads[cbuf_W->base] = dma->w_head;
		cbuf_W->base++;
	}
}


void startDMAs(dma_pt *dmas, cbuf_pt cbuf_input, cbuf_pt cbuf_output, int num_of_dmas) {
	dma_pt curDMA;
	cbuf_pt cbuf_R;
	cbuf_pt cbuf_W;

	for (int i = 0; i < num_of_dmas; ++i)
	{
		curDMA = dmas[i];

		if(curDMA->internal) {
			cbuf_R = cbuf_input;
			cbuf_W = cbuf_output;
		}
		else {
			cbuf_R = cbuf_output;
			cbuf_W = cbuf_input;
		}

		startDMA(curDMA, cbuf_R, cbuf_W);
	}
}


void startDMA(dma_pt dma, cbuf_pt cbuf_R, cbuf_pt cbuf_W) {
	// R
	if(!dma->r_started && cbuf_R->r_head < cbuf_R->w_tail) {
		dma->r_head = cbuf_R->r_head + dma->max_size;
		dma->r_tail = cbuf_R->r_head;
		cbuf_R->r_head += dma->max_size;
		dma_start_R(dma, cbuf_R->base_address);
	}

	// W
	if(!dma->w_started) { // check if w_head > r_tail
		dma->w_head = cbuf_W->w_head + dma->max_size;
		dma->w_tail = cbuf_W->w_head;
		cbuf_W->w_head += dma->max_size;
		dma_start_W(dma, cbuf_W->base_address);
	}
}


void dma_start_W(dma_pt dma, uintptr_t base_address) {
	XAxiDma_SimpleTransfer(
				dma->DMAPtr, // module
				(UINTPTR) (dma->w_tail + base_address), // base address
				dma->w_head - dma->w_tail, // size
				DIR_WRITE);  // read / write

	dma->w_started = TRUE;
}


void dma_start_R(dma_pt dma, uintptr_t base_address) {
	XAxiDma_SimpleTransfer(
				dma->DMAPtr, // module
				(UINTPTR) (dma->r_tail + base_address), // base address
				dma->r_head - dma->r_tail, // size
				DIR_READ);  // read / write

	dma->r_started = TRUE;
}
