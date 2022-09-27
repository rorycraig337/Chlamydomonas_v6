#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);

#filter fasta by list

my $fa;
my $list;
my $out;


GetOptions(
	'fa=s' => \$fa,
	'list=s' => \$list,
    'out=s' => \$out,
) or die "missing input\n";

my %filter;

open (IN1, "$list") or die;

while (my $l1 = <IN1>) {
	chomp $l1;
	$filter{$l1} = 1;
}

close IN1;

open (IN2, "$fa") or die;
open (OUT, ">$out") or die;

my $p = 0;
my $f = 0;

while (my $l2 = <IN2>) {
	chomp $l2;
	if ($l2 =~ /^>/) {
		my $id = substr $l2, 1;
		if (exists $filter{$id}) {
			$f++;
			$p = 0;
		}
		else {
			$p = 1;
			print OUT "$l2\n";
		}
	}
	elsif ($p == 1) {
		print OUT "$l2\n";
	}
}

close IN2;
close OUT;

print "$f filtered\n";

exit;
