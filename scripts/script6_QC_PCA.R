# Create DESeq2 object from counts and metadata (Love et al., 2014)
dds <- DESeqDataSetFromMatrix(
  countData = raw_counts_ensg,
  colData = metadata,
  design = ~ condition
)

# Transform count data using variance stabilizing transformation for PCA visualization (Love et al., 2014)
vsd <- vst(dds, blind = FALSE)

# Perform PCA to assess sample clustering by experimental condition (Love et al., 2014)
plotPCA(vsd, intgroup = "condition")

# Compute pairwise Euclidean distances between samples using VST-transformed expression values for global similarity assessment
sampleDists <- dist(t(assay(vsd)))

# Visualize sample-to-sample distances as a heatmap to assess clustering and detect potential outliers (Kolde, 2025)
pheatmap(as.matrix(sampleDists),
         main = "Sample Distance Heatmap")

# Compute total library sizes per sample to evaluate sequencing depth consistency across conditions
colSums(assay(dds))


