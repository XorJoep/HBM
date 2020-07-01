#include "dma.h"


void dma_init(dma_pt dma, int device_ID, int internal_dma, cbuf_pt cbuf_input, cbuf_pt cbuf_output) {

	XAxiDma_CfgInitialize(&(dma->dma_instance), XAxiDma_LookupConfig(device_ID));

	dma_reset(dma);

	// Disable interrupts, we use polling mode
	XAxiDma_IntrDisable(&(dma->dma_instance), XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrDisable(&(dma->dma_instance), XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DMA_TO_DEVICE);

	if(internal_dma) {
		channel_init(&(dma->s2mm), S2MM, &(dma->dma_instance), cbuf_output);
		channel_init(&(dma->mm2s), MM2S, &(dma->dma_instance), cbuf_input);
	}
	else {
		channel_init(&(dma->s2mm), S2MM, &(dma->dma_instance), cbuf_input);
		channel_init(&(dma->mm2s), MM2S, &(dma->dma_instance), cbuf_output);
	}
}


void dma_reset(dma_pt dma) {
	channel_reset(&(dma->s2mm));
	channel_reset(&(dma->mm2s));

	XAxiDma_Reset(&dma->dma_instance);
	while (!XAxiDma_ResetIsDone(&dma->dma_instance)) {}
}


void checkDMAs(dma_t *dmas) {
	dma_pt curDMA;

	for (int i = 0; i < N_TOTAL_DMA; ++i)
	{
		curDMA = &dmas[i];
		channel_check(&(curDMA->s2mm));
		channel_check(&(curDMA->mm2s));
	}
}


void startDMAs(dma_t *dmas) {
	dma_pt curDMA;

	for (int i = 0; i < N_TOTAL_DMA; ++i)
	{
		curDMA = &dmas[i];
		channel_start(&(curDMA->s2mm), MAX_LENGTH);
		channel_start(&(curDMA->mm2s), MAX_LENGTH);
	}
}

