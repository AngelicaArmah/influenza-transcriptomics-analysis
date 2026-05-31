# =========================================================
# 1. CHECK FOR DUPLICATE GENE IDS
# =========================================================
sum(duplicated(rownames(raw_counts_ensg)))


# =========================================================
# 2. VERIFY COUNTS ARE INTEGERS
# =========================================================
all(raw_counts_ensg == round(raw_counts_ensg))


# =========================================================
# 3. REMOVE LOWLY EXPRESSED GENES (OPTIONAL)
# =========================================================
keep <- rowSums(raw_counts_ensg) >= 10
raw_counts_ensg <- raw_counts_ensg[keep, ]

# Check new dimensions after filtering
dim(raw_counts_ensg)
