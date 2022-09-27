#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

#print 5bp up and downstream of ATG

my $in;
my $out1;

GetOptions(
    'in=s' => \$in,
    'out1=s' => \$out1,
) or die "missing input\n";

open (IN, "$in") or die;
open (OUT, ">$out1") or die;

while (my $l = <IN>) {
	chomp $l;
	my @c = split(/\t/, $l);
	my @c2 = split(/\./, $c[3]);
	my $last = pop @c2;
	if ($last == 1) {
		if ($c[5] eq "+") {
			my $start = $c[1] - 5;
			my $stop = $c[1] + 8;
			unless ($start < 0) {
				print OUT "$c[0]\t$start\t$stop\t$c[3]\t$c[4]\t$c[5]\n";
			}
		}
		else {
			my $start = $c[2] - 8;
			my $stop = $c[2] + 5;
                        unless ($start < 0) {
				print OUT "$c[0]\t$start\t$stop\t$c[3]\t$c[4]\t$c[5]\n";
                       	}
		}
	}
}

close IN;
close OUT;

exit;
