use List::Util qw(first max maxstr min minstr reduce shuffle sum);
use strict;

#####################################################################

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

#########################################################################

sub readAlignments{
    my $pathin=$_[0];
    my $species=$_[1]; ## required species
    my $minlen=$_[2]; ## minimum alignment length (excluding gaps, for each species)
    my $aln=$_[3];
    
    my $input;

    my @ext=split("\\.",$pathin);
    my $nbext=@ext;
    my $ext=$ext[$nbext-1];

    if($ext eq "gz"){
	open($input,"zcat < $pathin | ");
    }
    else{
	open($input,$pathin);
    }

    my $line=<$input>;
    my $firstchar=substr $line,0,1;

    while($firstchar eq "#"){
	$line=<$input>;
	$firstchar=substr $line,0,1;
    }
 
    my $currentscore="NA";
    
    my $indexaln=0;

    while($line){

	chomp $line;
	$firstchar=substr $line,0,1;
	
	if($firstchar eq "a"){
	    
	    $indexaln++;

	    my @s=split(" ",$line);
	    my $score=$s[1];
	    my @t=split("=",$score);
	    $score=$t[1]+0;
	    $currentscore=$score;

	    $aln->{$indexaln}={};
	}

	if($firstchar eq "s"){
	    my @s=split(" ",$line);
	    
	    my $spchr=$s[1];
	    my @t=split("\\.",$spchr); 
	    my $sp=$t[0];
	    my $chr=$t[1];

	    my $start=$s[2]+0; ## 0-based
	    my $ungappedlen=$s[3]+0;
	    my $strand=$s[4];
	    my $chrlen=$s[5]+0;
	    my $sequence=$s[6];
	    
	    $aln->{$indexaln}{$sp}={"start"=>$start,"strand"=>$strand,"sequence"=>$sequence,"chrlen"=>$chrlen,"ungappedlen"=>$ungappedlen};
	    
	}
		
	$line=<$input>;
    }

    close($input);
 

    ## remove alignments that do not have all species and/or which are too short

    my @indexes=keys %{$aln};
    
    foreach my $index (@indexes){
	my $nbsp=keys %{$aln->{$index}};

	my $allin=1;
	my $alllong=1;

	foreach my $sp (@{$species}){
	    if(!(exists $aln->{$index}{$sp})){
		$allin=0;
		last;
	    }

	    my $len=$aln->{$index}{$sp}{"ungappedlen"};
	    
	    if($len<$minlen){
		$alllong=0;
		last;
	    }
	}

	if($allin==0 || $alllong==0){
	    delete $aln->{$index};
	}
    }
   
    my $nbkept=keys %{$aln};

    print "Kept ".$nbkept." alignments.\n";
}

################################################################################

sub readExonBlocks{
    my $pathin=$_[0];
    my $exonblocks=$_[1];
   
    open(my $input, $pathin);
    
    my $line=<$input>;

    while($line){
	chomp $line;
	my @s=split("\t", $line);

	my $geneid=$s[0];
	my $exonid=$s[1];
	my $chr=$s[2];
	my $start=$s[3];
	my $end=$s[4];
	my $strand=$s[5];

	if(exists $exonblocks->{$geneid}){
	    $exonblocks->{$geneid}{$exonid}={"chr"=>$chr, "start"=>$start, "end"=>$end, "strand"=>$strand};
	}
	else{
	    $exonblocks->{$geneid}={$exonid=>{"chr"=>$chr, "start"=>$start, "end"=>$end, "strand"=>$strand}};
	}

	$line=<$input>;
    }

    close($input);
}

################################################################################

