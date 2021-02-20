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
freq = 246e6


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
ratios = np.array([f'{float(result_line[-2].strip()):.2f}' for result_line in result_lines])

single_decompress_time = (microseconds/1e6) / num_times # = average microseconds / freq = time per transaction

total_size = snap_cmpr_size_bytes + uncompr_size_bytes
total_size_l2 = np.array([math.floor(math.log(x, 2)) for x in total_size])

throughput = total_size / single_decompress_time
throughput /= 1e9

markerlist = ['o', '^', 's', 'P', '*', '<', '>', 'p', 'x', 'D', '|', '1']
# 'o', '^', 's', 'P', '*', '<', '>', 'p', 
# 'o', '^', 's', 'P', '*', '<', '>', 'p']

######################################################

# title = f"HBM throughput - random data - per chunk size"
# file_name_out = title.replace(' ', '_') + outputfiletype

# plt.figure(0)
# for i, n_runners in enumerate(sorted(set(num_runners))):
# 	indices = np.where(num_runners==n_runners)
# 	line, = plt.plot(chunk_size[indices], throughput[indices], marker=markerlist[i])
# 	line.set_label(f'{n_runners}')

# plt.legend(loc='upper left', fontsize='small', title="N Parallel\nvhsnunzip")

# highest_throughput = max(throughput)

# xticks = [x for x in set(chunk_size)]

# plt.xticks(xticks)
# plt.grid(True, axis='x')

# plt.axhline(y=highest_throughput, color='r', linestyle='-.')
# plt.text(x=22,y=highest_throughput-0.05*highest_throughput,s=f"{highest_throughput:.3f} GB/s")

# plt.title(title)
# plt.xlabel('log$_{2}$' + "(chunk size) (bytes)")
# plt.ylabel("Throughput (GB/s)")

# plt.savefig(file_name_out)

# print(f"wrote to: {file_name_out}")

######################################################

title = f"CPU Snappy decompression - files of size 2$^{2}$$^{7}$ bytes - chunks 2$^{2}$$^{0}$ bytes"
file_name_out = title.replace(' ', '_').replace('$','').replace('^','') + outputfiletype

_, axs = plt.subplots()
for i, ratio in enumerate(sorted(set(ratios))):
	indices = np.where(ratios==ratio)
	line, = plt.plot(num_runners[indices], throughput[indices], marker=markerlist[i])
	line.set_label(f'{ratio}')
	if i in [0, 1]:
		highest_throughput = max(throughput[indices])
		plt.axhline(y=highest_throughput, color='r', linestyle='-.')
		plt.text(x=0,y=highest_throughput-0.3,s=f"{highest_throughput:.3f} GB/s")
	if i == 7:
		highest_throughput = throughput[indices][5]
		plt.axhline(y=highest_throughput, color='r', linestyle='-.')
		plt.text(x=20,y=highest_throughput-0.3,s=f"{highest_throughput:.3f} GB/s")


plt.legend(loc='lower right', fontsize='small', title="Ratio of file size uncompressed/compressed", ncol=3)

highest_throughput = max(throughput)

xticks = [x for x in set(num_runners)]

plt.xticks(xticks)
plt.grid(True, axis='x')

# plt.axhline(y=highest_throughput, color='r', linestyle='-.')
# plt.text(x=max(num_runners[indices]),y=highest_throughput-0.05*highest_throughput,s=f"{highest_throughput:.3f} GB/s")

plt.title(title)
plt.xlabel('Number of threads [N]')
plt.ylabel("Throughput [GB/s]")

plt.savefig(file_name_out)

print(f"wrote to: {file_name_out}")

