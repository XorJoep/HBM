#include "dma.h"

int setupDMA(XAxiDma *AxiDmaPtr){
	int Status = XST_SUCCESS;
	XAxiDma_Config *Config;


	Config = XAxiDma_LookupConfig(DMA_DEV_ID);
	if (!Config) {
		return XST_FAILURE;
	}

	Status = XAxiDma_CfgInitialize(AxiDmaPtr, Config);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	if(XAxiDma_HasSg(AxiDmaPtr)){
		return XST_FAILURE;
	}

	// Reset DMA
	XAxiDma_Reset(AxiDmaPtr);
	while (!XAxiDma_ResetIsDone(AxiDmaPtr)) {}

	/* Disable interrupts, we use polling mode
	 */
	XAxiDma_IntrDisable(AxiDmaPtr, XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrDisable(AxiDmaPtr, XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DMA_TO_DEVICE);

	return Status;

}

int simpleTransfer(XAxiDma * AxiDmaPtr, int max_pkt_len) {
	int Status = XST_SUCCESS;

	long *BufferPtrWrite = 0x010000000;
	long *BufferPtrRead = 0x010000000;

	setStatus(2, max_pkt_len);

	setStatus(1, DMA_SETUP_WRITE);
	Status = XAxiDma_SimpleTransfer(AxiDmaPtr, (UINTPTR) BufferPtrWrite,
				max_pkt_len, XAXIDMA_DEVICE_TO_DMA);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	setStatus(1, DMA_WAIT_BUSY);
	while (XAxiDma_Busy(AxiDmaPtr,XAXIDMA_DEVICE_TO_DMA)) {
			/* Wait */
	}

	BufferPtrWrite = 0x030000000;

	setStatus(1, DMA_SETUP_READ);
	Status = XAxiDma_SimpleTransfer(AxiDmaPtr, (UINTPTR) BufferPtrRead,
				max_pkt_len, XAXIDMA_DMA_TO_DEVICE);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	setStatus(1, DMA_SETUP_WRITE);
	Status = XAxiDma_SimpleTransfer(AxiDmaPtr, (UINTPTR) BufferPtrWrite,
				max_pkt_len, XAXIDMA_DEVICE_TO_DMA);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	setStatus(1, DMA_WAIT_BUSY);
	while ((XAxiDma_Busy(AxiDmaPtr,XAXIDMA_DEVICE_TO_DMA)) ||
			(XAxiDma_Busy(AxiDmaPtr,XAXIDMA_DMA_TO_DEVICE))) {
				/* Wait */
		}

  	setStatus(1, DMA_SINGLE_DONE);
	return Status;
}
