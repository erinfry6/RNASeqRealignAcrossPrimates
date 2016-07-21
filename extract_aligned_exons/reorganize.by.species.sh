#!/bin/bash

#######################################################################
### this script collects all aligned exon sequences for one species and places them in a fasta file for Kallisto
## it reorganizes the aligned exon sequences by species instead of 1-1 ortho gene family
## be sure to change the species list in the for loop to match your species

## This script was written by Erin Fry

#######################################################################

export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ##set full path
export pathAlignedExonsSequences=${path}/results/aligned_exons_sequences
export pathResults=${path}/results/aligned_exons_sequences_by_species
 
export release=84
 
######################################################################################

for sp in Human Chimpanzee Gorilla Organutan Macaque

	if [ ${sp} = "Human" ]; then
    	export name="ENSG"
	fi

	if [ ${sp} = "Chimpanzee" ]; then
    	export name="ENSPTRG"
	fi

	if [ ${sp} = "Gorilla" ]; then
    	export name="ENSGGOG"
	fi

	if [ ${sp} = "Orangutan" ]; then
    	export name="ENSPPYG"
	fi

	if [ ${sp} = "Macaque" ]; then
    	export name="ENSMMUG"
	fi


	for f in ${pathAlignedExonsSequences}/ENSG*
	do
	head -1 $f >>${pathResults}/${sp}.fa
	sed -n -e '/'${name}'/,/>/ p' $f | sed '1d;$d' >>${pathResults}/${sp}.fa
	done

done