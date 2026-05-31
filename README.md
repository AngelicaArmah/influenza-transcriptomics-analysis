# INFLUENZA TRANSCRIPTOMICS ANALYSIS
This project investigates host-pathogen interactions in influenza infection using publicly available RNA-seq data. The dataset consists of rep(influenza-infected) and mock(control) (n=3 per group). Differential gene expression analysis was performed in R, followed by pathway enrichment analysis to identify biological processes associated with infection. This exploratory study focuses on characterizing host immune response signatures and demonstrating reproducible transcriptomic analysis workflows.

## Objectives
- Perform differential expression analysis between influenza-infected and control samples
- Assess consistency and clustering of biological replicates
- Identify genes and pathways associated with influenza infection using pathway enrichment analysis

## Methods
- RNA-seq data consisting of mock (control) and rep(influenza-infected) samples (n = 3 per group) were obtained from the Gene Expression      Omnibus (GEO) database (GSE252713).
- Raw data were processed in R, including quality filtering and normalization. Genes with missing or unannotated identifiers were removed     prior to downstream analysis.
- Differential expression analysis was performed, and results were adjusted for multiple testing to obtain corrected p-values.
- Exploratory data analysis was conducted using PCA, heatmaps, and volcano plots to assess sample clustering and expression patterns.
- Functional interpretation of differentially expressed genes was performed using pathway enrichment analysis (GO and KEGG).

## Tools and Software
*Core environment*
- R programming language

*Data acquisition*
- GEOquery

*Differential expression analysis*
- DESeq2
- apeglm (log fold change shrinkage)

*Data visualization*
- ggplot2
- ggrepel
- pheatmap

*Annotation and functional analysis*
- Bioconductor annotation packages (org.Hs.eg.db, AnnotationDbi)
