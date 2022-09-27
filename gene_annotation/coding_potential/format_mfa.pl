#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

#formats CDS mfa files by ordering by list, and converting * to -
#also outputs GC3, length. average coverage of each CDS
#usage: perl format_mfa.pl -- list species.txt --out stats.tsv

my $list;
my $out;

GetOptions(
	'list=s' => \$list,
	'out=s' => \$out,
) or die "missing input\n";

my @spp;

open (IN1, "$list") or die;

while (my $s1 = <IN1>) {
	chomp $s1;
	push @spp, $s1;
}

close IN1;

my @mfas = glob '*mfa';

open (OUT, ">$out") or die;

foreach my $mfa (@mfas) {
	my $gene = substr($mfa, 0, -4);
	my %seqs;
	open (IN, "$mfa") or die;
	my $id;
	my $c = 0;
	my $seq = "-";
	while (my $line = <IN>) {
		chomp $line;
		if ($line =~ /^>/) {
			my @cols = split(" ", $line);
			$c++;
			if ($c > 1) {
				my $fseq = substr $seq, 1;
				$fseq =~ tr/\*/\-/;
				$seqs{$id} = $fseq;
			}
			if ((length $cols[0]) == 1) {
				$id = $cols[1];
			}
			else {
				$id = substr $cols[0], 1;
			}
			$seq = "-";
		}
		else {
			$seq = $seq . $line;
		}
	}
	my $fseq = substr $seq, 1;
	$fseq =~ tr/\*/\-/;
	$seqs{$id} = $fseq;
#	print Dumper(\%seqs);
	close IN;
	open (OUT1, ">f.$mfa") or die;
	my $len;
	my $GC3;
	my $cov = 0;
	my $tot = 0;
	foreach my $sp (@spp) {
#		print "$sp\n";
		if (exists $seqs{$sp}) {
			$tot++;
			if ($sp eq "Chlamydomonas_reinhardtii") {
				$len = length $seqs{$sp};
				my @bases = split (//, $seqs{$sp});
				my $bc = 0;
				my $GC = 0;
				my $three = 0;
				foreach my $base (@bases) {
					$bc++;
					if ( ($bc % 3) == 0) {
						$three++;
#						print "$base";
						if ( ($base eq "G") or ($base eq "C") or ($base eq "g") or ($base eq "c") ) {
							$GC++;
						}
					}
				}
				if ($three > 0) {
					$GC3 = ($GC / $three) * 100;
				}
				else {
					$GC3 = "NA";
				}
				my $h1 = ">" . $sp;
				print OUT1 "$h1\n$seqs{$sp}\n";
#				print "$len , $GC3 , $tot , $three\n";
			}
			elsif ($sp =~ /^Eudorina/) {
				my $ali = $seqs{$sp} =~ tr/ATGCatgc//;
				$cov = $cov + $ali;
				my $h2 = ">" . "Eudorina";
				if ((length $seqs{$sp}) == $len) {
					print OUT1 "$h2\n$seqs{$sp}\n";
				}
				else {
					print "$mfa $sp seq not equal to $len\n";
				}
			}
			else {
				my $ali = $seqs{$sp} =~ tr/ATGCatgc//;
				$cov = $cov + $ali;
				my $h2 = ">" . $sp;
				if ((length $seqs{$sp}) == $len) {
					print OUT1 "$h2\n$seqs{$sp}\n";
				}
				else {
					print "$mfa $sp seq not equal to $len\n";
				}
			}
		}
	}
	close OUT1;
	my $covc = $cov / $len;
	print OUT "$gene\t$len\t$tot\t$covc\t$GC3\n";
}

close OUT;

exit;
