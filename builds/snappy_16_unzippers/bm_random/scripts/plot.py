import matplotlib.pyplot as plt
import math
import numpy as np
import os
import sys

if len(sys.argv) != 2:
	print(f"incorrect amount of arguments: {sys.argv}")
	exit(2)

result_file = sys.argv[1]
outputfiletype = '.pdf'
freq = 250e6

with open(result_file, 'r') as res_file:
	results = np.array([[int(s) for s in result.split() if s.isdigit()] for result in res_file])

i = results[:,0]
cycles = results[:,1]
snap_cmpr_size_bytes = results[:,2]
uncompr_size_bytes = results[:,3]
num_times = results[:,4]
num_runners = results[:,5]
chunk_size = results[:,6]
buffer_size = results[:,7]

chunk_size_limit = 23

single_decompress_time = cycles / num_times / freq # = average cycles / freq = time per transaction

total_size = snap_cmpr_size_bytes + uncompr_size_bytes
total_size_l2 = np.array([int(math.log(x, 2)) for x in total_size])

throughput = total_size / single_decompress_time
throughput /= 1e9

markerlist = ['o', '^', 's', 'P', '*', '<', '>', 'p', 'o', '^', 's', 'P', '*', '<', '>', 'p', 'o', '^', 's', 'P', '*', '<', '>', 'p']

######################################################

title = f"Snappy decompression - random data of size 2$^{2}$$^{7}$ - single vhsnunzip"
file_name = title.replace(' ', '_').replace('$','') + outputfiletype

plt.figure(figsize=(6, 4),)
set_runners = set(num_runners)
# used_set_runners = sorted([int(x) for x in set_runners if x in range(25)])
used_set_runners = [1]
highest_throughputs = []
for i, n_runners in enumerate(used_set_runners):
	# if n_runners != 1: break
	indices = np.where((num_runners==n_runners) & (chunk_size <= chunk_size_limit))
	line, = plt.plot(chunk_size[indices], throughput[indices], marker=markerlist[i])
	line.set_label(f'{n_runners}')
	highest_throughputs.append(max(throughput[indices]))

plt.legend(loc='upper left', fontsize='small', title="N Parallel\nvhsnunzip")



xticks = [x for x in set(chunk_size) if x <= chunk_size_limit]

plt.xticks(xticks)
plt.grid(True, axis='x')
highest_throughput = max(highest_throughputs)

plt.axhline(y=highest_throughput, color='r', linestyle='-.')
plt.text(x=21,y=highest_throughput-0.25,s=f"{highest_throughput:.3f} GB/s")

plt.title(title)
plt.xlabel('log$_{2}$' + "(chunk size) [bytes]")
plt.ylabel("Throughput [GB/s]")

plt.savefig(file_name)

print(f"wrote to: {file_name}")

######################################################

title = f"Snappy decompression -  random data of size 2$^{2}$$^{7}$ - parallel vhsnunzip"
file_name = title.replace(' ', '_').replace('$','') + outputfiletype

plt.figure(figsize=(6, 4),)
set_runners = set(num_runners)
used_set_runners = sorted([int(x) for x in set_runners])
# used_set_runners = [1]
highest_throughputs = []
for i, n_runners in enumerate(used_set_runners):
	# if n_runners != 1: break
	indices = np.where((num_runners==n_runners) & (chunk_size <= chunk_size_limit))
	line, = plt.plot(chunk_size[indices], throughput[indices], marker=markerlist[i])
	line.set_label(f'{n_runners}')
	highest_throughput = max(throughput[indices])

	if n_runners in [8, 12]:
		plt.axhline(y=highest_throughput, color='r', linestyle='-.')
		plt.text(x=15,y=highest_throughput-1.4,s=f"{highest_throughput:.3f} GB/s")
	elif n_runners in [1, 2, 4, 6]:
		plt.axhline(y=highest_throughput, color='r', linestyle='-.')
		plt.text(x=21,y=highest_throughput-1.5,s=f"{highest_throughput:.3f} GB/s")

plt.legend(loc='upper left', fontsize='small', title="N Parallel\nvhsnunzip")

xticks = [x for x in set(chunk_size) if x <= chunk_size_limit]

plt.xticks(xticks)
plt.grid(True, axis='x')
# highest_throughput = max(highest_throughputs)
# plt.axhline(y=highest_throughput, color='r', linestyle='-.')
# plt.text(x=16,y=highest_throughput-1.3,s=f"{highest_throughput:.3f} GB/s")

plt.title(title)
plt.xlabel('log$_{2}$' + "(chunk size) [bytes]")
plt.ylabel("Throughput [GB/s]")

plt.savefig(file_name)

print(f"wrote to: {file_name}")

######################################################

