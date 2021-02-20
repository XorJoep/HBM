#!/bin/bash
if [ $# -ne 7 ]; then
    echo "Your command line contains $# arguments, which is not enough"
    exit 1
fi

echo "----------------------------------------------------"
echo "Starting benchmark script with following parameters:"

hostfile=$1
xclbin=$2
kernel_name=$3
result_dir=$4
snap_generate_script=$5
gen_data_dir=$6
silesia_dir=$7

echo "from commandline:"
echo "  hostfile: [ $hostfile ]"
echo "  xclbin: [ $xclbin ]"
echo "  kernel_name: [ $kernel_name ]"
echo "  result_dir: [ $result_dir ]"
echo "  snap_generate_script: [ $snap_generate_script ]"
echo "  gen_data_dir: [ $gen_data_dir ]"
echo "  silesia_dir: [ $silesia_dir ]"

num_times=10
buffer_size=40
chunk_size_min=10
chunk_size_max=25
sleep_time=30

random_seed=2015

snappy_cmpr_file_name=compressed.sz
snappy_cmpr_file=$gen_data_dir/$snappy_cmpr_file_name
echo "from script:"
echo "  num_times: [ $num_times ]"
echo "  buffer_size: [ $buffer_size ]"
echo "  chunk_size_min: [ $chunk_size_min ]"
echo "  chunk_size_max: [ $chunk_size_max ]"
echo "  sleep_time: [ $sleep_time ]"
echo "  compressed filename: [ $snappy_cmpr_file_name ]"

echo "----------------------------------------------------"
echo "Starting benchmarks"
echo "----------------------------------------------------"

runner_config=( 1 2 3 4 5 6 8 12 16 )

python_logs_folder=$gen_data_dir/logs
mkdir -p $python_logs_folder

benchmark_n=0
export LD_PRELOAD="/opt/apps/xilinx/Vivado/2020.1/tps/lnx64/gcc-6.2.0/lib64/libstdc++.so.6" # needed to run host file..
for uncompr_file in $silesia_dir/*; do 
	# [ -e "$uncompr_file" ] || continue # just to be safe?
	file_size=$(du -b $uncompr_file | cut -f1)
	basename_file=$(basename $uncompr_file)

	echo "Starting benchmarks on file: [ $basename_file ] - size: [ $file_size ]"
	python3 $snap_generate_script -l -1 -cs_min $((1<<chunk_size_min)) -cs_max $((1<<chunk_size_max)) -rs $random_seed -f $uncompr_file -o $snappy_cmpr_file > $python_logs_folder/snap_$num.log
	echo "  done creating data"

	for num_runners in "${runner_config[@]}"
	do 
		num=$(printf "%03d" $benchmark_n)
		echo "  running benchmark with runners: [ $num_runners ] "
		$hostfile $xclbin $kernel_name $num_times $sleep_time 0 $buffer_size $snappy_cmpr_file $uncompr_file $basename_file $num_runners >> $result_dir/res_$num.log
		echo "   done running benchmark"
		case `cat $result_dir/res_$num.log | grep -Fq "TEST PASSED" >/dev/null; echo $?` in
		  0)
		    echo $bm_result >> "$result_dir/res_$num.log"
			((benchmark_n+=1))
		    ;;
		  1)
			echo "Failed test!"
			echo $bm_result
			exit 1
		    ;;
		  *)
		    echo "ERROR OCCURED"
		    exit 1
		    ;;
		esac
	done
done

echo "----------------------------------------------------"
echo "DONE with benchmarking"
echo "----------------------------------------------------"
