#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

#formats GFF to meet ENSEMBL format (### separating genes)
#only works with "gene" annotation, if noncoding genes are included then must be changed
#usage: perl ENSEMBL_format_gff3.pl --gff3 in.gff3 --out out.gff3

my $gff3;
my $out;

GetOptions(
	'gff3=s' => \$gff3,
	'out=s' => \$out,
) or die "missing input\n";

open (IN, "$gff3") or die;
open (OUT, ">$out") or die;

while (my $line = <IN>) {
	chomp $line;
	unless ($line =~ /^#/) {
		my @cols = split(/\t/, $line);
		if ( ( ($line !~ /^#/) and ($cols[2] eq "gene") ) or ( ($line !~ /^#/) and ($cols[2] eq "transposable_element_gene") ) ){
			print OUT "###\n$line\n";
		}
		elsif ($cols[2] ne "region") {
			print OUT "$line\n";
		}
	}
}

print OUT "###\n";

close IN;
close OUT;

exit;
