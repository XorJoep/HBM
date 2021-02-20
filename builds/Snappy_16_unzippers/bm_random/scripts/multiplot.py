import matplotlib.pyplot as plt
import math
import numpy as np
import os
import sys

if len(sys.argv) != 3:
	print(f"incorrect amount of arguments: {sys.argv}")
	exit(2)

file_name = "HBM_throughput_read_write.pdf"

result_file_read = sys.argv[1]
result_file_write = sys.argv[2]

title_read = f"HBM average throughput per bank\nread-only"
title_write = f"write-only"

freq = 250e6

plt.figure(0)
fig, axs = plt.subplots(2, 1, sharex=True)

markerlist = ['o', '^', 's', 'P', '*']

for subfig_n, (result_file, title) in enumerate([(result_file_read, title_read), (result_file_write, title_write)]):

	with open(result_file, 'r') as res_file:
		results = np.array([([int(s) for s in result.split() if s.isdigit()]) for result in res_file])

	i = results[:,0]
	cycles = results[:,1]

	runners = results[:,3]

	trans_size = results[:,2]
	trans_size_l2 = np.array([int(math.log(x, 2)) for x in trans_size])

	num_times = results[:,4]
	single_transaction_time = cycles / num_times / freq # = average cycles / freq = time per transaction

	total_size = trans_size
	total_size_l2 = np.array([int(math.log(x, 2)) for x in total_size])

	throughput = total_size / single_transaction_time
	throughput /= 1024*1024*1024

	for i, n_runners in enumerate(set(runners)):
		indices = np.where(runners==n_runners)
		line, = axs[subfig_n].plot(total_size_l2[indices], throughput[indices], marker=markerlist[i])
		line.set_label(f'Active DMA = {n_runners}')

	axs[subfig_n].legend(loc='lower right')

	highest_throughput = max(throughput)

	axs[subfig_n].grid(True, axis='x')

	axs[subfig_n].axhline(y=highest_throughput, color='r', linestyle='-.')
	axs[subfig_n].text(x=min(total_size_l2[indices]),y=highest_throughput-0.1*highest_throughput,s=f"{highest_throughput:.3f} GB/s")

	axs[subfig_n].title.set_text(title)
	if subfig_n == 1:
		axs[subfig_n].set_xlabel('log$_{2}$' + "(transaction size) (bytes)")
	axs[subfig_n].set_ylabel("Throughput (GB/s)")

xticks = [x for x in set(total_size_l2)]

plt.xticks(xticks)

plt.savefig(file_name)

print(f"wrote to: {file_name}")


