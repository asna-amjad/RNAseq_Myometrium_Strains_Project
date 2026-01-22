#!/bin/bash
#SBATCH -J correlationplo
#SBATCH -p super
#SBATCH -N 2
#SBATCH -t 0-12:35:30
#SBATCH --output=correlationplot_%j.out
#SBATCH --error=correlationplot_%j.err
#SBATCH --mail-user=asna.amjad@utsouthwestern.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL


module load samtools
module load deeptools/3.5.0

## Generate index of all .bam files
samtools index N2K23_14717_10_20250415-FVB_Veh_S10_L002_BT2_mapped2GRCm38_sort.bam

export PATH=/work/GCRB/s235990/rna-seq-pipeline:$PATH
cd cd /project/aamjad/RNAseq_June2025/raw/fastq/RNAseq/Align

mkdir crosscorrelations

function correlations {
multiBamSummary bins --bamfiles ${File1}.bam ${File2}.bam ${File3}.bam ${File4}.bam -o crosscorrelations/$NAME.npz
plotCorrelation -in crosscorrelations/$NAME.npz --corMethod pearson --skipZeros --plotTitle "Pearson Correlation Scatterplot" --whatToPlot heatmap --plotNumbers -o crosscorrelations/$NAME.heatmap.png
plotCorrelation -in crosscorrelations/$NAME.npz --corMethod pearson --skipZeros --plotTitle "Pearson Correlation HeatMapplot" --whatToPlot scatterplot -o crosscorrelations/$NAME.scatterplot.png --outFileCorMatrix crosscorrelations/$NAME_PearsonCorr.tab
}


##########################$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$####################################
### Samples
##########################$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$####################################

#1.################################################
#File1="SRR9409783"
#File2="SRR9409784"
#NAME="WT"
#correlations

#2.################################################
File1="20240903-129-Veh_S7_BT2_mapped2GRCm38_sort"
File2="20241009-129-Veh_S13_BT2_mapped2GRCm38_sort"
File3="N2K23_14717_1_20250217-129-Veh_S1_L002_BT2_mapped2GRCm38_sort"
NAME="129_Veh_merged"
correlations

File1="20240903-129-E2-2h_S8_BT2_mapped2GRCm38_sort"
File2="20241009-129-E2-2h_S14_BT2_mapped2GRCm38_sort"
File3="N2K23_14717_2_20250217-129-E2-2hr_S2_L002_BT2_mapped2GRCm38_sort"
NAME="129_E2_2h_merged"
correlations

File1="20240903-129-E2-6h_S9_BT2_mapped2GRCm38_sort"
File2="20241009-129-E2-6h_S15_BT2_mapped2GRCm38_sort"
File3="N2K23_14717_3_20250217-129-E2-6hr_S3_L002_BT2_mapped2GRCm38_sort"
NAME="129_E2_6h_merged"
correlations

File1="20240826-FVB-Veh_S4_BT2_mapped2GRCm38_sort"
File2="N2K23_14717_10_20250415-FVB_Veh_S10_L002_BT2_mapped2GRCm38_sort"
File3="N2K23_14717_4_20250224-FVB-Veh_S4_L002_BT2_mapped2GRCm38_sort"
File4="N2K23_14717_7_20250331-FVB_Veh_S7_L002_BT2_mapped2GRCm38_sort"
NAME="FVB_Veh_merged"
correlations

File1="20240826-FVB-E2-2h_S5_BT2_mapped2GRCm38_sort"
File2="N2K23_14717_11_20250415-FVB_E2-2hr_S11_L002_BT2_mapped2GRCm38_sort"
File3="N2K23_14717_5_20250224-FVB-E2-2hr_S5_L002_BT2_mapped2GRCm38_sort"
File4="N2K23_14717_8_20250331-FVB_E2-2hr_S8_L002_BT2_mapped2GRCm38_sort"
NAME="FVB_E2_2h_merged"
correlations

File1="20240826-FVB-E2-6h_S6_BT2_mapped2GRCm38_sort"
File2="N2K23_14717_12_20250415-FVB_E2-6hr_S12_L002_BT2_mapped2GRCm38_sort"
File3="N2K23_14717_6_20250224-FVB-E2-6hr_S6_L002_BT2_mapped2GRCm38_sort"
File4="N2K23_14717_9_20250331-FVB_E2-6hr_S9_L002_BT2_mapped2GRCm38_sort"
NAME="FVB_E2_6h_merged"
correlations

#File1="20240903-C57-Veh_S10_BT2_mapped2GRCm38_sort"
#File2="20241104-C57-Veh_S25_BT2_mapped2GRCm38_sort"
#AME="C57_Veh_merged"
#correlations

#File1="20240903-C57-E2-2h_S11_BT2_mapped2GRCm38_sort"
#File2="20241104-C57-E2-2h_S26_BT2_mapped2GRCm38_sort"
#NAME="C57_E2_2h_merged"
#correlations

#File1="20240903-C57-E2-6h_S12_BT2_mapped2GRCm38_sort"
#File2="20241104-C57-E2-6h_S27_BT2_mapped2GRCm38_sort"
#NAME="C57_E2_6h_merged"
#correlations

#File1="20240903-129-Veh_S7_BT2_mapped2GRCm38_sort"
#File2="20241009-129-Veh_S13_BT2_mapped2GRCm38_sort"
#NAME="129_Veh_merged"
#correlations

#File1="20240903-129-E2-2h_S8_BT2_mapped2GRCm38_sort"
#File2="20241009-129-E2-2h_S14_BT2_mapped2GRCm38_sort"
#NAME="129_E2_2h_merged"
#correlations

#File1="20240903-129-E2-6h_S9_BT2_mapped2GRCm38_sort"
#File2="20241009-129-E2-6h_S15_BT2_mapped2GRCm38_sort"
#NAME="129_E2_6h_merged"
#correlations

#File1="20240821-PWD-Veh_S1_BT2_mapped2GRCm38_sort"
#File2="20241105-PWD-Veh_S28_BT2_mapped2GRCm38_sort"
#File3="20241112-PWD-Veh_S31_BT2_mapped2GRCm38_sort"
#File4="20241205-PWD-Veh_S34_BT2_mapped2GRCm38_sort"
#NAME="PWD_Veh_merged"
#correlations

#File1="20240821-PWD-E2-2h_S2_BT2_mapped2GRCm38_sort"
#File2="20241105-PWD-E2-2h_S29_BT2_mapped2GRCm38_sort"
#File3="20241112-PWD-E2-2h_S32_BT2_mapped2GRCm38_sort"
#File4="20241205-PWD-E2-2h_S35_BT2_mapped2GRCm38_sort"
#NAME="PWD_E2_2h_merged"
#correlations

#File1="20240821-PWD-E2-6h_S3_BT2_mapped2GRCm38_sort"
#File2="20241105-PWD-E2-6h_S30_BT2_mapped2GRCm38_sort"
#File3="20241112-PWD-E2-6h_S33_BT2_mapped2GRCm38_sort"
#File4="20241205-PWD-E2-6h_S36_BT2_mapped2GRCm38_sort"
#NAME="PWD_E2_6h_merged"
#correlations
