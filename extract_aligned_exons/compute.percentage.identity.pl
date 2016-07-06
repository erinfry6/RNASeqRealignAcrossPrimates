use List::Util qw(first max maxstr min minstr reduce shuffle sum);
use strict;

######################################################################
######################################################################

sub readFasta{

    my $path=$_[0];
    my $reffasta=$_[1];
   
    my @s=split("\\.",$path);
    my $ext=$s[-1];

    my $input;

    if($ext eq "gz"){
	open($input,"zcat $path |");
    }
    else{
	open($input, $path);
    }
    
    my $line=<$input>;

    while($line){
	my $b=substr $line,0,1;
	
	if($b eq ">"){
	    chomp $line;
	    my $id=substr $line,1;

	    my @s=split(" ",$id);
	    $id=$s[0];
	    
	    $reffasta->{$id}="";

	    $line=<$input>;
	    $b=substr $line,0,1;
	    
	    while($line && !($b eq ">")){
		chomp $line;
		$reffasta->{$id}.=$line;
		$line=<$input>;
		$b=substr $line,0,1;
	    }
	}
    }

    close($input);
}


################################################################################

sub readGeneFamilies{
    my $pathin=$_[0];
    my $refsp=$_[1];
    my $fam=$_[2];
    
    open(my $input, $pathin);
    
    my $line=<$input>;
    chomp $line;
    my %header;
    my @s=split("\t",$line);
    my $nbfields=@s;
    
    for(my $i=0; $i<$nbfields; $i++){
	$header{$s[$i]}=$i;
    }
    
    $line=<$input>;
    
    while($line){
	chomp $line;
	my @s=split("\t",$line);
	my $famid=$s[$header{$refsp}];
	
	$fam->{$famid}={};

	foreach my $sp (keys %header){
	    $fam->{$famid}{$sp}=$s[$header{$sp}];
	}
	
	$line=<$input>;
    }
    
    close($input);
}

################################################################################

sub printHelp{

    my $parnames=$_[0];
    my $parvalues=$_[1];
    
    print "\n";
    print "This script computes % exon sequence identity for each gene family.\n";
    print "\n";
    print "Options:\n";
    
    foreach my $par (@{$parnames}){
	print "--".$par."  [  default value: ".$parvalues->{$par}."  ]\n";
    }
    print "\n";
}

######################################################################################
######################################################################################

my %parameters;
$parameters{"speciesList"}="NA";
$parameters{"refSpecies"}="NA";
$parameters{"pathGeneFamilies"}="NA";
$parameters{"dirAlignedExonsSequences"}="NA";
$parameters{"pathOutput"}="NA";

my %defaultvalues;
my @defaultpars=("speciesList", "refSpecies", "pathGeneFamilies", "dirAlignedExonsSequences", "pathOutput");

my @numericpars=();


my %numericpars;

foreach my $par (@numericpars){
    $numericpars{$par}=1;
}

foreach my $par (keys %parameters){
    $defaultvalues{$par}=$parameters{$par};
}

## check if help was asked 

foreach my $arg (@ARGV){
    if($arg eq "--help"){
	printHelp(\@defaultpars, \%defaultvalues);
	exit(0);
    }
}

## check new parameters

my $nbargs=@ARGV;

for(my $i=0; $i<$nbargs; $i++){
    my $arg=$ARGV[$i];
    $arg=substr $arg,2;
    my @s=split("=",$arg);
    my $parname=$s[0];
    my $parval=$s[1];
    
    if(exists $parameters{$parname}){
	$parameters{$parname}=$parval;
	
	if(exists $numericpars{$parname}){
	    $parameters{$parname}=$parval+0.0;
	}
    }
    else{
	print "Error: parameter ".$parname." was not recognized!!!\n";
	printHelp(\@defaultpars, \%defaultvalues);
	exit(1);
    }
}

## show parameters

print "\n";

print "Running program with the following parameters:\n";

foreach my $par (@defaultpars){
    print "--".$par."=".$parameters{$par}."\n";
}

print "\n";

#########################################################################################
#########################################################################################

my @species=split(",",$parameters{"speciesList"});
my $refsp=$parameters{"refSpecies"};
my $nbsp=@species;

print "Extracting aligned exon sequences from ".$nbsp." species: ".join(", ", @species)."\n";
print "Reference species (for file names): ".$refsp."\n";

#####################################################################

print "Reading gene families ids...\n";

my %genefamilies;

readGeneFamilies($parameters{"pathGeneFamilies"}, $refsp, \%genefamilies);

my $nbfam=keys %genefamilies;

print "There are ".$nbfam." families.\n";
print "Done.\n\n";

#####################################################################

print "Reading sequences and computing % identity...\n";

open(my $output, ">".$parameters{"pathOutput"});

my $line="RefID\tTotalLength";

foreach my $sp (@species){
    if($sp ne $refsp){
	$line.="\tIdenticalBases.".$sp;
    }
}


print $output $line."\n";

foreach my $id (keys %genefamilies){

    my $path=$parameters{"dirAlignedExonsSequences"}.$id.".fa";

    if(-e $path){

	print $id."\n";

	my %sequences;
	
	readFasta($path, \%sequences);
	
	my $refgene=$genefamilies{$id}{$refsp};

	my $refseq=$sequences{$refgene};
	my $nbbases=length $refseq;

	my $line=$id."\t".$nbbases;

	foreach my $sp (@species){
	    if($sp ne $refsp){
		my $thisgene=$genefamilies{$id}{$sp};
		my $thisseq=$sequences{$thisgene};

		my $nbid=0;

		for(my $i=0; $i<$nbbases; $i++){
		    my $b1=substr $refseq, $i,1;
		    my $b2=substr $thisseq, $i,1;

		    if($b1 eq $b2){
			$nbid++;
		    }
		}
		
		$line.="\t".$nbid;
	    }
	}
	
	print $output $line."\n";
    }
}

close($output);

print "Done.\n\n";

#####################################################################


