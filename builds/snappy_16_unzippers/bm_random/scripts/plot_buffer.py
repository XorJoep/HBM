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

single_decompress_time = cycles / num_times / freq # = average cycles / freq = time per transaction

total_size = snap_cmpr_size_bytes + uncompr_size_bytes
total_size_l2 = np.array([int(math.log(x, 2)) for x in total_size])
buffer_size_l2 = np.array([int(math.log(x, 2)) for x in buffer_size])

throughput = total_size / single_decompress_time
throughput /= 1024*1024*1024

markerlist = ['o', '^', 's', 'P', '*', '<', '>', 'p', 'o', '^', 's', 'P', '*', '<', '>', 'p', 'o', '^', 's', 'P', '*', '<', '>', 'p']

######################################################

title = f"Snappy decompression - random data (2^27) - buffer-size"
file_name = title.replace(' ', '_') + outputfiletype

plt.figure(figsize=(6, 4),)
set_runners = set(num_runners)
used_set_runners = sorted([int(x) for x in set_runners if x in range(17)])
for i, n_runners in enumerate(used_set_runners):
	# if n_runners != 1: break
	indices = np.where(num_runners==n_runners)
	line, = plt.plot(buffer_size_l2[indices], throughput[indices], marker=markerlist[i])
	line.set_label(f'{n_runners}')
highest_throughput = max(throughput)

plt.legend(loc='upper left', fontsize='small', title="N Parallel\nvhsnunzip")



xticks = [x for x in set(buffer_size_l2)]

plt.xticks(xticks)
plt.grid(True, axis='x')

plt.axhline(y=highest_throughput, color='r', linestyle='-.')
plt.text(x=22,y=highest_throughput-0.1,s=f"{highest_throughput:.3f} GB/s")

plt.title(title)
plt.xlabel('log$_{2}$' + "(chunk size) [bytes]")
plt.ylabel("Throughput [GB/s]")

plt.savefig(file_name)

print(f"wrote to: {file_name}")

######################################################

title = f"HBM throughput - random data - per active runners"
file_name = title.replace(' ', '_') + outputfiletype

plt.figure(1)
for i, chunk_size_n in enumerate(set(buffer_size)):
	indices = np.where(buffer_size==chunk_size_n)
	line, = plt.plot(num_runners[indices], throughput[indices], marker=markerlist[i])
	line.set_label(f'{chunk_size_n}')

plt.legend(loc='upper left', fontsize='small', title=" log$_{2}$(Chunk size)")

highest_throughput = max(throughput)

xticks = [x for x in set(num_runners)]

plt.xticks(xticks)
plt.grid(True, axis='x')

plt.axhline(y=highest_throughput, color='r', linestyle='-.')
plt.text(x=max(num_runners[indices]),y=highest_throughput-0.05*highest_throughput,s=f"{highest_throughput:.3f} GB/s")

plt.title(title)
plt.xlabel('Number of active runners [N]')
plt.ylabel("Throughput (GB/s)")

plt.savefig(file_name)

print(f"wrote to: {file_name}")

