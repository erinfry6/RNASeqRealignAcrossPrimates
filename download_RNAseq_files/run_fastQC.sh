##!/bin/bash

## written by EF in April 2017
## run fastqc (required) on all samples

##########################################################################################

export path=/Users/lynchlab/Desktop/ErinFry/ReconAncNeoTranscriptomes/Realigning ##set base directory path
export pathExonFasta=${path}/results/aligned_exons_sequences_by_species
export pathRNAseq=${path}/data/RNA_seq_raw
export pathResults=${path}/results/FASTQC

##########################################################################################

cd ${pathRNAseq}

## Convert the .sra RNA-seq files to .fastq files for analysis with Kallisto

	for d in *
	do
	
	if [ -e ${pathResults}/$d ]; then
    echo $d results directory already here
    else
	mkdir ${pathResults}/$d
	echo "making directory for $d"
    fi
    
cd $d
if [ -e ${pathResults}/${d}/RNAseq_fastqc.html ]; then
echo already did QC on $d
elif [ -e ${pathResults}/${d}/RNAseq_2_fastqc.html ]
then
echo already did QC on $d
else
fastqc *.fastq -o ${pathResults}/${d}/
fi

cd ..

done

