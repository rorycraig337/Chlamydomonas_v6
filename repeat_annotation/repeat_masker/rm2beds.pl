#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);

#script parses output of repeatmasker, creating bed files for TEs and satellites/simple/low-complexity (rRNA ignored)
#usage: perl rm2beds.pl --rm rm.out --TE interspersed.bed --other TRs.bed --zepp zepp.bed

my $rm;
my $TE;
my $other;
my $zepp;

GetOptions(
        'rm=s' => \$rm,
        'TE=s' => \$TE,
        'other=s' => \$other,
	'zepp=s' => \$zepp,
) or die "missing input\n";

open (IN, "$rm") or die;
open (OUT1, ">$TE") or die;
open (OUT2, ">$other") or die;
open (OUT3, ">$zepp") or die;

my $h1 = <IN>;
my $h2 = <IN>;
my $h3 = <IN>;

while (my $line = <IN>) {
	chomp $line;
	my @cols = split(" ", $line);
	unless ( ($cols[4] eq "cpDNA") or ($cols[4] eq "mtDNA") ) {
		my $start = $cols[5] - 1;
		if ( ($cols[10] eq "Simple_repeat") or ($cols[10] eq "Low_complexity") or ($cols[10] eq "Satellite") ) {
			print OUT2 "$cols[4]\t$start\t$cols[6]\n";
		}
		elsif ($cols[10] ne "RNA") {
			if ($cols[1] <= 20) {
				print OUT1 "$cols[4]\t$start\t$cols[6]\n";
				if ($cols[9] =~ /ZeppL/) {
					print OUT3 "$cols[4]\t$start\t$cols[6]\n";
				}
			}
		}
	}
}


close IN;
close OUT1;
close OUT2;
close OUT3;

exit;
