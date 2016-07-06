#!/bin/bash
 
######################################################################################

export PATH=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning/scripts/lastz-distrib-1.02.00/bin/:${PATH}
export PATH=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning/scripts/multiz-tba.012109/:${PATH}

######################################################################################
 ## trick to easily parallelize computations: in each parallel run we analyze genes whose human ID ends in ${i}${j} (e.g., 00, 01)
 
i=0
    for j in {2..9}
    do
    
    ./bsub_script_tba_${i}_${j} &
    
	done 
 
 
for i in {1..9}
do
    for j in {0..9}
    do
    
    ./bsub_script_tba_${i}_${j} &
    
    
    done
    
    wait
    
done