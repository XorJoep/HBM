from pathlib import Path
import sys
from os import urandom
import struct
import snappy
from math import ceil
import cyclic

import random

import argparse

# Parse command line.
def setup_argparse():
	parser = argparse.ArgumentParser(description='custom Snappy framing tool')
	parser.add_argument('-cs', '-chunk_size', type=int, metavar='size',
						default=65536,
						help="size of chunk that data is chunked in")

	parser.add_argument('-l', '-length', type=int, metavar='size_in_bytes',
						default = -1,
						help="size of input data to use in bytes (-1 for full file)")

	parser.add_argument('-f', '-file', type=str, metavar='path_to_file',
						help="File to compress")
	parser.add_argument('-r', '-random', action='store_true',
						help="use random data as input")
	parser.add_argument('-c', '-cyclic', action='store_true',
						help="use cyclic data as input")
	parser.add_argument('-cr', '-cyclic_rep', type=int, metavar='repeat',
						default=8,
						help="amount of times letters are repeated before cycling")

	parser.add_argument('-of', '-compare_file', type=str, metavar='output_name',
						default="uncompressed.out",
						help="File to store partial result for comparing")
	parser.add_argument('-o', '-out', type=str, metavar='output_name',
						default="compressed.sz",
						help="file to write compressed data to")
	parser.add_argument('-rcs', '-random_chunk_size', action='store_true',
						help="use random chunk size")
	parser.add_argument('-cs_min', '-chunk_size_min', type=int, metavar='min_size',
						help="minimum size of a chunk")
	parser.add_argument('-cs_max', '-chunk_size_max', type=int, metavar='max_size',
						help="maximum size of a chunk")
	parser.add_argument('-rs', '-random_seed', type=int, metavar='seed',
						default=0,
						help="set random generator with a seed")
	return parser

def get_data(args_in):
	if args_in.of is not None:
		path_partial_out = Path(args_in.of)

	if args_in.l % 8:
		print("WARNING: length does not align. Microblaze cycles might not be readable.")

	if args_in.c == True:
		if args_in.l <= 0:
			print(f"Error: length was set as non-positive value: {args_in.l}. default = -1")
			exit(2)
		print(f"Using cyclic data with length: {args_in.l}, repetition: {args_in.cr}")
		data = cyclic.cyclic(args_in.l, n=args.cr).encode()
		if args_in.of is not None:
			with open(path_partial_out, 'wb') as outf:
				outf.write(data)
		print(f"Wrote uncompressed cyclic data to {path_partial_out.name}")
	elif args_in.r == True:
		if args_in.l <= 0:
			print(f"Error: length was set as non-positive value: {args_in.l}. default = -1")
			exit(2)
		print(f"Using random data with length: {args_in.l}")
		data = urandom(args_in.l)
		if args_in.of is not None:
			with open(path_partial_out, 'wb') as outf:
				outf.write(data)
		print(f"Wrote uncompressed random data to {path_partial_out.name}")
	elif args_in.f is not None:
		infile_path = Path(args_in.f)
		if not infile_path.is_file():
			print(f"argument of -f is not a file: {infile_path}")
		print(f"Using file data from file: {infile_path}")

		file_size = infile_path.stat().st_size
		if args_in.l < 0:
			print(f"Reading full file with size of: {file_size} bytes")
		elif args_in.l == 0:
			print(f"ERROR: cannot read 0 bytes")
			exit(2)
		elif args_in.l > file_size:
			print(f"ERROR: trying to read more than size of file..")
			print(f"File size: {file_size}, trying to read: {args_in.l}")
			exit(2)
		else:
			print(f"Reading {args_in.l} bytes from file")
		with open(infile_path, 'rb') as fin:
			data = fin.read(args_in.l)
		print(f"Succesfully read {len(data)} bytes")

		if args_in.of is not None:
			with open(path_partial_out, 'wb') as outf:
				outf.write(data)
		print(f"Wrote partial uncompressed file to {path_partial_out.name}")
	else:
		print(f"Neither a file or cyclic length is given as argument. Exiting")
		sys.exit(2)

	if len(data) < args.l:
		print(f"Warning! Data is shorter than length parameter.\nlen(data): {len(data)}, args.l: {args.l}")
	return data

def compress_data(data, chunk_size_min, chunk_size_max):
	offset = 0
	uncompressed_chunks = []
	while offset < len(data):
		size = random.randint(chunk_size_min, chunk_size_max)
		chunk = data[offset:offset + size]
		uncompressed_chunks.append(chunk)
		offset += size

	compressed_chunks = list(map(snappy.compress, uncompressed_chunks))

	return zip(compressed_chunks, uncompressed_chunks), len(compressed_chunks)

args = setup_argparse().parse_args()
data = get_data(args)

random.seed(args.rs)
if args.cs_min is None:
	args.cs_min = args.cs
if args.cs_max is None:
	args.cs_max = args.cs

if args.cs_max < args.cs_min:
	print(f"cs_max ({args.cs_max}) is less than cs_min ({args.cs_min})")
	sys.exit(2)

chunks, num_of_chunks = compress_data(data, args.cs_min, args.cs_max)

ofile_path = Path(args.o)

print(f"Framing {num_of_chunks} chunks into single file named {ofile_path.name}")
with open(ofile_path, 'wb') as ofile:
	for i, (compr_chunk, uncompr_chunk) in enumerate(chunks):
		size_compressed = len(compr_chunk)
		size_uncompressed = len(uncompr_chunk)
		sizes_b = struct.pack("<II", size_compressed, size_uncompressed)

		framed_chunk = sizes_b + compr_chunk

		ofile.write(framed_chunk)

	ofile.write(bytes(8)) # end of file indicator

print(f"Compressed file size: {ofile_path.stat().st_size}")
print(f"compression ratio: {len(data)/ofile_path.stat().st_size:.3f}")
print(f"Wrote compressed file as {ofile_path.name}")