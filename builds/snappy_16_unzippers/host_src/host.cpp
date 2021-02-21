/**********
Copyright (c) 2020, Xilinx, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
may be used to endorse or promote products derived from this software
without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**********/

#include "xcl2.hpp"
#include <algorithm>
#include <numeric>
#include <vector>
#include <chrono>
#include <unistd.h>
#include <random>     // mt19937 and uniform_int_distribution
#include <functional> // bind

#define NUM_KERNEL 1
#define NUM_DMA 16
#define BUS_SIZE_BYTES 8


// Number of HBM Banks required
#define MAX_HBM_BANKCOUNT 32
#define BANK_NAME(n) n | XCL_MEM_TOPOLOGY
const int bank[MAX_HBM_BANKCOUNT] = {
    BANK_NAME(0),  BANK_NAME(1),  BANK_NAME(2),  BANK_NAME(3),  BANK_NAME(4),
    BANK_NAME(5),  BANK_NAME(6),  BANK_NAME(7),  BANK_NAME(8),  BANK_NAME(9),
    BANK_NAME(10), BANK_NAME(11), BANK_NAME(12), BANK_NAME(13), BANK_NAME(14),
    BANK_NAME(15), BANK_NAME(16), BANK_NAME(17), BANK_NAME(18), BANK_NAME(19),
    BANK_NAME(20), BANK_NAME(21), BANK_NAME(22), BANK_NAME(23), BANK_NAME(24),
    BANK_NAME(25), BANK_NAME(26), BANK_NAME(27), BANK_NAME(28), BANK_NAME(29),
    BANK_NAME(30), BANK_NAME(31)};

const int frequency = 250e6;

std::uint64_t get_buf_value(std::vector<uint32_t, aligned_allocator<uint32_t>> &buffer, uint32_t index) {
  return ((std::uint64_t) buffer[2*index+1] << 32) | buffer[2*index];
}

///////////////////////////Calculate Duration///////////////////////
void report_kernel(std::vector<uint32_t, aligned_allocator<uint32_t>> &status_buffer, 
    int snap_cmpr_size_bytes, 
    int uncompr_size_bytes, 
    int num_times, 
    int num_runners,
    int chunk_size, 
    int buffer_size,
    std::string file_name,
    double ratio) {

  for (int loop_counter = 0; loop_counter < num_times; loop_counter++) {
    std::uint64_t loopCounter = get_buf_value(status_buffer, 0 + loop_counter*4);
    // uint64_t hdr_list_ptr = get_buf_value(status_buffer, 1 + loop_counter*4*2);
    std::uint64_t endTime = get_buf_value(status_buffer, 2 + loop_counter*4);
    std::uint64_t runTime = get_buf_value(status_buffer, 3 + loop_counter*4);
    std::cout << loopCounter << " - endCycle: " << endTime << " - runTime: " << runTime << " - " << (double) runTime/frequency << " s"<< std::endl; 
  }

  std::uint64_t total_transfer_time = get_buf_value(status_buffer, num_times*4);
  std::uint64_t total_runtime = get_buf_value(status_buffer, 1+num_times*4);

  std::cout << "total_transfer_time: "  << total_transfer_time << std::endl;
  std::cout << "total_runtime: "  << total_runtime << std::endl;
  
  double throughput = (double) (uncompr_size_bytes + snap_cmpr_size_bytes) * num_times * frequency / (1024*1024*1024 * total_transfer_time);

  std::cout << "Time: " << (double) total_transfer_time/frequency << " s" << std::endl; 
  std::cout << "Throughput: " << throughput << " GB/s" << std::endl;
  std::cout << "###" << std::endl;
  std::cout << total_transfer_time << " ";
  std::cout << snap_cmpr_size_bytes << " ";
  std::cout << uncompr_size_bytes << " ";
  std::cout << num_times << " ";
  std::cout << num_runners << " ";
  std::cout << chunk_size << " ";
  std::cout << buffer_size << " ";
  std::cout << ratio << " ";
  std::cout << file_name << std::endl;
  std::cout << "###" << std::endl;
}

///////////////////VERIFY FUNCTION/////////////////////
bool verify(std::vector<int, aligned_allocator<int>> &sw_results, std::vector<int, aligned_allocator<int>> &hw_results, int size) {
  for (int i = 0; i < size; i++) {
    if (sw_results[i] != hw_results[i]) {
      std::cout << "error: Result mismatch" << std::endl;
      std::cout << "i = " << i << " CPU result = " << sw_results[i]
                << " Device result = " << hw_results[i]
                << " Difference: " << sw_results[i]-hw_results[i] << std::endl;   
      std::cout << std::endl;
      return 1;
    }
  }
  return 0;
}

