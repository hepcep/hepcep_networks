#!/bin/sh

#SBATCH --time=2:00:00
#SBATCH --mem=15000
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=aditya_khanna@brown.edu

module load R/3.6.0

R CMD BATCH --no-restore simulate-from-ergms/simulate-networks-from-meta-data-ergm-fit.R