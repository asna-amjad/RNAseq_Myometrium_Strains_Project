library(ggplot2)
library(ggrepel)
library(dplyr)

tr1 <- read.table("BYKBI4hr_OV4.txt", header = T, sep = "\t")
head(tr1)

tr1$diffexpressed <- "NO"
# if log2Foldchange > 0.6 and pvalue < 0.05, set as "UP" 
tr1$diffexpressed[tr1$log2FoldChange > 0.58 & tr1$pvalue < 0.05] <- "UP"
# if log2Foldchange < -0.6 and pvalue < 0.05, set as "DOWN"
tr1$diffexpressed[tr1$log2FoldChange < -0.58 & tr1$pvalue < 0.05] <- "DOWN"

tr1$delabel <- NA
tr1$delabel[tr1$diffexpressed != "NO"] <- tr1$gene[tr1$diffexpressed != "NO"]

# Subset of genes to highlight
highlight_genes <- c("ATF3", "CEBPD", "FOSL1")
#highlight_genes <- "FOSL1"
########################
# Volcano plot with label
ggplot(tr1, aes(x = log2FoldChange, y = -log10(pvalue))) +
  geom_point(color = "gray") +  # all points
  geom_point(data = tr1[tr1$gene == highlight_gene, ], 
             aes(x = log2FoldChange, y = -log10(pvalue)), 
             color = "red", size = 3) +  # highlight dot
  geom_text_repel(data = tr1[tr1$gene == highlight_gene, ],
                  aes(label = gene),
                  fontface = "bold",
                  color = "red",
                  size = 4) +
  theme_minimal()
##########################

## Used this for Plot
pdf("BYK_BI_4h_plot_DOWN_reg_v2.pdf")
ggplot(data=tr1, aes(x=log2FoldChange, y=-log10(pvalue),col=diffexpressed,label=delabel)) +
  geom_point() + 
  geom_point(data = tr1[tr1$gene %in% highlight_genes, ], 
             aes(x = log2FoldChange, y = -log10(pvalue)), 
             color ="forestgreen", size = 3) +  # highlight dot
  theme_minimal() +
  
  ## to add gene name on highlighted dots
  #geom_text_repel(data = tr1[tr1$gene %in% highlight_genes, ], 
   #               aes(label = gene), 
    #              size = 3, fontface = "bold", color = "black") +
  scale_color_manual(values=c("blue", "black", "red")) +
  geom_vline(xintercept=c(-0.58, 0.58), col="red") +
  geom_hline(yintercept=-log10(0.05), col="red")
dev.off()

