#!/bin/bash

export species=$1

#################################################################################

#export path=ComparableAnnotations ## replace with full absolute path 
export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ## replace with full absolute path 
export pathEnsembl=${path}/data/ensembl_annotations/${species}

#################################################################################

### this script construct exon blocks (i.e., union of all exon coordinates, for all isoforms)
### two sets of exon blocks are constructed: one with all annotated transcripts, one with filtered transcripts
### "filtered transcripts" means that for protein-coding genes only protein-coding transcripts are kept; for non-coding genes, all transcripts are kept in all cases
### for the data given here, I used the "filtered transcripts" annotations

#################################################################################

export release=84

perl make.exon.blocks.ensembl.pl --pathExonCoords=${pathEnsembl}/ExonCoords_Ensembl${release}.txt --pathExonAssignment=${pathEnsembl}/ExonsTranscripts_Ensembl${release}.txt --pathGeneInfo=${pathEnsembl}/GeneInfo_Ensembl${release}.txt --pathTranscriptInfo=${pathEnsembl}/TranscriptInfo_Ensembl${release}.txt --collapseDistance=10 --filter="yes" --pathOutputExonBlocks=${pathEnsembl}/ExonBlocks_Ensembl${release}_FilteredTranscripts.txt

perl make.exon.blocks.ensembl.pl --pathExonCoords=${pathEnsembl}/ExonCoords_Ensembl${release}.txt --pathExonAssignment=${pathEnsembl}/ExonsTranscripts_Ensembl${release}.txt --pathGeneInfo=${pathEnsembl}/GeneInfo_Ensembl${release}.txt --pathTranscriptInfo=${pathEnsembl}/TranscriptInfo_Ensembl${release}.txt --collapseDistance=10 --filter="no" --pathOutputExonBlocks=${pathEnsembl}/ExonBlocks_Ensembl${release}_AllTranscripts.txt

#################################################################################

    
