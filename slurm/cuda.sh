#!/usr/bin/env nix-shell
#!nix-shell -i bash /cfs/home/fpera/gmx_simulations/12_water/nix/cuda.nix
#SBATCH -n1
#SBATCH -c1
#SBATCH --gres gpu:a100:1
#SBATCH -pampere
#SBATCH -Jgromacs

# Automatic selection of ntomp argument based on "-c" argument to sbatch
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
   ntomp="$SLURM_CPUS_PER_TASK"
else
   ntomp="1"
fi

# Make sure to set OMP_NUM_THREADS equal to the value used for ntomp
# to avoid complaints from GROMACS
export OMP_NUM_THREADS=$ntomp

mpirun gmx_mpi mdrun -ntomp $ntomp -deffnm nvt
