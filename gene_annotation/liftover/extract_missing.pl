#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

my $in;
my $lift;
my $cov;
my $out;

GetOptions(
	'in=s' => \$in,
	'lift=i' => \$lift,
	'cov=i' => \$cov,
	'out=s' => \$out,
) or die "missing input\n";

open (IN, "$in") or die;
open (OUT, ">$out") or die;


while (my $line = <IN>) {
	chomp $line;
	my @cols = split(/\t/, $line);
	if ( ($cols[2] >= $lift) and ($cols[3] < $cov) ) {
		print OUT "$line\n";
	}
}

close IN;
close OUT;

exit;
