##!/bin/bash


## Download the RNA seq raw data from NCBI Geo : http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE30352
## Convert the .sra RNA-seq files to .fastq files for analysis with Kallisto
## ** requires SRA toolkit (brew install homebrew/science/sratoolkit) **
## these are all primate brain samples

##########################################################################################

export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ##set base directory path
export pathExonFasta=${path}/results/aligned_exons_sequences_by_species
export pathRNAseq=${path}/data/RNA_seq_raw
export pathScripts=${path}/scripts/map_RNA_seq_data

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081922/SRR306777/SRR306777.sra

mv  SRR306777.sra  ${pathRNAseq}/mml_br_F_1.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081923/SRR306778/SRR306778.sra

mv  SRR306778.sra  ${pathRNAseq}/mml_br_M_1.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081924/SRR306779/SRR306779.sra

mv  SRR306779.sra  ${pathRNAseq}/mml_br_M_2.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081935/SRR306791/SRR306791.sra

mv  SRR306791.sra  ${pathRNAseq}/ppy_br_F_1.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081936/SRR306792/SRR306792.sra

mv  SRR306792.sra  ${pathRNAseq}/ppy_br_M_1.sra

##########################################################################################
wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081944/SRR306800/SRR306800.sra

mv  SRR306800.sra  ${pathRNAseq}/ggo_br_F_1.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081945/SRR306801/SRR306801.sra

mv  SRR306801.sra ${pathRNAseq}/ggo_br_M_1.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081955/SRR306811/SRR306811.sra

mv  SRR306811.sra  ${pathRNAseq}/ptr_br_F_1.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081956/SRR306812/SRR306812.sra

mv  SRR306812.sra  ${pathRNAseq}/ptr_br_M_1.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081957/SRR306813/SRR306813.sra

mv  SRR306813.sra  ${pathRNAseq}/ptr_br_M_2.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081958/SRR306814/SRR306814.sra

mv  SRR306814.sra  ${pathRNAseq}/ptr_br_M_3.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081959/SRR306815/SRR306815.sra

mv  SRR306815.sra  ${pathRNAseq}/ptr_br_M_4.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081960/SRR306816/SRR306816.sra

mv  SRR306816.sra  ${pathRNAseq}/ptr_br_M_5.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081970/SRR306826/SRR306826.sra

mv  SRR306826.sra  ${pathRNAseq}/ppa_br_F_1.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081971/SRR306827/SRR306827.sra

mv  SRR306827.sra  ${pathRNAseq}/ppa_br_F_2.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081972/SRR306828/SRR306828.sra

mv  SRR306828.sra  ${pathRNAseq}/ppa_br_M_1.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081982/SRR306838/SRR306838.sra

mv  SRR306838.sra  ${pathRNAseq}/hsa_br_F_1.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081983/SRR306839/SRR306839.sra

mv  SRR306839.sra  ${pathRNAseq}/hsa_br_M_3.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081984/SRR306840/SRR306840.sra

mv  SRR306840.sra  ${pathRNAseq}/hsa_br_M_1.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081985/SRR306841/SRR306841.sra

mv  SRR306841.sra  ${pathRNAseq}/hsa_br_M_2.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081986/SRR306842/SRR306842.sra

mv  SRR306842.sra  ${pathRNAseq}/hsa_br_M_4.sra

##########################################################################################

wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByExp/sra/SRX/SRX081/SRX081987/SRR306843/SRR306843.sra

mv  SRR306843.sra  ${pathRNAseq}/hsa_br_M_5.sra

##########################################################################################

cd ${pathRNAseq}

## Convert the .sra RNA-seq files to .fastq files for analysis with Kallisto

	for f in *
	do
		fastq-dump $f --split-3
	done
	
cd ${pathScripts}