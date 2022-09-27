#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qq(GetOptions);
use Data::Dumper;

#takes the exon list file and extracts a list of genes

my $in;
my $out;

GetOptions(
    'in=s' => \$in,
    'out=s' => \$out,
) or die "missing input\n";

open (IN, "$in") or die;
open (OUT, ">$out") or die;

my %genes;

while (my $l = <IN>) {
        chomp $l;
        my @c = split(/\t/, $l);
        my @c2 = split(/\./, $c[3]);
        my $enum = pop @c2;
        my $id;
        if ((length $enum) == 1) {
                $id = substr($c[3], 0, -2);
        }
		elsif ((length $enum) == 2) {
                $id = substr($c[3], 0, -3);
        }
		elsif ((length $enum) == 3) {
                $id = substr($c[3], 0, -4);
        }
        $genes{$id} = 1;
}

close IN;

foreach my $gene (sort keys %genes) {
	print OUT "$gene\n";
}

close OUT;

exit;
