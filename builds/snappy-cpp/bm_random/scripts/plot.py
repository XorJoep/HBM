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

with open(result_file, 'r') as res_file:
	result_lines = [result.split(" ") for result in res_file]

results = np.array([[int(val) for val in result_line[:-2] if val.isdigit() ] for result_line in result_lines])

if results.size == 0:
	print("Results array is empty.. Benchmark not performed or parsing gone wrong!")
	exit(2)

i = results[:,0]
microseconds = results[:,1]
uncompr_size_bytes = results[:,2]
snap_cmpr_size_bytes = results[:,3]
num_times = results[:,4]
num_runners = results[:,5]
chunk_size = results[:,6]
file_names = np.array([result_line[-1].strip() for result_line in result_lines])

single_decompress_time = (microseconds/1e6) / num_times # = average microseconds / freq = time per transaction

total_size = snap_cmpr_size_bytes + uncompr_size_bytes
total_size_l2 = np.array([math.floor(math.log(x, 2)) for x in total_size])
num_runners_l2 = np.array([math.floor(math.log(x, 2)) for x in num_runners])

throughput = total_size / single_decompress_time
throughput /= 1e9

markerlist = ['o', '^', 's', 'P', '*', '<', '>', 'p', 'x', 'D', '|', '1'] * 2
######################################################

title = f"CPU Snappy decompression - random data of size $2^{2}$$^{7}$ bytes"
file_name = title.replace(' ', '_').replace('$','') + "_perChunk" + outputfiletype

plt.figure(0)
highest_throughputs = []
plotted_runners = [1, 2, 4, 6, 8, 12, 16, 32, 40]
for i, n_runners in enumerate(sorted(set(plotted_runners))):
	indices = np.where((num_runners==n_runners) & (chunk_size < 26-num_runners_l2))
	line, = plt.plot(chunk_size[indices], throughput[indices], marker=markerlist[i])
	line.set_label(f'{n_runners}')
	highest_throughput = max(throughput[indices])
	highest_throughputs.append(highest_throughput)	
	if n_runners in [1, 2, 4, 40]:
		plt.axhline(y=highest_throughput, color='r', linestyle='-.')
		plt.text(x=23,y=highest_throughput+0.1,s=f"{highest_throughput:.3f} GB/s")
	
highest_throughput = max(highest_throughputs)

plt.legend(loc='upper left', fontsize='small', title="Active\nthreads [N]")

xticks = [x for x in set(chunk_size[:-2])]

plt.xticks(xticks)
plt.grid(True, axis='x')

# plt.axhline(y=highest_throughput, color='r', linestyle='-.')
# plt.text(x=22,y=highest_throughput-0.05*highest_throughput,s=f"{highest_throughput:.3f} GB/s")

plt.title(title)
plt.xlabel('log$_{2}$' + "(chunk size) [bytes]")
plt.ylabel("Throughput [GB/s]")

plt.savefig(file_name)

print(f"wrote to: {file_name}")

######################################################

title = f"CPU Snappy decompression - random data - $2^{27}$ bytes"
file_name = title.replace(' ', '_').replace('$','') + "_perRunner" + outputfiletype

plt.figure(1)
for i, chunk_size_n in enumerate(set(chunk_size)):
	indices = np.where(chunk_size==chunk_size_n)
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
plt.xlabel('Number of threads [N]')
plt.ylabel("Throughput (GB/s)")

plt.savefig(file_name)

print(f"wrote to: {file_name}")

