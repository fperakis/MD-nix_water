#!/usr/bin/env nix-shell
#!nix-shell -i bash /cfs/home/fpera/gmx_simulations/12_water/nix/cpu.nix
#
#SBATCH -n 2
#SBATCH -pcops
#SBATCH -Jgromacs
#SBATCH -c 1
#
#nix-sdist `which gmx_mpi`

#Automatic selection of ntomp argument based on "-c" argument to sbatch
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
    ntomp="$SLURM_CPUS_PER_TASK"
else
    ntomp="1"
fi

# Make sure to set OMP_NUM_THREADS equal to the value used for ntomp
# # to avoid complaints from GROMACS
export OMP_NUM_THREADS=$ntomp

mpirun gmx_mpi mdrun -ntomp $ntomp -deffnm nvt
