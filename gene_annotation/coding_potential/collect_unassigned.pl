#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

#prints list of orthofinder genes that are either unassigned or single-species assigned

my $orthofinder;
my $out;

GetOptions(
	'orthofinder=s' => \$orthofinder,
	'out=s' => \$out,
) or die "missing input\n";


open (IN, "$orthofinder") or die;
open (OUT, ">$out") or die;

while (my $line = <IN>) {
	chomp $line;
	my @cols = split(" ", $line);
	my $c = 0;
	my $other = 0;
	my $main = 0;
	my @ids;
	foreach my $col (@cols) {
		$c++;
		if ($c > 1) {
			if ( ($col =~ /^v_carteri/) or ($col =~ /^r_subcapitata/) or ($col =~ /^p_parva/) or ($col =~ /^g_pectorale/) or ($col =~ /^d_salina/) or ($col =~ /^c_zofingiensis/) or ($col =~ /^c_schloesseri/) or ($col =~ /^c_incerta/) or ($col =~ /^c_eustigma/) or ($col =~ /^c_debaryana/) ) {
				$other++;
			}
			else {
				$main++;
				push @ids, $col;
			}
		}
	}
	if ($other == 0) {
		foreach my $chlamy (@ids) {
			print OUT "$chlamy\n";
		}
		if ($main > 2) {
        	        print "$line\n";
	        }
	}
}

close IN;
close OUT;

exit;
