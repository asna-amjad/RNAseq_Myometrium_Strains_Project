#!/bin/bash
#SBATCH -J wig                                                   # job name
#SBATCH -p super                                                 # select partion from 128GB, 256GB, 384GB, GPU and super
#SBATCH -N 1                                                     # number of nodes requested by user
#SBATCH -t 0-20:35:30                                            # run time, format: D-H:M:S (max wallclock time)
#SBATCH -o wig_C3H.bsh.o%j                                       # standard output file name
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu                # specify an email address
#SBATCH --mail-type=BEGIN                                        # send email when job status change (start, end, abortion and etc.)
#SBATCH --mail-type=END                                          # send email when job status change (start, end, abortion and etc.)
#SBATCH --mail-type=FAIL                                         # send email when job status change (start, end, abortion and etc.)


##### Remove sequencerID to reduce file size from the bed files
cd /project/aamjad/RNAseq_June2025/raw/fastq/RNAseq/Align

module load python/2.7.x-anaconda
module load bedtools/2.25.0
module load samtools/intel/1.3
module add RSeQC/2.6.4

export PATH=/project/shared/Scripts:$PATH
export PATH=/home/softwares/executables:$PATH

function MakeSignalTracks
{
##Sort replicates:
samtools sort $FILENAME1.bam -o $FILENAME1.sorted.bam
samtools sort $FILENAME2.bam -o $FILENAME2.sorted.bam
samtools sort $FILENAME3.bam -o $FILENAME3.sorted.bam


##Merge replicates, sort & index:
samtools merge $FILENAME5.bam $FILENAME1.sorted.bam $FILENAME2.sorted.bam $FILENAME3.sorted.bam
samtools sort $FILENAME5.bam -o $FILENAME5.sorted.bam
samtools index $FILENAME5.sorted.bam

##Check the library type:
infer_experiment.py -r GRCm38_mm10_RefSeq.bed -i $FILENAME5.sorted.bam

##Convert bam to wig:
bam2wig.py -s mm10.chrom.sizes -i $FILENAME5.sorted.bam -o tracks/$FILENAME5.sorted_strandSp -u -t 5950737333 -d "1+-,1-+,2++,2--"
##      Specified wigsum. 100000000 equals to coverage of 1 million 100nt reads. Ignore this option to disable normalization; In this case, read length is 50, average lib size is 100*31506397= 3150639700
}



FILENAME1="20241119-C3H-Veh_S22_BT2_mapped2GRCm38_sort"
FILENAME2="20241111-C3H-A-Veh_S16_BT2_mapped2GRCm38_sort"
FILENAME3="20241111-C3H-B-Veh_S19_BT2_mapped2GRCm38_sort"
FILENAME5="C3H_Veh"
MakeSignalTracks

FILENAME1="20241119-C3H-E2-2h_S23_BT2_mapped2GRCm38_sort"
FILENAME2="20241111-C3H-A-E2-2h_S17_BT2_mapped2GRCm38_sort"
FILENAME3="20241111-C3H-B-E2-2h_S20_BT2_mapped2GRCm38_sort"
FILENAME5="C3H_E2_2h"
MakeSignalTracks

FILENAME1="20241119-C3H-E2-6h_S24_BT2_mapped2GRCm38_sort"
FILENAME2="20241111-C3H-A-E2-6h_S18_BT2_mapped2GRCm38_sort"
FILENAME3="20241111-C3H-B-E2-6h_S21_BT2_mapped2GRCm38_sort"
FILENAME5="C3H_E2_6h"
MakeSignalTracks
