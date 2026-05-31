# Define thresholds for statistical significance (FDR) and biological effect size
padj_cutoff <- 0.05
lfc_cutoff <- 1

# Define significant genes
res_clean$significant <- ifelse(res_clean$padj < padj_cutoff & abs(res_clean$log2FC) > lfc_cutoff, "Significant", "Not Significant")

# Summarize distribution of shrinkage-adjusted log2 fold changes
summary(res_clean$log2FC)

# Identify top downregulated genes
down_genes <- res_clean[
  !is.na(res_clean$symbol) & res_clean$log2FC < -lfc_cutoff,
]

# Rank downregulated genes by magnitude of fold change
down_genes <- down_genes[order(down_genes$log2FC), ]

# Inspect top downregulated genes by gene symbol
head(na.omit(down_genes$symbol), 5)

# Define biologically relevant genes of interest for annotation in visualization
genes_of_interest <- c(
  "IFIT1", "IFIT3", "ISG15", "MX1",
  "RSAD2", "LINGO2", "TENM4"
)

# Subset selected genes for labeling in volcano plot
label_data <- res_clean[
  res_clean$symbol %in% genes_of_interest &
    res_clean$significant,
]

# Generate volcano plot using shrinkage-adjusted log2 fold changes and FDR values
ggplot(res_clean, aes(x = log2FC, y = -log10(padj))) +
  
  geom_point(aes(color = significant), alpha = 0.6, size = 1.2) +
  scale_color_manual(values = c("Not Significant" = "grey70", "Significant" = "firebrick")) +
  
  geom_vline(xintercept = c(-lfc_cutoff, lfc_cutoff),
             linetype = "dashed") +
  geom_hline(yintercept = -log10(padj_cutoff),
             linetype = "dashed") +
  
  geom_text_repel(
    data = label_data,
    aes(label = symbol),
    size = 3,
    max.overlaps = Inf
  ) +
  
  theme_classic() +
  
  labs(
    title = "Volcano Plot of Differential Gene Expression",
    x = "Log2 Fold Change (shrunken)",
    y = "-Log10 Adjusted P-value"
  )

# Save plot
ggsave("volcano_plot.png", width = 6, height = 5, dpi = 300)

# Save supporting outputs
write.csv(down_genes, "top_downregulated_genes.csv")
write.csv(label_data, "genes_labeled_volcano.csv")