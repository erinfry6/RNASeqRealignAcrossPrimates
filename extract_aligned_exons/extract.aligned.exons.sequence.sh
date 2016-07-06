#!/bin/bash

######################################################################################

export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning
export pathFasta=${path}/data/genome_sequences
export pathAnnot=${path}/data/ensembl_annotations
export pathOrtho=${path}/data/ensembl_ortho
export pathScripts=${path}/scripts/extract_aligned_exons
export pathAlignedExons=${path}/results/aligned_exons
export pathResults=${path}/results/aligned_exons_sequences

export release=84

######################################################################################

export speciesList="Human,Chimpanzee,Gorilla,Orangutan,Macaque"

######################################################################################

## this script will extract aligned exon sequences
## there will be 1 output file per 1-1 ortho family, containing the sequences for all species
## if genes on reverse strand, we take reverse complement of the sequence - "cDNA" -like 

perl ${pathScripts}/extract.aligned.exons.sequence.pl  --speciesList=${speciesList} --refSpecies=Human  --pathGeneFamilies=${pathOrtho}/GeneFamilies_1to1_ProteinCoding_Ensembl${release}.txt --dirGenomeSequence=${pathFasta}/ --suffixGenomeSequence=genome_ensembl${release}.fa.gz --dirAlignedExons=${pathAlignedExons}/ --suffixAlignedExons=AlignedExonParts_Ensembl${release}_FilteredTranscripts.txt --dirOutput=${pathResults}/

######################################################################################
