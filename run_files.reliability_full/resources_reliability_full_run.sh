#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=16gb
#SBATCH --time=15:00:00
#SBATCH -p amdsmall,amdlarge,amd512,small,ram256g,msismall
#SBATCH --mail-type=ALL
#SBATCH --mail-user=lmoore@umn.edu
#SBATCH -A elisonj

input_file="$1"

module purge
module load python3 matlab/R2019a

export PATH="/home/faird/shared/code/external/utilities/workbench/1.4.2/workbench/bin_rh_linux64/:${PATH}"
which wb_command

bash "$input_file"