#!/bin/sh

#SBATCH --account=pi-jozik
#SBATCH --job-name="new-synthpop-compute-summaries"
#SBATCH --output=out/new-synthpop-compute-summaries
#SBATCH --partition=broadwl
#SBATCH --time=0:10:00
#SBATCH --mem=15000
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=aditya_khanna@brown.edu

module load R

R CMD BATCH --no-restore summaries-across-simulated-distributions.R out/new-synthpop-compute-summaries.Rout
