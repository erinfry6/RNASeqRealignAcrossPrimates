##!/bin/bash

## written by EF in April 2017
## Convert the .sra RNA-seq files to .fastq files for analysis with Kallisto
## ** requires SRA toolkit (brew install homebrew/science/sratoolkit) **

##########################################################################################

export path=/Users/lynchlab/Desktop/ErinFry/ReconAncNeoTranscriptomes/Realigning ##set base directory path
export pathExonFasta=${path}/results/aligned_exons_sequences_by_species
export pathRNAseq=${path}/data/RNA_seq_raw

##########################################################################################	
	
cd ${pathRNAseq}

## Convert the .sra RNA-seq files to .fastq files for analysis with Kallisto

for d in *
do
cd $d
if [ -e RNAseq_1.fastq ]
then
echo "already created ${d} fasta file"
elif [ -e RNAseq_2.fastq ]
then
echo "already created ${d} fasta file"
elif [ -e RNAseq.fastq ]
then
echo "already created ${d} fasta file"
else
fastq-dump RNAseq.sra --split-3
fi

cd ..
done
	
