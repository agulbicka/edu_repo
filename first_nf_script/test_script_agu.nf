#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.fastq_file= "test_R1.fastq.gz"

Channel
    .fromPath(params.fastq_file)
    .set{ fastq_file_ch }

process COUNT_LINES {
    input:
    path read

    output:
    stdout

    script:
    if ( "$read.Extension" == 'gz' )
    """
    zcat $read | wc -l
    """
    else if ( "$read.Extension" == 'fastq' )
    """
    cat $read | wc -l 
    """
    else
    throw new IllegalArgumentException("Unknown file format")
}

process COUNT_READS {
    input:
    val line_n

    output:
    stdout

    shell:
    '''
    echo $((!{line_n}/4))
    '''
}

workflow {
    linecount_ch= COUNT_LINES(fastq_file_ch)
    linecount_ch.view{"Number of lines in your fastq file: $it"}
    readcount_ch= COUNT_READS(linecount_ch)
    readcount_ch.view{"Number of reads in your fastq file: $it"}
}


