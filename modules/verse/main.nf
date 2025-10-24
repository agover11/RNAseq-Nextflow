process VERSE {
    label 'process_medium'
    publishDir 'results/verse', mode: 'copy'
    container 'ghcr.io/bf528/verse:latest'

    input:
    tuple val(sample_id), path(bam)
    path gtf_file

    output:
    path "*.exon.txt"

    script:
    """
    verse -a ${gtf_file} -o ${sample_id}.exon.txt -S ${bam}
    """
}