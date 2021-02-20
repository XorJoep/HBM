import matplotlib.pyplot as plt
import math
import numpy as np
import os
import sys

if len(sys.argv) != 2:
	print(f"incorrect amount of arguments: {sys.argv}")
	exit(2)

result_file = sys.argv[1]

title = f"HBM baseline - read+write - 64 bit AXI-bus\nConfiguration 3"
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

throughput = runners * total_size / single_transaction_time
throughput /= 1024*1024*1024

markerlist = ['o', '^', 's', 'P', '*', '<', '>', 'p', 'o', 'p', 'o', 'p', 'o']

for i, n_runners in enumerate([1, 2, 4, 6, 8, 12, 16]):
	# if n_runners not in [1, 2, 4, 6, 8, 12, 16]: continue
	indices = np.where(runners==n_runners)
	line, = plt.plot(total_size_l2[indices], throughput[indices], marker=markerlist[i])
	line.set_label(f'{n_runners}')
	highest_throughput = max(throughput[indices])
	if n_runners == 1:
		plt.axhline(y=highest_throughput, color='r', linestyle='-.')
		plt.text(x=max(total_size_l2[indices])-2,y=highest_throughput-0.3,s=f"{highest_throughput:.3f} GB/s")
	elif n_runners == 6:
		plt.axhline(y=highest_throughput, color='r', linestyle='-.')
		plt.text(x=max(total_size_l2[indices])-2,y=highest_throughput+0.1,s=f"{highest_throughput:.3f} GB/s")
	elif n_runners == 16:
		plt.axhline(y=highest_throughput, color='r', linestyle='-.')
		plt.text(x=max(total_size_l2[indices])-2,y=highest_throughput+0.1,s=f"{highest_throughput:.3f} GB/s")

plt.legend(bbox_to_anchor=(0.21,1), loc="upper right", title="Active DMA")


xticks = [x for x in set(total_size_l2)]

plt.xticks(xticks)
plt.grid(True, axis='x')

plt.title(title)
plt.xlabel('log$_{2}$' + "(transaction size) [bytes]")
plt.ylabel("Throughput per DMA [GB/s]")

plt.savefig(file_name)

print(f"wrote to: {file_name}")