sub filterAlignmentStrands{
    my $aln=$_[0];
    my $genestrands=$_[1]; ## for each species

    my @indexes=keys %{$aln};
    
    my $nbtot=@indexes;
    my $nbkept=0;

    foreach my $index (@indexes){
	my $allok=1;
	my $allwrong=1;

	foreach my $sp (keys %{$aln->{$index}}){
	    my $alnstrand=$aln->{$index}{$sp}{"strand"};
	    
	    if(($alnstrand eq "+" && $genestrands->{$sp} eq "1") || ($alnstrand eq "-" && $genestrands->{$sp} eq "-1")){
		$allwrong=0;
	    }
	    else{
		if(($alnstrand eq "-" && $genestrands->{$sp} eq "1") || ($alnstrand eq "+" && $genestrands->{$sp} eq "-1")){
		    $allok=0;
		}
		else{
		    print "Weird strands!! aln ".$alnstrand." ".$genestrands->{$sp}."\n";
		    exit(1);
		}
	    }
	}

	if(($allok+$allwrong)!=1){
	    delete $aln->{$index};
	}
	else{
	    $nbkept++;
	}
    }

    print "Kept ".$nbkept." alignments out of ".$nbtot." after strand filtering.\n";
}

################################################################################

sub hashExonCoords{
    my $exoncoords=$_[0]; ## for a single gene
    my $hashcoords=$_[1];

    foreach my $id (keys %{$exoncoords}){
	my $start=$exoncoords->{$id}{"start"};
	my $end=$exoncoords->{$id}{"end"};
	my $strand=$exoncoords->{$id}{"strand"};

	my $newid=$id.",".$start.",".$end.",".$strand;
	
	for(my $j=$start; $j<=$end; $j++){
	    $hashcoords->{$j}=$newid;
	} 
    }
}

################################################################################

sub extractAlignedExons{
    my $aln=$_[0];
    my $hashcoords=$_[1]; ## for each species
    my $alignedpos=$_[2];

    foreach my $index (keys %{$aln}){
	## define starting pos and increment for each species
	
	my %alnpos;
	my %increment;

	my $alnlength;

	foreach my $sp (keys %{$aln->{$index}}){
	    my $alnstrand=$aln->{$index}{$sp}{"strand"};
	    my $start=$aln->{$index}{$sp}{"start"};
	    my $chrlen=$aln->{$index}{$sp}{"chrlen"};
	    $alnlength=length $aln->{$index}{$sp}{"sequence"};

	    if($alnstrand eq "+"){
		$alnpos{$sp}=$start; ## before the actual 1-based position
		$increment{$sp}=1;
	    }
	    else{
		if($alnstrand eq "-"){
		    $alnpos{$sp}=($chrlen-$start)+1; ## before the actual 1-based position
		    $increment{$sp}=-1;
		}
		else{
		    print "Weird alignment strand ".$alnstrand."\n";
		}
	    }
	}

	## now go over the alignment base by base

	for(my $i=0; $i<$alnlength; $i++){
	    my $allinexon=1;
	    my $allungap=1;

	    foreach my $sp (keys %{$aln->{$index}}){
		my $base=substr $aln->{$index}{$sp}{"sequence"}, $i, 1;

		if($base ne "-"){
		    ## this is not a gap, we update the position 
		    ## no *last* here - we need to update it even if there are gaps in other species
		    $alnpos{$sp}+=$increment{$sp};

		    if(!(exists $hashcoords->{$sp}{$alnpos{$sp}})){
			$allinexon=0;
		    }
		}
		else{
		    $allungap=0;
		}
	    }

	    if($allinexon==1 && $allungap==1){
		## these positions are all in exons, for each species 
		## there is no gap at this position
		
		foreach my $sp (keys %{$aln->{$index}}){
		    if(exists $alignedpos->{$sp}){
			push (@{$alignedpos->{$sp}}, $alnpos{$sp});
		    } 
		    else{
			$alignedpos->{$sp}=[];
			push (@{$alignedpos->{$sp}}, $alnpos{$sp});
		    }
		}
	    }
	}
    }    
}

################################################################################

