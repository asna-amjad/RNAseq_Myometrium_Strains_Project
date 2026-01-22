library(DESeq2)
library(ggpubr)
library(gplots)

setwd("/Users/Desktop/RNAseq/")

##########################################################
###colnames(data) <- c("Geneid","Chr","Start","End","Strand","Length","Veh_rep1","E2_1pm_rep1","E2_10pm_rep1","E2_100pm_rep1","E2_500pm_rep1","E2_1nm_rep1","E2_10nm_rep1","E2_100nm_rep1","Veh_rep2","E2_1pm_rep2","E2_10pm_rep2","E2_100pm_rep2","E2_500pm_rep2","E2_1nm_rep2","E2_10nm_rep2","E2_100nm_rep2")
###"20240903-129-Veh_S7_BT2_mapped2GRCm38_sort.bam","20240903-129-E2-2h_S8_BT2_mapped2GRCm38_sort.bam","20240903-129-E2-6h_S9_BT2_mapped2GRCm38_sort.bam","20241009-129-Veh_S13_BT2_mapped2GRCm38_sort.bam","20241009-129-E2-2h_S14_BT2_mapped2GRCm38_sort.bam","20241009-129-E2-6h_S15_BT2_mapped2GRCm38_sort.bam","20240903-C57-Veh_S10_BT2_mapped2GRCm38_sort.bam","20240903-C57-E2-2h_S11_BT2_mapped2GRCm38_sort.bam","20240903-C57-E2-6h_S12_BT2_mapped2GRCm38_sort.bam","20241104-C57-Veh_S25_BT2_mapped2GRCm38_sort.bam","20241104-C57-E2-2h_S26_BT2_mapped2GRCm38_sort.bam","20241104-C57-E2-6h_S27_BT2_mapped2GRCm38_sort.bam","20241111-C3H-A-Veh_S16_BT2_mapped2GRCm38_sort.bam","20241111-C3H-A-E2-2h_S17_BT2_mapped2GRCm38_sort.bam","20241111-C3H-A-E2-6h_S18_BT2_mapped2GRCm38_sort.bam","20241111-C3H-B-Veh_S19_BT2_mapped2GRCm38_sort.bam","20241111-C3H-B-E2-2h_S20_BT2_mapped2GRCm38_sort.bam","20241111-C3H-B-E2-6h_S21_BT2_mapped2GRCm38_sort.bam","20241119-C3H-Veh_S22_BT2_mapped2GRCm38_sort.bam","20241119-C3H-E2-2h_S23_BT2_mapped2GRCm38_sort.bam","20241119-C3H-E2-6h_S24_BT2_mapped2GRCm38_sort.bam","20240826-FVB-Veh_S4_BT2_mapped2GRCm38_sort.bam","20240826-FVB-E2-2h_S5_BT2_mapped2GRCm38_sort.bam","20240826-FVB-E2-6h_S6_BT2_mapped2GRCm38_sort.bam","20240821-PWD-Veh_S1_BT2_mapped2GRCm38_sort.bam","20240821-PWD-E2-2h_S2_BT2_mapped2GRCm38_sort.bam","20240821-PWD-E2-6h_S3_BT2_mapped2GRCm38_sort.bam","20241105-PWD-Veh_S28_BT2_mapped2GRCm38_sort.bam","20241105-PWD-E2-2h_S29_BT2_mapped2GRCm38_sort.bam","20241105-PWD-E2-6h_S30_BT2_mapped2GRCm38_sort.bam","20241112-PWD-Veh_S31_BT2_mapped2GRCm38_sort.bam","20241112-PWD-E2-2h_S32_BT2_mapped2GRCm38_sort.bam","20241112-PWD-E2-6h_S33_BT2_mapped2GRCm38_sort.bam","20241205-PWD-Veh_S34_BT2_mapped2GRCm38_sort.bam","20241205-PWD-E2-2h_S35_BT2_mapped2GRCm38_sort.bam","20241205-PWD-E2-6h_S36_BT2_mapped2GRCm38_sort.bam"
###"129-Veh_R1","129-E2-2h_R1","129-E2-6h_R2","129-Veh_R2","129-E2-2h_R2","129-E2-6h_R2","C57-Veh_R1","C57-E2-2h_R1","C57-E2-6h_R1","C57-Veh_R2","C57-E2-2h_R2","C57-E2-6h_R2","C3H-A-Veh_R1","C3H-A-E2-2h_R1","C3H-A-E2-6h_R1","C3H-B-Veh_R2","C3H-B-E2-2h_R2","C3H-B-E2-6h_R2","C3H-Veh_R3","C3H-E2-2h_R3","C3H-E2-6h_R3","FVB-Veh_R1","FVB-E2-2h_R1","FVB-E2-6h_R1","PWD-Veh_R1","PWD-E2-2h_R1","PWD-E2-6h_R1","PWD-Veh_R2","PWD-E2-2h_R2","PWD-E2-6h_R2","PWD-Veh_R3","PWD-E2-2h_R3","PWD-E2-6h_R3","PWD-Veh_R4","PWD-E2-2h_R4","PWD-E2-6h_R4"

