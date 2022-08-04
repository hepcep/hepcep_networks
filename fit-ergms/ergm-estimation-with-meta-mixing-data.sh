#!/bin/sh

#SBATCH --account=pi-jozik
#SBATCH --job-name="new-synthpop-data-fit"
#SBATCH --output=out/new-synthpop-data-fit
#SBATCH --partition=broadwl
#SBATCH --time=36:00:00
#SBATCH --mem=15000
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=aditya_khanna@brown.edu

module load R

R CMD BATCH --no-restore ergm-estimation-with-meta-data.R out/new-synthpop-data-fit
