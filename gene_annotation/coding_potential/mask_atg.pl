#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

#masks ATG in kozak

my $in;
my $out;

GetOptions(
    'in=s' => \$in,
    'out=s' => \$out,
) or die "missing input\n";


open (IN, "$in") or die;
open (OUT, ">$out") or die;

while (my $l = <IN>) {
        chomp $l;
        if ($l =~ /^>/) {
                print OUT "$l\n";
        }
	else {
              	my @c = split(//, $l);
                my $s = $c[0] . $c[1] . $c[2] . $c[3] . $c[4] . "NNN" . $c[8] .$c[9] . $c[10] . $c[11] . $c[12];
                print OUT "$s\n";
        }
}

close IN;
close OUT;

exit;
