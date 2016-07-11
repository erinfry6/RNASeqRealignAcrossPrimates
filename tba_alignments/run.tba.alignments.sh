#!/bin/bash
 
######################################################################################
 
export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ## replace with full absolute path 
export pathFasta=${path}/data/genome_sequences/
export pathAnnot=${path}/data/ensembl_annotations/
export pathOrtho=${path}/data/ensembl_ortho
export pathScripts=${path}/scripts/tba_alignments
export pathTBAalign=${path}/results
export pathResults=${path}/results/tba_alignments
export pathTemp=${path}/scratch
 
export release=84
 
######################################################################################
 
## species tree: this is needed for TBA alignments
 
export tree="((((Human Chimpanzee) Gorilla) Orangutan) Macaque)"
 
if [ -e ${pathTemp} ]; then
echo 'already here'
else
mkdir ${pathTemp}  	
fi

 
######################################################################################
 ## trick to easily parallelize computations: in each parallel run we analyze genes whose human ID ends in ${i}${j} (e.g., 00, 01)
 ## EF has modified this portion substantially from original code by A. Necsulea
for i in {0..9}
do
    for j in {2..9}
    do
    
    export pathLocal=${pathTemp}/TBA_${i}_${j}
    
    echo "if [ -e ${pathLocal} ]; then"> bsub_script_tba_${i}_${j}
	echo "echo 'already here'">> bsub_script_tba_${i}_${j}
	echo "else">> bsub_script_tba_${i}_${j}
	echo "mkdir ${pathLocal}">> bsub_script_tba_${i}_${j}    	
	echo "fi">> bsub_script_tba_${i}_${j}
    

    for gene in `ls ${pathTBAalign} | grep ${i}${j}$`; do
	    echo "cp -r ${pathTBAalign}/${gene} ${pathLocal}" >> bsub_script_tba_${i}_${j}   	
	    echo "cd ${pathLocal}/${gene}">> bsub_script_tba_${i}_${j}
	    echo "all_bz \""${tree}"\" >& bz.log"  >> bsub_script_tba_${i}_${j}   			
	    echo "tba \""${tree}"\" *.*.maf tba.maf >& tba.log" >> bsub_script_tba_${i}_${j}	
	    echo "mv tba.maf ${pathResults}/${gene}.maf" >> bsub_script_tba_${i}_${j}			
	    echo "gzip ${pathResults}/${gene}.maf" >>  bsub_script_tba_${i}_${j}					
	    echo "cd ${pathScripts}" >>  bsub_script_tba_${i}_${j}
	    echo "rm -r ${pathLocal}/${gene}" >>  bsub_script_tba_${i}_${j}		
	done

	echo "rm -r ${pathLocal}/" >>  bsub_script_tba_${i}_${j}
	
	echo echo "done with bsub_script_tba_${i}_${j}" >> bsub_script_tba_${i}_${j}
    chmod a+x bsub_script_tba_${i}_${j}
    
    
    done
done


######################################################################################

## EF: now run each of the bsub files, 10 at a time to align each gene
 
for i in {0..9}
do
    for j in {0..9}
    do
    
    ./bsub_script_tba_${i}_${j} &
    
    
    done
    
    wait
    
done