import matplotlib.pyplot as plt
import math
import numpy as np
import os
import sys

if len(sys.argv) != 2:
	print(f"incorrect amount of arguments: {sys.argv}")
	exit(2)

result_file = sys.argv[1]

title = f"HBM throughput for Silesia files"
figure_filename = title.replace(' ', '_') + ".pdf"

freq = 250e6

with open(result_file, 'r') as res_file:
	result_lines = [result.split(" ") for result in res_file]
	results = np.array([[int(val) for val in result_line if val.isdigit() ] for result_line in result_lines])
	file_names = [result_line[-1].strip() for result_line in result_lines]

# print(results)
# print(file_names)

i = results[:,0]
cycles = results[:,1]
snappy_cmpr_size_bytes = results[:,2]
uncmpr_size_bytes = results[:,3]
num_times = results[:,4]
num_runners = results[:,5]
chunk_size = results[:,6]
buffer_size = results[:,7]
# file_names = results[:,7]

single_decompress_time = cycles / num_times / freq # = average cycles / freq = time per transaction

total_size = snappy_cmpr_size_bytes + uncmpr_size_bytes
# total_size_l2 = np.array([int(math.log(x, 2)) for x in total_size])

throughput = total_size / single_decompress_time
throughput /= 1024*1024*1024

plt.figure()
_, axs = plt.subplots()
bar_ticks = np.arange(len(results))
file_ticks = ([], [])
for i, file_type in enumerate(set(file_names)):
	N = len(set(num_runners))
	file_ticks[0].append(sum(bar_ticks[i*N:i*N+N])/N)
	file_ticks[1].append(file_type)

width = 1
# print(file_names)
for runner in set(num_runners):
	indices = np.where(num_runners==runner)
	axs.barh(bar_ticks[indices], throughput[indices], width, align='center')

axs.set_xlabel("Throughput (GB/s)")
axs.set_title(title)
axs.set_yticks(file_ticks[0])
axs.set_yticklabels(file_ticks[1])

plt.savefig(figure_filename)

# markerlist = ['o', '^', 's', 'P', '*']

# for i, n_runners in enumerate(set(runners)):
# 	indices = np.where(runners==n_runners)
# 	line, = plt.plot(total_size_l2[indices], throughput[indices], marker=markerlist[i])
# 	line.set_label(f'Active DMA = {n_runners}')

# plt.legend(loc='lower right')

# highest_throughput = max(throughput)

# xticks = [x for x in set(total_size_l2)]

# plt.xticks(xticks)
# plt.grid(True, axis='x')

# plt.axhline(y=highest_throughput, color='r', linestyle='-.')
# plt.text(x=min(total_size_l2[indices]),y=highest_throughput-0.05*highest_throughput,s=f"{highest_throughput:.3f} GB/s")

print(f"Wrote plot to: {figure_filename}")


