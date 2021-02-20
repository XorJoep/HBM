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
	// status pointer is last pointer ->
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



void write_status(dma_pt dma, uint32_t value_low, uint32_t value_high) {
	channel_pt s2mm_channel = &(dma->s2mm);

	while(channel_IsBusy(s2mm_channel));
	write_stream(value_low, 0); // write value to microblaze output stream
	write_stream(value_high, 0); // write value to microblaze output stream
	channel_setBaseAddr(s2mm_channel, kernel_sts_ptr);
	channel_setPacketSize(s2mm_channel, 8);
	channel_start(s2mm_channel);
	kernel_sts_ptr += 8;
	while(channel_IsBusy(s2mm_channel));
}

void get_headers(dma_pt dma, XAxis_Switch *AxisSwitch, List * header_list, uint32_t amount_of_headers) {
	snap_header data;
	channel_pt mm2s_channel = &(dma->mm2s);
	
	while(DMAisBusy(dma)); // wait for dma to become available

	setSwitch_mblaze(AxisSwitch);

	for (int ii = 0; ii < amount_of_headers; ++ii)
	{
		channel_setBaseAddr(mm2s_channel, header_list->base_addr_in);

		channel_setPacketSize(mm2s_channel, 8);
		channel_start(mm2s_channel);

		data.compressed_size = read_stream(0);
		data.uncompressed_size = read_stream(0);
		data.addr_in = header_list->base_addr_in + 8;
		data.addr_out = header_list->base_addr_out;

		header_list->base_addr_in += data.compressed_size + 8;
		header_list->base_addr_out += data.uncompressed_size;

		while(channel_IsBusy(mm2s_channel));
		
		addToList(data, header_list);

		if(data.compressed_size == 0 && data.uncompressed_size == 0) {
			break;
		}
	}

	setSwitch_unzip(AxisSwitch);
}

dma_t DMAS[NUM_M_AXI];
XTmrCtr timer;
XAxis_Switch axis_switch;

int main()
{
	XStatus error = XST_SUCCESS;

	dma_pt DMA_PTR;
	dma_pt DMA_SWITCH_PTR = &DMAS[0];

	snap_header_pt header_data;

	uint64_t startTime;
	uint64_t endTime;
	uint64_t calibrationTime;
	uint64_t runTime;
	uint64_t runTimeFull;
//	uint64_t status_addr;

	uint32_t numTimes;
	uint32_t snap_header_buffer_size;
	uint32_t numRunners;

	List * header_list_pt;

	///////////////////////////////////////////
	// SETUP GPIO + KERNEL CONTROL REGISTERS //
	///////////////////////////////////////////

	setup_control();

	//////////////////////
	// SETUP PERIPHEALS //
	//////////////////////
	
	calibrationTime = timer_init(&timer);

	switch_init(&axis_switch);

	for (uint32_t ii = 0; ii < NUM_M_AXI; ++ii)
		error |= dma_init(&DMAS[ii], ii);

	while (error == XST_SUCCESS) {
		//setStatus(0, 1);
		wait_for_start_signal(); // blocks until start signal from host is given
		//setStatus(0, 2);
		set_kernel_args();
		//setStatus(0, 3);

		numTimes = kernel_args_scalar[0];
		snap_header_buffer_size = kernel_args_scalar[1];
		numRunners = kernel_args_scalar[2];
		
		///////////////////
		// MAIN FUNCTION //
		///////////////////

		//setStatus(0, 4);
		timer_reset(&timer);
		runTime = 0;
		runTimeFull = getTime(&timer);
		//setStatus(0, 5);
		for (uint32_t loop_counter = 0; loop_counter < numTimes; ++loop_counter)	{

			/////////////////////////
			// SETUP DMA + CHANNEL //
			/////////////////////////

			for (uint32_t jj = 0; jj < numRunners; ++jj) {
				dma_reset(&DMAS[jj]);
			}
			//setStatus(0, 6);
			startTime = getTime(&timer);
			
			//////////////////////////
			// OBTAIN CHUNK HEADERS //
			//////////////////////////

			header_list_pt = makelist(kernel_args_ptr[0][0], kernel_args_ptr[0][1]);
			get_headers(DMA_SWITCH_PTR, &axis_switch, header_list_pt, snap_header_buffer_size);
			//setStatus(0, 7);

			///////////////////////////
			// PROCESS CHUNK HEADERS //
			///////////////////////////	

			header_data = get_next_header(header_list_pt);
			//setStatus(0, 8);
			while(header_data->uncompressed_size != 0 && header_data->compressed_size != 0) {
				DMA_PTR = get_idle_dma(DMAS, numRunners); // blocks until available dma is found
				//setStatus(1, 1);
				startDMA(DMA_PTR, header_data); // configures and starts DMA
				//setStatus(1, 3);
				advance_tail(header_list_pt); // advances the buffer to the next header
				//setStatus(1, 4);
				if(header_list_pt->tail == NULL) { // if the next header isn't available we read new headers
					//setStatus(1, 10);
					get_headers(DMA_SWITCH_PTR, &axis_switch, header_list_pt, snap_header_buffer_size);
				}

				header_data = get_next_header(header_list_pt); // get the next header
				//setStatus(1, 5);

			}
			//setStatus(0, 9);
			// wait for running dmas to finish

			// status_addr = header_data->addr_out;
			//setStatus(0, 10);

			wait_dmas_done(DMAS, numRunners);
			destroylist(header_list_pt);
			//setStatus(0, 11);
			//////////
			// DONE //
			//////////	

			endTime = getTime(&timer) - startTime - calibrationTime;
			runTime += endTime;
			//setStatus(1, (uint32_t) runTime);
			write_status(DMA_SWITCH_PTR, loop_counter, 0);
			write_status(DMA_SWITCH_PTR, (uint32_t) startTime, (uint32_t) (startTime >> 32));

			write_status(DMA_SWITCH_PTR, (uint32_t) endTime, (uint32_t) (endTime >> 32));
			write_status(DMA_SWITCH_PTR, (uint32_t) runTime, (uint32_t) (runTime >> 32));

		}
		runTimeFull = getTime(&timer) - runTimeFull - calibrationTime;
		//setStatus(2, (uint32_t) runTimeFull);
		///////////////////
		// Report Cycles //
		///////////////////
		// twice so it's 4 packets in total, resetting a counter.
		write_status(DMA_SWITCH_PTR, (uint32_t) runTime, (uint32_t) (runTime >> 32));
		write_status(DMA_SWITCH_PTR, (uint32_t) runTimeFull, (uint32_t) (runTimeFull >> 32));

		write_status(DMA_SWITCH_PTR, (uint32_t) runTime, (uint32_t) (runTime >> 32));
		write_status(DMA_SWITCH_PTR, (uint32_t) runTimeFull, (uint32_t) (runTimeFull >> 32));
		//setStatus(0, 8);
		////////////////
		//    Exit    //
		////////////////

		cleanup();

	}

	//setStatus(3, error);
//	cleanup();

	return 0;
}
