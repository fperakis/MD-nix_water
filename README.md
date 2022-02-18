# MD-nix_water
An example of runing water MD simulations using gromacs at Fysikum HPC. 

Simulating a water box based on this tutorial
https://group.miletic.net/en/tutorials/gromacs/1-tip4pew-water/

Gromacs packages are initialised using NixOS, see here. 
https://github.com/markuskowa/NixOS-QChem

-----
## Pipeline

activate nix
```bash 
nix-shell -p qchem-unstable.gromacs
```

make topology file (topol.top)
```bash 
#include "oplsaa.ff/forcefield.itp"
#include "oplsaa.ff/tip4pew.itp"

[ System ]
TIP4PEW in water
```

generate box
```bash 
gmx solvate -cs tip4p -o box.gro -box 2.3 2.3 2.3 -p topol.top
```

prepare em
```bash 
gmx grompp -f mdp/em.mdp -c box.gro -p topol.top -o em.tpr
```

modify cuda file for em and run minimization
```bash 
sbatch slurm/cpu.sh
```

prepare nvt
```bash 
gmx grompp -f mdp/nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
```

modify cuda file for em and run minimization
```bash 
sbatch slurm/cuda.sh
```

