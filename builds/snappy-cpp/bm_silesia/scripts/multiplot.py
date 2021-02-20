import matplotlib.pyplot as plt
import math
import numpy as np
import os
import sys

if len(sys.argv) != 3:
	print(f"incorrect amount of arguments: {sys.argv}")
	exit(2)

output_filename = "CPU_Snappy_Silesia_dualplot.pdf"

result_file_read = sys.argv[1]
result_file_write = sys.argv[2]

title_read = f"chunk size = 2$^1$$^6$"
title_write = f"chunk size = 2$^2$$^0$"

freq = 250e6

plt.figure(0)
fig, axs = plt.subplots(1, 2)
fig.suptitle("CPU Snappy decompression - Silesia Corpus - multithreaded")

markerlist = ['o', '^', 's', 'P', '*', '<', '>', 'p', 'x', 'D', '|', '1']

for subfig_n, (result_file, title) in enumerate([(result_file_read, title_read), (result_file_write, title_write)]):

	with open(result_file, 'r') as res_file:
		result_lines = [result.split(" ") for result in res_file]

	results = np.array([[int(val) for val in result_line if val.isdigit() ] for result_line in result_lines])

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
	total_size_l2 = np.array([int(math.log(x, 2)) for x in total_size])

	throughput = total_size / single_decompress_time
	throughput /= 1e9

	for i, file_name in enumerate(sorted(set(file_names))):
		indices = np.where(file_names==file_name)
		line, = axs[subfig_n].plot(num_runners[indices], throughput[indices], marker=markerlist[i])
		line.set_label(f'{file_name}')
		print(f"{file_name} {max(throughput[indices])}")

	# axs[subfig_n].legend(loc='lower right')

	highest_throughput = max(throughput)

	axs[subfig_n].grid(True, axis='x')

	axs[subfig_n].axhline(y=highest_throughput, color='r', linestyle='-.')
	axs[subfig_n].text(x=24,y=highest_throughput+0.03,s=f"{highest_throughput:.3f} GB/s")

	axs[subfig_n].title.set_text(title)
	if subfig_n == 0:
		axs[subfig_n].set_ylabel("Throughput [GB/s]")
	axs[subfig_n].set_xlabel("Number of threads [N]")
	
	xticks = [x for x in set(num_runners)]

	axs[subfig_n].set_xticks(xticks)

axs[0].legend(loc='lower right', fontsize='small', title="Silesia Corpus files", ncol=2)


plt.savefig(output_filename)

print(f"wrote to: {output_filename}")


