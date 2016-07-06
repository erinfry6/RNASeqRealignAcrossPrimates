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



#################################################################################

sub reverseComplement{
    my $sequence=$_[0];
    
    my $rev=reverse $sequence;

    $rev=~s/A/X/g;
    $rev=~s/C/Y/g;
    $rev=~s/G/Z/g;
    $rev=~s/T/W/g;

    $rev=~s/X/T/g;
    $rev=~s/Y/G/g;
    $rev=~s/Z/C/g;
    $rev=~s/W/A/g;

    return $rev;
}


################################################################################

sub writeSequence{
    my $sequence=$_[0];
    my $name=$_[1];
    my $output=$_[2];

    my $n=length $sequence;

    print $output ">".$name."\n";

    my $i=0;

    while($i<($n-60)){

        my $subseq=substr $sequence,$i,60;

        print $output $subseq ."\n";

        $i+=60;
    }

    if($i<$n){
        my $subseq=substr $sequence,$i;
        print $output $subseq ."\n";
    }
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

sub readAlignedExons{
    my $pathin=$_[0];
    my $exonblocks=$_[1];
   
    open(my $input, $pathin);
    
    my $line=<$input>;

    while($line){
	chomp $line;
	my @s=split("\t", $line);

	my $geneid=$s[0];
	my $chr=$s[1];
	my $start=$s[2];
	my $end=$s[3];
	my $strand=$s[4];

	if(exists $exonblocks->{$geneid}){
	    push(@{$exonblocks->{$geneid}{"start"}}, $start);
	    push(@{$exonblocks->{$geneid}{"end"}}, $end);
	}
	else{
	    $exonblocks->{$geneid}={"chr"=>$chr, "start"=>[$start], "end"=>[$end], "strand"=>$strand};
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
    print "This script extracts aligned exon sequences.\n";
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

$parameters{"dirGenomeSequence"}="NA";
$parameters{"suffixGenomeSequence"}="NA";

$parameters{"dirAlignedExons"}="NA";
$parameters{"suffixAlignedExons"}="NA";

$parameters{"dirOutput"}="NA";

my %defaultvalues;
my @defaultpars=("speciesList", "refSpecies", "pathGeneFamilies", "dirGenomeSequence", "suffixGenomeSequence", "dirAlignedExons", "suffixAlignedExons","dirOutput");

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

#####################################################################
#####################################################################

my @species=split(",",$parameters{"speciesList"});
my $refsp=$parameters{"refSpecies"};
my $nbsp=@species;

print "Extracting aligned exon sequences from ".$nbsp." species: ".join(", ", @species)."\n";
print "Reference species (for output file names): ".$refsp."\n";

#####################################################################

print "Reading genome sequence for ".$nbsp." species...\n";

my %genome;

foreach my $sp (@species){
    print $sp."\n";
    
    $genome{$sp}={};

    my $path=$parameters{"dirGenomeSequence"}.$sp."/".$parameters{"suffixGenomeSequence"};
    
    if(-e $path){
	readFasta($path,$genome{$sp});
    }
    else{
	print "Cannot find fasta file for ".$sp."!!!\n";
	print $path."\n";
	exit(1);
    }
}


print "Done.\n\n";

#####################################################################

print "Reading aligned exon coordinates...\n";

my %exons;

foreach my $sp (@species){
    print $sp."\n";
    
    $exons{$sp}={};

    my $path=$parameters{"dirAlignedExons"}.$sp."/".$parameters{"suffixAlignedExons"};
    
    if(-e $path){
	readAlignedExons($path, $exons{$sp});
    }
    else{
	print "Cannot find aligned exons file for ".$sp."!!!\n";
	print $path."\n";
	exit(1);
    }
    
    my $nbg=keys %{$exons{$sp}};
    
    print "Found ".$nbg." genes with aligned exons for ".$sp.".\n";
}

print "Done.\n\n";

#####################################################################

print "Reading gene families ids...\n";

my %genefamilies;

readGeneFamilies($parameters{"pathGeneFamilies"}, $refsp, \%genefamilies);

my $nbfam=keys %genefamilies;

print "There are ".$nbfam." families.\n";
print "Done.\n\n";

#####################################################################

my $nbdone=0;
my $nbok=0;

foreach my $idfam (keys %genefamilies){
    my $refgene=$genefamilies{$idfam}{$refsp};

    if(exists $exons{$refsp}{$refgene}){
	$nbok++;

	open(my $output, ">".$parameters{"dirOutput"}.$idfam.".fa");

	foreach my $sp (@species){
    
	    my $geneid=$genefamilies{$idfam}{$sp};
	    
	    if(!(exists $exons{$sp}{$geneid})){
		print "Weird! cannot find ".$geneid." for ".$sp." in family ".$idfam."\n";
		exit(1);
	    }
	    
	    my $chr=$exons{$sp}{$geneid}{"chr"};
	    my $strand=$exons{$sp}{$geneid}{"strand"};

	    my $seq="";
	    my $nbexons=@{$exons{$sp}{$geneid}{"start"}};

	    for(my $i=0; $i<$nbexons; $i++){
		my $start=${$exons{$sp}{$geneid}{"start"}}[$i];
		my $end=${$exons{$sp}{$geneid}{"end"}}[$i];

		my $subseq=substr $genome{$sp}{$chr}, ($start-1), ($end-$start+1);

		$seq.=$subseq;
	    }

	    if($strand eq "-1"){
		$seq=reverseComplement($seq);
	    }
	    else{
		if($strand ne "1"){
		    print "Weird strand for ".$sp." ".$geneid."\n";
		    exit(1);
		}
	    }
	    
	    writeSequence($seq, $geneid, $output);
	  
	}

	close($output);
    }

    $nbdone++;

    if($nbdone%1000==0){
	print $nbdone." genes done.\n";
    }
}

print "Found ".$nbok." OK sequences out of ".$nbdone." families.\n";

#####################################################################
