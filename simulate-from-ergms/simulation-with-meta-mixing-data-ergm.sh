#!/bin/sh

#SBATCH --account=pi-jozik
#SBATCH --job-name="new-synthpop-100-nets"
#SBATCH --output=out/new-synthpop-100-nets
#SBATCH --partition=broadwl
#SBATCH --time=5:00:00
#SBATCH --mem=15000
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=aditya_khanna@brown.edu

module load R

R CMD BATCH --no-restore simulate-networks-from-meta-data-ergm-fit.R out/new-synthpop-100-netws.Rout