data1<-read.table("counts_Rseq.txt",sep="\t",header = TRUE)
colnames(data1) <- c("Geneid","Chr","Start","End","Strand","Length","129_Veh_R1","129_E2_2h_R1","129_E2_6h_R1","129_Veh_R2","129_E2_2h_R2","129_E2_6h_R2","C57_Veh_R1","C57_E2_2h_R1","C57_E2_6h_R1","C57_Veh_R2","C57_E2_2h_R2","C57_E2_6h_R2","C3H_A_Veh_R1","C3H_A_E2_2h_R1","C3H_A_E2_6h_R1","C3H_B_Veh_R2","C3H_B_E2_2h_R2","C3H_B_E2_6h_R2","C3H_Veh_R3","C3H_E2_2h_R3","C3H_E2_6h_R3","FVB_Veh_R1","FVB_E2_2h_R1","FVB_E2_6h_R1","PWD_Veh_R1","PWD_E2_2h_R1","PWD_E2_6h_R1","PWD_Veh_R2","PWD_E2_2h_R2","PWD_E2_6h_R2","PWD_Veh_R3","PWD_E2_2h_R3","PWD_E2_6h_R3","PWD_Veh_R4","PWD_E2_2h_R4","PWD_E2_6h_R4")
a1<-subset(data1,select=`129_Veh_R1`:`PWD_E2_6h_R4`)
cts1<-as.matrix(a1)	# count matrix
cts1<-round(cts1,0)
row.names(cts1)<-data1$Geneid
coldata1<-read.csv("RNAseqcoldata.tsv",sep="\t",header=T,row.names=1)
condition <- factor(coldata1$condition, levels=c("129_Veh","129_E2_2h","129_E2_6h","C57_Veh","C57_E2_2h","C57_E2_6h","C3H_Veh","C3H_E2_2h","C3H_E2_6h","FVB_Veh","FVB_E2_2h","FVB_E2_6h","PWD_Veh","PWD_E2_2h","PWD_E2_6h"))
#condition <- factor(coldata1$condition, levels=c("PWD_Veh","PWD_E2_2h","PWD_E2_6h"))

dds <- DESeqDataSetFromMatrix(countData=cts1, colData=coldata1, design=~condition)
keep <- rowSums(counts(dds)) >= 10 # only keeping rows with fold changes more than or equal to 10
dds <- dds[keep,]
dds_norm_estimatesize <- estimateSizeFactors(dds)
deseq_Ncounts <- as.data.frame(counts(dds_norm_estimatesize, normalized=TRUE))
write.table(deseq_Ncounts, "Liz_counts_rnaseq_all_samples_normalizedcounts.txt",sep="\t",quote=F)

dds <- DESeq(dds)
rld <- rlogTransformation(dds)
resultsNames(dds)

library(ggplot2)
vsdata <- vst(dds, blind=FALSE)
pdf("Liz_RNAseqplot.pdf")
plotPCA(vsdata) + geom_text(size=2,aes(label=name),vjust=2)
dev.off()

 #normlzd_dds <- counts(dds_norm_estimatesize, normalized=TRUE)
#pdf("Liz_RNAseq_DEG_hclust.pdf")
#plot(hclust(dist(t(normlzd_dds))), labels=colData(dds)$protocol)
#dev.off()

################### 129 Veh vs. 129 E2 2h ######################
res<- results(dds, contrast=c("condition","129_E2_2h","129_Veh"))
res <- res[order(res$padj), ]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
write.table(resdata, file="1.129_E2_2hrvsVeh_DESEQ2.txt",sep="\t",quote=F,row.names=T)

