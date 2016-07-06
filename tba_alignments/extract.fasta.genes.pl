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
	#open($input,"zcat $path |");
	open($input,"gunzip -c $path |");
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
    my $sp=$_[1];
    my $refsp=$_[2];
    my $fam=$_[3];
    
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
	my $geneid=$s[$header{$sp}];
	
	$fam->{$famid}=$geneid;
	
	$line=<$input>;
    }
    
    close($input);
}

################################################################################

sub readGeneInfo{
    my $pathin=$_[0];
    my $geneinfo=$_[1];

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
	
	my $geneid=$s[$header{"stable_id"}];
	my $chr=$s[$header{"name"}];
	my $start=$s[$header{"seq_region_start"}];
	my $end=$s[$header{"seq_region_end"}];
	my $strand=$s[$header{"seq_region_strand"}];

	$geneinfo->{$geneid}={"chr"=>$chr, "start"=>$start, "end"=>$end, "strand"=>$strand};
	
	$line=<$input>;
    }
    
    close($input);
}

################################################################################

sub printHelp{

    my $parnames=$_[0];
    my $parvalues=$_[1];
    
    print "\n";
    print "This script extracts gene sequences for TBA alignment.\n";
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
$parameters{"species"}="NA";
$parameters{"refSpecies"}="NA";
$parameters{"pathGenomeSequence"}="NA";
$parameters{"pathGeneInfo"}="NA";
$parameters{"pathGeneFamilies"}="NA";
$parameters{"dirOutput"}="NA";

my %defaultvalues;
my @defaultpars=("species", "refSpecies","pathGenomeSequence","pathGeneInfo","pathGeneFamilies","dirOutput");

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

my $species=$parameters{"species"};
my $refsp=$parameters{"refSpecies"};

print "Extracting gene sequences for ".$species."\n";
print "Reference species (for gene family names): ".$refsp."\n";

#####################################################################

print "Reading genome sequence for ".$species."...\n";

my %genome;

my $path=$parameters{"pathGenomeSequence"};

if(-e $path){
    readFasta($path,\%genome);
}
else{
    print "Cannot find fasta file for ".$species."!!!\n";
    print $path."\n";
    exit(1);
}

my %chrsizes;

foreach my $chr (keys %genome){
    my $size=length $genome{$chr};
    $chrsizes{$chr}=$size;
}

print "Done.\n\n";

#####################################################################

print "Reading gene info...\n";

my %geneinfo;

readGeneInfo($parameters{"pathGeneInfo"}, \%geneinfo);

my $nbg=keys %geneinfo;

print "Found ".$nbg." genes.\n";

print "Done.\n";

#####################################################################

print "Reading gene families ids...\n";

my %genefamilies;

readGeneFamilies($parameters{"pathGeneFamilies"},$species, $refsp, \%genefamilies);

my $nbfam=keys %genefamilies;

print "There are ".$nbfam." families.\n";
print "Done.\n\n";

#####################################################################

my $nbdone=0;
my $nbok=0;

foreach my $idfam (keys %genefamilies){
    
    if(!(-e $parameters{"dirOutput"}.$idfam)){
	system("mkdir ".$parameters{"dirOutput"}.$idfam);
    }
    
    my $geneid=$genefamilies{$idfam};
    
    if(exists $geneinfo{$geneid}){
	my $chr=$geneinfo{$geneid}{"chr"};
	my $start=$geneinfo{$geneid}{"start"};
	my $end=$geneinfo{$geneid}{"end"};
	my $strand=$geneinfo{$geneid}{"strand"};

	if(exists $genome{$chr}){
	    
	    if($start>$end){
		print "Weird coordinates for ".$geneid."\n";
		exit(1);
	    }

	    my $seq=substr $genome{$chr}, ($start-1), ($end-$start)+1; ## coordinates start at 1, start end included
	    my $name=$species.":".$chr.":".$start.":+:".$chrsizes{$chr};

	    open(my $output, ">".$parameters{"dirOutput"}.$idfam."/".$species);
	    writeSequence($seq, $name, $output);
	    close($output);
	    $nbok++;
	}
    }

    $nbdone++;

    if($nbdone%1000==0){
	print $nbdone." genes done.\n";
    }
}

print "Found ".$nbok." OK sequences out of ".$nbdone." families.\n";

#####################################################################
