#!/bin/bash
if [ $# -ne 6 ]; then
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

echo "from commandline:"
echo "  hostfile: [ $hostfile ]"
echo "  xclbin: [ $xclbin ]"
echo "  kernel_name: [ $kernel_name ]"
echo "  result_dir: [ $result_dir ]"
echo "  snap_generate_script: [ $snap_generate_script ]"
echo "  gen_data_dir: [ $gen_data_dir ]"

num_times=1
buffer_size_min=4
buffer_size_max=4
chunk_size=23
sleep_time=5
data_size=27

snappy_cmpr_file_name=compressed.sz
snappy_cmpr_file=$gen_data_dir/$snappy_cmpr_file_name

part_uncompr_file_name=part_uncompressed.dat
part_uncompr_file=$gen_data_dir/$part_uncompr_file_name

echo "from script:"
echo "  data_size: [ $data_size ]"
echo "  num_times: [ $num_times ]"
echo "  chunk_size: [ $chunk_size ]"
echo "  buffer_size_min: [ $buffer_size_min ]"
echo "  buffer_size_max: [ $buffer_size_max ]"
echo "  sleep_time: [ $sleep_time ]"

echo "----------------------------------------------------"
echo "Starting benchmarks"
echo "----------------------------------------------------"

runner_config=( 12 )


python_logs_folder=$gen_data_dir/logs
mkdir -p $python_logs_folder

benchmark_n=0
export LD_PRELOAD="/opt/apps/xilinx/Vivado/2020.1/tps/lnx64/gcc-6.2.0/lib64/libstdc++.so.6" # needed to run host file..
for (( buffer_size=buffer_size_min; buffer_size <= buffer_size_max; buffer_size++ ))  
do
	echo "Starting benchmarks with buffer_size: [ $buffer_size ]"
	python3 $snap_generate_script -r -l $((1<<data_size)) -cs $((1<<chunk_size)) -of $part_uncompr_file -o $snappy_cmpr_file > $python_logs_folder/snap_$num.log
	echo "  done creating data"

	for num_runners in "${runner_config[@]}"
	do 
		num=$(printf "%03d" $benchmark_n)
		echo "  running benchmark [ $benchmark_n ] with runners: [ $num_runners ] "
		$hostfile $xclbin $kernel_name $num_times $sleep_time $chunk_size $((1<<buffer_size)) $snappy_cmpr_file $part_uncompr_file $num_runners >> $result_dir/res_$num.log
		echo "    done running benchmark"

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
