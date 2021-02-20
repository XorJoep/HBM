import os
import re
import math

import sys

if len(sys.argv) != 3:
	print(f"incorrect amount of arguments: {sys.argv}")
	exit(2)

folder = sys.argv[1]

prefix = "###"
postfix = prefix

num_vars = 4
var_reg_exp = r"\d+"
pattern = prefix + '\n' + (var_reg_exp + " ") * (num_vars-1) + var_reg_exp + '\n' + postfix
pattern_nums = re.compile(pattern)
# pattern_pass = re.compile("TEST PASSED")

files = []

extention = r".log"

results = []

result_file = sys.argv[2]

for filename in sorted(os.listdir(folder)):
    if filename.endswith(extention):
    	files.append(os.path.join(folder, filename))

for i, path in enumerate(files):
	with open(path, 'r') as file:
		content = file.read()
		try:
			result_line = re.findall(pattern_nums, content)[0]
		except IndexError:
			print(f"File at {path} does not contain results, skipping..")
			continue

		values = [int(s) for s in result_line.split() if s.isdigit()]

		# passed = re.findall(pattern_pass, content)
		# if len(passed) == 0:
		# 	print(f"[{i}] -> benchmark has failed [btt, size_kb = {int(math.log(btt,2))}, {int(math.log(size_kb,2))}]")
		# else:
		results.append([i] + list(values))



		# print(f"[{i}] -> ex cyclecount: {cyclecount} (ns) - packet size: {btt} bytes - data size: {size_kb} kb")

with open(os.path.join(folder,result_file), 'w') as res_file:
	for result in results:
		# i, kernel_n, cyclecount, btt, size_kb, num_times = result
		res_file.write(f"{' '.join(str(x) for x in result)}\n")

