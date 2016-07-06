#!/bin/bash

##########################################################################

export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ## replace with full absolute path 
export pathOrtho=${path}/data/ensembl_ortho
export pathAnnot=${path}/data/ensembl_annotations

export release=84

##########################################################################

perl extract.all1to1.ortho.families.pl --pathHomology=${pathOrtho}/homology_members_one2one_ensembl${release}.txt --pathEnsemblIDs=${pathOrtho}/EnsemblIDs.txt --speciesList=Human,Chimpanzee,Gorilla,Orangutan,Macaque --prefixGeneInfo=${pathAnnot}/ --suffixGeneInfo=GeneInfo_Ensembl${release}.txt --pathOutputFamilies=${pathOrtho}/GeneFamilies_1to1_ProteinCoding_Ensembl${release}.txt

##########################################################################
