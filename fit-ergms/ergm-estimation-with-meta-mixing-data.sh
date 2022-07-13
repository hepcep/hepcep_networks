#!/bin/sh

#SBATCH --account=pi-khanna7
#SBATCH --job-name="racemix-plus-dist-plus-negbin-indeg0-1-only-OL-data"
#SBATCH --output=out/racemix-plus-dist-plus-negbin-indeg0-1-only-OL
#SBATCH --partition=broadwl
#SBATCH --time=36:00:00
#SBATCH --mem=15000
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=aditya_khanna@brown.edu

module load R

R CMD BATCH --no-restore ergm-estimation-with-meta-data.R out/racemix-plus-dist-plus-negbin-indeg0-1-OL.Rout