resdata <- read.table("1.129_E2_2hrvsVeh_DESEQ2.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) #64
up <- subset(resultsAlpha, log2FoldChange>=0.58 )
NROW(up) #60
up$RegStatus <- paste("UP_in_129_E2_2h")

down <- subset(resultsAlpha, log2FoldChange <= -0.58)
NROW(down) #4
down$RegStatus <- paste("DOWN_in_129_E2_2h")

DEG_1 <- rbind(up,down)
NROW(DEG_1) #64
write.table(DEG_1, file="129_E2_2h_DEGs.txt",sep="\t",quote=F,row.names=T)

################### 129 Veh vs. 129 E2 6h ######################
res<- results(dds, contrast=c("condition","129_E2_6h","129_Veh"))
res <- res[order(res$padj), ]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
write.table(resdata, file="1.129_E2_6hrvsVeh_DESEQ2.txt",sep="\t",quote=F,row.names=T)

resdata <- read.table("1.129_E2_6hrvsVeh_DESEQ2.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) #87
up <- subset(resultsAlpha, log2FoldChange>=0.58 )
NROW(up) #84
up$RegStatus <- paste("UP_in_129_E2_6h")

down <- subset(resultsAlpha, log2FoldChange <= -0.58)
NROW(down) #3
down$RegStatus <- paste("DOWN_in_129_E2_6h")

DEG_2 <- rbind(up,down)
NROW(DEG_2) #87
write.table(DEG_2, file="129_E2_6h_DEGs.txt",sep="\t",quote=F,row.names=T)

################### C57 Veh vs. C57 E2 2h ######################
res<- results(dds, contrast=c("condition","C57_E2_2h","C57_Veh"))
res <- res[order(res$padj), ]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
write.table(resdata, file="2.C57_E2_2hrvsVeh_DESEQ2.txt",sep="\t",quote=F,row.names=T)

resdata <- read.table("2.C57_E2_2hrvsVeh_DESEQ2.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) #151
up <- subset(resultsAlpha, log2FoldChange>=0.58 )
NROW(up) #115
up$RegStatus <- paste("UP_in_C57_E2_2h")

down <- subset(resultsAlpha, log2FoldChange <= -0.58)
NROW(down) #33
down$RegStatus <- paste("DOWN_in_C57_E2_2h")

DEG_3 <- rbind(up,down)
NROW(DEG_3) #148
write.table(DEG_3, file="C57_E2_2h_DEGs.txt",sep="\t",quote=F,row.names=T)

################### C57 Veh vs. C57 E2 6h ######################
res<- results(dds, contrast=c("condition","C57_E2_6h","C57_Veh"))
res <- res[order(res$padj), ]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
write.table(resdata, file="2.C57_E2_6hrvsVeh_DESEQ2.txt",sep="\t",quote=F,row.names=T)

resdata <- read.table("2.C57_E2_6hrvsVeh_DESEQ2.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) #94
up <- subset(resultsAlpha, log2FoldChange>=0.58 )
NROW(up) #90
up$RegStatus <- paste("UP_in_C57_E2_6h")

down <- subset(resultsAlpha, log2FoldChange <= -0.58)
NROW(down) #3
down$RegStatus <- paste("DOWN_in_C57_E2_6h")

DEG_4 <- rbind(up,down)
NROW(DEG_4) #93
write.table(DEG_4, file="C57_E2_6h_DEGs.txt",sep="\t",quote=F,row.names=T)

################### C3H Veh vs. C3H E2 2h ######################
res<- results(dds, contrast=c("condition","C3H_E2_2h","C3H_Veh"))
res <- res[order(res$padj), ]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
write.table(resdata, file="3.C3H_E2_2hrvsVeh_DESEQ2.txt",sep="\t",quote=F,row.names=T)

resdata <- read.table("3.C3H_E2_2hrvsVeh_DESEQ2.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) #66
up <- subset(resultsAlpha, log2FoldChange>=0.58 )
NROW(up) #62
up$RegStatus <- paste("UP_in_C3H_E2_2h")

down <- subset(resultsAlpha, log2FoldChange <= -0.58)
NROW(down) #4
down$RegStatus <- paste("DOWN_in_C3H_E2_2h")

DEG_5 <- rbind(up,down)
NROW(DEG_5) #66
write.table(DEG_5, file="C3H_E2_2h_DEGs.txt",sep="\t",quote=F,row.names=T)

################### C3H Veh vs. C3H E2 6h ######################
res<- results(dds, contrast=c("condition","C3H_E2_6h","C3H_Veh"))
res <- res[order(res$padj), ]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
write.table(resdata, file="3.C3H_E2_6hrvsVeh_DESEQ2.txt",sep="\t",quote=F,row.names=T)

resdata <- read.table("3.C3H_E2_6hrvsVeh_DESEQ2.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) #66
up <- subset(resultsAlpha, log2FoldChange>=0.58 )
NROW(up) #60
up$RegStatus <- paste("UP_in_C3H_E2_6h")

down <- subset(resultsAlpha, log2FoldChange <= -0.58)
NROW(down) #5
down$RegStatus <- paste("DOWN_in_C3H_E2_6h")

DEG_6 <- rbind(up,down)
NROW(DEG_6) #65
write.table(DEG_6, file="C3H_E2_6h_DEGs.txt",sep="\t",quote=F,row.names=T)

################### FVB Veh vs. FVB E2 2h ######################
res<- results(dds, contrast=c("condition","FVB_E2_2h","FVB_Veh"))
res <- res[order(res$padj), ]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
write.table(resdata, file="4.FVB_E2_2hrvsVeh_DESEQ2.txt",sep="\t",quote=F,row.names=T)

resdata <- read.table("4.FVB_E2_2hrvsVeh_DESEQ2.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) #45
up <- subset(resultsAlpha, log2FoldChange>=0.58 )
NROW(up) #39
up$RegStatus <- paste("UP_in_FVB_E2_2h")

down <- subset(resultsAlpha, log2FoldChange <= -0.58)
NROW(down) #6
down$RegStatus <- paste("DOWN_in_FVB_E2_2h")

DEG_7 <- rbind(up,down)
NROW(DEG_7) #45
write.table(DEG_7, file="FVB_E2_2h_DEGs.txt",sep="\t",quote=F,row.names=T)

################### FVB Veh vs. FVB E2 6h ######################
res<- results(dds, contrast=c("condition","FVB_E2_6h","FVB_Veh"))
res <- res[order(res$padj), ]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
write.table(resdata, file="4.FVB_E2_6hrvsVeh_DESEQ2.txt",sep="\t",quote=F,row.names=T)

resdata <- read.table("4.FVB_E2_6hrvsVeh_DESEQ2.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) #27
up <- subset(resultsAlpha, log2FoldChange>=0.58 )
NROW(up) #26
up$RegStatus <- paste("UP_in_FVB_E2_6h")

down <- subset(resultsAlpha, log2FoldChange <= -0.58)
NROW(down) #1
down$RegStatus <- paste("DOWN_in_FVB_E2_6h")

DEG_8 <- rbind(up,down)
NROW(DEG_8) #27
write.table(DEG_8, file="FVB_E2_6h_DEGs.txt",sep="\t",quote=F,row.names=T)

################### PWD Veh vs. PWD E2 2h ######################
res<- results(dds, contrast=c("condition","PWD_E2_2h","PWD_Veh"))
res <- res[order(res$padj), ]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
write.table(resdata, file="5.PWD_E2_2hrvsVeh_DESEQ2.txt",sep="\t",quote=F,row.names=T)

resdata <- read.table("5.PWD_E2_2hrvsVeh_DESEQ2.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) #182
up <- subset(resultsAlpha, log2FoldChange>=0.58 )
NROW(up) #165
up$RegStatus <- paste("UP_in_PWD_E2_2h")

down <- subset(resultsAlpha, log2FoldChange <= -0.58)
NROW(down) #10
down$RegStatus <- paste("DOWN_in_PWD_E2_2h")

DEG_9 <- rbind(up,down)
NROW(DEG_9) #175
write.table(DEG_9, file="PWD_E2_2h_DEGs.txt",sep="\t",quote=F,row.names=T)

################### PWD Veh vs. PWD E2 6h ######################
res<- results(dds, contrast=c("condition","PWD_E2_6h","PWD_Veh"))
res <- res[order(res$padj), ]
resdata <- merge(as.data.frame(res), as.data.frame(counts(dds, normalized=TRUE)), by="row.names", sort=FALSE)
names(resdata)[1] <- "Gene"
write.table(resdata, file="5.PWD_E2_6hrvsVeh_DESEQ2.txt",sep="\t",quote=F,row.names=T)

resdata <- read.table("5.PWD_E2_6hrvsVeh_DESEQ2.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha) #206
up <- subset(resultsAlpha, log2FoldChange>=0.58 )
NROW(up) #188
up$RegStatus <- paste("UP_in_PWD_E2_6h")

down <- subset(resultsAlpha, log2FoldChange <= -0.58)
NROW(down) #12
down$RegStatus <- paste("DOWN_in_PWD_E2_6h")

DEG_10 <- rbind(up,down)
NROW(DEG_10) #200
write.table(DEG_10, file="PWD_E2_6h_DEGs.txt",sep="\t",quote=F,row.names=T)

#####To get up and down regulated genes: FC cut off 2
resdata <- read.table("5.PWD_E2_6hrvsVeh_DESEQ2.txt",header=T,sep="\t")
resultsAlpha <- resdata[which(resdata$padj < 0.05),]
NROW(resultsAlpha)
up <- subset(resultsAlpha, log2FoldChange >= 1 )
NROW(up) #161
up$RegStatus <- paste("UP_in_PWD_E2_6h")

down <- subset(resultsAlpha, log2FoldChange <= -1)
NROW(down) #8
down$RegStatus <- paste("DOWN_in_PWD_E2_6h")


