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
	mode_text = "read only - config 3"
elif mode == 1:
	mode_text = "write only - config 3"
elif mode == 2:
	mode_text = "read+write - config 3"
elif mode == 3:
	mode_text = "read+write - config 3.1"
else:
	print(f"ERROR plotting, mode {mode} unknown")
	exit()

title = f"HBM baseline - read+write - 256 bit AXI-bus\nConfiguration 3"
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

throughput = runners * total_size / single_transaction_time
throughput /= 1024*1024*1024

markerlist = ['o', '^', 's', 'P', '*']
# plt.subplots_adjust(right=1)
for i, n_runners in enumerate(set(runners)):
	indices = np.where(runners==n_runners)
	line, = plt.plot(total_size_l2[indices], throughput[indices], marker=markerlist[i])
	line.set_label(f'{n_runners}')
	highest_throughput = max(throughput[indices])
	plt.axhline(y=highest_throughput, color='r', linestyle='-.')
	if i <= 2:
		plt.text(x=max(total_size_l2[indices])-2,y=highest_throughput-1.1,s=f"{highest_throughput:.3f} GB/s")
	else:
		plt.text(x=max(total_size_l2[indices])-2,y=highest_throughput-0.7,s=f"{highest_throughput:.3f} GB/s")


plt.legend(bbox_to_anchor=(0.25,0.97), loc="upper right", title="Active DMA")


xticks = [x for x in set(total_size_l2)]

plt.xticks(xticks)
plt.grid(True, axis='x')

# plt.tight_layout(rect=[0,0,0.75,1])
plt.title(title)
plt.xlabel('log$_{2}$' + "(transaction size) (bytes)")
plt.ylabel("Throughput (GB/s)")
plt.savefig(file_name)#, bbox_inches="tight")

print(f"wrote to: {file_name}")


