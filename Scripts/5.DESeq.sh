#!/bin/bash
#SBATCH -J deseq
#SBATCH -p super
#SBATCH -N 2
#SBATCH -t 1-4:35:30
#SBATCH --output=deseq_%j.out
#SBATCH --error=deseq_%j.err
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

module load subread/1.6.3
cd /project/aamjad/RNAseq_June2025/raw/fastq/RNAseq/Align

########################################################################
######## filenames
FILE1='20240903-129-Veh_S7_BT2_mapped2GRCm38_sort.bam'
FILE2='20240903-129-E2-2h_S8_BT2_mapped2GRCm38_sort.bam'
FILE3='20240903-129-E2-6h_S9_BT2_mapped2GRCm38_sort.bam'
FILE4='20241009-129-Veh_S13_BT2_mapped2GRCm38_sort.bam'
FILE5='20241009-129-E2-2h_S14_BT2_mapped2GRCm38_sort.bam'
FILE6='20241009-129-E2-6h_S15_BT2_mapped2GRCm38_sort.bam'
FILE7='N2K23_14717_1_20250217-129-Veh_S1_L002_BT2_mapped2GRCm38_sort.bam'
FILE8='N2K23_14717_2_20250217-129-E2-2hr_S2_L002_BT2_mapped2GRCm38_sort.bam'
FILE9='N2K23_14717_3_20250217-129-E2-6hr_S3_L002_BT2_mapped2GRCm38_sort.bam'
FILE10='20240826-FVB-Veh_S4_BT2_mapped2GRCm38_sort.bam'
FILE11='20240826-FVB-E2-2h_S5_BT2_mapped2GRCm38_sort.bam'
FILE12='20240826-FVB-E2-6h_S6_BT2_mapped2GRCm38_sort.bam'
FILE13='N2K23_14717_10_20250415-FVB_Veh_S10_L002_BT2_mapped2GRCm38_sort.bam'
FILE14='N2K23_14717_11_20250415-FVB_E2-2hr_S11_L002_BT2_mapped2GRCm38_sort.bam'
FILE15='N2K23_14717_12_20250415-FVB_E2-6hr_S12_L002_BT2_mapped2GRCm38_sort.bam'
FILE16='N2K23_14717_4_20250224-FVB-Veh_S4_L002_BT2_mapped2GRCm38_sort.bam'
FILE17='N2K23_14717_5_20250224-FVB-E2-2hr_S5_L002_BT2_mapped2GRCm38_sort.bam'
FILE18='N2K23_14717_6_20250224-FVB-E2-6hr_S6_L002_BT2_mapped2GRCm38_sort.bam'
FILE19='N2K23_14717_7_20250331-FVB_Veh_S7_L002_BT2_mapped2GRCm38_sort.bam'
FILE20='N2K23_14717_8_20250331-FVB_E2-2hr_S8_L002_BT2_mapped2GRCm38_sort.bam'
FILE21='N2K23_14717_9_20250331-FVB_E2-6hr_S9_L002_BT2_mapped2GRCm38_sort.bam'

########################################################################
featureCounts -a /project/shared/Gencode_mouse_VM25/transcriptomeindex/gencode.vm25.annotation.gtf -t exon -T 16 -o Deseq-outs/counts_Rseq.txt -s 2 -M --fraction $FILE1 $FILE2 $FILE3 $FILE4 $FILE5 $FILE6 $FILE7 $FILE8 $FILE9 $FILE10 $FILE11 $FILE12 $FILE13 $FILE14 $FILE15 $FILE16 $FILE17 $FILE18 $FILE19 $FILE20 $FILE21
