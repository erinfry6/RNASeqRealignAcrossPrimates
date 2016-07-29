path="/Users/lynchlab/Desktop/ErinFry/BrainTranscription/Realigning/" ##full absolute path to main directory
pathResults=paste(path,"results/",sep="")
pathData=paste(path,"data/",sep="")
pathRaw=paste(pathResults,"RawGeneExpression/",sep="")

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

setwd(pathRaw)
write.table(Abundances,"All_Abundances.csv", sep="\t",row.names=FALSE,col.names=FALSE)
