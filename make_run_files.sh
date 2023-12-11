#!/bin/bash 
set +x 

# Get bin for minutes of rest to sample from the config.json
json_file="config.json"
min=$(grep -o '"max_minutes": *[0-9]*' "$json_file" | awk -F': ' '{print $2}')min

# determine data directory, run folders, and run templates
run_folder=`pwd`
data_dir="/home/faird/shared/projects/MSC_to_DCAN/split_halves/half1"

work_dir="/tmp"
#work_dir="${run_folder}/workdir/${min}"
out_dir="${run_folder}/OUT/${min}"
half2_ILI="${run_folder}/half2_ILI"
reliability_folder="${run_folder}/run_files.reliability_full"
reliability_template="template.reliability_full_run"
logs_folder="${reliability_folder}/output_logs"

email=`echo $USER@umn.edu`
group=`groups|cut -d" " -f1`

# make work_dir if it's not set to /tmp and isn't already present on tier1
if [[ "${work_dir}" != "/tmp" ]]; then
	if [ ! -d "${work_dir}" ]; then
		mkdir -p "${work_dir}"
	fi
fi

# make output logs directory if missing
if [ ! -d "${logs_folder}" ]; then
	mkdir "${logs_folder}"
fi

# make output directory if missing
if [ ! -d "${out_dir}" ]; then
	mkdir -p "${out_dir}"
fi

subjects=(MSC01 MSC02 MSC03 MSC04 MSC05 MSC06 MSC07 MSC08 MSC09 MSC10)

for subject in "${subjects[@]}"; do
	sed -e "s|SUBJECTID|${subject}|g" -e "s|WORKDIR|${work_dir}|g" -e "s|DATADIR|${data_dir}|g" -e "s|RUNDIR|${run_folder}|g" -e "s|OUTDIR|${out_dir}|g" -e "s|HALF2ILI|${half2_ILI}|g" -e "s|MIN|${min}|g" ${run_folder}/${reliability_template} > ${reliability_folder}/${subject}_${min}
done

chmod 775 -R ${reliability_folder}

sed -e "s|GROUP|${group}|g" -e "s|EMAIL|${email}|g" -i ${reliability_folder}/resources_reliability_full_run.sh 
