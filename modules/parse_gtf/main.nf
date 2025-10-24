#!/usr/bin/env python3

process PARSE_GTF {
    label 'process_low'
    container 'ghcr.io/bf528/pandas:latest'
    publishDir params.outdir, mode: 'copy'

    input:
    path(gtf_file)

    output:
    path('gene_mapping.txt'), emit: gene_mapping

    script:
    """
    gene_extract.py -i ${gtf_file} -o gene_mapping.txt
    """
}