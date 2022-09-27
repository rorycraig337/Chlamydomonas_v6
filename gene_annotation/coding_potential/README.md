Step 1. Split genes with a algal homolog or protein domain 

```
interproscan.sh -dp -appl Pfam,CDD -goterms -i CC4532_preliminary_primary_peptides.fa

perl collect_unassigned.pl --orthofinder ../orthofinder/preprocessed_fastas/Results_Nov13/WorkingDirectory/Orthogroups.txt --out CC4532.unassigned.txt
perl filter_genes_w_domains.pl --ips CC4532_preliminary_primary_peptides.fa.tsv --unass CC4532.unassigned.txt --out CC4532.unassigned_no-domains.txt
cut -c 15- CC4532.unassigned_no-domains.txt > CC4532.unassigned_no-domains.f.txt

perl CDS_gff2bed.pos_filter.pl --gff CC4532_preliminary.gene.gff3 --list c_reinhardtii.unassigned_no-domains.f.txt --out CDS.control.bed
perl CDS_gff2bed.neg_filter.pl --gff CC4532_preliminary.gene.gff3 --list c_reinhardtii.unassigned_no-domains.f.txt --out CDS.test.bed
perl CDS_gff2bed.pos_filter.exon_filter.pl --gff CC4532_preliminary.gene.gff3 --list c_reinhardtii.unassigned_no-domains.f.txt --out CDS.control.exon.bed
perl CDS_gff2bed.neg_filter.exon_filter.pl --gff CC4532_preliminary.gene.gff3 --list c_reinhardtii.unassigned_no-domains.f.txt --out CDS.test.exon.bed
```


