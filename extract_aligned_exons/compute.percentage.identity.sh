#!/bin/bash

######################################################################################

export path=/scratch/cluster/monthly/anecsule/ComparableAnnotations
export pathFasta=${path}/data/genome_sequences
export pathAnnot=${path}/data/ensembl_annotations
export pathOrtho=${path}/data/ensembl_ortho
export pathScripts=${path}/scripts/extract_aligned_exons
export pathAlignedExons=${path}/results/aligned_exons
export pathResults=${path}/results/aligned_exons_sequences

export release=84

######################################################################################

export speciesList="Human,Chimpanzee,Gorilla,Orangutan,Macaque,Mouse,Opossum,Platypus,Chicken,Xenopus"

######################################################################################

perl ${pathScripts}/compute.percentage.identity.pl  --speciesList=${speciesList} --refSpecies=Human   --pathGeneFamilies=${pathOrtho}/GeneFamilies_1to1_ProteinCoding_Ensembl${release}.txt --dirAlignedExonsSequences=${pathResults}/ --pathOutput=${pathResults}/Stats_AlignedSequenceIdentity.txt

######################################################################################
