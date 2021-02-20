#include "dma.h"

const char DMAMap[16] = {
	XPAR_VHUNZIP_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP1_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP2_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP3_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP4_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP5_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP6_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP7_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP8_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP9_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP10_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP11_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP12_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP13_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP14_AXI_DMA_0_DEVICE_ID,
	XPAR_VHUNZIP15_AXI_DMA_0_DEVICE_ID,
};

XStatus dma_init(dma_pt dma, int device_ID) {
	XStatus error = XST_SUCCESS;
	error |= XAxiDma_CfgInitialize(&(dma->dma_instance), XAxiDma_LookupConfig(DMAMap[device_ID]));

	dma_reset(dma);

	// Disable interrupts, we use polling mode
	XAxiDma_IntrDisable(&(dma->dma_instance), XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrDisable(&(dma->dma_instance), XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DMA_TO_DEVICE);

	return error;
}


void dma_reset(dma_pt dma) {
	channel_reset(&dma->s2mm);
	channel_reset(&dma->mm2s);

	channel_init(&dma->s2mm, &dma->dma_instance, S2MM);
	channel_init(&dma->mm2s, &dma->dma_instance, MM2S);
}

void wait_dmas_done(dma_pt dmas, uint32_t num_dmas) {
	uint32_t busy_dma_found;
	do {
		busy_dma_found = 0;
		for (uint32_t ii = num_dmas; ii != 0; --ii) {
			if (DMAisBusy(&dmas[ii-1])){
				busy_dma_found = 1;
				break;
			}
		}
	} while (busy_dma_found == 1);
}

void startDMA(dma_pt dma, snap_header_pt header) {
	channel_setPacketSize(&(dma->mm2s), header->compressed_size);
	channel_setBaseAddr(&(dma->mm2s), header->addr_in);
	channel_start(&(dma->mm2s));

	channel_setPacketSize(&(dma->s2mm), header->uncompressed_size);
	channel_setBaseAddr(&(dma->s2mm), header->addr_out);
	channel_start(&(dma->s2mm));
}

dma_pt get_idle_dma(dma_pt dmas, uint32_t num_dmas){
	while(1){
		for (uint32_t ii = num_dmas; ii != 0; --ii) {
			if (!DMAisBusy(&dmas[ii-1])){
				return &dmas[ii-1];
			}
		}
	}
}

int DMAisBusy(dma_pt dma) {
	return channel_IsBusy(&(dma->s2mm)) || channel_IsBusy(&(dma->mm2s));
}

