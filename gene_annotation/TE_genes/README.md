







Get overlap between non-TE and TE genes in final CC-4532 v6.1 annotation

```
perl ENSEMBL_format_gff3.pl --gff3 CC4532_v6.1.primaryTrs.gff3 --out primary.ens.gff3
perl transcript_TE_overlap.v6.pl --gff primary.ens.gff3 --TEs ../../repeat_annotation/repeatmasker/m.CC4532.TEs.bed --repeats ../../repeat_annotation/repeatmasker/u.CC4532_v6.all_TRs.bed --out CC4532.repeat_overlap.tsv
```
