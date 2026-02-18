#!/bin/bash
#SBATCH --job-name=parTI
#SBATCH --output=parTI_%j.out
#SBATCH --error=parTI_%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --time=20:00:00

# Load MATLAB module
module load matlab

# Feed the desired number of archetypes (4) as input to MATLAB
echo "5" | matlab -nodisplay -r "run('run_parTI_sc.m'); exit"
