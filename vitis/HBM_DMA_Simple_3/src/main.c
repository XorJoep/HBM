#include "status.h"
#include "xstatus.h"

#include "trafficgen.h"
#include "dma.h"

#define TDATA_WIDTH 256 // bits [set in vivado tfcg IP]
#define PKT_SIZE 128 * 8 // data elements per packet
#define PKT_CNT 10 // how many packets tfcg sends before stop
#define MAX_LENGTH PKT_SIZE * TDATA_WIDTH / 8 // bytes


int main()
{
	XTrafGen TrafGen;
	XAxiDma AxiDma;
	// UINTPTR BD_mem_ptr = NULL;

	/* Setup the traffic generator */
	setStatus(0, ST_SETUP_TRAFGEN); // 0x1
	if (setupTrafGen(&TrafGen, PKT_SIZE, PKT_CNT) != XST_SUCCESS) {
		setStatus(0, -ST_SETUP_TRAFGEN);
		return XST_FAILURE;
	}

	/* Setup the Direct Memory Access module */
	setStatus(0, ST_SETUP_DMA); // 0x2
	if (setupDMA(&AxiDma) != XST_SUCCESS) {
		setStatus(0, -ST_SETUP_DMA);
		return XST_FAILURE;
	}

	/* Enable the traffic generation */
	setStatus(0, ST_ENABLE_TRAFGEN); // 0x4
	XTrafGen_StreamEnable(&TrafGen);

	setStatus(0, ST_SIMPLE_TRANSFER);
	if (simpleTransfer(&AxiDma, MAX_LENGTH) != XST_SUCCESS) {
		setStatus(0, -ST_SIMPLE_TRANSFER);
		return XST_FAILURE;
	}

	/* Done */
	setStatus(0, ST_DONE);
    return 0;
}
