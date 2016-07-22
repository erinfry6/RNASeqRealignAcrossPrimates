##!/bin/bash


## Pseudo-align and quantify the RNA-seq raw reads to the .fa files created in step 5
## ** requires Kallisto (brew install kallisto) **

##########################################################################################

export path=/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning ##set base directory path
export pathExonFasta=${path}/results/aligned_exons_sequences_by_species
export pathRNAseq=${path}/data/RNA_seq_raw
export pathResults=${path}/results/GeneExpression
export pathScripts=${path}/scripts/map_RNA_seq_data

##########################################################################################

cd ${pathExonFasta}

for sp in *.fa
	do
		echo Creating index file for ${sp}
		kallisto index -i $sp.idx $sp
	
	if [ ${sp} = "Human.fa" ]; then
    	export name="hsa_br"
	fi

	if [ ${sp} = "Chimpanzee.fa" ]; then
    	export name="ptr_br"
    fi
    	
    if [ ${sp} = "Bonobo.fa" ]; then
    	export name="ppa_br"
    fi

	if [ ${sp} = "Gorilla.fa" ]; then
    	export name="ggo_br"
	fi

	if [ ${sp} = "Orangutan.fa" ]; then
    	export name="ppy_br"
	fi

	if [ ${sp} = "Macaque.fa" ]; then
    	export name="mml_br"
    fi

	cd ${pathRNAseq}
    
    	for i in ${name}_*_*_1.fastq
    		do
    	
    		echo Quantifying ${i}

			i2=$(echo $i | sed s/./2/12)

			kallisto quant -i ${pathExonFasta}/${sp}.idx -o ${pathResults}/$i.out -b 100 ${i} ${i2}
			
			done
		
		
		
		for i in ${name}_M_1.fastq
			do
			
			echo Quantifying ${i}

			kallisto quant -i ${pathExonFasta}/${sp}.idx -o ${pathResults}/$i.out -b 100 --single -l 76 -s 1 ${i}
			
			done
		
		for i in ${name}_F_1.fastq
			do
			
			echo Quantifying ${i}

			kallisto quant -i ${pathExonFasta}/${sp}.idx -o ${pathResults}/$i.out -b 100 --single -l 76 -s 1 ${i}
			
			done
			
	done
	
cd ${pathScripts}