#!/bin/bash

#####################################################################

export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ### define the full, absolute path here 
export pathAnnot=${path}/data/ensembl_annotations
export pathOrtho=${path}/data/ensembl_ortho
export pathTBA=${path}/results/tba_alignments
export pathResults=${path}/results/aligned_exons
export pathScripts=${path}/scripts/extract_aligned_exons

#####################################################################

export speciesList="Human,Chimpanzee,Gorilla,Orangutan,Macaque"

export release=84 ## Ensembl release

#####################################################################

### this script will go through the TBA alignments one by one
### and will extract the aligned exon coordinates - aligned, ungapped positions that are annotated as exons in all species
### there will be one output file for each species
### the output files will be in ${pathResults}/${sp}/AlignedExonParts_Ensembl${release}_FilteredTranscripts.txt

perl ${pathScripts}/extract.aligned.exons.pl --speciesList=${speciesList} --refSpecies=Human --pathGeneFamilies=${pathOrtho}/GeneFamilies_1to1_ProteinCoding_Ensembl${release}.txt --dirTBA=${pathTBA}/ --minAlignmentLength=10 --minFractionOrdered=0.9 --dirAnnot=${pathAnnot}/ --suffixAnnot=ExonBlocks_Ensembl${release}_FilteredTranscripts.txt --dirOutput=${pathResults}/ --suffixOutput=AlignedExonParts_Ensembl${release}_FilteredTranscripts.txt --pathOutputStats=${pathResults}/StatsAlignment.txt

#####################################################################
