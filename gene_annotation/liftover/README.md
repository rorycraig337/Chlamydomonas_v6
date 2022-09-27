The following gene sets were compared to CC-4532 preliminary models

1. manually curated missing genes from v4
2. v5.6 genes
3. CC-503 v6 preliminary gene models

MT genes were ignored
Perform in a hierarchical manner to avoid overlaps from multiple sources
Was performed after coding potential and TE filtering

CC-503 v6 preliminary: 

```
perl liftover_overlap.pl --list CC503_preliminary.noMT_R.high_coding_potential.txt --gff CC503_v6_preliminary.gff3 --from CC503v6 --to CC4532 --hal Cr_5way.hal --CDS CC4532_v6_preliminary.high_coding_potential.CDS.bed  --out CC503-v6_CC4532_liftover.tsv

perl extract_missing.pl --in CC503-v6_CC4532_liftover.tsv --lift 90 --cov 10 --out CC503-v6_CC4532_missing.tsv
```

Then v4 and v5 (all v4 genes were already missing from v5 so no conflict)

```
perl liftover_overlap.pl --list v4_missing.txt --gff Creinhardtii_169_gene_exons.gff3 --from CC503v4 --to CC4532 --hal Cr_5way.hal --CDS CC4532_v6_preliminary.high_coding_potential.CDS.bed  --out v4_CC4532_liftover.tsv
perl liftover_overlap.pl --list v5_list.noMT_R.txt --gff v5_6.filtered.gff3 --from CC503v5 --to CC4532 --hal Cr_5way.hal --CDS CC4532_v6_preliminary.high_coding_potential.CDS.bed --out v5_CC4532_liftover.tsv
```
