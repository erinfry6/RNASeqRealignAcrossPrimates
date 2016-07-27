##!/bin/bash

## written by EF in July 2016
## Pseudo-align and quantify the RNA-seq raw reads to the .fa files created in step 5
## ** requires Kallisto (brew install kallisto) **

##########################################################################################

export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ##set base directory path
export pathExonFasta=${path}/results/aligned_exons_sequences_by_species
export pathRNAseq=${path}/data/RNA_seq_raw
export pathResults=${path}/results/GeneExpression
export pathScripts=${path}/scripts/map_RNA_seq_data

##########################################################################################

cd ${pathExonFasta}

## for each species, create the index file required for kallisto RNA-seq pseudo alignment/quantification
## for each sample in that species name, determine if single or paired end reads
## use the index file to run kallisto and create output csv in $pathResults

for sp in *.fa
	do
		#echo Creating index file for ${sp}
		#kallisto index -i $sp.idx $sp
	
	if [ ${sp} = "Human.fa" ]; then
    	export name="hsa"
	fi

	if [ ${sp} = "Chimpanzee.fa" ]; then
    	export name="ptr"
    fi
    	
    if [ ${sp} = "Bonobo.fa" ]; then
    	export name="ppa"
    fi

	if [ ${sp} = "Gorilla.fa" ]; then
    	export name="ggo"
	fi

	if [ ${sp} = "Orangutan.fa" ]; then
    	export name="ppy"
	fi

	if [ ${sp} = "Macaque.fa" ]; then
    	export name="mml"
    fi

	cd ${pathRNAseq} 
    
    
    for i in ${name}*
    do
    echo Quantifying ${i}
    cd ${i}
    numreads=$(ls -l *.fastq | wc -l)
    
    if [ ${numreads} = "1" ]; then
    echo single ends reads
    kallisto quant -i ${pathExonFasta}/${sp}.idx -o ${pathResults}/$i -b 100 --single -l 76 -s 1 RNAseq.fastq
    fi
	
	if [ ${numreads} = "2" ]; then
    echo paired ends reads
    kallisto quant -i ${pathExonFasta}/${sp}.idx -o ${pathResults}/$i -b 100 RNAseq_1.fastq RNAseq_2.fastq
    fi

	cd ..
    	
	done
done
	
cd ${pathScripts}