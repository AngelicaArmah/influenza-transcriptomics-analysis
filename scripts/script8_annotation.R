# Remove NA padj
res_clean <- res[!is.na(res$padj), ]

# Create ranked gene list (USE SHRUNK VALUES)
ranked_genes <- resLFC$log2FoldChange
names(ranked_genes) <- rownames(resLFC)
ranked_genes <- na.omit(ranked_genes) # Remove any structural NAs
ranked_genes <- sort(ranked_genes, decreasing = TRUE)

# Map Ensembl IDs to gene symbols
gene_symbols <- mapIds(
  org.Hs.eg.db,
  keys = rownames(res_clean),
  column = "SYMBOL",
  keytype = "ENSEMBL",
  multiVals = "first"
)

# Add symbols
res_clean$symbol <- gene_symbols

# Add shrunk log2FC (CORRECT VERSION)
res_clean$log2FC <- resLFC[rownames(res_clean), "log2FoldChange"]

# Save outputs
write.csv(res_clean, "DE_results_annotated.csv")
write.csv(ranked_genes, "ranked_gene_list.csv")
