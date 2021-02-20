#!/bin/bash

if [ $# -lt 5 ]; then
    echo "Your command line contains $# arguments, which is not enough"
    exit 1
fi

hostfile=$1
xclbin=$2
kernel_name=$3
result_folder=$4
transfer_mode=$5

echo "hostfile set: [$hostfile]"
echo "xclbin set: [$xclbin]"
echo "result_folder set: [$result_folder]"

echo "Transfer mode:"

case $transfer_mode in
	0 )
		echo "READ"
		;;
	1 ) 
		echo "WRITE"
		;;
	2 ) 
		echo "READ+WRITE"
		echo "DIFFERENT BANKS"
		;;
	3 ) 
		echo "READ+WRITE"
		echo "SAME BANKS"
		;;
	* ) 
		echo "$transfer_mode is INVALID"
		exit
		;;
esac

echo "!!!!!!!!!!!!!!"
echo "Starting benchmarks"
echo "!!!!!!!!!!!!!!"

benchmark_n=0

num_times=100
transaction_size_min=10
transaction_size_max=28
sleep_time=10

runner_config=( 1 2 4 8 16 )

echo "num_times set to: $num_times"
echo "data size will range between $transaction_size_min - $transaction_size_max"
# echo "num runners will range between $num_runners_min - $num_runners_max"

export LD_PRELOAD="/opt/apps/xilinx/Vivado/2020.1/tps/lnx64/gcc-6.2.0/lib64/libstdc++.so.6"

for (( data_size=transaction_size_min; data_size <= transaction_size_max; data_size++ ))  # 30 mb
do 
	for num_runners in "${runner_config[@]}"
	do 
		num=$(printf "%03d" $benchmark_n)
		echo "Starting benchmark ${benchmark_n} -- data_size: $data_size -- num_runners: $num_runners"
		$hostfile $xclbin $kernel_name $num_times $((1<<data_size)) $transfer_mode $sleep_time $num_runners >> ${result_folder}/res_${num}.log
		echo "   done running benchmark"
		case `cat ${result_folder}/res_${num}.log | grep -Fq "error" >/dev/null; echo $?` in
		  1)
		    echo $bm_result >> "${result_folder}/res_${num}.log"
			((benchmark_n+=1))
		    ;;
		  0)
			echo "Failed test!"
			echo $bm_result
			exit
		    ;;
		  *)
		    echo "ERROR OCCURED"
		    exit
		    ;;
		esac
	done
done
# echo "Parsing results into single output file.."
# python3 $parse_script $result_folder $result_file

echo "!!!!!!!!!!!!!!"
echo "DONE with benchmarking"
echo "!!!!!!!!!!!!!!"

