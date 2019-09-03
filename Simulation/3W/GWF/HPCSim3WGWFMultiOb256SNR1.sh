#!/bin/bash
#SBATCH --partition computeq
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=5000M
#SBATCH --time=0-06:00:00

# just in case purge the old modules and load Matlab module
module purge
module load matlab

# run matlab program via the run_matlab script
logFile=Sim3WGWFMultiOb256SNR1.log
mFile=Sim3WGWFMultiOb256SNR1.m
/public/apps/matlab/R2018a/bin/matlab -nodisplay -nosplash -nodesktop -logfile $logFile -r "run $mFile;quit;"
