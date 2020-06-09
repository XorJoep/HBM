#ifndef __DMA_H_
#define __DMA_H_

// to use axidma
#include "xaxidma.h"

// to know stuff about the devices
#include "xparameters.h"

// to debug easily
#include "status.h"

#define DMA_DEV_ID		XPAR_AXIDMA_0_DEVICE_ID

#define HBM_MEM_BASE_ADDR	0x10000000

#define RX_BUFFER_BASE		(HBM_MEM_BASE_ADDR)
#define RX_BUFFER_BASE_HIGH	(HBM_MEM_BASE_ADDR + 0x00000FFF)


#define TX_BD_SPACE_BASE	(RX_BUFFER_BASE + 0x10000000)
#define TX_BD_SPACE_HIGH	(HBM_MEM_BASE_ADDR + 0x00000FFF)

// Macros (From dma_passthrough example)
#define ALIGN64(some_ptr) (int*)(some_ptr + XAXIDMA_BD_MINIMUM_ALIGNMENT-some_ptr%XAXIDMA_BD_MINIMUM_ALIGNMENT);



int setupDMA(XAxiDma *AxiDmaPtr);
int setupTX(XAxiDma * AxiDmaPtr, UINTPTR bdMemSpacePtr);
int sendData(XAxiDma * AxiDmaPtr, UINTPTR MemoryBaseAddress, int max_pkt_len);
int waitForDone(XAxiDma * AxiDmaPtr);

int simpleTransfer(XAxiDma * AxiDmaPtr, int max_pkt_len);

#endif
