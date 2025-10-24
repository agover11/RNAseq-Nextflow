#!/usr/bin/env nextflow

include { FASTQC } from './modules/fastqc'
include { PARSE_GTF } from './modules/parse_gtf'
include { STAR_INDEX } from './modules/star_index'
include { STAR_ALIGN } from './modules/star_align'
include { MULTIQC } from './modules/multiqc'
include { VERSE } from './modules/verse'
include { CONCAT } from './modules/concat'

workflow {
    // Create a channel of paired-end FASTQ files
    Channel.fromFilePairs(params.reads).set { align_ch }

    // Create a channel with one tuple per FASTQ file (for FASTQC)
    //use transpose 
    Channel.fromFilePairs(params.reads).transpose().set{ fastqc_ch }

    // Run QC on 12 fastqc files
    FASTQC(fastqc_ch)

    // Parse GTF
    PARSE_GTF(params.gtf)

    // Run STAR_INDEX and emit the genome_index path channel, assign to star_idx
    STAR_INDEX(params.genome, params.gtf).genome_index.set { star_idx }
    //.set { star_idx }

    // Pass paired reads channel and genome_index channel separately to STAR_ALIGN
    STAR_ALIGN(align_ch, star_idx)

    multiqc_ch = FASTQC.out.zip
        .map { sample, file -> file }
        .mix(STAR_ALIGN.out.log.map { sample, file -> file })
        .collect()

    // Run MultiQC on everything once
    MULTIQC(multiqc_ch)

    VERSE(STAR_ALIGN.out.bam, params.gtf)

    // Collect VERSE outputs
    verse_files_ch = VERSE.out.collect()

    // Run merge.py after all VERSE tasks finish
    CONCAT(verse_files_ch, file('./bin/merge.py'))
}