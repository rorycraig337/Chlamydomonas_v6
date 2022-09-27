#!/usr/bin/perl

use warnings;
use strict;
use Getopt::Long qw(GetOptions);
use Data::Dumper;

#script extract CDS alignment for a list of genes, output is single fasta alingment for each gene
#based on CDS of reference species, other species assumed to be CDS if aligned
#assumes that maf files do not contain paralogs and are split by chromosome/scaffold with name format "chromsome_X.maf"
#requires BED6 format for CDS, with gene_ID.CDS_number in column 4
#assumes CDS file is sorted by order of exons (i.e. not by start coordinate for reverse strand genes!)
#requires PHAST and EMBOSS tools to be installed and in the path

my $CDS;
my $maf_path;
my $list;

GetOptions(
	'CDS=s' => \$CDS,
	'maf_path=s' => \$maf_path,
	'list=s' => \$list,
) or die "missing input\n";

#build hash containing all CDS blocks by gene ID

my %CDS_index;

open (IN1, "$CDS") or die;

while (my $CDS_line = <IN1>) {
	chomp $CDS_line;
	my @CDS_cols = split(/\t/, $CDS_line);
	my $index_info = "$CDS_cols[0]\t$CDS_cols[1]\t$CDS_cols[2]\t$CDS_cols[5]";
	push @{ $CDS_index{$CDS_cols[3]} }, $index_info;
}

close IN1;

#foreach gene, extract each CDS from MAF
#reverse complement if - strand
#convert to MFA and combine

foreach my $gene (sort keys %CDS_index) {
	my $elem_count = 0;
	my @mfa_array;
	foreach my $CDS_elem ( @{$CDS_index{$gene}} ) {
		$elem_count++;
		my @elem_cols = split(/\t/, $CDS_elem);
		my $maf = "$maf_path" . "$elem_cols[0]" . ".maf";
		my $start = $elem_cols[1] + 1; #maf_parse is 1-based
		system("maf_parse --start $start --end $elem_cols[2] $maf > $elem_count.maf"); #extract MAF for CDS block
		system("msa_view $elem_count.maf --out-format FASTA > $elem_count.mfa"); #convert MAF to MFA
		if ($elem_cols[3] eq "-") { #need to reverse complement MAF blocks
			system("/localdisk/home/s0920593/software/EMBOSS-6.6.0/emboss/seqret -sreverse $elem_count.mfa $elem_count.r.mfa"); #reverse complement
			system("rm $elem_count.mfa"); #remove original file so it isn't concatenated in the next step
			push @mfa_array, "$elem_count.r.mfa";
		}
		else {
			push @mfa_array, "$elem_count.mfa";
		}
	}
	my $cat = join(" ", @mfa_array);
	system("perl ../catfasta2phyml.pl -c --fasta $cat > $gene.mfa"); #concatenate alignments
	foreach my $mfa (@mfa_array) {
		system("rm $mfa");
	}
	system("rm *maf");
}

exit;
