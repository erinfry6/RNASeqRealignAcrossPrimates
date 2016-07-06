#!/bin/bash

#######################################################################
### this script extracts Ensembl annotations from the MySQL database, for the following 10 species
### the database name are valid for Ensembl 84 
### if using on another species or other Ensembl release, first connect to mysql server and find out the correct database name (e.g., show databases like "%homo_sapiens_core%";) 
## we extract exon coordinates, gene info, transcript info (including transcript-gene correspondence), exon-transcript correspondence

## EF: I have again only eliminated unnecessary species and added the below comment
## this is what the files you are going to extract information from look like in ensembl http://ftp.ensembl.org/pub/current_mysql/pan_troglodytes_core_84_214/
#######################################################################

export species=$1 
export release=84

#######################################################################

if [ ${species} = "Human" ]; then
    export db="homo_sapiens_core_84_38"
fi

if [ ${species} = "Chimpanzee" ]; then
    export db="pan_troglodytes_core_84_214"
fi

if [ ${species} = "Gorilla" ]; then
    export db="gorilla_gorilla_core_84_31"
fi

if [ ${species} = "Orangutan" ]; then
    export db="pongo_abelii_core_84_1"
fi

if [ ${species} = "Macaque" ]; then
    export db="macaca_mulatta_core_84_10"
fi

#######################################################################

if [ -e ../../data/ensembl_annotations/${species} ]; then 
    echo "path exists"
else
    mkdir ../../data/ensembl_annotations/${species}
fi

echo "extracting ensembl_annotations for "${species}

#######################################################################

echo "use $db; " > get.exons.${species}.sh
echo "select exon.stable_id, seq_region.name, exon.seq_region_start, exon.seq_region_end, exon.seq_region_strand from exon, seq_region where exon.seq_region_id=seq_region.seq_region_id; " >> get.exons.${species}.sh

mysql -h ensembldb.ensembl.org -P 5306 -u anonymous < get.exons.${species}.sh > ../../data/ensembl_annotations/${species}/ExonCoords_Ensembl${release}.txt

echo "use $db; " > get.transcripts.${species}.sh
echo "select gene.stable_id, transcript.stable_id, transcript.biotype, seq_region.name, transcript.seq_region_start, transcript.seq_region_end, transcript.seq_region_strand from transcript, gene, seq_region where transcript.gene_id=gene.gene_id and transcript.seq_region_id=seq_region.seq_region_id; " >> get.transcripts.${species}.sh

mysql -h ensembldb.ensembl.org -P 5306 -u anonymous < get.transcripts.${species}.sh > ../../data/ensembl_annotations/${species}/TranscriptInfo_Ensembl${release}.txt

echo "use $db; " > get.genes.${species}.sh
echo "select gene.stable_id, gene.biotype, gene.status, gene.description, seq_region.name, gene.seq_region_start, gene.seq_region_end, gene.seq_region_strand from gene, seq_region where gene.seq_region_id=seq_region.seq_region_id; " >> get.genes.${species}.sh

mysql -h ensembldb.ensembl.org -P 5306 -u anonymous < get.genes.${species}.sh > ../../data/ensembl_annotations/${species}/GeneInfo_Ensembl${release}.txt


echo "use $db; " > get.exontx.${species}.sh
echo "select exon.stable_id, transcript.stable_id from exon_transcript, exon, transcript where exon_transcript.exon_id=exon.exon_id and exon_transcript.transcript_id=transcript.transcript_id; " >> get.exontx.${species}.sh

mysql -h ensembldb.ensembl.org -P 5306 -u anonymous < get.exontx.${species}.sh > ../../data/ensembl_annotations/${species}/ExonsTranscripts_Ensembl${release}.txt

mv *${species}.sh species_scripts/


#######################################################################
