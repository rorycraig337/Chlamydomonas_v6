#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

#filters repeatmasker gff on % divergence

my $in;
my $lim;
my $out;

GetOptions(
	'in=s' => \$in,
	'lim=i' => \$lim,
	'out=s' => \$out,
) or die "missing input\n";

open (IN, "$in") or die;
open (OUT, ">$out") or die;


while (my $line = <IN>) {
	chomp $line;
	if ($line =~ /^#/) {
		print OUT "$line\n";
	}
	else {
		my @cols = split(/\t/, $line);
		if ($cols[5] <= $lim) {
			print OUT "$line\n";
		}
	}
}

close IN;
close OUT;

exit;
