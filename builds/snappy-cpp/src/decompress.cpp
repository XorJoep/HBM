#include "decompress.h"

header get_header(std::vector<char> &cmpr_data, uint32_t &byte_offset_in, uint32_t &byte_offset_out) {
	header data;

	std::memcpy(&data.compressed_size, &cmpr_data[byte_offset_in], sizeof(uint32_t));
	std::memcpy(&data.uncompressed_size, &cmpr_data[byte_offset_in + 4], sizeof(uint32_t));

	data.byte_offset_in = byte_offset_in + 8;
	data.byte_offset_out = byte_offset_out;

	byte_offset_in += data.compressed_size + 8;
	byte_offset_out += data.uncompressed_size;
	data.last_header = data.uncompressed_size == 0 || data.compressed_size == 0;

	return data;
}

void decompress(int id, header snap_header, std::vector<char> &cmpr_data, std::shared_ptr<std::vector<char>> &decmpr_data) {
	(void)id; // to suppress unused variable warning

 	decmpr_data->resize(snap_header.uncompressed_size);
 	snappy::RawUncompress(&cmpr_data[snap_header.byte_offset_in],
					   snap_header.compressed_size,
					   decmpr_data->data());
}