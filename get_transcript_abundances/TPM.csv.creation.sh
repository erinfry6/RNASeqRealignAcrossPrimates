##!/bin/bash

## written by EF in July 2016

##########################################################################################

export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ##set base directory path
export pathExonFasta=${path}/results/aligned_exons_sequences_by_species
export pathRNAseq=${path}/data/RNA_seq_raw
export pathRawExpression=${path}/results/RawGeneExpression
export pathScripts=${path}/scripts/map_RNA_seq_data

##########################################################################################

## check that all abundance.tsv files have the same number of aligned exons

first=$(wc -l $(ls ${pathRawExpression}/*/abundance.tsv | head -1) | awk '{print $1}')

for i in $(ls ${pathRawExpression}/)
do

length=$(wc -l ${pathRawExpression}/${i}/abundance.tsv | awk '{print $1}')

if [ ${length} = ${first} ]; then
echo ${i} good
else
echo all abundance.tsv files dont have the same number of orthologs, error at ${i}
fi
done

R --vanilla <Collect.All.Sample.Abundances.R