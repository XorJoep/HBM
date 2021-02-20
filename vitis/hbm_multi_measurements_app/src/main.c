#include "main.h"

uint32_t kernel_args_scalar[NUM_INPUT_ARGS];
uint64_t kernel_args_ptr[NUM_M_AXI][NUM_M_AXI_ARGS];
uint64_t kernel_sts_ptr;


void set_kernel_args() {
	// obtain kernel arguments (scalar)
	for (uint32_t ii = 0; ii < NUM_INPUT_ARGS; ++ii)	{
		kernel_args_scalar[ii] = Xil_In32(SCALAR_ARGS_OFFSET + ii * SCALAR_ARGS_SIZE);
	}

	// obtain kernel arguments (64b global memory pointers)
	for (uint32_t ii = 0; ii < NUM_M_AXI; ++ii) {
		for (uint32_t jj = 0; jj < NUM_M_AXI_ARGS; ++jj)
		{
			kernel_args_ptr[ii][jj] = ((uint64_t) Xil_In32(AXI_PTR_OFFSET 
															  + sizeof(uint32_t)
															  + (ii * NUM_M_AXI_ARGS + jj) * AXI_PTR_SIZE 
														   ) << 32) 
												| Xil_In32(AXI_PTR_OFFSET 
														   	  + (ii * NUM_M_AXI_ARGS + jj) * AXI_PTR_SIZE);
		}
	}
	kernel_sts_ptr = ((uint64_t) Xil_In32(AXI_PTR_OFFSET
									  + sizeof(uint32_t)
									  + (NUM_M_AXI * NUM_M_AXI_ARGS) * AXI_PTR_SIZE
								   ) << 32)
									| Xil_In32(AXI_PTR_OFFSET
									  + (NUM_M_AXI * NUM_M_AXI_ARGS) * AXI_PTR_SIZE);
}

void setup_control(){
	// Clear done and idle
	CLR(CONTROL_OFFSET, CONTROL_DONE_MASK | CONTROL_IDLE_MASK);
	// initialize user registers to zero. (scalars + global memory pointers)
	for (uint32_t ii = SCALAR_ARGS_OFFSET; ii < END_OF_REG_OFFSET; ii +=4) {
		Xil_Out32(ii, 0);
	}
	SET(GPIO_DATA_REG, GPIO_READY_MASK);
	SET(CONTROL_OFFSET, CONTROL_IDLE_MASK);
}

void wait_for_start_signal(){
	// Wait until host writes start signal to control register
	while ((Xil_In32(CONTROL_OFFSET) & CONTROL_START_MASK) == 0);

	// signal that kernel has started
	CLR(CONTROL_OFFSET, CONTROL_DONE_MASK | CONTROL_IDLE_MASK);
	SET(GPIO_DATA_REG, GPIO_START_MASK);
}

void cleanup() {
	CLR(GPIO_DATA_REG, GPIO_START_MASK);
	SET(GPIO_IPISR_REG, C2IS_MASK); // Clear GPIO interrupt status register (Toggle-on-Write)
	// Done: Set done and idle
	CLR(CONTROL_OFFSET, CONTROL_START_MASK);
	SET(CONTROL_OFFSET, CONTROL_DONE_MASK | CONTROL_IDLE_MASK);
}



void write_status(dma_pt dma, uint64_t * status_addr, uint32_t value_low, uint32_t value_high) {
	channel_pt s2mm_channel = &(dma->s2mm);

	while(channel_IsBusy(s2mm_channel));
	write_stream(value_low, 0); // write value to microblaze output stream
	write_stream(value_high, 0); // write value to microblaze output stream
	channel_setBaseAddr(s2mm_channel, *status_addr);
	channel_setPacketSize(s2mm_channel, 8);
	channel_start(s2mm_channel);
	*status_addr += 8;
	while(channel_IsBusy(s2mm_channel));
}

dma_t DMAS[NUM_M_AXI];
XTmrCtr timer;

