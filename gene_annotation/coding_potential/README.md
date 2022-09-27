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

