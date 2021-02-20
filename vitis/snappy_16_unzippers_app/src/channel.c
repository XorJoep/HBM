#include "channel.h"

void channel_init(channel_pt channel, XAxiDma *dma_inst_ptr, int direction) {
	channel->dma_inst_ptr = dma_inst_ptr;
	channel->direction = direction;
}

void channel_reset(channel_pt channel) {
	
	// optional to reset
	channel->dma_inst_ptr = NULL;
	channel->direction = 0;
	channel->base_address = 0;

	channel->packet_size = 0;

	channel->initial_transfer = 1;
}

void channel_setPacketSize(channel_pt channel, uint32_t packet_size){
	channel->packet_size = packet_size;
}

void channel_setBaseAddr(channel_pt channel, uint64_t base_address) {
	channel->base_address = base_address;
}

int channel_IsBusy(channel_pt channel) {
	return XAxiDma_Busy(channel->dma_inst_ptr, channel->direction) && !(channel->initial_transfer);
}


void channel_start(channel_pt channel) {
	// only needed works if chunks are smaller than 64mb!
	simpleTransfer_64bit(
				channel->dma_inst_ptr, // module
				channel->base_address, // base address
				channel->packet_size, // size
				channel->direction);  // read / write

	channel->initial_transfer = 0;
}


/*****************************************************************************
 * This is a modified version of the XAxiDma_SimpleTransfer function from xaxidma.c
 * However that function doesn't handle 64 bit addresses unless the microblaze is a 64bit architecture
 * So here it is modified to support it anyway, since the addresses will be used by the dma/hbm and not
 * the microblaze.
 *
 * check are removed. This simply writes to registers.
 *****************************************************************************/
u32 simpleTransfer_64bit(XAxiDma *InstancePtr, uint64_t buffaddr, u32 Length, int Direction)
{
	if(Direction == XAXIDMA_DMA_TO_DEVICE){
		XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase,
				 XAXIDMA_SRCADDR_OFFSET, (unsigned int) buffaddr);
		XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase,
				 XAXIDMA_SRCADDR_MSB_OFFSET,
				 (unsigned int) (buffaddr >> 32));

		XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase,
				XAXIDMA_CR_OFFSET,
				XAxiDma_ReadReg(InstancePtr->TxBdRing.ChanBase,
					XAXIDMA_CR_OFFSET) | XAXIDMA_CR_RUNSTOP_MASK);
		/* Writing to the BTT register starts the transfer
		 */
		XAxiDma_WriteReg(InstancePtr->TxBdRing.ChanBase,
					XAXIDMA_BUFFLEN_OFFSET, Length);
	}
	else if(Direction == XAXIDMA_DEVICE_TO_DMA){
		XAxiDma_WriteReg(InstancePtr->RxBdRing[0].ChanBase,
				 XAXIDMA_DESTADDR_OFFSET, (unsigned int) buffaddr);
		XAxiDma_WriteReg(InstancePtr->RxBdRing[0].ChanBase,
				 XAXIDMA_DESTADDR_MSB_OFFSET,
				 (unsigned int) (buffaddr >> 32));

		XAxiDma_WriteReg(InstancePtr->RxBdRing[0].ChanBase,
				XAXIDMA_CR_OFFSET,
				XAxiDma_ReadReg(InstancePtr->RxBdRing[0].ChanBase,
					XAXIDMA_CR_OFFSET) | XAXIDMA_CR_RUNSTOP_MASK);
		/* Writing to the BTT register starts the transfer
		 */
		XAxiDma_WriteReg(InstancePtr->RxBdRing[0].ChanBase,
					XAXIDMA_BUFFLEN_OFFSET, Length);
	}
	return XST_SUCCESS;
}

