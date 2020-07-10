#include "status.h"

#include "config.h"

#include "trafficgen.h"
#include "dma.h"
#include "hbm.h"

const int ext_dma[N_EXT_DMA] = {
	XPAR_MAIN_DMA_DEVICE_ID
};

const int int_dma[N_INT_DMA] = {
	XPAR_AXI_DMA_0_DEVICE_ID
};

dma_t DMAS[N_TOTAL_DMA];
XTrafGen TrafGen;

cbuf_t cbuf_input;
cbuf_t cbuf_output;

int main() {
	int ii;
	setStatus(0, ST_SETUP_TRAFGEN);
	initTrafGen(&TrafGen);

	setStatus(0, ST_INIT_DMA);
	setStatus(1, 1);
	// setup external dmas
	for (ii = 0; ii < N_EXT_DMA; ++ii)
	{
		dma_init(&DMAS[ii], ext_dma[ii], false, &cbuf_input, &cbuf_output);
	}

	setStatus(1, 2);
	// setup internal dmas
	for (ii = 0; ii < N_INT_DMA; ++ii)
	{
		dma_init(&DMAS[N_EXT_DMA+ii], int_dma[ii], true, &cbuf_input, &cbuf_output);
	}

	setStatus(0, ST_INIT_CBUF);
	setStatus(1, 1);
	circular_buf_init(&cbuf_input, (uintptr_t) HBM_BASE_INPUT_ADDR, HBM_BANK_SIZE, HBM_N_BANKS);
	setStatus(1, 2);
	circular_buf_init(&cbuf_output, (uintptr_t) HBM_BASE_OUTPUT_ADDR, HBM_BANK_SIZE, HBM_N_BANKS);

	setStatus(0, ST_ENABLE_TRAFGEN);
	XTrafGen_StreamEnable(&TrafGen);

	for (ii = 0; 1; ++ii)
	{
		setStatus(1, ii);

		// Check busy states of dma's
		setStatus(0, ST_CHECK_DMA);
		checkDMAs(DMAS);

		// update HaTs of cbufs
		setStatus(0, ST_UPDATE_CBUF_IN);
		updateCBuf(&cbuf_input);

		setStatus(0, ST_UPDATE_CBUF_OUT);
		updateCBuf(&cbuf_output);

		// update HaTs individual dma's and start their transactions
		setStatus(0, ST_START_DMA);
		startDMAs(DMAS);
	}

	/* Done */
	setStatus(0, ST_DONE);
    return 0;
}
