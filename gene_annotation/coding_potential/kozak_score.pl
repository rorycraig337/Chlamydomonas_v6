#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

#takes nat scores from weblogo and checks agreement between sequences to get bit score

my $weblogo;
my $in;
my $dataset;
my $out;

GetOptions(
	'weblogo=s' => \$weblogo,
    'in=s' => \$in,
    'dataset=s' => \$dataset,
    'out=s' => \$out,
) or die "missing input\n";

open (IN1, "$weblogo") or die;

my %bits;

while (my $l1 = <IN1>) {
	chomp $l1;
	my @c1 = split(" ", $l1);
	unless ( ($c1[0] == 6) or ($c1[0] == 7) or ($c1[0] == 8) ) {
	my $sum = $c1[1] + $c1[2] + $c1[3] + $c1[4];
		my $A = $c1[1] / $sum;
		my $C = $c1[2] / $sum;
		my $G = $c1[3] / $sum;
		my $T = $c1[4] / $sum;
		$bits{$c1[0]}{"A"} = $A * ($c1[5] * 1.44);
		$bits{$c1[0]}{"C"} = $C * ($c1[5] * 1.44);
		$bits{$c1[0]}{"G"} = $G * ($c1[5] * 1.44);
		$bits{$c1[0]}{"T"} = $T * ($c1[5] * 1.44);
	}
}

close IN1;

open (IN2, "$in") or die;
open (OUT, ">$out") or die;

my $gene;

while (my $l2 = <IN2>) {
	chomp $l2;
	if ($l2 =~ /^>/) {
		my @c3 = split(/\t/, $l2);
		my @c2 = split(/\:/, $c3[0]);
		$gene = substr $c2[0], 1;
	}
	else {
		my @bases = split(//, $l2);
		my $count = 1;
		my $kscore = 0;
		foreach my $base (@bases) {
			my $ubase = uc $base;
			unless ( ($count == 6) or ($count == 7) or ($count == 8) or ($ubase eq "N") ) {
				$kscore+= $bits{$count}{$ubase};
			}
			$count++;
		}
		print OUT "$gene\t$kscore\t$dataset\n";
	}
}

close IN2;
close OUT;

exit;
