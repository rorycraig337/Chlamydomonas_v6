#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

open (IN1, "CC4532_v6.gene_exons.gff3") or die;
open (OUT1, ">CC4532_v6.TSS.bed") or die;

my $p = 0;

while (my $l2 = <IN1>) {
	chomp $l2;
	unless ($l2 =~ /^#/) {
		my @cols = split(/\t/, $l2);
		my $start = $cols[3] - 1;
		if ($cols[2] eq "gene") {
			if ($cols[6] eq "+") {
				print OUT1 "$cols[0]\t$start\t$i3[0]\n";
			}
			if ($cols[6] eq "-") {
				print OUT1 "$cols[0]\t$cols[4]\t$i3[0]\n";
			}
			$p = 1;
		}
	}
}

close IN1;
close OUT1;

exit;
