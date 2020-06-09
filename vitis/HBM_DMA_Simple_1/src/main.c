#include "status.h"
#include "xstatus.h"

#include "trafficgen.h"
#include "dma.h"

int main()
{
	XTrafGen TrafGen;
	XAxiDma AxiDma;
	// UINTPTR BD_mem_ptr = NULL;

	/* Setup the traffic generator */
	setStatus(0, ST_SETUP_TRAFGEN); // 0x1
	if (setupTrafGen(&TrafGen) != XST_SUCCESS) {
		setStatus(0, -ST_SETUP_TRAFGEN);
		return XST_FAILURE;
	}

	/* Setup the Direct Memory Access module */
	setStatus(0, ST_SETUP_DMA); // 0x2
	if (setupDMA(&AxiDma) != XST_SUCCESS) {
		setStatus(0, -ST_SETUP_DMA);
		return XST_FAILURE;
	}

	// /* Setup the TX Buffer descriptors */
	// setStatus(0, ST_SETUP_TX); // 0x3
	// if (setupTX(&AxiDma, BD_mem_ptr) != XST_SUCCESS) {
	// 	setStatus(0, -ST_SETUP_TX);
	// 	return XST_FAILURE;
	// }
	
	/* Enable the traffic generation */
	setStatus(0, ST_ENABLE_TRAFGEN); // 0x4
	XTrafGen_StreamEnable(&TrafGen);

	setStatus(0, ST_SIMPLE_TRANSFER);
	if (simpleTransfer(&AxiDma, MAX_PKT_CNT) != XST_SUCCESS) {
		setStatus(0, -ST_SIMPLE_TRANSFER);
		return XST_FAILURE;
	}



	// /* Send some data using a buffer descriptor from tfcg to HBM */
	// setStatus(0, ST_SEND_DATA); // 0x5
	// if (sendData(&AxiDma, HBM_MEM_BASE_ADDR, MAX_PKT_LEN) != XST_SUCCESS) {
	// 	setStatus(0, -ST_SEND_DATA);
	// 	return XST_FAILURE;
	// }

	// /* Wait for tx ring to complete */
	// setStatus(0, ST_WAIT_FOR_DONE); // 0x6
	// if (waitForDone(&AxiDma) != XST_SUCCESS) {
	// 	setStatus(0, -ST_WAIT_FOR_DONE);
	// 	return XST_FAILURE;
	// }

	// free(BD_mem_ptr);

	/* Done */
	setStatus(0, ST_DONE);
    return 0;
}
