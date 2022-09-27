#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);

#script takes list of genes for a given genome and annotation and performs liftover on coordinates to a target genome
#performs additional same strand overlap check with CDS bed file from target genome

my $list;
my $gff;
my $from;
my $to;
my $hal;
my $CDS;
my $out;

GetOptions(
	'list=s' => \$list,
	'gff=s' => \$gff,
	'from=s' => \$from,
	'to=s' => \$to,
	'hal=s' => \$hal,
	'CDS=s' => \$CDS,
	'out=s' => \$out,
) or die "missing input\n";

#store hash of genes of interest

my %genes;

open (IN1, "$list") or die;

while (my $l1 = <IN1>) {
	chomp $l1;
	$genes{$l1} = 1;
}

close IN1;

#makes has or arrays with genes as keys and CDS elements as values

my %exons;
my %lengths;

open (IN2, "$gff") or die;

my $p = 0;
my $count = 0;
my $gene;
my $cds;

while (my $l2 = <IN2>) {
	chomp $l2;
	unless ($l2 =~ /^#/) {
		my @c2 = split(/\t/, $l2);
		if ($c2[2] eq "mRNA") {
			my @i1 = split(/;/, $c2[8]);
			my @i2 = split(/=/, $i1[1]);
			$gene = $i2[1];
			if (exists $genes{$i2[1]}) {
				$p = 1;
				$count++;
			}
			else {
				$p = 0;
			}
			$cds = 0;
		}
		elsif ( ($c2[2] eq "CDS") and ($p == 1) ) {
			my $start = $c2[3] - 1;
			my $len = $c2[4] - $start;
			$lengths{$gene} += $len;
			$cds++;
			my $id = $gene . "." . $cds;
			my $bline = "$c2[0]\t$start\t$c2[4]\t$id\t0\t$c2[6]";
			push @{ $exons{$gene} }, $bline;
		}
	}
}

print "$count genes found\n";

close IN2;

open (OUT1, ">$out") or die;

foreach my $G (keys %exons) {
	open (OUT2, ">$G.CDS.bed") or die;
	foreach my $C (@{ $exons{ $G } }) {
		print OUT2 "$C\n";
	}
	close OUT2;
	system("halLiftover $hal $from $G.CDS.bed $to $G.CDS.$to.bed");
	my $lift = 0;
	system("sort -k1,1 -k2n,2n $G.CDS.$to.bed | bedtools merge -i stdin > temp1.bed");
	open (IN3, "temp1.bed") or die;
	while (my $l3 = <IN3>) {
		chomp $l3;
		my @c3 = split(/\t/, $l3);
		$lift+= ($c3[2] - $c3[1]);
	}
	close IN3;
	my $liftp = ($lift / $lengths{$G}) * 100;
	system("bedtools intersect -a $G.CDS.$to.bed -b $CDS > temp2.bed");
	system("sort -k1,1 -k2n,2n temp2.bed | bedtools merge -i stdin > temp3.bed");
	my $hit = 0;
	open (IN4, "temp3.bed") or die;
	while (my $l4 = <IN4>) {
		chomp $l4;
		my @c4 = split(/\t/, $l4);
		$hit += ($c4[2] - $c4[1]);
	}
	close IN3;
	my $hitp = ($hit / $lengths{$G}) * 100;
	print OUT1 "$G\t$lengths{$G}\t$liftp\t$hitp\n";
	system("rm $G.CDS.bed");
	system("rm temp1.bed");
	system("rm temp2.bed");
	system("rm temp3.bed");
}

close OUT1;

exit;
