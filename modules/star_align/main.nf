process STAR_ALIGN {
    label 'process_high'
    container 'ghcr.io/bf528/star:latest'
    publishDir params.outdir, mode: 'copy', pattern: '*.Log.final.out'

    input:
    tuple val(sample), path(reads)
    path genome_index

    output:
    tuple val(sample), path("${sample}.Aligned.sortedByCoord.out.bam"), emit: bam
    tuple val(sample), path("${sample}.Log.final.out"), emit: log

    script:
    """
    STAR \
        --runThreadN ${task.cpus} \
        --genomeDir ${genome_index} \
        --readFilesIn ${reads} \
        --readFilesCommand zcat \
        --outFileNamePrefix ${sample}. \
        --outSAMtype BAM SortedByCoordinate \
        2> ${sample}.Log.final.out
    """
}