#!/bin/bash


arr_size=$((10000)) # num of integer elements to sort
type=merge_sequence		# program name

# Clear the results file
> mergesort_results/${type}.txt
echo "num threads = ${num_threads}" >> mergesort_results/${type}.txt

./${type} ${arr_size} ${thresh} ${num_threads} >> mergesort_results/${type}.txt


