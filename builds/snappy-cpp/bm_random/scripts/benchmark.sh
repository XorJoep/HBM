#!/bin/bash
if [ $# -ne 4 ]; then
    echo "Your command line contains $# arguments, which is not enough"
    exit 1
fi

echo "----------------------------------------------------"
echo "Starting benchmark script with following parameters:"

executable=$1
result_dir=$2
snap_generate_script=$3
gen_data_dir=$4

echo "from commandline:"
echo "  executable: [ $executable ]"
echo "  result_dir: [ $result_dir ]"
echo "  snap_generate_script: [ $snap_generate_script ]"
echo "  gen_data_dir: [ $gen_data_dir ]"

num_times=1
chunk_size_min=10
chunk_size_max=26
data_size=27

snappy_cmpr_file_name=compressed.sz
snappy_cmpr_file=$gen_data_dir/$snappy_cmpr_file_name

part_uncompr_file_name=part_uncompressed.dat
part_uncompr_file=$gen_data_dir/$part_uncompr_file_name

echo "from script:"
echo "  data_size: [ $data_size ]"
echo "  num_times: [ $num_times ]"
echo "  chunk_size_min: [ $chunk_size_min ]"
echo "  chunk_size_max: [ $chunk_size_max ]"

echo "----------------------------------------------------"
echo "Starting benchmarks"
echo "----------------------------------------------------"

threads_config=(1 2 4 6 8 12 16 32 40)

python_logs_folder=$gen_data_dir/logs
mkdir -p $python_logs_folder

benchmark_n=0
for (( chunk_size=chunk_size_min; chunk_size <= chunk_size_max; chunk_size++ ))  
do 
	num=$(printf "%03d" $benchmark_n)
	echo "Starting benchmarks on chunk_size: [ $chunk_size ]"
	python3 $snap_generate_script -r -l $((1<<data_size)) -cs $((1<<chunk_size)) -o $snappy_cmpr_file -of $part_uncompr_file > $python_logs_folder/snap_$rep-$num.log
	echo "  done creating data"
	ratio=$(grep compression $python_logs_folder/snap_$rep-$num.log | cut -d ':' -f 2)

	for threads in "${threads_config[@]}"
	do 
		num=$(printf "%03d" $benchmark_n)
		echo "  running benchmark [ $benchmark_n ] with runners: [ $threads ] "
		$executable $snappy_cmpr_file $part_uncompr_file $threads $num_times $chunk_size $ratio >> $result_dir/res_$num.log
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
