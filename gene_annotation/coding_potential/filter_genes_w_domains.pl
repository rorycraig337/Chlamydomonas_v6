#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

my $ips;
my $unass;
my $out;

GetOptions(
	'ips=s' => \$ips,
	'unass=s' => \$unass,
	'out=s' => \$out,
) or die "missing input\n";


open (IN1, "$ips") or die;

my %dom;

while (my $l1 = <IN1>) {
	chomp $l1;
	my @c1 = split(/\t/, $l1);
	$dom{$c1[0]} = $l1;
}

close IN1;

open (IN, "$unass") or die;
open (OUT, ">$out") or die;

while (my $line = <IN>) {
	chomp $line;
	unless (exists $dom{$line}) {
		print OUT "$line\n";
	}
	else {
		print "$dom{$line}\n"
	}
}

close IN;
close OUT;

exit;
