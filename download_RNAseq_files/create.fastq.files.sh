##!/bin/bash

## written by EF in July 2016
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

	for d in *
	do
		cd $d
		fastq-dump RNAseq.sra --split-3
		cd ..
	done
	
	
cd ${pathScripts}