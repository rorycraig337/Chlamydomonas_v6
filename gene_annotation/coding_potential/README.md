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
