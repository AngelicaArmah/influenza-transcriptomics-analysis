# ---------------------------------
# 0. GLOBAL SETTINGS
# ---------------------------------
# Increase download timeout for large GEO files
options(timeout = 3600)

# Set seed for reproducibility of analysis
set.seed(123)

# ----------------------------------
# 1. PACKAGES
# ----------------------------------
# Project root handling and reproducible file paths (here; Müller, 2025)
library(here)

# GEO database source (Edgar et al., 2002)
# GEOquery R package for accessing GEO datasets (Davis & Meltzer, 2007)
library(GEOquery)

# RNA-seq differential expression (Love et al., 2014)
library(DESeq2)

# Load apeglm package for log2 fold change shrinkage (Zhu et al., 2018)
library(apeglm)

# Data visualization using Grammar of Graphics (ggplot2; Wickham, 2016)
library(ggplot2)

# Prevent overlapping labels in ggplot2 visualizations (ggrepel; Slowikowski et al., 2026)
library(ggrepel)

# Heatmap visualization (pheatmap; Kolde, 2025)
library(pheatmap)

# Human gene annotation database (org.Hs.eg.db; Carlson, 2025)
library(org.Hs.eg.db)

# Annotate Ensembl IDs to gene symbols using local annotation database (Pagès et al., 2025)
library(AnnotationDbi)

# ----------------------------------------------------
# 2. PROJECT PATH SETUP (reproducible structure)
# -----------------------------------------------------
# Define reproducible project root using here (Müller, 2025)
project_root <- here::here()

# Safety check to ensure project root is correctly detected before proceeding
if (!dir.exists(project_root)) stop("Project root not found")

# Define reproducible data directory within project structure
base_dir <- file.path(project_root, "data")

# Dataset-specific directory for isolated GEO storage (improves reproducibility)
geo_dir <- file.path(base_dir, "GSE252713")


# ----------------------------------------
# 3. CREATE FOLDERS SAFELY
# ----------------------------------------
# Ensure reproducible data directory exists before downloading GEO files
if (!dir.exists(base_dir)) {
  dir.create(base_dir, recursive = TRUE)
}

# Create dataset-specific directory for isolated GEO data storage
if (!dir.exists(geo_dir)) {
  dir.create(geo_dir, recursive = TRUE)
  