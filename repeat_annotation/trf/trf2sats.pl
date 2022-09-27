#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

#takes trf output (*dat) and parse to microsat, minisat and sat DNA
#usage: trf2sats.pl --in trf.dat --prefix Cr.v6_1

my $in;
my $prefix;

GetOptions(
	'in=s' => \$in,
	'prefix=s' => \$prefix,
) or die "missing input\n";

open (IN, "$in") or die;
open (OUT1, ">$prefix.microsats.gtf") or die;
open (OUT3, ">$prefix.sats.gtf") or die;

open (OUT4, ">$prefix.microsats.bed") or die;
open (OUT6, ">$prefix.sats.bed") or die;

my $chr;

while (my $line = <IN>) {
	chomp $line;
	if ($line =~ /^@/) {
		$chr = substr($line, 1);
	}
	else {
		my @cols = split(" ", $line);
		my $len = $cols[3] * $cols[2];
		if ($cols[2] < 10) { #microsat
			if ($cols[3] >= 2) { #>2 tandem repeats
				print OUT1 "$chr\ttrf\tmicrosatellite\t$cols[0]\t$cols[1]\t0\t+\t.\tTarget \"Motif:$cols[13]\" $cols[2] $cols[3] $len\n";
				my $s1 = $cols[0] - 1;
				print OUT4 "$chr\t$s1\t$cols[1]\n";
			}
		}
		else { #sat
			if ($cols[3] >= 2) {
				print OUT3 "$chr\ttrf\tsatellite\t$cols[0]\t$cols[1]\t0\t+\t.\tTarget \"Motif:$cols[13]\" $cols[2] $cols[3] $len\n";
                                my $s3 = $cols[0] - 1;
                                print OUT6 "$chr\t$s3\t$cols[1]\n";
			}
		}
	}
}

close IN;
close OUT1;
close OUT3;
close OUT4;
close OUT6;

exit;