Step 2. Run phyloCSF on 8-species cactus WGA
Note this requires PhyloCSF install with custom volvocales WGA and files from cactus WGA (see https://github.com/rorycraig337/Chlamydomonas_comparative_genomics/tree/master/Cactus_WGA)
Run both for individual exons and whole genes

```
mkdir control
cd control
perl ../cds-exon2mfa.pl --CDS ../CDS.control.bed --maf_path ~/projects/chlamy_genomics/cactus_WGA/run_CC4532/maf/split/
perl ../format_mfa.pl --list ~/projects/chlamy_genomics/cactus_WGA/run4/4D_divergence/species.txt --out control.align_stats.tsv
ls f.*mfa > alignments.txt
~/software/PhyloCSF/PhyloCSF volvocales --files alignments.txt --strategy=omega > phyloCSF_control.txt

mkdir test
cd test
perl ../cds-exon2mfa.pl --CDS ../CDS.test.bed --maf_path ~/projects/chlamy_genomics/cactus_WGA/run_CC4532/maf/split/
perl ../format_mfa.pl --list ~/projects/chlamy_genomics/cactus_WGA/run4/4D_divergence/species.txt --out test.align_stats.tsv
ls f.*mfa > alignments.txt
~/software/PhyloCSF/PhyloCSF volvocales --files alignments.txt --strategy=omega > phyloCSF_test.txt

mkdir control_full
cd control_full
perl ../cds2mfa.pl --CDS ../CDS.control.bed --maf_path ~/projects/chlamy_genomics/cactus_WGA/run_CC4532/maf/split/
perl ../format_mfa.pl --list  ~/projects/chlamy_genomics/cactus_WGA/run4/4D_divergence/species.txt --out control.align_stats.tsv
ls f.*mfa > alignments.txt
~/software/PhyloCSF/PhyloCSF volvocales --files alignments.txt --strategy=omega > phyloCSF_control_full.txt

mkdir test_full
cd test_full
perl ../cds2mfa.pl --CDS ../CDS.test.bed --maf_path ~/projects/chlamy_genomics/cactus_WGA/run_CC4532/maf/split/
perl ../format_mfa.pl --list  ~/projects/chlamy_genomics/cactus_WGA/run4/4D_divergence/species.txt --out test.align_stats.tsv
ls f.*mfa > alignments.txt
~/software/PhyloCSF/PhyloCSF volvocales --files alignments.txt --strategy=omega > phyloCSF_test_full.txt
```

Step 3: get genetic diversity for 0D and 4D sites
Re-sequencing for 17 Quebec isolates were aligned against CC-4532 v6 and variant called with GATK
see: https://github.com/rorycraig337/Chlamydomonas_reinhardtii_population_structure/tree/master/SNP_filtering/species_wide

Genetic diversity was calcualted at 0D and 4D sites
see: https://github.com/rorycraig337/Chlamydomonas_reinhardtii_population_structure/tree/master/differentiation_divergence_analyses/overall_diversity

Step 4: codon usage as calculated previously using DAMBE GUI (see https://academic.oup.com/plcell/article/33/4/1016/6126463)

Step 5: Kozak (scores produced using Weblogo3)

```
perl fasta_filter.pl --fa CDS.control.fa --list rDNA.txt --out CDS.control.rF.fa
perl fasta_filter.pl --fa CDS.test.fa --list rDNA.txt --out CDS.test.rF.fa
perl extract_genes_from_exons.pl --in CDS.control.bed --out CDS.control.txt
grep -vf "rDNA.txt" CDS.control.txt > CDS.control.rF.txt
shuf -n7824 CDS.control.rF.txt > CDS.control.random_half.txt
grep -vf "CDS.control.random_half.txt" CDS.control.rF.txt > CDS.control.other_half.txt
perl CDS_gff2bed.neg_filter.pl --gff CC4532_preliminary.gene.gff3 --list CDS.control.random_half.txt --out CDS.control.random_half.bed
perl CDS_gff2bed.neg_filter.pl --gff CC4532_preliminary.gene.gff3 --list CDS.control.other_half.txt --out CDS.control.other_half.bed

perl extract_kozak.pl --in CDS.control.random_half.bed --out1 CDS.control.random_half.kozak.bed
sort -k1,1 -k2n,2n CDS.control.random_half.kozak.bed > s.CDS.control.random_half.kozak.bed
bedtools getfasta -fi ~/projects/chlamy_v6/frozen_v6/genomes/CC4532.fa -bed s.CDS.control.random_half.kozak.bed -fo CDS.control.random_half.kozak.fa -s -name
perl mask_atg.pl --in CDS.control.random_half.kozak.fa --out CDS.control.random_half.kozak_mask.fa

perl extract_kozak.pl --in CDS.control.other_half.bed --out1 CDS.control.other_half.kozak.bed
sort -k1,1 -k2n,2n CDS.control.other_half.kozak.bed > s.CDS.control.other_half.kozak.bed
bedtools getfasta -fi ~/projects/chlamy_v6/frozen_v6/genomes/CC4532.fa -bed s.CDS.control.other_half.kozak.bed -fo CDS.control.other_half.kozak.fa -s -name
perl mask_atg.pl --in CDS.control.other_half.kozak.fa --out CDS.control.other_half.kozak_mask.fa

#after getting weblogo data from random half, get scores for other, nOGd and random
perl kozak_score.pl --weblogo kozak_bits_random_half.weblogo.txt --in CDS.control.random_half.kozak_mask.fa --dataset null --out CDS.control.random_half.kozak_scores.tsv
perl kozak_score.pl --weblogo kozak_bits_random_half.weblogo.txt --in CDS.control.other_half.kozak_mask.fa --dataset control --out CDS.control.other_half.kozak_scores.tsv

perl extract_kozak.pl --in CDS.test.bed --out1 CDS.test.kozak.bed
bedtools getfasta -fi ~/projects/chlamy_v6/frozen_v6/genomes/CC4532.fa -bed CDS.test.kozak.bed -fo CDS.test.kozak.fa -s -name
perl mask_atg.pl --in CDS.test.kozak.fa --out CDS.test.kozak_mask.fa
perl kozak_score.pl --weblogo kozak_bits_random_half.weblogo.txt --in CDS.test.kozak_mask.fa --dataset test --out CDS.test.kozak_scores.tsv
```
