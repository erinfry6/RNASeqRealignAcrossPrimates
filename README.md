## The following pipeline is adapted from Brawand et al 2011 (http://www.ncbi.nlm.nih.gov/pubmed/22012392)'s pipeline obtained from Anamaria Necsulea
## Erin Fry (efry@uchicago.edu) in the Lynch Laboratory at the University of Chicago has modified the pipeline

#################################################################################

Before beginning, create a home directory for the pipeline that contains the following subdirectories

				home/data  		/ensembl_annotations

		   						/ensembl_ortho

		   						/genome_sequences

				home/results 	/aligned_exons

								/aligned_exons_sequences

								/tba_alignments

				home/scratch

				home/scripts

Place the contents of this repository in the scripts folder.


Adapted scripts and instructions:

#################################################################################

The scripts are divided in the following "modules" (in order of usage): 

#################################################################################

1) download_genomes  - simple script to download genome sequences from Ensembl FTP site  *EF eliminated unnecessary species*

2) get_ensembl_annotations 

  - download annotations from the Ensembl MySQL database using ./get.ensembl.annotations.sh Human *EF again eliminated unnecessary species*

 -  format annotations into "exon blocks" (union of all exon coordinates) using ./make.exon.blocks.ensembl.sh $species

3) get_ensembl_ortho

 - extract all 1-1 orthology relationships from the Ensembl MySQL database using get_ortho_ensembl_mysql.sh

 - extract all 1-1 orthologous families for a given set of species using extract.ortho.families.sh

4) tba_alignments

 - extract.fasta.genes.sh sequences (including exons and introns) for each 1-1 ortho gene family, for each species
 
 - run basrc_file with the appropriate PATH 's to run lastz titled 'blastz' instead (blastz is no longer available but lastz does the same thing).
 	Just download the latest version of lastz, make a copy of the executable in the lastz/src directory and name it blastz
 	Then change the two PATHs to the location of blastz and multiz  *This step was added by EF*
 	
 - align these sequences with LASTZ and TBA (download multiz) using run.tba.alignments.sh *EF has modified this substantially*

5) extract_aligned_exons

 - extract aligned exon coordinates from the TBA alignments

 - sanity checks:  all species must have the same aligned exon sequence length

 - extract aligned exon sequence for each 1-1 ortho gene family and for each species 

 - check exon alignments by  computing % sequence identity
 
6) Kallisto RNA Sequencing mapping

#################################################################################

### In general, for a specific procedure there is a generic perl "script", which takes a rather extensive set of parameters (e.g., species, annotations files, genome sequences etc.). 
### Then there is a bash script that defines the correct parameters. The bash script will either not take any arguments at all, or the argument will be the species for which we want to do a specific procedure. 

For example, you will find in the "get_ensembl_annotations" folder the following scripts:

make.exon.blocks.ensembl.pl - this is the generic perl script

make.exon.blocks.ensembl.sh - this is the bash script that runs perl, it only needs the species (e.g., Human, Chimpanzee) as a parameter

If you run the perl script without defining the parameters (e.g., perl make.exon.blocks.ensembl.pl)  you will see the full list of parameters for that script. In general the parameter names are intuitive. 

#################################################################################

######## RNASeqRealignAcrossPrimates
