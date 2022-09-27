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
chomp $h;
print OUT "$h\tquery_cov\thit_cov\tblast\tdomain\tpass\n";

my $pass;

my $pcount = 0;

while (my $line = <IN>) {
	chomp $line;
	$pass = "FALSE";
	my @cols = split(/\t/, $line);
	print OUT "$line\t";
	if ($cols[3] ne "NA") {
		my $hcov = ($cols[5] - $cols[4] + 1) / $cols[6];
		my $qcov = ($cols[8] - $cols[7] + 1) / $cols[9];
		print OUT "$hcov\t$qcov\t";
		if ($cols[10] >= 60) {
			if ( ($hcov >= 0.5) and ($qcov >= 0.5) ) {
				$pass = "TRUE";
				print OUT "TRUE\t";
			}
			else {
				print OUT "FALSE\t";
			}
 		}
 		else {
			if ( ($hcov >= 0.2) and ($qcov >= 0.2) ) {
				$pass = "TRUE";
				print OUT "TRUE\t";
			}
			else {
				print OUT "FALSE\t";
			}
 		}
	}
	else {
		print OUT "NA\tNA\tFALSE\t";
	}
	if ($cols[1] ne "NA") {
		print OUT "TRUE\t";
		$pass = "TRUE";
	}
	else {
		print OUT "FALSE\t";
	}
	print OUT "$pass\n";
	if ($pass eq "TRUE") {
		$pcount++;
	}
}

print "$pcount\n";

close IN;
close OUT;

exit;
