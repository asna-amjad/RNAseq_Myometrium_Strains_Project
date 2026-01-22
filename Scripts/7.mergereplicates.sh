#!/bin/bash
#SBATCH -J merge                                           # job name
#SBATCH -p super                                 # select partion from 128GB  256GB  384GB  GPU and super
#SBATCH --nodes=1                                         # number of nodes requested by user
#SBATCH --time=0-48:00:00                                 # run time, format: D-H:M:S (max wallclock time)
#SBATCH --output=merge_%j.out                         # standard output file name
#SBATCH --error=merge_%j.error                        # standard error output file name
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu           # specify an email address
#SBATCH --mail-type=ALL                                   # send email when job status change (start, end, abortion and etc.)



#cd /project/GCRB/Lee_Lab/shared/Elizabeth/RNAseq_Feb2025/RNAseq_LIZ/Align
###########################################################################
### This step should be altered depending on the number of sequencing runs
### are in the experiment. In general, one can edit this part of the code
### to merge technical replicates, remove duplicates and get the mapping statistics

### STEPS:
### 1.Merge technical reps Bam: Merge Rep1,3,5 and Rep2,4,6 and treat as R1, R2 (optional)
### 2.Remove dups from R1, R2
### Check Alignment stats
###########################################################################

cd /project/aamjad/RNAseq_June2025/raw/fastq/RNAseq/Align

#Load required modules
module load samtools/0.1.19
module load bedtools/2.17.0
module load picard/2.10.3

mkdir mergedReps

function BamMergeRepsGetBed {
echo "Merging technical replicates:" "$FILENAME4"
echo "TechRep1 from round1:" "$FILENAME1"
echo "TechRep2 from round2:" "$FILENAME2"
echo "TechRep3 from round3:" "$FILENAME3"

# Merge bams:
echo "Merging replicates and sorting merged file..."
samtools merge SEmergeRepsFVB/$NAME.bam $File2.bam $File3.bam $File4.bam
samtools sort SEmergeRepsFVB/$NAME.bam mergedReps/$NAME.sorted

# Create index for merged bam
echo "Creating Index for merged bam..."
samtools index SEmergeRepsFVB/$NAME.sorted.bam SEmergeRepsFVB/$NAME.sorted.bam.bai


#File1="20240826-FVB-Veh_S4_BT2_mapped2GRCm38_sort"
File2="N2K23_14717_10_20250415-FVB_Veh_S10_L002_BT2_mapped2GRCm38_sort"
File3="N2K23_14717_4_20250224-FVB-Veh_S4_L002_BT2_mapped2GRCm38_sort"
File4="N2K23_14717_7_20250331-FVB_Veh_S7_L002_BT2_mapped2GRCm38_sort"
NAME="FVB_Veh_merged_SE"
BamMergeRepsGetBed

#File1="20240826-FVB-E2-2h_S5_BT2_mapped2GRCm38_sort"
File2="N2K23_14717_11_20250415-FVB_E2-2hr_S11_L002_BT2_mapped2GRCm38_sort"
File3="N2K23_14717_5_20250224-FVB-E2-2hr_S5_L002_BT2_mapped2GRCm38_sort"
File4="N2K23_14717_8_20250331-FVB_E2-2hr_S8_L002_BT2_mapped2GRCm38_sort"
NAME="FVB_E2_2h_merged_SE"
BamMergeRepsGetBed

#File1="20240826-FVB-E2-6h_S6_BT2_mapped2GRCm38_sort"
File2="N2K23_14717_12_20250415-FVB_E2-6hr_S12_L002_BT2_mapped2GRCm38_sort"
File3="N2K23_14717_6_20250224-FVB-E2-6hr_S6_L002_BT2_mapped2GRCm38_sort"
File4="N2K23_14717_9_20250331-FVB_E2-6hr_S9_L002_BT2_mapped2GRCm38_sort"
NAME="FVB_E2_6h_merged_SE"
BamMergeRepsGetBed

#File1="20240903-129-Veh_S7_BT2_mapped2GRCm38_sort"
#File2="20241009-129-Veh_S13_BT2_mapped2GRCm38_sort"
#File3="N2K23_14717_1_20250217-129-Veh_S1_L002_BT2_mapped2GRCm38_sort"
#NAME="129_Veh_merged"
#BamMergeRepsGetBed

#File1="20240903-129-E2-2h_S8_BT2_mapped2GRCm38_sort"
#File2="20241009-129-E2-2h_S14_BT2_mapped2GRCm38_sort"
#File3="N2K23_14717_2_20250217-129-E2-2hr_S2_L002_BT2_mapped2GRCm38_sort"
#NAME="129_E2_2h_merged"
#BamMergeRepsGetBed

#File1="20240903-129-E2-6h_S9_BT2_mapped2GRCm38_sort"
#File2="20241009-129-E2-6h_S15_BT2_mapped2GRCm38_sort"
#File3="N2K23_14717_3_20250217-129-E2-6hr_S3_L002_BT2_mapped2GRCm38_sort"
#NAME="129_E2_6h_merged"
#BamMergeRepsGetBed
