#include "status.h"
#include "xstatus.h"

#include "trafficgen.h"
#include "dma.h"
#include "hbm.h"
#include "cbuf.h"

#define TDATA_WIDTH 256 // bits [set in vivado tfcg IP]
#define PKT_SIZE 128 * 8 // data elements per packet
#define PKT_CNT 10 // how many packets tfcg sends before stop
#define MAX_LENGTH PKT_SIZE * TDATA_WIDTH / 8 // bytes

int main() {
	setStatus(0, ST_SETUP_TRAFGEN);
	XTrafGen TrafGen;
	initTrafGen(&TrafGen, PKT_SIZE, PKT_CNT);
	
	setStatus(0, ST_INIT_DMA);
	setStatus(1, 1);
	dma_pt dma_external_0 = dma_init(DMA_ID_EXTERNAL_0, MAX_LENGTH, false);
	setStatus(1, 2);
	dma_pt dma_internal_0 = dma_init(DMA_ID_INTERNAL_0, MAX_LENGTH, true);

	dma_pt DMAs[NUM_OF_DMAS] = {dma_external_0, dma_internal_0};

	setStatus(0, ST_INIT_CBUF);
	setStatus(1, 1);
	cbuf_pt cbuf_input  = circular_buf_init((uintptr_t) HBM_BASE_INPUT_ADDR, HBM_BANK_SIZE, HBM_N_BANKS);
	setStatus(1, 2);
	cbuf_pt cbuf_output = circular_buf_init((uintptr_t) HBM_BASE_OUTPUT_ADDR, HBM_BANK_SIZE, HBM_N_BANKS);

	setStatus(0, ST_ENABLE_TRAFGEN);
	XTrafGen_StreamEnable(&TrafGen);

	int ii;
	int runs = 50;
	for (ii = 0; ii < runs; ++ii)
	{
		setStatus(1, ii);

		// Check busy states of dma's
		setStatus(0, ST_CHECK_DMA);
		checkDMAs(DMAs, cbuf_input, cbuf_output, NUM_OF_DMAS);

		// update HaTs of cbufs
		setStatus(0, ST_UPDATE_CBUF_IN);
		updateCBuf(cbuf_input);

		setStatus(0, ST_UPDATE_CBUF_OUT);
		updateCBuf(cbuf_output);

		// update HaTs individual dma's and start their transactions
		setStatus(0, ST_START_DMA);
		startDMAs(DMAs, cbuf_input, cbuf_output, NUM_OF_DMAS);
	}

	/* Done */
	setStatus(0, ST_DONE);
    return 0;
}
