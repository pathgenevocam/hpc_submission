#!/bin/sh
#! sbatch directives begin here ###############################
#! Name of the job:
#SBATCH -J JOBNAME
#! Which project should be charged:
#SBATCH -A GROUPNAME
#! Output filename: %A means slurm job ID
#SBATCH --output=beast_gpu_%A.log
# Redirect error messages with: -e <file_name>
#SBATCH --error=beast_gpu_%A.err

#SBATCH -p ampere
#! How many whole nodes should be allocated?
#SBATCH --nodes=1
#SBATCH --ntasks 1
#! How many cores will be allocated per task? (for single core jobs always leave this at 1)
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#! Choose minimum number of CPUs allocated per node
#SBATCH --mincpus=1
#! How much wallclock time will be required?
#SBATCH --time=12:00:00
#! What types of email messages do you wish to receive?
#SBATCH --mail-type=ALL
#! Uncomment this to prevent the job from being requeued (e.g. if
#! interrupted by node failure or system downtime):
##SBATCH --no-requeue
#SBATCH --mem 24000

module load rhel8/default-amp              # REQUIRED - loads the basic environment

module load pkg-config-0.29.2-gcc-6.2.0-we4glmw
module load gcc/11
module load beagle-3.1.2
module load cuda/11.4
module load jdk-8u131-b11-gcc-5.4.0-z7brlnq

##Run BEAST
/home/USER/beast/bin/beast -beagle_GPU -seed $RANDOM ${file}

