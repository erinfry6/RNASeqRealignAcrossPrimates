#################################################################

path="/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning/"
pathOrtho=paste(path,"data/ensembl_ortho/",sep="")
pathAligned=paste(path,"results/aligned_exons/",sep="")

#################################################################

ortho=read.table(paste(pathOrtho, "GeneFamilies_1to1_ProteinCoding_Ensembl84.txt", sep=""), h=T, stringsAsFactors=F, sep="\t")

#################################################################

exonblocks=list()
genelengths=list()

for(sp in colnames(ortho)){
  blocks=read.table(paste(pathAligned,sp,"/AlignedExonParts_Ensembl84_FilteredTranscripts.txt",sep=""), h=F, stringsAsFactors=F, sep="\t")

  blocks$length=blocks[,4]-blocks[,3]+1

  glen=tapply(blocks$length, as.factor(blocks[,1]), sum)
  names(glen)=levels(as.factor(blocks[,1]))

  genelengths[[sp]]=glen
  exonblocks[[sp]]=blocks
}

#################################################################

for(gene in intersect(ortho$Human, names(genelengths[["Human"]]))){
  lengths=c()
  for(sp in colnames(ortho)){
    this.gene=ortho[which(ortho$Human==gene),sp]
    lengths=c(lengths, genelengths[[sp]][this.gene])
  }

  if(length(unique(lengths))>1){
    print(paste(length(unique(lengths)), "unique aligned lengths"))
    print(lengths)
    stop()
    
  } else{
    print(paste(gene,"OK"))
  }
}

#################################################################
