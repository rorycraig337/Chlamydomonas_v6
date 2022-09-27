#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

#liftover covers 90% of total length and cannot be >10% longer in span

open (IN, "intergenic_peaks.bed") or die;
open (OUT, ">intergenic_peaks_CC4532.bed") or die;

while (my $line = <IN>) {
	chomp $line;
	my @cols = split(/\t/, $line);
	my $length = $cols[2] - $cols[1];
	open (OUT1, ">temp.bed") or die;
	print OUT1 "$line\n";
	close OUT1;
	system("halLiftover Cr_5way.hal CC503v5 temp.bed CC4532 temp1.bed");
	my $lift = 0;
	my %chr;
	my $c;
	my $start = 10000000;
	my $end = 0;
	system("sort -k1,1 -k2n,2n temp1.bed | bedtools merge -i stdin > temp2.bed");
	open (IN1, "temp2.bed") or die;
	while (my $l1 = <IN1>) {
		chomp $l1;
		my @c1 = split(/\t/, $l1);
		$lift+= ($c1[2] - $c1[1]);
		$chr{$c1[0]} = 1;
		$c = $c1[0];
		if ($c1[1] < $start) {
			$start = $c1[1];
		}
		if ($c1[2] > $end) {
			$end = $c1[2];
		}
	}
	close IN1;
	if (scalar keys %chr == 1) {
		if ((($lift/$length)*100) >= 90) {
			my $span = $end - $start;
			if ((($span/$length)*100) <= 110) {
				print OUT "$c\t$start\t$end\t$cols[3]\n";
			}
		}
	}
	system("rm temp.bed");
	system("rm temp1.bed");
	system("rm temp2.bed");
}

close IN;
close OUT;

exit;
