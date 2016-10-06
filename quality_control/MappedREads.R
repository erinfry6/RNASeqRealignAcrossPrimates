path="/Users/lynchlab/Desktop/ErinFry/ReconAncNeoTranscriptomes/Realigning/" ##full absolute path to main directory
pathresults=paste(path,"results/",sep="")
pathAbundance=paste(pathresults,"RawGeneExpression/",sep="")
pathdata=paste(path,"data/",sep="")
pathResults=paste(pathresults,"QualityControl/",sep="")

setwd(pathAbundance)
ldf <- list() # creates a list
listcsv<-as.character(dir(pattern="*")) # creates the list of all the csv files in the directory in true (not computer) numerical order

## sum the est_counts column of each abundance.tsv file

SampleInfo<-read.table(paste(pathdata,"/SampleInformation.txt",sep=""),sep='\t',header=TRUE)
SampleInfo<-SampleInfo[order(SampleInfo$SampleID),]
SampleInfo$SampleID==listcsv

#n equals the number of columns in SampleInfo
n=ncol(SampleInfo)

for (k in 1:nrow(SampleInfo)){ 
  SampleInfo[k,(n+1)]<-as.numeric(sum((read.delim(paste(listcsv[k],"/","abundance.tsv",sep="")))$est_counts))
}

colnames(SampleInfo)<-c(colnames(SampleInfo)[-n],"Mapped_Reads")

SampleInfo$Proportion_mapped_reads<-SampleInfo$Mapped_Reads/SampleInfo$Raw_reads
SampleInfo$Unmapped_reads<-SampleInfo$Raw_reads-SampleInfo$Mapped_Reads
SampleInfo$Proportion_unmapped_reads<-SampleInfo$Unmapped_reads/SampleInfo$Raw_reads

write.table(SampleInfo,"Sampleinfo.txt",sep='\t')

head(SampleInfo)

library(ggplot2)
library(scales)

ggplot(SampleInfo, aes(x = factor(SampleID), y = Unmapped_reads, fill = Species)) + 
  geom_bar(stat = "identity", colour = "black") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  xlab("Sample") + ylab("Number of unmapped reads") + 
  ggtitle("Number of Unmapped reads for all samples (RNA-seq)") + 
  scale_y_continuous(labels=comma)
ggsave(paste(pathResults,"UnmappedReads.pdf"))


ggplot(SampleInfo, aes(x = factor(SampleID), y = Mapped_Reads, fill = Species)) + 
  geom_bar(stat = "identity", colour = "black") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  xlab("Sample") + ylab("Number of mapped reads") + 
  ggtitle("Number of Mapped reads for all samples (RNA-seq)") + 
  scale_y_continuous(labels=comma)
ggsave(paste(pathResults,"MappedReads.pdf"))

ggplot(SampleInfo, aes(x = factor(SampleID), y = Proportion_mapped_reads, fill = Species)) + 
  geom_bar(stat = "identity", colour = "black") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  xlab("Sample") + ylab("Proportion of Mapped Reads") + 
  ggtitle("Proportion of Reads Mapped for all samples (RNA-seq)") + 
  scale_y_continuous(labels=comma)
ggsave(paste(pathResults,"ProportionMapped.pdf"))