#!/bin/bash
#SBATCH -J align
#SBATCH -p super
#SBATCH -N 1
#SBATCH -t 0-48:35:30
#SBATCH --output=align_%j.out
#SBATCH --error=align_%j.err
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL


cd /project/aamjad/RNAseq_June2025/raw/fastq/RNAseq

module load bowtie2
module load samtools

### MAP Paired-End data ###
###########################
for i in 20240821-PWD-Veh_S1 20240821-PWD-E2-2h_S2 20240821-PWD-E2-6h_S3 20240826-FVB-Veh_S4 20240826-FVB-E2-2h 20240826-FVB-E2-6h 20240903-129-Veh_S7 20240903-129-E2-2h_S8 20240903-129-E2-6h_S9 20240903-C57-Veh_S10 20240903-C57-E2-2h_S11 20240903-C57-E2-6h_S12 \
       20241009-129-Veh_S13 20241009-129-E2-2h_S14 20241009-129-E2-6h_S15 20241111-C3H-A-Veh_S16 20241111-C3H-A-E2-2h_S17 20241111-C3H-A-E2-6h_S18 20241111-C3H-B-Veh_S19 20241111-C3H-B-E2-2h_S20 20241111-C3H-B-E2-6h_S21 20241119-C3H-Veh_S22 20241119-C3H-E2-2h_S23 \
       20241119-C3H-E2-6h_S24 20241104-C57-Veh_S25 20241104-C57-E2-2h_S26 20241104-C57-E2-6h_S27 20241105-PWD-Veh_S28 20241105-PWD-E2-2h_S29 20241105-PWD-E2-6h_S30 20241112-PWD-Veh_S31 20241112-PWD-E2-2h_S32 20241112-PWD-E2-6h_S33 20241205-PWD-Veh_S34 \
       20241205-PWD-E2-2h_S35 20241205-PWD-E2-6h_S36
do
       bowtie2 -p 16 -t -x /project/shared/CommonGenomes_Indexes/bowtie2/GRCm38/genome -1 "$i"_R1_001.fastq.gz -2 "$i"_R2_001.fastq.gz | samtools view -@ 16 -bS | \
       samtools sort -@ 16 -O bam -o Align/"$i"_BT2_mapped2GRCm38_sort.bam
done


### MAP Single-End data ###
###########################
for i in N2K23_14717_1_20250217-129-Veh_S1_L002 N2K23_14717_2_20250217-129-E2-2hr_S2_L002 N2K23_14717_3_20250217-129-E2-6hr_S3_L002 N2K23_14717_10_20250415-FVB_Veh_S10_L002 \
          N2K23_14717_11_20250415-FVB_E2-2hr_S11_L002 N2K23_14717_12_20250415-FVB_E2-6hr_S12_L002 N2K23_14717_4_20250224-FVB-Veh_S4_L002 N2K23_14717_5_20250224-FVB-E2-2hr_S5_L002 \
          N2K23_14717_6_20250224-FVB-E2-6hr_S6_L002 N2K23_14717_7_20250331-FVB_Veh_S7_L002 N2K23_14717_8_20250331-FVB_E2-2hr_S8_L002 N2K23_14717_9_20250331-FVB_E2-6hr_S9_L002
do
        bowtie2 -p 16 -t -x /project/shared/CommonGenomes_Indexes/bowtie2/GRCm38/genome -U "$i"_R1_001.fastq.gz | samtools view -@ 16 -bS | \
       samtools sort -@ 16 -O bam -o Align/"$i"_BT2_mapped2GRCm38_sort.bam
done
