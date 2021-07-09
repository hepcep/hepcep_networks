#!/bin/sh

#SBATCH --account=pi-khanna7
#SBATCH --job-name="racemix-plus-dist-plus-negbin-indeg0-2-orignialdata"
#SBATCH --output=out/racemix-plus-dist-plus-negbin-indeg0-2-orignialdata
#SBATCH --partition=broadwl
#SBATCH --time=5:00:00
#SBATCH --mem=15000
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=aditya_khanna@brown.edu

module load R

R CMD BATCH --no-restore simulate-networks-from-meta-data-ergm-fit.R out/racemix-plus-dist-plus-negbin-indeg0-2-orignialdata.Rout