sub filterRearrangements{
    my $alignedpos=$_[0];
    my $minfraction=$_[1];
    my $filteredpos=$_[2];

    my @species=keys %{$alignedpos};
    my $refsp=shift @species;
    
    my $alnlen=@{$alignedpos->{$refsp}};

    my %alntypes;
    my @types;
    
    for(my $i=0; $i<($alnlen-1); $i++){
	my $pos1ref=${$alignedpos->{$refsp}}[$i];
	my $pos2ref=${$alignedpos->{$refsp}}[$i+1];

	if($pos1ref==$pos2ref){
	    print "Weird! saw ".$pos1ref." twice for ".$refsp."\n";
	    exit(1);
	}
	
	my $thistype="";

	foreach my $sp (@species){
	    my $pos1other=${$alignedpos->{$sp}}[$i];
	    my $pos2other=${$alignedpos->{$sp}}[$i+1];

	    if($pos1other==$pos2other){
		print "Weird! saw ".$pos1other." twice for ".$sp."\n";
		exit(1);
	    }
	    
	    if(($pos1ref<$pos2ref && $pos1other<$pos2other) || ($pos1ref>$pos2ref && $pos1other>$pos2other)){
		$thistype.="+";
	    }
	    else{
		$thistype.="-";
	    }
	}

	if(exists $alntypes{$thistype}){
	    $alntypes{$thistype}++;
	}
	else{
	    $alntypes{$thistype}=1;
	}

	push(@types, $thistype);
    }

    ## find out if there is one majority type

    my $kepttype="NA";
    my $keptfreq=0;

    foreach my $type (keys %alntypes){
	my $freq=$alntypes{$type}/($alnlen-1);

	if($freq>=$minfraction){
	    $kepttype=$type;
	    $keptfreq=$freq;

	    # print "type ".$type." frequency ".$freq."\n";
	    last;
	}
    }

    if($kepttype eq "NA"){
	print "Could not find any consensus alignment type, probably a lot of rearrangements.\n";
    }
    else{

	## initialize 
	$filteredpos->{$refsp}=[];

	foreach my $sp (@species){
	    $filteredpos->{$sp}=[];
	}

	if($keptfreq==1){
	    push(@{$filteredpos->{$refsp}}, @{$alignedpos->{$refsp}});
	    
	    foreach my $sp (@species){
		push(@{$filteredpos->{$sp}}, @{$alignedpos->{$sp}});
	    }
	}
	else{
	    ## go through the positions one by one, check if that was the aligned type
	    
	    for(my $i=0; $i<($alnlen-1); $i++){
		my $thistype=$types[$i];
		
		if($thistype eq $kepttype){
		    push(@{$filteredpos->{$refsp}}, ${$alignedpos->{$refsp}}[$i]);
		    
		    foreach my $sp (@species){
			push(@{$filteredpos->{$sp}}, ${$alignedpos->{$sp}}[$i]);
		    }
		}
	    }
	    
	    ## add the lastpos if the previous alignment type is ok 
	    
	    my $thistype=$types[-1];
	    
	    if($thistype eq $kepttype){
		push(@{$filteredpos->{$refsp}}, ${$alignedpos->{$refsp}}[-1]);
		
		foreach my $sp (@species){
		    push(@{$filteredpos->{$sp}}, ${$alignedpos->{$sp}}[-1]);
		}
	    }
	}
    }
}

################################################################################

sub makeAlignedBlocks{
    my $alignedpos=$_[0];
    my $alignedblocks=$_[1]; ## just for one species

    my @sortedpos=sort {$a<=>$b} @{$alignedpos};
    my $nbpos=@sortedpos;

    my $currentstart=$sortedpos[0];
    my $currentend=$sortedpos[0];
    
    for(my $i=1; $i<$nbpos; $i++){
	my $thispos=$sortedpos[$i];

	if($thispos<=($currentend+1)){
	    $currentend=$thispos;
	}
	else{
	    push(@{$alignedblocks->{"start"}}, $currentstart);
	    push(@{$alignedblocks->{"end"}}, $currentend);

	    $currentstart=$thispos;
	    $currentend=$thispos;
	}
    }
    
    push(@{$alignedblocks->{"start"}}, $currentstart);
    push(@{$alignedblocks->{"end"}}, $currentend);
}


