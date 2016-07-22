##!/bin/bash


## Download the RNA seq raw data from NCBI Geo : http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE30352
## Convert the .sra RNA-seq files to .fastq files for analysis with Kallisto
## ** requires SRA toolkit (brew install homebrew/science/sratoolkit) **
## these are all primate brain samples

##########################################################################################

export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ##set base directory path
export pathExonFasta=${path}/results/aligned_exons_sequences_by_species
export pathRNAseq=${path}/data/RNA_seq_raw
export pathScripts=${path}/scripts/map_RNA_seq_data

##########################################################################################

cd ${pathRNAseq}

## Convert the .sra RNA-seq files to .fastq files for analysis with Kallisto

	for f in *
	do
		fastq-dump $f --split-3
	done
	
	mv *F_1.fastq *F_1_1.fastq
	
	
cd ${pathScripts}