#!/bin/bash
if [ $# -ne 5 ]; then
    echo "Your command line contains $# arguments, which is not enough"
    exit 1
fi

echo "----------------------------------------------------"
echo "Starting benchmark script with following parameters:"

executable=$1
result_dir=$2
snap_generate_script=$3
gen_data_dir=$4
silesia_dir=$5

echo "from commandline:"
echo "  executable: [ $executable ]"
echo "  result_dir: [ $result_dir ]"
echo "  snap_generate_script: [ $snap_generate_script ]"
echo "  gen_data_dir: [ $gen_data_dir ]"
echo "  silesia_dir: [ $silesia_dir ]"

num_times=1
chunk_size=20

echo "from script:"
echo "  num_times: [ $num_times ]"
echo "  chunk_size: [ $chunk_size ]"

echo "----------------------------------------------------"
echo "Starting benchmarks"
echo "----------------------------------------------------"

threads_config=( 1 2 4 6 8 12 16 20 24 28 32 36 40)

python_logs_folder=$gen_data_dir/logs
mkdir -p $python_logs_folder

file_n=0
echo "Compressing files at : [ $silesia_dir/ ]"
for uncompr_file in $silesia_dir/*; do 
	file_size=$(du -b $uncompr_file | cut -f1)
	basename_file=$(basename $uncompr_file)
	snappy_cmpr_file=$gen_data_dir/$basename_file.sz

	echo "Compressing file: [ $basename_file ] - size: [ $file_size ]"
	python3 $snap_generate_script -l -1 -cs $((1<<chunk_size)) -f $uncompr_file -o $snappy_cmpr_file > $python_logs_folder/snap_$file_n.log
	echo "  wrote to [ $snappy_cmpr_file ]"
	((file_n+=1))
done
echo "Done compressing files"

echo "Starting benchmarks on files at [ $gen_data_dir/ ]"
benchmark_n=0
for num_threads in "${threads_config[@]}"
do 	
	echo "running benchmarks with [ $num_threads ] threads"
	for uncompr_file in $silesia_dir/*; do 
		num=$(printf "%03d" $benchmark_n)
		basename_file=$(basename $uncompr_file)
		snappy_cmpr_file=$gen_data_dir/$basename_file.sz

		echo "  running benchmark [ $benchmark_n ] - on file [ $basename_file ]"
		$executable $snappy_cmpr_file $uncompr_file $num_threads $num_times $chunk_size >> $result_dir/res_$num.log
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