int main() {
	XStatus error = XST_SUCCESS;
	dma_pt DMA_PTR = &DMAS[0];

	uint64_t startTime;
	uint64_t endTime;
	uint64_t calibrationTime;
	uint64_t runTime;
	uint64_t runTimeFull;
	uint64_t status_addr;

	uint32_t numTimes;
	uint32_t transaction_size;
	uint32_t transfer_mode;
	uint32_t numRunners;

	///////////////////////////////////////////
	// SETUP GPIO + KERNEL CONTROL REGISTERS //
	///////////////////////////////////////////

	setup_control();

	//////////////////////
	// SETUP PERIPHEALS //
	//////////////////////
	
	calibrationTime = timer_init(&timer);//
	//setStatus(0, 0x1);

	for (uint32_t ii = 0; ii < NUM_M_AXI; ++ii)
		error |= dma_init(&DMAS[ii], ii);
	//setStatus(0, 0x2);
	while (error == XST_SUCCESS) {

		wait_for_start_signal(); // blocks until start signal from host is given
		//setStatus(0, 0x3);
		set_kernel_args();
		//setStatus(0, 0x4);

		numTimes = kernel_args_scalar[0];
		transaction_size = kernel_args_scalar[1];
		transfer_mode = kernel_args_scalar[2];
		numRunners = kernel_args_scalar[3];
		//setStatus(1, numTimes);
		//setStatus(1, transaction_size);
		//setStatus(1, transfer_mode);
		//setStatus(2, kernel_args_ptr[0][0]);
		//setStatus(2, kernel_args_ptr[0][1]);
		//setStatus(2, kernel_args_ptr[0][2]);

		status_addr = kernel_sts_ptr; // output address status
		
		//setStatus(0, 0x5);

		///////////////////
		// MAIN FUNCTION //
		///////////////////

		timer_reset(&timer);
		runTime = 0;
		runTimeFull = getTime(&timer);

		for (uint32_t loop_counter = 0; loop_counter < numTimes; ++loop_counter)	{

			/////////////////////////
			// SETUP DMA + CHANNEL //
			/////////////////////////

			//setStatus(0, 0x7);
			for (uint32_t jj = 0; jj < numRunners; ++jj) {
				dma_reset(&DMAS[jj]);
			}
			startTime = getTime(&timer);
			//setStatus(0, 0x8);

			if(transfer_mode >= 1) {
				setStatus(3, 1<<31);
				setStatus(3, transaction_size/8-1);
			}

			for (uint32_t jj = 0; jj < numRunners; ++jj) {
				switch(transfer_mode) {
					case 1:
						channel_setPacketSize(&(DMAS[jj].s2mm), transaction_size);
						channel_setBaseAddr(&(DMAS[jj].s2mm), kernel_args_ptr[jj][1]); // whatever output address is
						channel_start(&(DMAS[jj].s2mm));
						break;
					case 2:
						channel_setPacketSize(&(DMAS[jj].s2mm), transaction_size);
						channel_setBaseAddr(&(DMAS[jj].s2mm), kernel_args_ptr[jj][1]); // whatever output address is
						channel_start(&(DMAS[jj].s2mm));
					case 0:
						channel_setPacketSize(&(DMAS[jj].mm2s), transaction_size);
						channel_setBaseAddr(&(DMAS[jj].mm2s), kernel_args_ptr[jj][0]); // whatever input address is
						channel_start(&(DMAS[jj].mm2s));
						break;
				}
			}

			wait_dmas_done(DMAS, numRunners);
			//setStatus(0, 0x9);
			//////////
			// DONE //
			//////////	

			endTime = getTime(&timer) - startTime - calibrationTime;

			runTime += endTime;
			//setStatus(1, (uint32_t) runTime);
			write_status(DMA_PTR, &status_addr, loop_counter, 0);
			write_status(DMA_PTR, &status_addr, (uint32_t) startTime, (uint32_t) (startTime >> 32));

			write_status(DMA_PTR, &status_addr, (uint32_t) endTime, (uint32_t) (endTime >> 32));
			write_status(DMA_PTR, &status_addr, (uint32_t) runTime, (uint32_t) (runTime >> 32));

			//setStatus(0, 0xA);
		}
		runTimeFull = getTime(&timer) - runTimeFull - calibrationTime;

		///////////////////
		// Report Cycles //
		///////////////////
		// twice so it's 4 packets in total, resetting a counter.
		write_status(DMA_PTR, &status_addr, (uint32_t) runTime, (uint32_t) (runTime >> 32));
		write_status(DMA_PTR, &status_addr, (uint32_t) runTimeFull, (uint32_t) (runTimeFull >> 32));

		write_status(DMA_PTR, &status_addr, (uint32_t) runTime, (uint32_t) (runTime >> 32));
		write_status(DMA_PTR, &status_addr, (uint32_t) runTimeFull, (uint32_t) (runTimeFull >> 32));
		//setStatus(0, 0xFF);
		////////////////
		//    Exit    //
		////////////////

		cleanup();

	}

	return 0;
}
