# Run full DESeq2 pipeline (normalization, dispersion, model fitting) (Love et al., 2014)
dds <- DESeq(dds)

# Extract differential expression results with defined contrast
res <- results(dds, contrast = c("condition", "infection", "control"))

# Summarize differential expression results
summary(res)

# View top differentially expressed genes sorted by significance
head(res[order(res$padj, na.last = NA), ], 10)

# Plot p-value distribution for QC
hist(res$pvalue, breaks = 50, main = "P-value distribution", xlab = "p-value")

# Define significant genes (FDR < 0.05)
sig <- res[!is.na(res$padj) & res$padj < 0.05, ]

# Count significant genes
nrow(sig)

# Apply shrinkage to log2 fold changes to improve effect size estimation for visualization (Zhu et al., 2018)
resLFC <- lfcShrink(
  dds,
  coef = "condition_infection_vs_control",
  type = "apeglm"
)

# Save outputs
write.csv(as.data.frame(res), "DE_results_raw.csv")
write.csv(as.data.frame(resLFC), "DE_results_shrunk.csv")