int main(int argc, char **argv) {
  int args_expected = 12;
  if (argc != args_expected) {
    std::cout << "Expected " << args_expected << " arguments." << std::endl;
    std::cout << "Got only " << argc << " arguments:" << std::endl;
    for (int i = 0; i < argc; ++i) {
      std::cout << "Arg [" << i << "]: " << argv[i] << std::endl;
    }
    return EXIT_FAILURE;
  }

  std::cout << "----------------------" << std::endl;
  std::cout << "-- HOST bin started --" << std::endl;
  std::cout << "----------------------" << std::endl;

  /*
  **    PARSE COMMAND LINE ARGUMENTS
  */

  std::string binaryFile = argv[1];
  std::string kernel_name = argv[2];
  int num_times = strtol(argv[3], NULL, 10);
  int sleep_time = strtol(argv[4], NULL, 10);

  int chunk_size = strtol(argv[5], NULL, 10);
  int buffer_size = strtol(argv[6], NULL, 10);

  std::string snappyCompressedFile = argv[7];
  std::string snappyDecompressedFile = argv[8];
  std::string file_name = argv[9];

  int num_runners = strtol(argv[10], NULL, 10);
  double ratio = std::stod(argv[11]);

  std::cout << "From arguments: " << std::endl;
  std::cout << "\t kernel File: [ " << binaryFile << " ]" << std::endl;
  std::cout << "\t kernel name: [ " << kernel_name << " ]" << std::endl;
  std::cout << "\t Num Times: [ " << num_times << " ]" << std::endl;
  std::cout << "\t Chunk Size: [ " << chunk_size << " ]" << std::endl;
  std::cout << "\t Sleep time: [ " << sleep_time << " ]" << std::endl;
  std::cout << "\t Buffer size: [ " << buffer_size << " ]" << std::endl;
  std::cout << "\t Snappy Compressed File: [ " << snappyCompressedFile << " ]" << std::endl;
  std::cout << "\t Snappy Decompressed File: [ " << snappyDecompressedFile << " ]" << std::endl;
  std::cout << "\t file_name: [ " << file_name << " ]" << std::endl;
  std::cout << "\t num_runners: [ " << num_runners << " ]" << std::endl;
  std::cout << "\t ratio: [ " << ratio << " ]" << std::endl;
  std::cout << "----------------------" << std::endl;

  int status_messages = 8;
  int status_integers = status_messages * 1;

  auto CMP_Buf = xcl::read_binary_file(snappyCompressedFile);
  int CMP_Size_bytes = CMP_Buf.size();
  std::cout << "Size of compressed file: " << CMP_Size_bytes << " (bytes)" << std::endl;
  
  auto DEC_Buf = xcl::read_binary_file(snappyDecompressedFile);
  int DEC_Size_bytes = DEC_Buf.size();
  int DEC_Size_ints = DEC_Size_bytes / 4;
  std::cout << "Size of decompressed file: " << DEC_Size_bytes << " (bytes)" << std::endl;

  cl_int err;
  cl::Context context;
  cl::Kernel krnl_vector_add;
  cl::CommandQueue q;
  cl::Event ev;
  std::vector<cl::Kernel> kernels(NUM_KERNEL);

  /*
  **    PROGRAM DEVICE
  */
  

  // OPENCL HOST CODE AREA START
  // get_xil_devices() is a utility API which will find the xilinx
  // platforms and will return list of devices connected to Xilinx platform
  auto devices = xcl::get_xil_devices();
  // read_binary_file() is a utility API which will load the binaryFile
  // and will return the pointer to file buffer.
  auto xclbinBuf = xcl::read_binary_file(binaryFile);
  cl::Program::Binaries bins{{xclbinBuf.data(), xclbinBuf.size()}};
  int valid_device = 0;
  for (unsigned int i = 1; i < devices.size(); i++) {
    auto device = devices[i];
    // Creating Context and Command Queue for selected Device
    OCL_CHECK(err, context = cl::Context(device, NULL, NULL, NULL, &err));
    OCL_CHECK(err, q = cl::CommandQueue(context, device,
                                        CL_QUEUE_PROFILING_ENABLE, &err));
    std::cout << "Trying to program device [" << i
              << "]: " << device.getInfo<CL_DEVICE_NAME>() << std::endl;
    cl::Program program(context, {device}, bins, NULL, &err);
    if (err != CL_SUCCESS) {
      std::cout << "Failed to program device[" << i << "] with xclbin file!\n";
    } else {
      std::cout << "Device[" << i << "]: program successful!\n";
      std::cout << "Creating " << NUM_KERNEL << " kernels\n";
      // Creating Kernel object using Compute unit names
      for (int i = 0; i < NUM_KERNEL; i++) {
        std::string cu_id = std::to_string(i + 1);
        std::string krnl_name_full =
            kernel_name + ":{" + kernel_name + "_" + cu_id + "}";

        // printf("Creating a kernel [%s] for CU(%d)\n", krnl_name_full.c_str(),
        //        i + 1);

        // Here Kernel object is created by specifying kernel name along with
        // compute unit.
        // For such case, this kernel object can only access the specific
        // Compute unit

        OCL_CHECK(err,
                  kernels[i] = cl::Kernel(program, krnl_name_full.c_str(), &err));
      }
      valid_device++;
      break; // we break because we found a valid device
    }
  }
  if (valid_device == 0) {
    std::cout << "Failed to program any device found, exit!\n";
    exit(EXIT_FAILURE);
  }

 /*
  **    SETUP VECTORS
  */
  std::cout << "----------------------" << std::endl;
  std::cout << "Setting up buffers... " << std::flush;

  std::vector<unsigned char, aligned_allocator<unsigned char>> source_in(CMP_Size_bytes);
  std::vector<int, aligned_allocator<int>> source_sw_results(DEC_Size_ints);

  std::vector<int, aligned_allocator<int>> source_hw_results[NUM_KERNEL];
  std::vector<uint32_t, aligned_allocator<uint32_t>> source_status[NUM_KERNEL];

  // create vectors for results from fpga
  for (int i = 0; i < NUM_KERNEL; i++) {
    source_hw_results[i].resize(DEC_Size_ints);
    std::fill(source_hw_results[i].begin(), source_hw_results[i].end(), 0);

    source_status[i].resize(num_times * sizeof(int) * 2 + status_integers);
    std::fill(source_status[i].begin(), source_status[i].end(), 0);
  }
 
  // create input
  // source_in = create_random_data(source_in); // random
  memcpy( source_in.data(), CMP_Buf.data(), CMP_Size_bytes );
  // create software result
  memcpy( source_sw_results.data(), DEC_Buf.data(), DEC_Size_bytes);

  // for (int i = 0; i < dec_size_ints; i++) {
  //   source_sw_results[i] = source_in[i] + 1;
  // }

  /*
  **    SETUP BUFFERS
  */

  std::vector<cl_mem_ext_ptr_t> inBufExt(NUM_KERNEL);
  std::vector<cl_mem_ext_ptr_t> outBufExt(NUM_KERNEL);
  std::vector<cl_mem_ext_ptr_t> StatusBufExt(NUM_KERNEL);

  std::vector<cl::Buffer> buffer_input(NUM_KERNEL);
  std::vector<cl::Buffer> buffer_output(NUM_KERNEL);
  std::vector<cl::Buffer> buffer_status(NUM_KERNEL);

///////////////////////////////////////////////// TODO
  for (int i = 0; i < NUM_KERNEL; i++) {
    inBufExt[i].obj = source_in.data();
    inBufExt[i].param = 0;
    inBufExt[i].flags = bank[0];

    outBufExt[i].obj = source_hw_results[i].data();
    outBufExt[i].param = 0;
    outBufExt[i].flags = bank[4];

    StatusBufExt[i].obj = source_status[i].data();
    StatusBufExt[i].param = 0;
    StatusBufExt[i].flags = bank[5];
  }

  std::cout << "Done!" << std::endl;


  /*
  **    WRITE BUFFERS
  */

  // These commands will allocate memory on the FPGA. The cl::Buffer objects can
  // be used to reference the memory locations on the device.
  // Creating Buffers
  std::cout << "Buffers being copied to device...";
  for (int i = 0; i < NUM_KERNEL; i++) {
    OCL_CHECK(err, buffer_input[i] = cl::Buffer(
                       context, CL_MEM_READ_ONLY | CL_MEM_EXT_PTR_XILINX |
                                    CL_MEM_USE_HOST_PTR,
                       (cl::size_type) CMP_Size_bytes, 
                       &inBufExt[i], &err));

    // N_integers + status_size since it is appended
    OCL_CHECK(err, buffer_output[i] = cl::Buffer(
                       context, CL_MEM_WRITE_ONLY | CL_MEM_EXT_PTR_XILINX |
                                    CL_MEM_USE_HOST_PTR,
                        (cl::size_type) DEC_Size_bytes, 
                        &outBufExt[i], &err));

    OCL_CHECK(err, buffer_status[i] = cl::Buffer(
                       context, CL_MEM_WRITE_ONLY | CL_MEM_EXT_PTR_XILINX |
                                    CL_MEM_USE_HOST_PTR,
                        (cl::size_type) (sizeof(uint32_t) * (num_times * 8 + status_integers)), 
                        &StatusBufExt[i], &err));
  }

  // Copy input data to Device Global Memory
  for (int i = 0; i < NUM_KERNEL; i++) {
    OCL_CHECK(err, err = q.enqueueMigrateMemObjects(
                       {buffer_input[i]},
                       0 /* 0 means from host*/));
  }
  q.finish();
  std::cout << "Done!" << std::endl;

  /*
  **    INVOKE KERNELS
  */

  std::chrono::duration<double> kernel_time(0);

  std::cout << "--------------------" << std::endl;
  std::cout << "Invoking kernels... " << std::flush;
    auto kernel_start = std::chrono::high_resolution_clock::now();
  for (int i = 0; i < NUM_KERNEL; i++) {
    // Setting the k_vadd Arguments
    OCL_CHECK(err, err = kernels[i].setArg(0, num_times));
    OCL_CHECK(err, err = kernels[i].setArg(1, buffer_size));
    OCL_CHECK(err, err = kernels[i].setArg(2, num_runners));
    OCL_CHECK(err, err = kernels[i].setArg(3, 0)); // not used
    OCL_CHECK(err, err = kernels[i].setArg(4, buffer_input[i]));
    OCL_CHECK(err, err = kernels[i].setArg(5, buffer_output[i]));
    for (int j = 0; j < NUM_DMA - 1; ++j) {
      OCL_CHECK(err, err = kernels[i].setArg(6 + j*2, buffer_input[i]));
      OCL_CHECK(err, err = kernels[i].setArg(7 + j*2, buffer_output[i]));
    }
    OCL_CHECK(err, err = kernels[i].setArg(36, buffer_status[i]));
    // Invoking the kernel
    OCL_CHECK(err, err = q.enqueueTask(kernels[i]));
  }
  std::cout << "Done!" << std::endl;

  std::cout << "--------------------" << std::endl;
  std::cout << "Waiting for kernels to finish... " << std::flush;
  q.finish();
  std::cout << "Done!" << std::endl;
  std::cout << "Waiting " << sleep_time << " more seconds... " << std::flush;
  sleep(sleep_time);
  std::cout << "Done!" << std::endl;

  double kernel_time_in_sec = 0;
  auto kernel_end = std::chrono::high_resolution_clock::now();
  kernel_time = std::chrono::duration<double>(kernel_end - kernel_start);
  kernel_time_in_sec = kernel_time.count();
  // kernel_time_in_sec /= NUM_KERNEL;


  std::cout << "(Kernel took: " << kernel_time_in_sec << " s [LIES])" <<std::endl;

  /*
  **    READ BUFFERS
  */
  // Copy Result from Device Global Memory to Host Local Memory
  for (int i = 0; i < NUM_KERNEL; i++) {
    OCL_CHECK(err, err = q.enqueueMigrateMemObjects(
                       {buffer_output[i], buffer_status[i]},
                       CL_MIGRATE_MEM_OBJECT_HOST));
  }
  q.finish();


  /*
  **    REPORT RESULTS
  */
  bool match = 0;
  for (int i = 0; i < NUM_KERNEL; i++) { // returns 0 if matches, returns 1 if fails.
    match += verify(source_sw_results, source_hw_results[i], DEC_Size_ints);
  }
  std::cout << "TEST " << (match ? "FAILED" : "PASSED") << std::endl;

  for (int i = 0; i < NUM_KERNEL; i++) {
    report_kernel(source_status[i], CMP_Size_bytes, DEC_Size_bytes, num_times, num_runners, chunk_size, buffer_size, file_name, ratio);
  }

  // report_full_throughput(source_status, CMP_Size_ints, DEC_Size_ints, chunk_size, num_times, buffer_size);

  return match ? EXIT_FAILURE : EXIT_SUCCESS;
}
