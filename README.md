# TYK2 RNA-seq Analysis in Human Pancreatic β-Cells

## Description
This project investigates the role of the **TYK2 gene** in human pancreatic β-cell development and response to interferon-α (IFN-α), a cytokine involved in Type 1 Diabetes (T1D). Using RNA-seq data, the analysis examines gene expression changes, differential expression, and enriched biological pathways to better understand TYK2’s contribution to β-cell function and T1D pathogenesis.

## Methods
1. **Data Input & QC**
   - Paired-end RNA-seq reads processed with Nextflow channels and FastQC v0.12.1  
   - Quality summarized with MultiQC v1.25  
2. **Genome Alignment & Quantification**
   - STAR v2.7.11b used for alignment to human reference genome  
   - Gene-level quantification with VERSE v0.1.5  
   - Custom Python scripts for generating counts matrix  
3. **Downstream Analysis**
   - Normalization and differential expression using DESeq2 v1.46.0 in R v4.4.3  
   - Gene set enrichment analysis (GSEA) with FGSEA and ENRICHR  
4. **Visualization & QC**
   - PCA and sample-to-sample heatmaps to assess experimental variability  
   - Volcano plots and enriched pathway plots generated in R  
5. **Execution Environment**
   - Nextflow pipelines run on BU Shared Computing Cluster using Singularity containers  

## Usage
- All scripts and Nextflow workflows are provided for **reproducible RNA-seq analysis**  
- Data and reference files are expected to be organized as described in the workflow channels

## Deliverables
- Filtered gene counts matrix  
- Differential expression results (CSV)  
- Enriched pathway tables and plots (ENRICHR, GSEA)  
- PCA, heatmap, and volcano plot visualizations

## References
*The type 1 diabetes gene TYK2 regulates β-cell development and its responses to interferon-α*. Nature Communications. https://www.nature.com/articles/s41467-022-34349-7  
