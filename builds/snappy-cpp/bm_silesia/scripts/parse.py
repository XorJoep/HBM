import os
import re
import math

import sys

if len(sys.argv) != 3:
	print(f"incorrect amount of arguments: {sys.argv}")
	exit(2)

folder = sys.argv[1]

prefix = "###\n"
postfix = prefix

num_vars = 6
var_reg_exp = r"\d+"
filename_reg_exp = r"\w+.*\w+"
pattern = prefix + (var_reg_exp + " ") * num_vars + filename_reg_exp + '\n' + postfix
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
		results.append(str(i) + " " + result_line.replace(prefix, ""))

with open(result_file, 'w') as res_file:
	for result in results:
		res_file.write(f"{result}")

print(f"Wrote parsed results to: {result_file}")

