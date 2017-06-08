##!/bin/bash

## written by EF in April 2017
## run fastqc (required) on all samples

##########################################################################################

export path=/Users/lynchlab/Desktop/ErinFry/ReconAncNeoTranscriptomes/Realigning ##set base directory path
export pathScripts=${path}/scripts/download_RNAseq_files
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

## move all files to the fastqc home directory for 

cd ${pathResults}

if [ -e ${pathResults}/Summary ]; then
    echo Summary directory already here
    else
	mkdir ${pathResults}/Summary
	echo "making summary directory"
    fi

for d in *
do 
cp ${d}/RNAseq_fastqc.zip ${pathResults}/Summary/${d}_fastqc.zip
cp ${d}/RNAseq_1_fastqc.zip ${pathResults}/Summary/${d}_1_fastqc.zip
cp ${d}/RNAseq_2_fastqc.zip ${pathResults}/Summary/${d}_2_fastqc.zip
done

cd ${pathScripts}/

./fastqc_summary.py