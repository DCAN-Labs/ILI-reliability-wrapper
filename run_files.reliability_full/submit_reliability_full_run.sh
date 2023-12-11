#!/bin/bash -l

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 input_file1 input_file2 input_file3 ..."
    exit 1
fi

# Extract the input files from the command-line arguments
input_files=("$@")

# Loop through each input file
for input_file in "${input_files[@]}"; do
    outlog="output_logs/reliability_${input_file}_%A_%a.out"
    errlog="output_logs/reliability_${input_file}_%A_%a.err"

    # Submit an array of jobs to run each input file 1000 times
    reliability=$(sbatch --parsable --array=1-100 -J "${input_file}" --output="${outlog}" --error="${errlog}" resources_reliability_full_run.sh "$input_file")

    echo "Submitted a job array for $input_file. Job ID: $reliability"
done