#include <string>
#include <iostream>
#include <unistd.h>
#include <chrono>
#include <mutex>
#include <functional>
#include <thread>
#include <vector>
#include <fstream>
#include <memory>

#include <ctpl_stl.h>
#include "decompress.h"

using namespace std;

/*
** Reads a binary file from disk and stores it in memory as a vector
*/
vector<char> read_file(const string &file_path) {
  cout << "Reading file at: [ " << file_path.c_str() << " ] " << endl;

  if (access(file_path.c_str(), R_OK) != 0) {
    printf("ERROR: %s file not available!\n", file_path.c_str());
    exit(EXIT_FAILURE);
  }
  ifstream bin_file(file_path.c_str(), ifstream::binary); // setupstream
  bin_file.seekg(0, bin_file.end); // set pointer to end
  auto nb = bin_file.tellg(); // size is current offset
  bin_file.seekg(0, bin_file.beg); // return pointer to begin
  vector<char> buf; // declare buffer
  buf.resize(nb); // allocate buffer
  bin_file.read(reinterpret_cast<char *>(buf.data()), nb); // read file with known size into buffer
  
  return buf;
}

/*
** Flattens a 2D vector into a 1D vector
*/
template<typename T>
vector<T> flatten(const vector<shared_ptr<vector<T>>> &orig)
{   
    vector<T> ret;
    for(const auto &v: orig)
        ret.insert(ret.end(), v->begin(), v->end());                                                                                         
    return ret;
}

/*
** Compares decompressed to uncompressed data
*/
bool verify(vector<char> &decompressed_data, vector<char> &uncompressed_data) {
  int mismatched = 0;
  if(decompressed_data != uncompressed_data) {
    if(uncompressed_data.size() != decompressed_data.size()){
      cout << "Uncompressed vector is not the same size as decompressed vector:" << endl;
      cout << "decompressed_data.size() = " << decompressed_data.size() << endl;
      cout << "uncompressed_data.size() = " << uncompressed_data.size() << endl;
      return false;
    }

    for (uint ii = 0; ii < min(uncompressed_data.size(), decompressed_data.size()); ++ii) {
      if (decompressed_data[ii] != uncompressed_data[ii]) {
        cout << "Mismatch between decompressed and uncompressed data:" << endl;
        cout << " decompressed[ " << ii << " ] - " << hex << (int) decompressed_data[ii] << endl;
        cout << " uncompressed[ " << ii << " ] - " << hex << (int) uncompressed_data[ii] << endl;
        mismatched++;
      }
      if(mismatched>=3){
        break;
      }
    }
  }
  else{
    return true;
  }
  cout << "Not the same vector, although data looks correct.." << endl;
  return false;
}

/*
** Creates a report on the benchmark, writing used parameters and resulting time
*/
void report(long decompress_time_in_usec, 
            int uncompressed_size_bytes, 
            int compressed_size_bytes, 
            int num_times, 
            int num_active_threads,
            int chunk_size,
            double ratio,
            string uncompressed_file_basename) {
    cout << "Throughput: " << (double) (compressed_size_bytes + uncompressed_size_bytes)
                                       / (1024*1024*1024) 
                                       / (decompress_time_in_usec / 1e6 / num_times)
                          << " GB/s" << endl;
    cout << "###" << endl;
    cout << decompress_time_in_usec << " ";
    cout << uncompressed_size_bytes << " ";
    cout << compressed_size_bytes << " ";
    cout << num_times << " ";
    cout << num_active_threads << " ";
    cout << chunk_size << " ";
    cout << ratio << " ";
    cout << uncompressed_file_basename << endl;
    cout << "###" << endl;
}

