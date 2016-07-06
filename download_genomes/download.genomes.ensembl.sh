##!/bin/bash


## download the genomes for all species
## I have only eliminated the species I am not using, for fuller list, see Brawand et al

##########################################################################################

## for human and mouse we take the primary assembly - no alternative haplotypic sequences or genome patches

wget ftp://ftp.ensembl.org/pub/release-84/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz 

mv  Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz  ../../data/genome_sequences/Human/genome_ensembl84.fa.gz 

##########################################################################################

wget ftp://ftp.ensembl.org/pub/release-84/fasta/pan_troglodytes/dna/Pan_troglodytes.CHIMP2.1.4.dna.toplevel.fa.gz

mv Pan_troglodytes.CHIMP2.1.4.dna.toplevel.fa.gz ../../data/genome_sequences/Chimpanzee/genome_ensembl84.fa.gz 

##########################################################################################

wget ftp://ftp.ensembl.org/pub/release-84/fasta/gorilla_gorilla/dna/Gorilla_gorilla.gorGor3.1.dna.toplevel.fa.gz

mv Gorilla_gorilla.gorGor3.1.dna.toplevel.fa.gz  ../../data/genome_sequences/Gorilla/genome_ensembl84.fa.gz 

##########################################################################################

wget ftp://ftp.ensembl.org/pub/release-84/fasta/pongo_abelii/dna/Pongo_abelii.PPYG2.dna.toplevel.fa.gz

mv Pongo_abelii.PPYG2.dna.toplevel.fa.gz  ../../data/genome_sequences/Orangutan/genome_ensembl84.fa.gz 

##########################################################################################

wget ftp://ftp.ensembl.org/pub/release-84/fasta/macaca_mulatta/dna/Macaca_mulatta.MMUL_1.dna.toplevel.fa.gz

mv Macaca_mulatta.MMUL_1.dna.toplevel.fa.gz  ../../data/genome_sequences/Macaque/genome_ensembl84.fa.gz 

##########################################################################################
