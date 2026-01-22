#!/bin/bash
#SBATCH -J qc
#SBATCH -p super
#SBATCH -N 1
#SBATCH -t 0-48:35:30
#SBATCH --output=qc_%j.out
#SBATCH --error=qc_%j.err
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL


cd /project/aamjad/RNAseq_June2025/raw/fastq/RNAseq
function RunfastQC {
        for i in $(ls *.fastq.gz);
        do
            /project/shared/quality-metric-fastqc.sh -f $i -o /project/aamjad/RNAseq_June2025/raw/fastq/RNAseq/outs
        done
}
RunfastQC
