#!/bin/bash

## written by EF in July 2016
## this script collects all aligned exon sequences for one species and places them in a fasta file for Kallisto
## it reorganizes the aligned exon sequences by species instead of 1-1 ortho gene family
## to run the file, type ' ./reorganize.by.species.sh SPECIES ', replacing SPECIES with each of your species

#######################################################################

export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ##set full path
export pathAlignedExonsSequences=${path}/results/aligned_exons_sequences
export pathResults=${path}/results/aligned_exons_sequences_by_species
 
export release=84
 
######################################################################################

## for the given species, specify the ensembl ID code

sp=$1

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

## if human, take all lines before the next species in the fasta files and put it in the new species.fa fasta file
## if macaque, or last species in list, extract all lines after the macaque ensembl ID name
## for all other species, take all lines between the species ensembl ID code and the next species transcript (indicated by '>') 
## again, place this transcript in the species.fa fasta file
## each new species.fa file wil lhave the sequences for that species filed under the human transcript ensembl ID

if [ ${sp} = "Human" ]; then
    for f in ${pathAlignedExonsSequences}/ENSG*
	do
	number=$(grep -n "ENSPTRG" $f | grep -Eo '^[^:]+')
	((number--))
	head -${number} $f >>${pathResults}/${sp}.fa
	done
  
elif [ ${sp} = "Macaque" ]; then
    for f in ${pathAlignedExonsSequences}/ENSG*
	do
	head -1 $f >>${pathResults}/${sp}.fa
	sed -n -e '/'${name}'/,/>/ p' $f | sed '1d' >>${pathResults}/${sp}.fa
  	done  

else 

	for f in ${pathAlignedExonsSequences}/ENSG*
	do
	head -1 $f >>${pathResults}/${sp}.fa
	sed -n -e '/'${name}'/,/>/ p' $f | sed '1d;$d' >>${pathResults}/${sp}.fa
	done
fi

## use the chimpanzee genome and annotations/transcripts as the Bonobo until ensembl publishes annotated Bonobo gnenome
cp ${pathResults}/Chimpanzee.fa ${pathResults}/Bonobo.fa