################################################################################

sub printHelp{

    my $parnames=$_[0];
    my $parvalues=$_[1];
    
    print "\n";
    print "This script extracts aligned exon sequences from TBA alignments.\n";
    print "\n";
    print "Options:\n";
    
    foreach my $par (@{$parnames}){
	print "--".$par."  [  default value: ".$parvalues->{$par}."  ]\n";
    }
    print "\n";
}

################################################################################
################################################################################

my %parameters;
$parameters{"speciesList"}="NA";
$parameters{"refSpecies"}="NA";
$parameters{"pathGeneFamilies"}="NA";
$parameters{"dirTBA"}="NA";
$parameters{"minAlignmentLength"}="NA";
$parameters{"minFractionOrdered"}="NA";
$parameters{"dirAnnot"}="NA";
$parameters{"suffixAnnot"}="NA";
$parameters{"dirOutput"}="NA";
$parameters{"suffixOutput"}="NA";
$parameters{"pathOutputStats"}="NA";
$parameters{"start"}="NA";
$parameters{"end"}="NA";

my %defaultvalues;
my @defaultpars=("speciesList", "refSpecies", "pathGeneFamilies", "dirTBA", "minAlignmentLength", "minFractionOrdered", "dirAnnot", "suffixAnnot", "dirOutput", "suffixOutput", "pathOutputStats", "start", "end");

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

print "Extracting exon alignments from ".$nbsp." species: ".join(", ", @species)."\n";
print "Reference species: ".$refsp."\n";

#####################################################################

print "Reading gene families...\n";

my %genefam;
readGeneFamilies($parameters{"pathGeneFamilies"}, $refsp, \%genefam);
my $nbfam=keys %genefam;

print "Found ".$nbfam." families.\n";

print "Done.\n";

#####################################################################

print "Reading exon blocks for each species...\n";

my %exonblocks; 
foreach my $sp (@species){
    $exonblocks{$sp}={};

    my $path=$parameters{"dirAnnot"}.$sp."/".$parameters{"suffixAnnot"};

    if(-e $path){
	readExonBlocks($path, $exonblocks{$sp});
	my $nbg=keys %{$exonblocks{$sp}};
	
	print "Found ".$nbg." genes for ".$sp."\n";
    }
    else{
	print "Cannot find ".$path." for ".$sp."\n";
    }
}

print "Done.\n";

#####################################################################

print "Extracting aligned exons...\n";

my %alignedblocks;

foreach my $sp (@species){
    $alignedblocks{$sp}={};
}

my $minalnlength=$parameters{"minAlignmentLength"}+0;

print "Minimum alignment length: ".$minalnlength."\n";

my $minfrordered=$parameters{"minFractionOrdered"}+0.0;

print "We discard projections that do not have a consensus order with at least ".$minfrordered." positions.\n";

my @ids=keys %genefam;
my @sortedids=sort @ids;
my $nbfam=@ids;

my $start=$parameters{"start"};
my $end=$parameters{"end"};


if($start eq "NA" || $end eq "NA"){
    $start=0;
    $end=$nbfam;
}
else{
   $start=$parameters{"start"}+0; 
   $end=$parameters{"end"}+0;

   if($end>$nbfam){
       $end=$nbfam;
   }
}


print "Analyzing families from ".$start." to ".$end."\n";


open(my $outputstats, ">".$parameters{"pathOutputStats"});

