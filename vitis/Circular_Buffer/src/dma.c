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

	/* Disable interrupts, we use polling mode
	 */
	XAxiDma_IntrDisable(AxiDmaPtr, XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrDisable(AxiDmaPtr, XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DMA_TO_DEVICE);

	// Reset DMA
	XAxiDma_Reset(AxiDmaPtr);
	while (!XAxiDma_ResetIsDone(AxiDmaPtr)) {}

	return Status;

}

int setupTX(XAxiDma * AxiDmaPtr, UINTPTR bdMemSpacePtr)
{
	XAxiDma_BdRing *TxRingPtr;
	XAxiDma_Bd*     bd_ptr;
	XAxiDma_Bd BdTemplate;
	XAxiDma_Bd*     cur_bd_ptr;
	UINTPTR bdMemSpacePtrAligned;
	int Delay = 0;
	int Coalesce = 1;
	int Status = XST_SUCCESS;
	int ii;
	int buf_addr;
	int cr_bits = 0;
	u32 BdCount;
	u32 MemSpaceSize;

	setStatus(1, DMA_GET_TX_RING);
	TxRingPtr = XAxiDma_GetTxRing(AxiDmaPtr);


	/* Disable all TX interrupts before TxBD space setup */
	setStatus(1, DMA_SET_INT_DIS);
	XAxiDma_BdRingIntDisable(TxRingPtr, XAXIDMA_IRQ_ALL_MASK);


	/* Set TX delay and coalesce */
	setStatus(1, DMA_SET_COALESCE);
	XAxiDma_BdRingSetCoalesce(TxRingPtr, Coalesce, Delay);


	/* Setup TxBD space  */
	setStatus(1, DMA_RING_CALC);
	BdCount = XAxiDma_BdRingCntCalc(XAXIDMA_BD_MINIMUM_ALIGNMENT,
				TX_BD_SPACE_HIGH - TX_BD_SPACE_BASE + 1);
	MemSpaceSize = BdCount * (sizeof(XAxiDma_Bd) + (XAXIDMA_BD_MINIMUM_ALIGNMENT - 1)) & ~(XAXIDMA_BD_MINIMUM_ALIGNMENT - 1);
	setStatus(2, BdCount);;
	setStatus(3, MemSpaceSize);;

	/* Create space to store BDRING */
	setStatus(1, DMA_MALLOC_BDSPACE);
	bdMemSpacePtr = malloc(MemSpaceSize);
	bdMemSpacePtrAligned = ALIGN64((int)bdMemSpacePtr);


	setStatus(1, DMA_RING_CREATE);
	Status = XAxiDma_BdRingCreate(TxRingPtr, 
				bdMemSpacePtrAligned, bdMemSpacePtrAligned,
				XAXIDMA_BD_MINIMUM_ALIGNMENT, BdCount);
	if (Status != XST_SUCCESS) {
		setStatus(1, Status);
		return XST_FAILURE;
	}

	/*
	 * We create an all-zero BD as the template.
	 */
	setStatus(1, DMA_BD_CLEAR);
	XAxiDma_BdClear(&BdTemplate);

	setStatus(1, DMA_BD_CLONE);
	Status = XAxiDma_BdRingClone(TxRingPtr, &BdTemplate);
	if (Status != XST_SUCCESS) {
		setStatus(1, Status);
		return XST_FAILURE;
	}

	/* Start the TX channel */
	setStatus(1, DMA_BD_RING_START);
	Status = XAxiDma_BdRingStart(TxRingPtr);
	if (Status != XST_SUCCESS) {
		setStatus(1, Status);
		return XST_FAILURE;
	}

	setStatus(1, DMA_SETUP_DONE);
	return XST_SUCCESS;
}

int sendData(XAxiDma * AxiDmaPtr, UINTPTR MemoryBaseAddress, int max_pkt_len){
	XAxiDma_BdRing *TxRingPtr;
	XAxiDma_Bd *BdPtr;
	int Status;
	int bdAmount = 1; /* temp */

	setStatus(1, DMA_GET_TX_RING);
	TxRingPtr = XAxiDma_GetTxRing(AxiDmaPtr);

	/* Allocate a BD */
	setStatus(1, DMA_BD_RING_ALLOC);
	Status = XAxiDma_BdRingAlloc(TxRingPtr, bdAmount, &BdPtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/* Set up the BD using the information of the packet to transmit */
	setStatus(1, DMA_BD_SET_BUFFER);
	Status = XAxiDma_BdSetBufAddr(BdPtr, MemoryBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	setStatus(1, DMA_BD_SET_LENGTH);
	Status = XAxiDma_BdSetLength(BdPtr, max_pkt_len,
				TxRingPtr->MaxTransferLen);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	/* For single packet, both SOF and EOF are to be set
	 */
	setStatus(1, DMA_BD_SET_CTRL);
	XAxiDma_BdSetCtrl(BdPtr, XAXIDMA_BD_CTRL_TXEOF_MASK |
						XAXIDMA_BD_CTRL_TXSOF_MASK);

	setStatus(1, DMA_BD_SET_ID);
	XAxiDma_BdSetId(BdPtr, MemoryBaseAddress);

	/* Give the BD to DMA to kick off the transmission. */
	setStatus(1, DMA_BD_RING_TO_HW);
	Status = XAxiDma_BdRingToHw(TxRingPtr, 1, BdPtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	setStatus(1, DMA_SEND_DONE);
	return XST_SUCCESS;
}

int waitForDone(XAxiDma * AxiDmaPtr){
	XAxiDma_BdRing *TxRingPtr;
	XAxiDma_Bd *BdPtr;
	int ProcessedBdCount;
	int Status;

	TxRingPtr = XAxiDma_GetTxRing(AxiDmaPtr);

	/* Wait until the one BD TX transaction is done */
	while ((ProcessedBdCount = XAxiDma_BdRingFromHw(TxRingPtr,
						       XAXIDMA_ALL_BDS,
						       &BdPtr)) == 0) {
	}

	/* Free all processed TX BDs for future transmission */
	Status = XAxiDma_BdRingFree(TxRingPtr, ProcessedBdCount, BdPtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}


int simpleTransfer(XAxiDma * AxiDmaPtr, int max_pkt_len) {
	int Status = XST_SUCCESS;

	int *BufferPtr = (int *) RX_BUFFER_BASE;

	setStatus(1, DMA_PERFORM_WRITE);
	setStatus(2, max_pkt_len);
	Status = XAxiDma_SimpleTransfer(AxiDmaPtr, (UINTPTR) BufferPtr,
				max_pkt_len, XAXIDMA_DEVICE_TO_DMA);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	setStatus(1, DMA_WAIT_BUSY);
	while (XAxiDma_Busy(AxiDmaPtr,XAXIDMA_DEVICE_TO_DMA)) {
			/* Wait */
	}

	setStatus(1, DMA_PERFORM_READ);
	Status = XAxiDma_SimpleTransfer(AxiDmaPtr, (UINTPTR) BufferPtr,
				max_pkt_len, XAXIDMA_DMA_TO_DEVICE);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	setStatus(1, DMA_WAIT_BUSY);
	while (XAxiDma_Busy(AxiDmaPtr,XAXIDMA_DMA_TO_DEVICE)) {
			/* Wait */
	}

  	setStatus(1, DMA_SINGLE_DONE);
	return Status;
}
