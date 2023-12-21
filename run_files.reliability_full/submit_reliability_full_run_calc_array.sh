#!/bin/bash -l

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 input_file1 input_file2 input_file3 ..."
    exit 1
fi

# Extract the input files from the command-line arguments
input_files=("$@")

#HARDCODE WARNING - PATH TO OUTPUT FOLDER
outdir=<PATH>

# Loop through each input file
for input_file in "${input_files[@]}"; do
    outlog="output_logs/reliability_${input_file}_%A_%a.out"
    errlog="output_logs/reliability_${input_file}_%A_%a.err"
    
    subject=$(echo ${input_file} | grep -o "MSC[0-9]*")
    min=$(echo ${input_file} | grep -o "[0-9]*min")
	
    output_csv_file=${outdir}/${min}/${subject}_${min}_correlation.csv
    
    if [ ! -e ${output_csv_file} ]; then
      N=0
    else
      N=$(cat $output_csv_file | wc -l)
      N=$(( N + 1 ))
    fi

    # Submit an array of jobs to run each input file 1000 times
    reliability=$(sbatch --parsable --array=${N}-1000 -J "${input_file}" --output="${outlog}" --error="${errlog}" resources_reliability_full_run.sh "$input_file")

    echo "Submitted a job array for $input_file. Job ID: $reliability"
done