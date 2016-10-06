##!/bin/bash

## written by EF in July 2016
## Download the RNA seq raw data from NCBI Geo : http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE30352
## Convert the .sra RNA-seq files to .fastq files for analysis with Kallisto
## ** requires SRA toolkit (brew install homebrew/science/sratoolkit  AND brew install fastqc) **
## these are all primate brain samples

##########################################################################################

export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ##set base directory path
export pathExonFasta=${path}/results/aligned_exons_sequences_by_species
export pathRNAseq=${path}/data/RNA_seq_raw
export pathResults=${path}/results/FASTQC
export pathScripts=${path}/scripts/download_RNAseq_files

##########################################################################################

cd ${pathRNAseq}

## Convert the .sra RNA-seq files to .fastq files for analysis with Kallisto

	for d in *
	do
	
	if [ -e ${pathResults}/$d ]; then
    echo $d results directory already here
    else
	mkdir ${pathResults}/$d
    fi
    
		cd $d
		fastqc *.fastq -o ${pathResults}/${d}/
		cd ..
	done
	
	
cd ${pathScripts}