import matplotlib.pyplot as plt
import math
import numpy as np
import os
import sys

if len(sys.argv) != 3:
	print(f"incorrect amount of arguments: {sys.argv}")
	exit(2)

result_file = sys.argv[1]
mode = int(sys.argv[2])

if mode == 0:
	mode_text = "read only - configuration 1"
elif mode == 1:
	mode_text = "write only - configuration 1"
elif mode == 2:
	mode_text = "read+write - configuration 1"
elif mode == 3:
	mode_text = "read+write - configuration 2"
else:
	print(f"ERROR plotting, mode {mode} unknown")
	exit()
title = f"HBM throughput {mode_text}"
file_name = title.replace(' ', '_') + ".pdf"

freq = 250e6

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

throughput = 2 * total_size / single_transaction_time
throughput /= 1024*1024*1024

markerlist = ['o', '^', 's', 'P', '*', '<', '>', 'p', 'o', 'p', 'o', 'p', 'o']

for i, n_runners in enumerate(set(runners)):
	if n_runners not in [1, 2, 4, 8, 16]: continue
	indices = np.where(runners==n_runners)
	line, = plt.plot(total_size_l2[indices], throughput[indices], marker=markerlist[i])
	line.set_label(f'Active DMA = {n_runners}')

plt.legend(loc='lower right')

highest_throughput = max(throughput)

xticks = [x for x in set(total_size_l2)]

plt.xticks(xticks)
plt.grid(True, axis='x')

plt.axhline(y=highest_throughput, color='r', linestyle='-.')
plt.text(x=min(total_size_l2[indices]),y=highest_throughput-0.05*highest_throughput,s=f"{highest_throughput:.3f} GB/s")

plt.title(title)
plt.xlabel('log$_{2}$' + "(transaction size) (bytes)")
plt.ylabel("Throughput (GB/s)")

plt.savefig(file_name)

print(f"wrote to: {file_name}")


