path="/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning/" ##full absolute path to main directory
pathData=paste(path,"results/",sep="")
pathRaw=paste(pathData,"RawGeneExpression/",sep="")
pathResults=paste(path,"results/","QualityControl",sep="")

setwd(pathRaw)
ldf <- list() # creates a list
listcsv<-as.character(dir(pattern="*")) # creates the list of all the csv files in the directory in true (not computer) numerical order

## find the dimensions and gene names from one of the abundance.tsv files

firstfile<-read.delim(paste(listcsv[1],"/","abundance.tsv",sep=""),header=T)

Abundances<-matrix(nrow=nrow(firstfile),ncol=(length(listcsv)+1))
colnames(Abundances)<-c("Human_Ortho_EnsemblID",listcsv)
Abundances[,1]<-as.character(firstfile[,1])

for (k in 1:length(listcsv)){ 
  Abundances[,(k+1)]<-read.delim(paste(listcsv[k],"/","abundance.tsv",sep=""))[,5]
}

head(Abundances)

setwd(pathResults)
write.table(Abundances,"Transcript_Abundances.txt", sep="\t",row.names=FALSE,col.names=TRUE)
