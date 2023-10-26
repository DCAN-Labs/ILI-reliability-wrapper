#!/bin/bash -l

#SBATCH -J MSC
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem-per-cpu=32gb
#SBATCH --time=15:00:00
#SBATCH -p amdsmall,amdlarge,amd512,small,ram256g,msismall
#SBATCH --mail-type=ALL
#SBATCH --mail-user=lmoore@umn.edu
#SBATCH -o output_logs/reliability_%A_%a.out
#SBATCH -e output_logs/reliability_%A_%a.err
#SBATCH -A elisonj

cd run_files.reliability_full

module purge
module load python3 matlab/R2019a

export PATH="/home/faird/shared/code/external/utilities/workbench/1.4.2/workbench/bin_rh_linux64/:${PATH}"
which wb_command

file=run${SLURM_ARRAY_TASK_ID}

bash ${file}
