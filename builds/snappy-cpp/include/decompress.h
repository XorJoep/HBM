#pragma once
#include <snappy/snappy.h>
#include <vector>
#include <string>
#include <iostream>
#include <unistd.h>
#include <cstring>
#include <memory>

typedef struct header {
  uint32_t uncompressed_size;
  uint32_t compressed_size;
  uint32_t byte_offset_in;
  uint32_t byte_offset_out;
  bool last_header;
} header;

header get_header(std::vector<char> &cmpr_data, uint32_t &byte_offset_in, uint32_t &byte_offset_out);
void decompress(int id, header snap_header, std::vector<char> &cmpr_data, std::shared_ptr<std::vector<char>> &decmpr_data);
