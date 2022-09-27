#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

open (IN1, "CC4532_v6_TSS.bed") or die;

my %TSS;

while (my $l1 = <IN1>) {
	chomp $l1;
	my @c1 = split(/\t/, $l1);
	my $target = "$c1[0]\t$c1[1]";
	$TSS{$c1[2]} = $target;
}

close IN1;

open (IN2, "intergenic_peaks_CC4532.bed") or die;

my %peaks;

while (my $l2 = <IN2>) {
	chomp $l2;
	my @c2 = split(/\t/, $l2);
	my $length = $c2[2] - $c2[1];
	my $mid = $c2[2] - ($length/2);
	my $min = $mid - 750;
	my $max = $mid + 750;
	foreach my $pro (keys %TSS) {
		my @p1 = split(/\t/, $TSS{$pro});
		if ($c2[0] eq $p1[0]) {
			if ( ($p1[1] >= $min) and ($p1[1] <= $max) ) {
				push @{ $peaks{$l2} }, $pro;
			}
		}
	}
}

close IN2;

open (OUT, ">peaks_x_TSS.tsv") or die;

foreach my $peak (keys %peaks) {
	print OUT "$peak";
	foreach my $gene (@{ $peaks{ $peak } }) {
		print OUT "\t$gene"
	}
	print OUT "\n";
}

close OUT;

exit;
