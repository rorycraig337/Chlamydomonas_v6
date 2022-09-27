#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

my $tsv;
my $out;

GetOptions(
	'tsv=s' => \$tsv,
	'out=s' => \$out,
) or die "missing input\n";

open (IN, "$tsv") or die;
open (OUT, ">$out") or die;

my $h = <IN>;

print OUT "$h";

while (my $l = <IN>) {
	chomp $l;
	my @c = split(/\t/, $l);
	if ($c[16] eq "TRUE") {
		print OUT "$l\n";
	}
}

close IN;
close OUT;

exit;
