Step 1. Split genes with a algal homolog or protein domain 

```
interproscan.sh -dp -appl Pfam,CDD -goterms -i CC4532_preliminary_primary_peptides.fa

perl collect_unassigned.pl --orthofinder ../orthofinder/preprocessed_fastas/Results_Nov13/WorkingDirectory/Orthogroups.txt --out CC4532.unassigned.txt
perl filter_genes_w_domains.pl --ips CC4532_preliminary_primary_peptides.fa.tsv --unass CC4532.unassigned.txt --out CC4532.unassigned_no-domains.txt
cut -c 15- CC4532.unassigned_no-domains.txt > CC4532.unassigned_no-domains.f.txt
```


Step 2. Run phyloCSF on 8-species cactus WGA

