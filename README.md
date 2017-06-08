# Quantify RNA-seq across Primates

The following scripts quantify orthologous exon / gene expression from RNA-seq data across Humans, Chimpanzees, Bonobos, Gorillas, Orangutans, and Macaques.

They will:

1) Create orthologous exon fasta files for all species

2) Psuedoalign RNA-seq raw reads using Kallisto

3) Go through Quality control and filter data to prepare the data for [Ancestral Transcriptome Reconstruction](https://github.com/erinfry6/AncGeneExpReconstructionBT)

*Steps 1-5 are adapted from the [Brawand et al 2011](http://www.ncbi.nlm.nih.gov/pubmed/22012392) pipeline obtained from Anamaria Necsulea*


*Steps 5.5 + were written by Erin Fry (efry@uchicago.edu), Lynch Laboratory at the University of Chicago has modified*

## Set up directories

Before beginning, create a home directory for the pipeline that contains the following subdirectories

				home/data  			/ensembl_annotations /each species

		   						/ensembl_ortho

		   						/genome_sequences /each species
		   						
		   						/RNA_seq_raw

				home/results 			/aligned_exons /each species

								/aligned_exons_sequences
								
								/aligned_exons_sequences_by_species

								/tba_alignments
								
								/FASTQC
								
								/qualitycontrol
								
								/RawGeneExpression

				home/scratch

				home/scripts

Place the contents of this repository in the scripts folder.


## Modify the scripts

 - The top of each script (all .sh and .R files) must be modified to contain the proper home directory path
 
 - If you are using a different dataset, you will have to modify some of the scripts to include the correct species. For example, the very first script you will have to manually set up the FTP commands to download the correct genomes.


## Adapted scripts and instructions:

#### 1) `./download_genomes`  - simple script to download genome sequences from Ensembl FTP site  *EF eliminated unnecessary species*

#### 2) get_ensembl_annotations 

  - download annotations from the Ensembl MySQL database `./get.ensembl.annotations.sh Human` *EF eliminated unnecessary species*

 -  format annotations into "exon blocks" (union of all exon coordinates) `./make.exon.blocks.ensembl.sh $species`

#### 3) get_ensembl_ortho

 - extract all 1-1 orthology relationships from the Ensembl MySQL database `./get_ortho_ensembl_mysql.sh`

 - extract all 1-1 orthologous families for a given set of species `./extract.ortho.families.sh`

#### 4) tba_alignments

 - `./extract.fasta.genes.sh` sequences (including exons and introns) for each 1-1 ortho gene family, for each species *EF made slight modifications in first function of perl script to run on a mac*
 
 - `./basrc_file` with the appropriate PATH 's to run lastz titled 'blastz' instead (blastz is no longer available but lastz does the same thing).
 	Download the latest version of lastz, make a copy of the executable in the lastz/src directory and name it blastz
 	Then change the two PATHs to the location of blastz and multiz  *This step was added by EF*
 	
 - align these sequences with LASTZ and TBA (download multiz) `./run.tba.alignments.sh` *EF has modified this substantially*

#### 5) extract_aligned_exons

 - extract aligned exon coordinates from the TBA alignments `./extract.aligned.exons.sh`

 - sanity checks:  all species must have the same aligned exon sequence length `check.aligned.length.R`

 - extract aligned exon sequence for each 1-1 ortho gene family and for each species `./extract.aligned.exons.sequences.sh` *EF made slight modifications in first function of perl script to run on a mac*

 - check exon alignments by computing % sequence identity `./compute.percentage.identity.sh`
 
  ### EF's code starts here
 
 - reorganize extract aligned exon sequences by species, not 1-1 ortho gene `./reorganize.by.species.sh Human`
 
 
#### 6) download_RNAseq_files

 - `./download.raw.read.sh` downloads the raw read .sra files from Brawand et al's original paper
 
 - `./create.fastq.files.sh` creates index files and RNA-seq count files using Kallisto, requires modification depending on species
 
 - `./run_fastQC.sh` runs fastqc creates .html files for visual inspection of RNA-seq data quality
 
 #### 7) get_transcript_abundances

 - `./quantify.RNA.seq.sh` pseudoaligns and quantifies RNA seq data to fasta files using Kallisto
 
 - `./TPM.csv.creation.sh` creates one file with expression data from all samples
 
 
 #### 8) Simulate_RNA_seq_data to check for biases in pipeline
 
 - `R --vanilla <sim_RNA_seq.r` will simulate RNA-seq samples, detailed explanation at the beginning of the script
 
 - `./quantify.RNA.seq.sh` pseudoaligns and quantifies RNA seq data to fasta files using Kallisto
 
 - `./TPM.csv.creation.sh` creates one file with expression data from all samples
 
 
 
 #### 9) Process_data
 
 - Use BioMart in ensembl to get the gene names and chromosomal locations of all genes in the dataset
 
 - PrepDataforBAGER.Rmd file eliminates bad samples and processes the data for Bayesian Ancestral Gene Expression Reconstruction to identify gene expression shifts in the human lineage.
 
 
## General notes
In general the first steps include a generic perl "script", which takes a rather extensive set of parameters (e.g., species, annotations files, genome sequences etc.). 

Then there is a bash script that defines the correct parameters. The bash script will either not take any arguments at all, or the argument will be the species for which we want to do a specific procedure. 

For example, you will find in the "get_ensembl_annotations" folder the following scripts:

make.exon.blocks.ensembl.pl - this is the generic perl script

make.exon.blocks.ensembl.sh - this is the bash script that runs perl, it only needs the species (e.g., Human, Chimpanzee) as a parameter

If you run the perl script without defining the parameters (e.g., perl make.exon.blocks.ensembl.pl)  you will see the full list of parameters for that script. In general the parameter names are intuitive. 





### written by Erin Fry
### Last modified: April 24 2017
