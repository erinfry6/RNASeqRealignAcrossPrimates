##!/bin/bash


## Pseudo-align and quantify the RNA-seq raw reads to the .fa files created in step 5
## ** requires Kallisto (brew install kallisto) **

##########################################################################################

export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ##set base directory path
export pathExonFasta=${path}/results/aligned_exons_sequences_by_species
export pathRNAseq=${path}/data/RNA_seq_raw
export pathResults=${path}/results/GeneExpression

##########################################################################################

for f in {pathExonFasta}/*.fa
	do
		kallisto index -i $f.idx $f
		kallisto quant -i $f.idx -o $f.out -b 100 <(gzcat reads_1.fastq.gz) <(gzcat reads_1.fastq.gz)
	done