#!/usr/bin/perl
use warnings;
use strict;
my $infile1=shift;
my $infile2=shift;
my $outfile=shift;

open IN1,"<$infile1" or die $!;
open IN2,"<$infile2" or die $!;
open OUT,">$outfile" or die $!;

my %PathInScaffold=();
#R498_1000597_1/0_20096 R498_1529553_1/0_15939 R498_4185055_1/534_10716 R498_1943875_1/174_16211 R498_1847476_1/10222_18999	Super-Scaffold_262-5-6-Passing
while(<IN1>){
	chomp;
	my $line=$_;
	my @content=split /\s+/,$line;
	my $path=$content[0];
	for(my $i=1;$i<@content-1;$i++){
		$path=$path."_".$content[$i];
	}
	$PathInScaffold{$path}=$content[-1];
}
close(IN1);

my %CommonPath=();
#R498_1000597_1/0_20096_R498_1529553_1/0_15939_R498_4703259_1/3_25063_R498_551312_1/0_22055_R498_1943875_1/174_16211_R498_2980934_1/35_16991	57580
while(<IN2>){
	chomp;
	my $line=$_;
	my @content=split /\s+/,$line;
	if(exists $PathInScaffold{$content[0]}){
		print OUT "$line\t$PathInScaffold{$content[0]}\n";
		$CommonPath{$content[0]}=0;
	}
}
close(IN2);

=pod
foreach my $key (keys %PathInScaffold){
	next if(exists $CommonPath{$key});
	print "$key\t$PathInScaffold{$key}\n";
}
=cut
