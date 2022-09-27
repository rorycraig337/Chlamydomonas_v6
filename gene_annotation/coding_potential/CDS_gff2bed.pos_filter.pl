#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

#converts gene entries in gff3 to bed6
#allows filtering of genes by a list
#usage: perl CDS_ggf2bed.pl --gff in.gff --filter list.txt --out cds.bed

my $gff;
my $list;
my $out;

GetOptions(
	'gff=s' => \$gff,
	'list=s' => \$list,
	'out=s' => \$out,
) or die "missing input\n";

open (IN1, "$list") or die;

my %filter;

while (my $fline = <IN1>) {
	chomp $fline;
	my @fcols = split(" ", $fline);
	$filter{$fcols[0]} = 1;
}

close IN1;

open (IN, "$gff") or die;
open (OUT, ">$out") or die;

my $p = 0;
my $gene;
my $cds = 0;
my $f = 0;

while (my $line = <IN>) {
	unless ($line =~ /^#/) {
		chomp $line;
		my @cols = split(/\t/, $line);
		if ($cols[2] eq "mRNA") {
			my @i1 = split(/;/, $cols[8]);
			my @i2 = split(/=/, $i1[1]);
			$gene = $i2[1];
			if (exists $filter{$i2[1]}) {
				$p = 0;
				$f++;
			}
			elsif ($cols[8] =~ /longest=1/) {
				$p = 1;
			}
			else {
				$p = 0;
			}
			$cds = 0;
		}
		elsif ( ($cols[2] eq "CDS") and ($p == 1) ) {
			my $start = $cols[3] - 1;
			$cds++;
			my $id = $gene . "." . $cds;
			print OUT "$cols[0]\t$start\t$cols[4]\t$id\t0\t$cols[6]\n";
		}
	}
}

print "$f filtered genes\n";

close IN;
close OUT;

exit;
