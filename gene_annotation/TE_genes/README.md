Preliminary TE genes were produced from JGI's pipeline
These were reduced to a high confidence set using homology and protein domains 

Homology to RepBase TE proteins:

```
blastp -db repbase_prot -query CC4532_preliminary_TE_pep.fa -outfmt "6 qseqid qstart qend sseqid sstart send pident slen qlen length mismatch gapopen evalue" -evalue 0.001 > CC4532_TE_prot.out
```

Interproscan:

```
interproscan.sh -dp -appl Pfam,SignalP -goterms -i CC4532_preliminary_TE_pep.fa
```

Combine and extract passed hits:

```
perl combine_domain_blastp.pl --ipr CC4532_preliminary_TE_pep.fa.tsv --blast CC4532_TE_prot.out --pep CC4532_preliminary_TE_pep.fa --out CC4532_putative_TE.blastp_ipr.tsv
perl filter_TE-genes.pl --tsv CC4532_putative_TE.blastp_ipr.tsv --out CC4532_putative_TE.blastp_ipr.pass_fail.tsv
perl extract_pass.pl --tsv CC4532_putative_TE.blastp_ipr.pass_fail.tsv --out CC4532_putative_TE.blastp_ipr.pass.tsv
```





Get overlap between non-TE and TE genes in final CC-4532 v6.1 annotation

```
perl ENSEMBL_format_gff3.pl --gff3 CC4532_v6.1.primaryTrs.gff3 --out primary.ens.gff3
perl transcript_TE_overlap.v6.pl --gff primary.ens.gff3 --TEs ../../repeat_annotation/repeatmasker/m.CC4532.TEs.bed --repeats ../../repeat_annotation/repeatmasker/u.CC4532_v6.all_TRs.bed --out CC4532.repeat_overlap.tsv
```
