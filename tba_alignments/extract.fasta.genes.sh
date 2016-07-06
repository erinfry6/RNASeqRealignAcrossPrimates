#!/bin/bash

export sp=$1

######################################################################################

export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ## replace with full absolute path 
export pathFasta=${path}/data/genome_sequences/${sp}
export pathAnnot=${path}/data/ensembl_annotations/${sp}
export pathOrtho=${path}/data/ensembl_ortho
export pathScripts=${path}/scripts/tba_alignments
export pathResults=${path}/results/tba_alignments/

export release=84

######################################################################################

## this script will extract the gene sequence (exons + introns) for each 1-1 ortho family, for each species
## the output files follow TBA conventions: the sequence for species Human is stored in file named "Human"

perl ${pathScripts}/extract.fasta.genes.pl --pathGenomeSequence=${pathFasta}/genome_ensembl${release}.fa.gz --pathGeneInfo=${pathAnnot}/GeneInfo_Ensembl${release}.txt --species=${sp} --refSpecies=Human --pathGeneFamilies=${pathOrtho}/GeneFamilies_1to1_ProteinCoding_Ensembl${release}.txt --dirOutput=${pathResults}

######################################################################################
