#!/bin/bash
#SBATCH --partition computeq
#SBATCH --nodes=3
#SBATCH --cpus-per-task=12
#SBATCH --mem-per-cpu=20000M
#SBATCH --time=2-00:00:00

# just in case purge the old modules and load Matlab module
module purge
module load matlab

# run matlab program via the run_matlab script
logFile=Sim3WMBMultiOb256.log
mFile=Sim3WMBMultiOb256.m
/public/apps/matlab/R2018a/bin/matlab -nodisplay -nosplash -nodesktop -logfile $logFile -r "run $mFile;quit;"
