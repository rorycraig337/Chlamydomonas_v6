#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

my $ipr;
my $blast;
my $pep;
my $out;

GetOptions(
	'ipr=s' => \$ipr,
	'blast=s' => \$blast,
	'pep=s' => \$pep,
	'out=s' => \$out,
) or die "missing input\n";


open (IN1, "$ipr") or die;

my %domains;
my %def;

while (my $l1 = <IN1>) {
	chomp $l1;
	my @c1 = split(/\t/, $l1);
	if ( ($c1[3] eq "Pfam") or ($c1[3] eq "CDD") ) {
		push @{ $domains{$c1[0]} }, "$c1[4]";
		push @{ $def{$c1[0]} }, "$c1[5]";
	}
}

close IN1;

open (IN2, "$blast") or die;

my %blastp;

while (my $l2 = <IN2>) {
	chomp $l2;
	my @c2 = split(/\t/, $l2);
	unless (exists $blastp{$c2[0]}) {
		$blastp{$c2[0]} = "$c2[3]\t$c2[1]\t$c2[2]\t$c2[8]\t$c2[4]\t$c2[5]\t$c2[7]\t$c2[6]\t$c2[12]";
	}
}

close IN2;

open (IN, "$pep") or die;
open (OUT, ">$out") or die;

print OUT "transcript\tdomain_IDs\tdomain_descriptions\tbest_blastp_hit\tquery_start\tquery_end\tquery_length\thit_start\thit_end\thit_length\tperc_identity\te-value\n";

while (my $line = <IN>) {
	chomp $line;
	if ($line =~ /^>/) {
		my @cols = split(" ", $line);
		my $gene = substr $cols[0], 1;
		print OUT "$gene\t";
		if (exists $domains{$gene}) {
			my $last1 = pop @{ $domains{ $gene } };
			if (scalar @{ $domains{ $gene } } > 0) {
				foreach my $dom (@{ $domains{ $gene } }) {
					print OUT "$dom,";
				}
				print OUT "$last1\t";
			}
			else {
				print OUT "$last1\t";
			}
			my $last2 = pop @{ $def{ $gene } };
			if (scalar @{ $def{ $gene } } > 0) {
				foreach my $D (@{ $def{ $gene } }) {
					print OUT "$D,";
				}
				print OUT "$last2\t";
			}
			else {
				print OUT "$last2\t";
			}
		}
		else {
			print OUT "NA\tNA\t";
		}
		if (exists $blastp{$gene}) {
			print OUT "$blastp{$gene}\n";
		}
		else {
			print OUT "NA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\tNA\n";
		}

	}

}

close IN;
close OUT;

exit;