/*
** Benchmarks multithreaded Snappy decompression
*/
int main(int argc, char **argv) {
  /*
  **    Parse commandline arguments
  */
  int args_expected = 7;
  if (argc != args_expected) {
    cout << "Expected " << args_expected << " arguments." << endl;
    cout << "Got only " << argc << " arguments:" << endl;
    for (int i = 0; i < argc; ++i) {
      cout << "Arg [" << i << "]: " << argv[i] << endl;
    }
    return EXIT_FAILURE;
  }

  string compressed_file = argv[1];
  string uncompressed_file = argv[2];
  int num_active_threads = strtol(argv[3], NULL, 10);;
  int num_times = strtol(argv[4], NULL, 10);;
  int chunk_size = strtol(argv[5], NULL, 10);;
  double ratio = stod(argv[6]);;

  string uncompressed_file_basename = uncompressed_file.substr(
                                        uncompressed_file.find_last_of("/\\") + 1);

  cout << "From arguments: " << endl;
  cout << "  compressed_file: [ " << compressed_file << " ]" << endl;
  cout << "  uncompressed_file: [ " << uncompressed_file << " ]" << endl;
  cout << "  num_active_threads: [ " << num_active_threads << " ]" << endl;
  cout << "  num_times: [ " << num_times << " ]" << endl;
  cout << "  chunk_size: [ " << chunk_size << " ]" << endl;
  cout << "----------------------" << endl;

  /*
  **    Load compressed file into memory
  */
  auto compressed_data = read_file(compressed_file);
  int compressed_size_bytes = compressed_data.size();
  cout << "Size of compressed file: " << compressed_size_bytes << " (bytes)" << endl;

  /*
  **    Load uncompressed file into memory
  */ 
  auto uncompressed_data = read_file(uncompressed_file);
  int uncompressed_size_bytes = uncompressed_data.size();
  cout << "Size of uncompressed file: " << uncompressed_size_bytes << " (bytes)" << endl;

  /*
  **    Allocate output
  */
  cout << "Allocating output.. " << flush;
  vector<shared_ptr<vector<char>>> decompressed_data_parts;
  cout << "Done!" << endl;

  /*
  **    Setup thread pool
  */
  int max_thread_n = std::thread::hardware_concurrency();
  cout << "number of threads: [ " << num_active_threads << " ]"<< endl;
  cout << "Setting up thread pool.. " << flush;
  if(num_active_threads > max_thread_n){
    cout << endl;
    cout << "Max number of threads is: [ " << max_thread_n << " ]" << endl;
    cout << "Exiting.." << endl;
    exit(EXIT_FAILURE);
  }

  ctpl::thread_pool pool(num_active_threads);
  cout << "Done!" << endl;

  /*
   *		Decompression main loop
  */
  cout << "Performing decompression.. ";

  auto timer_start = chrono::high_resolution_clock::now();
  for (int loop_count = 0; loop_count < num_times; ++loop_count) {
    uint32_t byte_offset_in = 0;
    uint32_t byte_offset_out = 0;

    // clear vectors from previous loops -> the shared_ptrs should now destroy themselves
    decompressed_data_parts.clear();

    // fill pool with decompression tasks 
    while(true) {
      // obtain info from chunk header
     	header snap_header = get_header(compressed_data, byte_offset_in, byte_offset_out);
    	if(snap_header.last_header == 1) { // if final chunk is found, wait for threads to finish
    		break;
    	}

      // create a (shared) pointer to a vector where thread can store output
      // shared so it lives until the partial data is used
      auto partial_decompressed_data_PTR = make_shared<vector<char>>();

      // store partial decompressed data location for final result
      decompressed_data_parts.push_back(partial_decompressed_data_PTR);

      // push decompression task to pool
    	pool.push(decompress, snap_header, ref(compressed_data), partial_decompressed_data_PTR);
    }

    // wait for all threads/tasks to finish
    while (pool.busy()); 
  }
  cout << "Done!" << endl;

  /*
   *    Calculate decompression time
  */
  auto timer_end = chrono::high_resolution_clock::now();
  auto timer_duration = chrono::duration<double>(timer_end - timer_start);
  long decompress_time_in_usec = chrono::duration_cast<chrono::microseconds>(timer_duration).count();
  cout << "Duration: " << decompress_time_in_usec << " (us)" << endl;

  /*
   *    Flatten 2D vector filled with partial decompressions to 1D vector
  */
  cout << "Flattening 2D partial decompressed data vector into 1D vector.. " << flush;
  vector<char> decompressed_data = flatten(decompressed_data_parts);
  cout << "Done!" << endl;

  /*
   *    Compare decompressed data to uncompressed data
  */
  cout << "Comparing decompressed to uncompressed data.. " << flush;
  bool succesful_decompression = verify(decompressed_data, uncompressed_data);
  cout << "Done!" << endl;

  /*
   *    Write used parameters and result to out
  */
  if(succesful_decompression) {
    cout << "TEST PASSED!" << endl;
    report(decompress_time_in_usec, 
           uncompressed_size_bytes, 
           compressed_size_bytes, 
           num_times, 
           num_active_threads,
           chunk_size,
           ratio,
           uncompressed_file_basename);
  }
  else {
    cout << "FAILED!" << endl;
  }

	return succesful_decompression ? EXIT_FAILURE : EXIT_SUCCESS;
}

