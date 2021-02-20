import matplotlib.pyplot as plt
import math
import numpy as np
import os
import sys

if len(sys.argv) != 2:
	print(f"incorrect amount of arguments: {sys.argv}")
	exit(2)

result_file = sys.argv[1]

title = f"HBM baseline - read+write - 64 bit AXI-bus - Configuration 3"
file_name = title.replace(' ', '_') + "v2.pdf"

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

throughput = total_size / single_transaction_time
throughput /= 1e9

markerlist = ['o', '^', 's', 'P', '*', '<', '>', 'p', 'o', 'p', 'o', 'p', 'o']
fig, axs = plt.subplots(1,2)

runners_to_plot = [1, 2, 3, 4, 5, 6, 8, 12, 16]

for i, n_runners in enumerate(runners_to_plot):
	indices = np.where(runners==n_runners)
	line, = axs[0].plot(total_size_l2[indices], throughput[indices], marker=markerlist[i])
	line.set_label(f'{n_runners}')
	highest_throughput = max(throughput[indices])
	if n_runners in [1, 6, 12, 16]:
		axs[0].axhline(y=highest_throughput, color='r', linestyle='-.')
		axs[0].text(x=18.5,y=highest_throughput+0.02,s=f"{highest_throughput:.3f} GB/s")
	# else:
	# 	axs[0].text(x=19,y=highest_throughput-0.4,s=f"{highest_throughput:.3f} GB/s")

axs[0].grid(True, axis='x')

axs[0].set_ylabel("Throughput [GB/s]")
xticks = [x for x in set(total_size_l2) if x%2==0]
axs[0].set_xticks(xticks)
axs[0].set_xlabel('log$_{2}$' + "(transaction size) [bytes]")
axs[0].set_title('per DMA per channel')

throughput = runners * total_size / single_transaction_time
throughput /= 1e9

for i, n_runners in enumerate(runners_to_plot):
	indices = np.where(runners==n_runners)
	line, = axs[1].plot(total_size_l2[indices], throughput[indices], marker=markerlist[i])
	line.set_label(f'{n_runners}')
	highest_throughput = max(throughput[indices])
	if n_runners in [1, 2, 4, 5, 6]:
		axs[1].axhline(y=highest_throughput, color='r', linestyle='-.')
		axs[1].text(x=18.5,y=highest_throughput+0.1,s=f"{highest_throughput:.3f} GB/s")
	elif n_runners in [12]:
		axs[1].axhline(y=highest_throughput, color='r', linestyle='-.')
		axs[1].text(x=18.5,y=highest_throughput+0.1,s=f"{highest_throughput:.3f} GB/s")
	elif n_runners in [8]:
		axs[1].axhline(y=highest_throughput, color='r', linestyle='-.')
		axs[1].text(x=19.5,y=highest_throughput+0.1,s=f"{highest_throughput:.3f} GB/s")
	# else:

axs[1].set_title('per bank')
axs[1].legend(loc='upper left', title='Active DMA')
axs[1].set_xlabel('log$_{2}$' + "(transaction size) [bytes]")

axs[1].grid(True, axis='x')
# axs[1].set_title('full')
# axs[1].set_ylabel("Throughput [GB/s]")

plt.xticks(xticks)

throughput = total_size / single_transaction_time
throughput /= 1024*1024*1024

fig.suptitle(title)
plt.xticks(xticks)
# plt.grid(True, axis='x')

# # plt.tight_layout(rect=[0,0,0.75,1])
# plt.title(title)
# plt.xlabel('log$_{2}$' + "(transaction size) [bytes]")
# plt.ylabel("Throughput (GB/s)")
plt.savefig(file_name)#, bbox_inches="tight")

print(f"wrote to: {file_name}")


