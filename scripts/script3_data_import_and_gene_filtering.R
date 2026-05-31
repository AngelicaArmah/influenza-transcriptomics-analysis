# ------------------------------
# 1. RAW COUNT IMPORT
#-------------------------------
# Rows = genes/transcripts, columns = samples
raw_counts <- read.table(
  gzfile(count_file),
  sep = "\t",
  header = TRUE,
  row.names = 1,
  check.names = FALSE,
  stringsAsFactors = FALSE
)

# -----------------------------  
# 2. INITIAL QUALITY CONTROL
# -----------------------------
# Check dataset dimensions (genes × samples)
dim(raw_counts)
# Inspect first few rows of expression matrix
head(raw_counts[, 1:5])


# ------------------------------
# 3. GENE IDENTIFIER EXTRACTION
# ------------------------------
# Extract gene identifiers from expression matrix
gene_ids <- rownames(raw_counts)
head(gene_ids)


# ------------------------------
# 4. ENSG GENE FILTERING
# ------------------------------
# Identify Ensembl gene IDs (ENSG)
ensg_keep <- grepl("^ENSG", gene_ids)


# Subset matrix to retain only ENSG genes
raw_counts_ensg <- raw_counts[ensg_keep, ]


# ------------------------------
# 5. FILTER VALIDATION
# ------------------------------
# Check dimensions before and after filtering
dim(raw_counts)
dim(raw_counts_ensg)


# Validate filtering by confirming no non-ENSG IDs remain
non_ensg_count <- sum(!grepl("^ENSG", rownames(raw_counts_ensg)))
non_ensg_count


# Inspect filtered gene IDs
head(rownames(raw_counts_ensg))
# Enforce strict validation to ensure only ENSG genes remain
stopifnot(all(grepl("^ENSG", rownames(raw_counts_ensg))))


# ---------------------------
# 6. FINAL STRUCTURE CHECK
# --------------------------
# Inspect column names
colnames(raw_counts_ensg)
