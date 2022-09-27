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
my $r = 0;

my %all;

while (my $line = <IN>) {
	unless ($line =~ /^#/) {
		chomp $line;
		my @cols = split(/\t/, $line);
		if ($cols[2] eq "mRNA") {
			my @i1 = split(/;/, $cols[8]);
			my @i2 = split(/=/, $i1[1]);
			$gene = $i2[1];
			$all{$i2[1]} = 1;
			if (exists $filter{$i2[1]}) {
				$p = 1;
				$r++;
			}
			else {
				$p = 0;
				$f++;
			}
			$cds = 0;
		}
		elsif ( ($cols[2] eq "CDS") and ($p == 1) ) {
			my $start = $cols[3] - 1;
			my $end = $cols[4];
			$cds++;
			my $id = $gene . "." . $cds;
			if ($cols[6] eq "+") {
				if ($cols[7] == 1) {
					$start = $start + 1;
				}
				elsif ($cols[7] == 2) {
					$start = $start + 2;
				}
			}
			elsif ($cols[6] eq "-") {
				if ($cols[7] == 1) {
					$end = $end - 1;
				}
				elsif ($cols[7] == 2) {
					$end = $end - 2;
				}
			}
			my $len = $end - $start;
			my $rem = $len % 3;
			if ($cols[6] eq "+") {
				$end = $end - $rem;
			}
			elsif ($cols[6] eq "-") {
				$start = $start + $rem;
			}
			if ((($end - $start) % 3) != 0) {
				die "$line\n";
			}
			if (($end - $start) >= 45) {
				print OUT "$cols[0]\t$start\t$end\t$id\t0\t$cols[6]\n";
			}
		}
	}
}

print "$r retained genes, $f filtered genes\n";

close IN;
close OUT;

exit;
