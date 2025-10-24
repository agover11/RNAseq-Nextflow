process CONCAT {
    label 'process_low'
    container 'ghcr.io/bf528/pandas:latest'
    publishDir 'results', mode: 'copy'

    input:
    path verse_files
    path merge_py

    output:
    path "all_samples_counts.csv"

    script:
    """
    python3 ${merge_py} -i ${verse_files.join(' ')} -o all_samples_counts.csv
    """
}