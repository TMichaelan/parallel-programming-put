#!/bin/bash


thresh=32     	# threshold at which sort reverts to insertion
arr_size=$((10000)) # num of integer elements to sort
num_runs=1         	# number of runs/thread count
type=quick_parallel		# program name

# Array with desired thread numbers
thread_counts=(1 2 4 8 12)

# Clear the results file
> mergesort_results/${type}.txt

for num_threads in ${thread_counts[@]}; do
    echo "num threads = ${num_threads}" >> mergesort_results/${type}.txt
    for (( i = 0; i < num_runs; i++ ))
    do
       ./${type} ${arr_size} ${thresh} ${num_threads} >> mergesort_results/${type}.txt
    done
done