for(my $indexfam=$start; $indexfam<$end; $indexfam++){
    my $idfam=$sortedids[$indexfam];

    my $pathTBA=$parameters{"dirTBA"}."tba_alignments".$idfam.".maf.gz";

    if(-e $pathTBA){

	print $idfam."\n";

	## alignment

	my %aln;
	
	readAlignments($pathTBA, \@species, $minalnlength, \%aln);

	my $nbaln=keys %aln;

	if($nbaln>0){
	    
	    ## process gene annotations 
	    
	    my %hashexons;
	    my %genestrands;
	    
	    foreach my $sp (@species){
		$hashexons{$sp}={};
		my $gene=$genefam{$idfam}{$sp};
		
		if(exists $exonblocks{$sp}{$gene}){
		    my @exons=keys %{$exonblocks{$sp}{$gene}};
		    
		    my $strand=$exonblocks{$sp}{$gene}{$exons[0]}{"strand"};
		    $genestrands{$sp}=$strand;

		    hashExonCoords($exonblocks{$sp}{$gene}, $hashexons{$sp});
		}
		else{
		    print "Weird! cannot find ".$gene." for ".$sp.", family ".$gene."\n";
		    exit(1);
		}
	    }
	    
	    ## filter alignments for strands
	    
	    filterAlignmentStrands(\%aln, \%genestrands);

	    my $nbfilteredaln=keys %aln;
	    
	    if($nbfilteredaln>0){
		
		## extracting aligned exons
		
		my %alignedpos;
		
		extractAlignedExons(\%aln, \%hashexons, \%alignedpos);

		my $hasaln=1;
		
		foreach my $sp (@species){
		    my $gene=$genefam{$idfam}{$sp};
		    my $nbpos=0;

		    if(exists $alignedpos{$sp}){
			$nbpos=@{$alignedpos{$sp}};
		    } 
		    else{
			$hasaln=0;
		    }
		    
		    print $outputstats $sp."\t".$gene."\t".$nbpos."\taligned_all\n";
		}

		if($hasaln==1){ 
		    ## if there are any aligned exons
		    ## filtering rearrangements
		    
		    my %filteredaln;
		    
		    filterRearrangements(\%alignedpos, $minfrordered, \%filteredaln);

		    my $hasfilteredaln=1;
		    
		    foreach my $sp (@species){
			my $gene=$genefam{$idfam}{$sp};
			my $nbpos=0;
			
			if(exists $filteredaln{$sp}){
			    $nbpos=@{$filteredaln{$sp}};
			} 
			else{
			    $hasfilteredaln=0;
			}
			
			print $outputstats $sp."\t".$gene."\t".$nbpos."\taligned_filtered_rearrangements\n";
		    }
		    
		    if($hasfilteredaln==1){
			## if there are any aligned exons after filtering rearrangements
			## making aligned blocks
			
			foreach my $sp (@species){
			    
			    my $gene=$genefam{$idfam}{$sp};
			    my $nbpos=@{$filteredaln{$sp}};
			    
			    if($nbpos>0){
				$alignedblocks{$sp}{$gene}={"start"=>[], "end"=>[]};
				
				makeAlignedBlocks($filteredaln{$sp}, $alignedblocks{$sp}{$gene});
			    }
			}
		    }
		}
	    }
	}
    }
    else{
	print "Cannot find ".$pathTBA."\n";
    }
}

close($outputstats);
print "Done.\n";

#####################################################################

print "Writing output...\n";

foreach my $sp (@species){
    
    open(my $output, ">".$parameters{"dirOutput"}.$sp."/".$parameters{"suffixOutput"});
    
    foreach my $idfam (@sortedids){
	my $gene=$genefam{$idfam}{$sp};
	
	if(exists $alignedblocks{$sp}{$gene}){
	    my @exons=keys %{$exonblocks{$sp}{$gene}};
	    
	    my $strand=$exonblocks{$sp}{$gene}{$exons[0]}{"strand"};
	    my $chr=$exonblocks{$sp}{$gene}{$exons[0]}{"chr"};
	    
	    my $nbblocks=@{$alignedblocks{$sp}{$gene}{"start"}};

	    for(my $i=0; $i<$nbblocks; $i++){
		my $start=${$alignedblocks{$sp}{$gene}{"start"}}[$i];
		my $end=${$alignedblocks{$sp}{$gene}{"end"}}[$i];

		print $output $gene."\t".$chr."\t".$start."\t".$end."\t".$strand."\n";
	    }
	}
    }

    close($output);
}

print "Done.\n";

#####################################################################
#####################################################################
